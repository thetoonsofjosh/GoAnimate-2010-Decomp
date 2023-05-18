package anifire.cc_theme_lib
{
   import anifire.constant.CcLibConstant;
   import anifire.util.UtilHashArray;
   
   public class CcCharacter
   {
      
      public static const XML_NODE_NAME:String = "cc_char";
       
      
      private var _tags:Array;
      
      private var _bodyShape:anifire.cc_theme_lib.CcBodyShape;
      
      private var _currentTheme:anifire.cc_theme_lib.CcTheme;
      
      private var _userChosenColors:UtilHashArray;
      
      private var _createDateTime:String = "";
      
      private var _name:String;
      
      private var _assetId:String = "";
      
      private var _userChosenComponents:Array;
      
      private var _category:String = null;
      
      public function CcCharacter()
      {
         this._userChosenColors = new UtilHashArray();
         this._userChosenComponents = new Array();
         this._tags = new Array();
         super();
      }
      
      public static function getComponentScaling(param1:String) : Number
      {
         if(param1 == "female")
         {
            return CcLibConstant.COMPONENT_SCALE_FEMALE;
         }
         return CcLibConstant.COMPONENT_SCALE_MALE;
      }
      
      public function deserialize(param1:XML, param2:UtilHashArray) : void
      {
         var _loc3_:XML = null;
         var _loc4_:CcComponent = null;
         var _loc5_:CcColor = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:CcComponent = null;
         this._assetId = param1.@aid;
         this._name = param1.@name;
         this._createDateTime = param1.@create || "";
         if(param1.@tags != null)
         {
            _loc6_ = param1.@tags;
            this._tags = _loc6_.split(",");
         }
         else
         {
            this._tags = new Array();
         }
         this.removeAllUserChosenComponent();
         for each(_loc3_ in param1.child(CcComponent.XML_NODE_NAME))
         {
            if((_loc7_ = CcComponent.getComponentThumbTypeFromXml(_loc3_)) == CcLibConstant.COMPONENT_TYPE_BODYSHAPE)
            {
               _loc8_ = CcComponent.getComponentThemeIdFromXml(_loc3_);
               _loc9_ = CcComponent.getComponentIdFromXml(_loc3_);
               this._bodyShape = (param2.getValueByKey(_loc8_) as anifire.cc_theme_lib.CcTheme).getBodyShapeByShapeId(_loc9_);
               this.currentTheme = param2.getValueByKey(_loc8_) as anifire.cc_theme_lib.CcTheme;
               (_loc10_ = new CcComponent()).componentThumb = CcComponentThumb.createBodyShapeComponentThumb(this.bodyShape);
               this.addUserChosenComponent(_loc10_);
            }
            else
            {
               (_loc4_ = new CcComponent()).deserialize(_loc3_,param2);
               this.addUserChosenComponent(_loc4_);
            }
         }
         this.removeAllUserChosenColors();
         for each(_loc3_ in param1.child(CcColor.XML_NODE_NAME))
         {
            (_loc5_ = new CcColor()).deserialize(_loc3_,this.currentTheme,this);
            this.addUserChosenColor(_loc5_);
         }
      }
      
      public function removeAllUserChosenColors() : void
      {
         this._userChosenColors.removeAll();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function removeUserChosenComponentByType(param1:String) : void
      {
         var _loc3_:CcComponent = null;
         var _loc2_:int = int(this._userChosenComponents.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this._userChosenComponents[_loc2_] as CcComponent;
            if(_loc3_.componentThumb.type == param1)
            {
               this._userChosenComponents.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      public function getUserChosenColorByColorReference(param1:String) : CcColor
      {
         var _loc2_:CcColor = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._userChosenColors.length)
         {
            _loc2_ = this._userChosenColors.getValueByIndex(_loc3_) as CcColor;
            if(_loc2_.ccColorThumb.colorReference == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getUserChosenColorByComponentType(param1:String) : Array
      {
         var _loc3_:CcColor = null;
         var _loc2_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < this._userChosenColors.length)
         {
            _loc3_ = this._userChosenColors.getValueByIndex(_loc4_) as CcColor;
            if(_loc3_.ccColorThumb.componentType == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getUserChosenColorByIndex(param1:int) : CcColor
      {
         return this._userChosenColors.getValueByIndex(param1);
      }
      
      public function transformBodyShape(param1:anifire.cc_theme_lib.CcBodyShape) : void
      {
         var _loc2_:CcComponent = null;
         var _loc3_:CcComponent = null;
         var _loc4_:CcComponentThumb = null;
         var _loc5_:String = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:CcComponentThumb = null;
         if(param1.id != this.bodyShape.id)
         {
            this._bodyShape = param1;
            _loc2_ = new CcComponent();
            _loc2_.componentThumb = CcComponentThumb.createBodyShapeComponentThumb(this.bodyShape);
            this.addUserChosenComponent(_loc2_);
            _loc3_ = new CcComponent();
            _loc4_ = this.bodyShape.getComponentThumbByType(CcLibConstant.COMPONENT_TYPE_SKELETON).getValueByIndex(0) as CcComponentThumb;
            _loc3_.componentThumb = _loc4_;
            this.addUserChosenComponent(_loc3_);
            for each(_loc5_ in CcLibConstant.USER_CHOOSE_ABLE_BODY_COMPONENT_TYPES)
            {
               if(_loc5_ != CcLibConstant.COMPONENT_TYPE_BODYSHAPE)
               {
                  _loc6_ = new UtilHashArray();
                  _loc7_ = this.bodyShape.getComponentThumbByType(_loc5_).getValueByIndex(0) as CcComponentThumb;
                  _loc6_.push(_loc7_.componentId,_loc7_);
                  this.randomlyChooseComponentInArray(_loc6_,this.bodyShape.bodyType);
               }
            }
         }
      }
      
      public function clone() : CcCharacter
      {
         var _loc1_:int = 0;
         var _loc3_:CcColor = null;
         var _loc4_:CcComponent = null;
         var _loc2_:CcCharacter = new CcCharacter();
         _loc2_.currentTheme = this.currentTheme;
         _loc2_.assetId = this.assetId;
         _loc2_.bodyShape = this.bodyShape;
         _loc2_._name = this._name;
         _loc2_._tags = this.tags.slice();
         _loc1_ = 0;
         while(_loc1_ < this.getUserChosenColorNum())
         {
            _loc3_ = this.getUserChosenColorByIndex(_loc1_);
            _loc2_.addUserChosenColor(_loc3_.clone());
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getUserChosenComponentSize())
         {
            _loc4_ = this.getUserChosenComponentByIndex(_loc1_);
            _loc2_.addUserChosenComponent(_loc4_.clone());
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get tags() : Array
      {
         return this._tags;
      }
      
      public function get bodyShape() : anifire.cc_theme_lib.CcBodyShape
      {
         return this._bodyShape;
      }
      
      public function set currentTheme(param1:anifire.cc_theme_lib.CcTheme) : void
      {
         this._currentTheme = param1;
      }
      
      public function removeAllUserChosenComponent() : void
      {
         this._userChosenComponents.splice(0,this._userChosenComponents.length);
      }
      
      public function get assetId() : String
      {
         return this._assetId;
      }
      
      public function removeUserChosenComponentById(param1:String) : void
      {
         var _loc4_:CcComponent = null;
         var _loc5_:CcColor = null;
         var _loc2_:int = int(this._userChosenComponents.length - 1);
         while(_loc2_ >= 0)
         {
            if((_loc4_ = this._userChosenComponents[_loc2_] as CcComponent).id == param1)
            {
               this._userChosenComponents.splice(_loc2_,1);
            }
            _loc2_--;
         }
         var _loc3_:int = this._userChosenColors.length - 1;
         while(_loc3_ >= 0)
         {
            if((_loc5_ = this._userChosenColors.getValueByIndex(_loc3_) as CcColor).ccComponent != null && _loc5_.ccComponent.id == param1)
            {
               this._userChosenColors.remove(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function randomize(param1:anifire.cc_theme_lib.CcTheme, param2:String, param3:anifire.cc_theme_lib.CcBodyShape = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:CcCharacter = null;
         if(Math.random() > CcLibConstant.PROBABILITY_RANDOM_FROM_PRE_MADE_CHAR)
         {
            _loc5_ = true;
         }
         else if(param1.preMadeChars.length <= 0)
         {
            _loc5_ = true;
         }
         else
         {
            _loc5_ = true;
            _loc4_ = 0;
            while(_loc4_ < param1.preMadeChars.length)
            {
               if((_loc6_ = param1.preMadeChars[_loc4_] as CcCharacter).bodyShape.bodyType == param2)
               {
                  _loc5_ = false;
                  break;
               }
               _loc4_++;
            }
         }
         if(_loc5_)
         {
            this.randomizeEverythingRandomlly(param1,param2,param3);
         }
         else
         {
            this.randomizeFromPreMadeChar(param1,param2);
         }
      }
      
      public function cloneFromSourceToMe(param1:CcCharacter) : void
      {
         var _loc2_:int = 0;
         this.currentTheme = param1.currentTheme;
         this.removeAllUserChosenComponent();
         _loc2_ = 0;
         while(_loc2_ < param1.getUserChosenComponentSize())
         {
            this.addUserChosenComponent(param1.getUserChosenComponentByIndex(_loc2_));
            _loc2_++;
         }
         this.removeAllUserChosenColors();
         _loc2_ = 0;
         while(_loc2_ < param1.getUserChosenColorNum())
         {
            this.addUserChosenColor(param1.getUserChosenColorByIndex(_loc2_));
            _loc2_++;
         }
         this.bodyShape = param1.bodyShape;
         this.assetId = param1.assetId;
         this._name = param1._name;
         this._tags = param1.tags.slice();
      }
      
      public function getUserChosenComponentByComponentType(param1:String) : Array
      {
         var _loc3_:CcComponent = null;
         var _loc2_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < this._userChosenComponents.length)
         {
            _loc3_ = this._userChosenComponents[_loc4_] as CcComponent;
            if(_loc3_.componentThumb.type == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get createDateTime() : String
      {
         return this._createDateTime;
      }
      
      public function getUserChosenComponentByIndex(param1:int) : CcComponent
      {
         return this._userChosenComponents[param1] as CcComponent;
      }
      
      public function set bodyShape(param1:anifire.cc_theme_lib.CcBodyShape) : void
      {
         this._bodyShape = param1;
      }
      
      public function calculateGoPoint() : Number
      {
         var _loc1_:CcComponent = null;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.getUserChosenComponentSize())
         {
            _loc1_ = this.getUserChosenComponentByIndex(_loc3_);
            _loc2_ += _loc1_.componentThumb.sharingPoint;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getUserChosenComponentSize() : Number
      {
         return this._userChosenComponents.length;
      }
      
      public function get currentTheme() : anifire.cc_theme_lib.CcTheme
      {
         return this._currentTheme;
      }
      
      private function randomizeFromPreMadeChar(param1:anifire.cc_theme_lib.CcTheme, param2:String) : void
      {
         var _loc4_:CcCharacter = null;
         var _loc3_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < param1.preMadeChars.length)
         {
            if((_loc4_ = param1.preMadeChars[_loc5_] as CcCharacter).bodyShape.bodyType == param2)
            {
               _loc3_.push(_loc4_);
            }
            _loc5_++;
         }
         var _loc6_:int = Math.floor(Math.random() * _loc3_.length);
         _loc4_ = _loc3_[_loc6_] as CcCharacter;
         var _loc7_:UtilHashArray;
         (_loc7_ = new UtilHashArray()).push(param1.id,param1);
         this.cloneFromSourceToMe(_loc4_);
      }
      
      public function set assetId(param1:String) : void
      {
         this._assetId = param1;
      }
      
      public function getFacialByFacialId(param1:String) : CcFacial
      {
         return this.currentTheme.getFacialById(param1);
      }
      
      public function addUserChosenColor(param1:CcColor) : void
      {
         var _loc2_:String = null;
         if(param1.ccComponent != null && CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1.ccColorThumb.componentType) > -1)
         {
            _loc2_ = param1.ccComponent.id + param1.ccColorThumb.internalId;
         }
         else
         {
            _loc2_ = param1.ccColorThumb.internalId;
         }
         this._userChosenColors.push(_loc2_,param1);
      }
      
      public function serialize() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < this.getUserChosenColorNum())
         {
            _loc2_ += this.getUserChosenColorByIndex(_loc1_).serialize();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getUserChosenComponentSize())
         {
            _loc2_ += this.getUserChosenComponentByIndex(_loc1_).serialize();
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function calculateGobuck() : Number
      {
         var _loc1_:CcComponent = null;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.getUserChosenComponentSize())
         {
            _loc1_ = this.getUserChosenComponentByIndex(_loc3_);
            _loc2_ += _loc1_.componentThumb.money;
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function randomlyChooseComponentInArray(param1:UtilHashArray, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:CcComponentThumb = null;
         var _loc5_:CcComponent = null;
         var _loc6_:CcColorThumb = null;
         var _loc7_:CcColor = null;
         if(param1 != null && param1.length > 0)
         {
            param1 = param1.clone();
            _loc3_ = param1.length - 1;
            while(_loc3_ >= 0)
            {
               if(!(_loc4_ = param1.getValueByIndex(_loc3_) as CcComponentThumb).is_randomable)
               {
                  param1.remove(_loc3_,1);
               }
               _loc3_--;
            }
            _loc4_ = param1.getValueByIndex(Math.random() * param1.length) as CcComponentThumb;
            _loc5_ = new CcComponent();
            _loc5_.xscale = _loc5_.yscale = CcCharacter.getComponentScaling(param2);
            _loc5_.componentThumb = _loc4_;
            this.addUserChosenComponent(_loc5_);
            _loc3_ = 0;
            while(_loc3_ < _loc4_.getMyOwnColorNum())
            {
               _loc6_ = _loc4_.getMyOwnColorByIndex(_loc3_);
               (_loc7_ = new CcColor()).ccColorThumb = _loc6_;
               _loc7_.colorValue = _loc6_.defaultColor;
               this.addUserChosenColor(_loc7_);
               _loc3_++;
            }
         }
      }
      
      public function getUserChosenColorNum() : Number
      {
         return this._userChosenColors.length;
      }
      
      private function addBodyShapeThumb() : void
      {
      }
      
      private function randomizeEverythingRandomlly(param1:anifire.cc_theme_lib.CcTheme, param2:String, param3:anifire.cc_theme_lib.CcBodyShape = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:UtilHashArray = null;
         var _loc6_:CcComponentThumb = null;
         var _loc7_:CcColorThumb = null;
         var _loc8_:CcColor = null;
         var _loc10_:int = 0;
         var _loc14_:Number = NaN;
         var _loc9_:Array = param1.getBodyShapesByShapeType(param2);
         this._currentTheme = param1;
         this.removeAllUserChosenColors();
         this.removeAllUserChosenComponent();
         _loc10_ = 0;
         while(_loc10_ < param1.getColorThumbNum())
         {
            _loc7_ = param1.getColorThumbByIndex(_loc10_);
            if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(_loc7_.componentType) == -1)
            {
               (_loc8_ = new CcColor()).ccColorThumb = _loc7_;
               _loc8_.colorValue = _loc7_.colorChoices[Math.floor(Math.random() * _loc7_.colorChoices.length)];
               this.addUserChosenColor(_loc8_);
            }
            _loc10_++;
         }
         if(param3 == null)
         {
            this._bodyShape = _loc9_[Math.floor(Math.random() * _loc9_.length)] as anifire.cc_theme_lib.CcBodyShape;
         }
         else
         {
            this._bodyShape = param3;
         }
         var _loc11_:CcComponent;
         (_loc11_ = new CcComponent()).componentThumb = CcComponentThumb.createBodyShapeComponentThumb(this.bodyShape);
         this.addUserChosenComponent(_loc11_);
         var _loc12_:CcComponent = new CcComponent();
         var _loc13_:CcComponentThumb = this.bodyShape.getComponentThumbByType(CcLibConstant.COMPONENT_TYPE_SKELETON).getValueByIndex(0) as CcComponentThumb;
         _loc12_.componentThumb = _loc13_;
         this.addUserChosenComponent(_loc12_);
         for each(_loc4_ in CcLibConstant.USER_CHOOSE_ABLE_BODY_COMPONENT_TYPES)
         {
            _loc14_ = CcLibConstant.GET_COMPONENT_TYPE_OCCURANCE_PROBABILITY(_loc4_);
            if(Math.random() < _loc14_)
            {
               _loc5_ = this.bodyShape.getComponentThumbByType(_loc4_);
               this.randomlyChooseComponentInArray(_loc5_,this.bodyShape.bodyType);
            }
         }
         for each(_loc4_ in CcLibConstant.USER_CHOOSE_ABLE_HEAD_COMPONENT_TYPES)
         {
            _loc14_ = CcLibConstant.GET_COMPONENT_TYPE_OCCURANCE_PROBABILITY(_loc4_);
            if(Math.random() < _loc14_)
            {
               _loc5_ = param1.getComponentThumbByType(_loc4_);
               this.randomlyChooseComponentInArray(_loc5_,this.bodyShape.bodyType);
            }
         }
      }
      
      public function get thumbnailActionId() : String
      {
         return this.bodyShape.thumbnailActionId;
      }
      
      public function get category() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this._category == null)
         {
            _loc1_ = "_category_";
            this._category = "";
            _loc3_ = 0;
            while(_loc3_ < this.tags.length)
            {
               _loc2_ = this.tags[_loc3_] as String;
               if(_loc2_.substr(0,_loc1_.length) == _loc1_)
               {
                  this._category = _loc2_.substr(_loc1_.length);
                  break;
               }
               _loc3_++;
            }
         }
         return this._category;
      }
      
      public function addUserChosenComponent(param1:CcComponent) : void
      {
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1.componentThumb.type) == -1)
         {
            this.removeUserChosenComponentByType(param1.componentThumb.type);
         }
         this._userChosenComponents.push(param1);
      }
   }
}
