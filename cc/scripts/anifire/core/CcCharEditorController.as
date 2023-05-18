package anifire.core
{
   import anifire.cc_interface.ICcCharEditorContainer;
   import anifire.cc_theme_lib.CcBodyShape;
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcColor;
   import anifire.cc_theme_lib.CcComponent;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcBodyShapeChooserEvent;
   import anifire.event.CcButtonBarEvent;
   import anifire.event.CcColorPickerEvent;
   import anifire.event.CcComponentThumbChooserEvent;
   import anifire.event.CcComponentTypeChooserEvent;
   import anifire.event.CcCoreEvent;
   import anifire.event.CcPreMadeCharChooserEvent;
   import anifire.event.CcSelectedDecorationEvent;
   import anifire.event.CcThumbPropertyEvent;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class CcCharEditorController extends EventDispatcher
   {
       
      
      private var _moneyMode:int;
      
      private var _currentCommandIndex:Number = -1;
      
      private var isNewCharInsteadOfExistingChar:Boolean;
      
      private var _currentTheme:CcTheme;
      
      private var _ccCharCopyForReset:CcCharacter;
      
      private var _currentComponentType:String;
      
      private var _coupon:int;
      
      private var _commands:Array;
      
      private var _ui_ce_container:ICcCharEditorContainer;
      
      private var _ccChar:CcCharacter;
      
      private var _userLevel:int;
      
      private var _isUserLogined:Boolean;
      
      public function CcCharEditorController(param1:IEventDispatcher = null)
      {
         this._commands = new Array();
         super(param1);
      }
      
      private function get moneyMode() : int
      {
         return this._moneyMode;
      }
      
      private function onUserClickRandomizeButton(param1:Event) : void
      {
         var _loc4_:CcComponent = null;
         this.ccChar.randomize(this.currentTheme,this.ccChar.bodyShape.bodyType);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         var _loc2_:Number = this.ccChar.getUserChosenComponentSize();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.ccChar.getUserChosenComponentByIndex(_loc3_)).componentThumb.type == this.currentComponentType)
            {
               this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc4_,this.userLevel);
            }
            _loc3_++;
         }
         this.propagateNewCharToUi(this.ccChar);
         this.refreshCurrentUi();
         this.addCommand(this.ccChar);
      }
      
      private function initChar(param1:CcCharacter) : void
      {
         this._ccChar = param1;
      }
      
      private function onUserChoosePreMadeChar(param1:CcPreMadeCharChooserEvent) : void
      {
         var _loc5_:CcComponent = null;
         var _loc2_:CcCharacter = param1.ccCharChosen;
         this.copyCcChar(_loc2_);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         var _loc3_:Number = this.ccChar.getUserChosenComponentSize();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.ccChar.getUserChosenComponentByIndex(_loc4_)).componentThumb.type == this.currentComponentType)
            {
               this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc5_,this.userLevel);
            }
            _loc4_++;
         }
         this.propagateNewCharToUi(this.ccChar);
         if(this.currentComponentType)
         {
            this.refreshCurrentUi();
         }
         this.addCommand(this.ccChar);
      }
      
      private function onUserOverDecoration(param1:CcSelectedDecorationEvent) : void
      {
         var _loc2_:CcComponent = param1.ccComponent;
         this.ui_ce_container.ui_ce_charPreviewer.highlightComponent(_loc2_);
      }
      
      private function get ccCharCopyForReset() : CcCharacter
      {
         return this._ccCharCopyForReset;
      }
      
      private function switchComponentType(param1:String, param2:Boolean) : void
      {
         var _loc8_:CcComponent = null;
         var _loc3_:String = String(param1 == "componentGroupClothes" ? "body" : param1);
         _loc3_ = _loc3_.charAt(0).toUpperCase() + _loc3_.substr(1);
         Util.gaTracking("/creator/Pick" + _loc3_,this.ui_ce_container.ui_ce_mainViewStack);
         this.currentComponentType = param1;
         if(param2)
         {
            this.ui_ce_container.ui_ce_componentTypeChooser.switchToComponentType(param1,false);
         }
         var _loc4_:Array = CcLibConstant.USER_CHOOSE_ABLE_HEAD_COMPONENT_TYPES;
         var _loc5_:Array = new Array();
         if(_loc4_.indexOf(param1) > -1)
         {
            this.ui_ce_container.ui_ce_charPreviewer.zoomInFacial();
         }
         else
         {
            this.ui_ce_container.ui_ce_charPreviewer.zoomOutFacial();
         }
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) > -1)
         {
            this.ui_ce_container.ui_ce_selectedDecoration.visible = true;
         }
         else
         {
            this.ui_ce_container.ui_ce_selectedDecoration.visible = false;
         }
         if(param1 == CcLibConstant.COMPONENT_TYPE_BODYSHAPE)
         {
            this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_bodyShapeMegaChooser;
         }
         else if(param1 == CcLibConstant.COMPONENT_GROUP_UPPER_LOWER)
         {
            _loc5_.push(CcLibConstant.COMPONENT_TYPE_UPPER_BODY);
            _loc5_.push(CcLibConstant.COMPONENT_TYPE_LOWER_BODY);
            this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_mainEditorComponentsContainer;
            this.ui_ce_container.ui_ce_componentChooserViewStack.selectedChild = this.ui_ce_container.ui_ce_clothesChooser;
            this.ui_ce_container.ui_ce_clothesChooser.init(this.ccChar,this.currentTheme,param1,this.moneyMode,false);
            this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         }
         else
         {
            _loc5_.push(param1);
            this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_mainEditorComponentsContainer;
            this.ui_ce_container.ui_ce_componentChooserViewStack.selectedChild = this.ui_ce_container.ui_ce_componentThumbChooser;
            this.ui_ce_container.ui_ce_componentThumbChooser.init(this.ccChar,this.currentTheme,param1,this.moneyMode,CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) > -1 ? false : true);
            this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         }
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         var _loc6_:Number = this.ccChar.getUserChosenComponentSize();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = this.ccChar.getUserChosenComponentByIndex(_loc7_);
            if(_loc5_.indexOf(_loc8_.componentThumb.type) >= 0 && CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) == -1 || _loc8_.componentThumb.type == CcLibConstant.COMPONENT_TYPE_BODYSHAPE && _loc5_.indexOf(CcLibConstant.COMPONENT_TYPE_FACESHAPE) >= 0)
            {
               this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc8_,_loc8_.componentThumb.type,this.currentTheme,this.ccChar);
               this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc8_,_loc8_.componentThumb,this.currentTheme,this.ccChar);
               this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc8_,this.userLevel);
            }
            _loc7_++;
         }
      }
      
      private function onUserClickSaveButton(param1:Event) : void
      {
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.USER_WANT_TO_PREVIEW,this));
      }
      
      private function onUserChooseNullThumb(param1:CcComponentThumbChooserEvent) : void
      {
         var _loc2_:CcComponent = new CcComponent();
         _loc2_.xscale = _loc2_.yscale = CcCharacter.getComponentScaling(this.ccChar.bodyShape.bodyType);
         _loc2_.componentThumb = param1.componentThumb;
         this.ccChar.removeUserChosenComponentByType(param1.noneComponentThumbType);
         this.ui_ce_container.ui_ce_charPreviewer.initByCcChar(this.ccChar,this.ccChar.bodyShape.thumbnailActionId);
         this.refreshMoney();
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc2_,param1.noneComponentThumbType,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         this.addCommand(this.ccChar);
      }
      
      private function onUserChooseDecoration(param1:CcSelectedDecorationEvent) : void
      {
         var _loc2_:CcComponent = param1.ccComponent;
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc2_,_loc2_.componentThumb.type,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc2_,_loc2_.componentThumb,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc2_,this.userLevel);
         this.refreshMoney();
      }
      
      public function initTheme(param1:CcTheme) : void
      {
         this._currentTheme = param1;
         this.ui_ce_container.ui_ce_componentTypeChooser.init(this.currentTheme,false);
         this.ui_ce_container.ui_ce_bodyShapeMegaChooser.init();
      }
      
      private function onUserChooseBodyShape(param1:CcBodyShapeChooserEvent) : void
      {
         var _loc2_:CcBodyShape = param1.bodyShapeChosen;
         if(_loc2_ != null)
         {
            this.ccChar.transformBodyShape(_loc2_);
            this.onUserChooseBodyShapeCommon();
         }
      }
      
      private function onUserChooseCloth(param1:CcComponentThumbChooserEvent) : void
      {
         var _loc3_:CcComponent = null;
         var _loc2_:CcComponent = new CcComponent();
         _loc2_.componentThumb = param1.componentThumb;
         this.onUserChooseThumbCommon(_loc2_);
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         _loc3_ = this.ccChar.getUserChosenComponentByComponentType(CcLibConstant.COMPONENT_TYPE_UPPER_BODY)[0] as CcComponent;
         this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc3_,CcLibConstant.COMPONENT_TYPE_UPPER_BODY,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc3_,_loc3_.componentThumb,this.currentTheme,this.ccChar);
         _loc3_ = this.ccChar.getUserChosenComponentByComponentType(CcLibConstant.COMPONENT_TYPE_LOWER_BODY)[0] as CcComponent;
         this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc3_,CcLibConstant.COMPONENT_TYPE_LOWER_BODY,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc3_,_loc3_.componentThumb,this.currentTheme,this.ccChar);
      }
      
      private function set ccCharCopyForReset(param1:CcCharacter) : void
      {
         this._ccCharCopyForReset = param1;
      }
      
      private function onUserDeleteDecoration(param1:CcSelectedDecorationEvent) : void
      {
         var _loc2_:CcComponent = param1.ccComponent;
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         this.ui_ce_container.ui_ce_charPreviewer.removeComponent(_loc2_);
         this.ccChar.removeUserChosenComponentById(_loc2_.id);
         this.refreshMoney();
         this.addCommand(this.ccChar);
      }
      
      private function get coupon() : int
      {
         return this._coupon;
      }
      
      private function onUserChooseThumbCommon(param1:CcComponent) : void
      {
         param1.xscale = param1.yscale = CcCharacter.getComponentScaling(this.ccChar.bodyShape.bodyType);
         this.ccChar.addUserChosenComponent(param1);
         this.ui_ce_container.ui_ce_charPreviewer.switchComponent(param1,this.ccChar,this.ccChar.bodyShape.thumbnailActionId);
         this.refreshMoney();
         this.ui_ce_container.ui_ce_thumbPropertyInspector.init(param1,this.userLevel);
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1.componentThumb.type) > -1)
         {
            this.ui_ce_container.ui_ce_selectedDecoration.addComponent(param1);
         }
         this.addCommand(this.ccChar);
      }
      
      private function onUserChooseBodyShapeCommon() : void
      {
         var _loc1_:UtilHashArray = null;
         if(this.isNewCharInsteadOfExistingChar)
         {
            _loc1_ = new UtilHashArray();
            _loc1_.push(this.currentTheme.id,this.currentTheme);
            this.ccCharCopyForReset = new CcCharacter();
            this.ccCharCopyForReset.deserialize(this.ccChar.bodyShape.getDefaultCharXml(),_loc1_);
         }
         this.propagateNewCharToUi(this.ccChar);
         this.addCommand(this.ccChar);
         this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_mainEditorComponentsContainer;
         this.switchComponentType(CcLibConstant.COMPONENT_TYPE_CHOOSER_ORDERING[1] as String,true);
      }
      
      public function copyCcChar(param1:CcCharacter) : void
      {
         this._ccChar.cloneFromSourceToMe(param1);
      }
      
      private function refreshMoney() : void
      {
         if(this.moneyMode != CcLibConstant.MONEY_MODE_SCHOOL)
         {
            this.ui_ce_container.ui_ce_statusPanel.setGobuck(this.ccChar.calculateGobuck(),this.moneyMode,false,this.coupon);
            this.ui_ce_container.ui_ce_statusPanel.setGopoint(this.ccChar.calculateGoPoint(),this.moneyMode);
         }
         else
         {
            this.ui_ce_container.ui_ce_statusPanel.visible = false;
         }
      }
      
      private function onUserClickUndoButton(param1:Event) : void
      {
         var _loc5_:CcComponent = null;
         var _loc2_:CcCharacter = this._commands[this._currentCommandIndex - 2];
         this.copyCcChar(_loc2_.clone());
         this.ui_ce_container.ui_ce_charPreviewer.initByCcChar(this.ccChar,this.ccChar.thumbnailActionId);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         var _loc3_:Number = this.ccChar.getUserChosenComponentSize();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.ccChar.getUserChosenComponentByIndex(_loc4_)).componentThumb.type == this.currentComponentType)
            {
               this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc5_,this.userLevel);
            }
            _loc4_++;
         }
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(this.currentComponentType) > -1)
         {
            this.ui_ce_container.ui_ce_selectedDecoration.initByCcChar(this.ccChar);
         }
         this.refreshMoney();
         --this._currentCommandIndex;
         if(this._currentCommandIndex == 1)
         {
            this.ui_ce_container.ui_ce_buttonBar.btnUndo.enabled = false;
         }
         else
         {
            this.ui_ce_container.ui_ce_buttonBar.btnUndo.enabled = true;
         }
         this.ui_ce_container.ui_ce_buttonBar.btnRedo.enabled = true;
         this.refreshCurrentUi();
      }
      
      private function get ui_ce_container() : ICcCharEditorContainer
      {
         return this._ui_ce_container;
      }
      
      private function onUserWantToReset(param1:Event) : void
      {
         this.ccChar.cloneFromSourceToMe(this.ccCharCopyForReset);
         this.propagateNewCharToUi(this.ccChar);
         this.refreshCurrentUi();
         this.addCommand(this.ccChar);
      }
      
      private function onUserChooseBodyShapeAtFirstTime(param1:CcBodyShapeChooserEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:CcCharacter = null;
         var _loc5_:UtilHashArray = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onUserChooseBodyShapeAtFirstTime);
         this.ui_ce_container.ui_ce_bodyShapeChooser.addEventListener(CcBodyShapeChooserEvent.BODY_SHAPE_CHOSEN,this.onUserChooseBodyShape);
         var _loc2_:CcBodyShape = param1.bodyShapeChosen;
         if(_loc2_ != null && this.ccChar.getUserChosenComponentSize() == 0)
         {
            _loc3_ = _loc2_.getDefaultCharXml();
            _loc4_ = new CcCharacter();
            (_loc5_ = new UtilHashArray()).push(this.currentTheme.id,this.currentTheme);
            _loc4_.deserialize(_loc3_,_loc5_);
            this.ccChar.cloneFromSourceToMe(_loc4_);
            this.onUserChooseBodyShapeCommon();
         }
         else if(this.ccChar.getUserChosenComponentSize() > 0)
         {
         }
      }
      
      private function set currentComponentType(param1:String) : void
      {
         this._currentComponentType = param1;
      }
      
      private function propagateNewCharToUi(param1:CcCharacter) : void
      {
         this.ui_ce_container.ui_ce_charPreviewer.initByCcChar(param1,param1.thumbnailActionId);
         this.ui_ce_container.ui_ce_selectedDecoration.initByCcChar(this.ccChar);
         this.refreshMoney();
      }
      
      public function initUi(param1:ICcCharEditorContainer) : void
      {
         var self:CcCharEditorController = null;
         var ui_ce_container:ICcCharEditorContainer = param1;
         this._ui_ce_container = ui_ce_container;
         this.ui_ce_container.ui_ce_buttonBar.btnRedo.enabled = this.ui_ce_container.ui_ce_buttonBar.btnUndo.enabled = false;
         this.ui_ce_container.ui_ce_buttonBar.addEventListener(CcButtonBarEvent.UNDO_BUTTON_CLICK,this.onUserClickUndoButton);
         this.ui_ce_container.ui_ce_buttonBar.addEventListener(CcButtonBarEvent.REDO_BUTTON_CLICK,this.onUserClickRedoButton);
         this.ui_ce_container.ui_ce_buttonBar.addEventListener(CcButtonBarEvent.SAVE_BUTTON_CLICK,this.onUserClickSaveButton);
         this.ui_ce_container.ui_ce_buttonBar.addEventListener(CcButtonBarEvent.RANDOMIZE_BUTTON_CLICK,this.onUserClickRandomizeButton);
         this.ui_ce_container.ui_ce_buttonBar.addEventListener(CcButtonBarEvent.RESET_BUTTON_CLICK,this.onUserWantToReset);
         this.ui_ce_container.ui_ce_componentTypeChooser.addEventListener(CcComponentTypeChooserEvent.COMPONENT_TYPE_CHOSEN,this.onUserChooseType);
         this.ui_ce_container.ui_ce_componentTypeChooser.addEventListener(CcButtonBarEvent.SAVE_BUTTON_CLICK,this.onUserClickSaveButton);
         this.ui_ce_container.ui_ce_colorPicker.addEventListener(CcColorPickerEvent.COLOR_CHOSEN,this.onUserChooseColor);
         this.ui_ce_container.ui_ce_componentThumbChooser.addEventListener(CcComponentThumbChooserEvent.COMPONENT_THUMB_CHOSEN,this.onUserChooseThumb);
         this.ui_ce_container.ui_ce_componentThumbChooser.addEventListener(CcComponentThumbChooserEvent.NONE_COMPONENT_THUMB_CHOSEN,this.onUserChooseNullThumb);
         this.ui_ce_container.ui_ce_clothesChooser.addEventListener(CcComponentThumbChooserEvent.COMPONENT_THUMB_CHOSEN,this.onUserChooseCloth);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_UP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_DOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_LEFT_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_RIGHT_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEUP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEDOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEXUP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEXDOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEYUP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_SCALEYDOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_ROTATEUP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_ROTATEDOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_OFFSETUP_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_OFFSETDOWN_BUTTON_CLICK,this.onUserEditComponentProperty);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.addEventListener(CcThumbPropertyEvent.CCPROP_LOCATION_UPDATE,this.onUserUpdateComponentProperty);
         this.ui_ce_container.ui_ce_selectedDecoration.addEventListener(CcSelectedDecorationEvent.DECORATION_CHOOSEN,this.onUserChooseDecoration);
         this.ui_ce_container.ui_ce_selectedDecoration.addEventListener(CcSelectedDecorationEvent.DECORATION_MOUSE_OVER,this.onUserOverDecoration);
         this.ui_ce_container.ui_ce_selectedDecoration.addEventListener(CcSelectedDecorationEvent.DECORATION_MOUSE_OUT,this.onUserOutDecoration);
         this.ui_ce_container.ui_ce_selectedDecoration.addEventListener(CcSelectedDecorationEvent.DECORATION_DELETED,this.onUserDeleteDecoration);
         self = this;
         this.ui_ce_container.ui_ce_bodyShapeMegaChooser.addEventListener(CcPreMadeCharChooserEvent.PRE_MADE_CHAR_CHOSEN,function(param1:CcPreMadeCharChooserEvent):void
         {
            onUserChoosePreMadeChar(param1);
            self.switchComponentType(CcLibConstant.COMPONENT_GROUP_UPPER_LOWER,true);
         });
         this.ui_ce_container.ui_ce_bodyShapeMegaChooser.addEventListener(CcCoreEvent.USER_WANT_TO_PREVIEW,function(param1:CcCoreEvent):void
         {
            var _loc2_:CcPreMadeCharChooserEvent = new CcPreMadeCharChooserEvent(CcPreMadeCharChooserEvent.PRE_MADE_CHAR_CHOSEN,self);
            _loc2_.ccCharChosen = param1.getData() as CcCharacter;
            onUserChoosePreMadeChar(_loc2_);
            self.switchComponentType(CcLibConstant.COMPONENT_GROUP_UPPER_LOWER,true);
            onUserClickSaveButton(param1);
         });
      }
      
      private function get currentTheme() : CcTheme
      {
         return this._currentTheme;
      }
      
      private function refreshCurrentUi() : void
      {
         this.switchComponentType(this.currentComponentType,true);
      }
      
      public function initMode(param1:int, param2:Boolean, param3:int, param4:int = 0) : void
      {
         this._isUserLogined = param2;
         this._moneyMode = param1;
         this._userLevel = param3;
         this._coupon = param4;
      }
      
      private function onUserClickRedoButton(param1:Event) : void
      {
         var _loc5_:CcComponent = null;
         var _loc2_:CcCharacter = this._commands[this._currentCommandIndex];
         this.copyCcChar(_loc2_.clone());
         this.ui_ce_container.ui_ce_charPreviewer.initByCcChar(this.ccChar,this.ccChar.thumbnailActionId);
         this.ui_ce_container.ui_ce_thumbPropertyInspector.destroy();
         var _loc3_:Number = this.ccChar.getUserChosenComponentSize();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.ccChar.getUserChosenComponentByIndex(_loc4_)).componentThumb.type == this.currentComponentType)
            {
               this.ui_ce_container.ui_ce_thumbPropertyInspector.init(_loc5_,this.userLevel);
            }
            _loc4_++;
         }
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(this.currentComponentType) > -1)
         {
            this.ui_ce_container.ui_ce_selectedDecoration.initByCcChar(this.ccChar);
         }
         this.refreshMoney();
         ++this._currentCommandIndex;
         if(this._currentCommandIndex == this._commands.length)
         {
            this.ui_ce_container.ui_ce_buttonBar.btnRedo.enabled = false;
         }
         else
         {
            this.ui_ce_container.ui_ce_buttonBar.btnRedo.enabled = true;
         }
         this.ui_ce_container.ui_ce_buttonBar.btnUndo.enabled = true;
         this.refreshCurrentUi();
      }
      
      public function get ccChar() : CcCharacter
      {
         return this._ccChar;
      }
      
      private function onUserChooseType(param1:CcComponentTypeChooserEvent) : void
      {
         this.switchComponentType(param1.componentType,false);
      }
      
      public function start(param1:CcCharacter, param2:Boolean) : void
      {
         this.ui_ce_container.ui_ce_bodyShapeChooser.init(this.currentTheme,this.moneyMode);
         this.initChar(param1);
         this.isNewCharInsteadOfExistingChar = param2;
         if(this.isNewCharInsteadOfExistingChar)
         {
            this.ui_ce_container.ui_ce_bodyShapeChooser.addEventListener(CcBodyShapeChooserEvent.BODY_SHAPE_CHOSEN,this.onUserChooseBodyShapeAtFirstTime);
            this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_bodyShapeMegaChooser;
            Util.gaTracking("/creator/PickBodyshape",this.ui_ce_container.ui_ce_mainViewStack);
         }
         else
         {
            this.ui_ce_container.ui_ce_bodyShapeChooser.addEventListener(CcBodyShapeChooserEvent.BODY_SHAPE_CHOSEN,this.onUserChooseBodyShape);
            this.ui_ce_container.ui_ce_mainViewStack.selectedChild = this.ui_ce_container.ui_ce_mainEditorComponentsContainer;
            this.ccCharCopyForReset = this._ccChar.clone();
            this.addCommand(this.ccChar);
            this.propagateNewCharToUi(this.ccChar);
            this.switchComponentType(CcLibConstant.COMPONENT_TYPE_CHOOSER_ORDERING[1] as String,true);
         }
      }
      
      private function onUserChooseThumb(param1:CcComponentThumbChooserEvent) : void
      {
         var _loc3_:CcComponent = null;
         var _loc2_:CcComponent = new CcComponent();
         _loc2_.componentThumb = param1.componentThumb;
         this.onUserChooseThumbCommon(_loc2_);
         this.ui_ce_container.ui_ce_colorPicker.destroy();
         if(_loc2_.componentThumb.type == CcLibConstant.COMPONENT_TYPE_FACESHAPE)
         {
            _loc3_ = this.ccChar.getUserChosenComponentByComponentType(CcLibConstant.COMPONENT_TYPE_BODYSHAPE)[0] as CcComponent;
            this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc3_,_loc3_.componentThumb.type,this.currentTheme,this.ccChar);
            this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc3_,_loc3_.componentThumb,this.currentTheme,this.ccChar);
         }
         this.ui_ce_container.ui_ce_colorPicker.addComponentType(_loc2_,_loc2_.componentThumb.type,this.currentTheme,this.ccChar);
         this.ui_ce_container.ui_ce_colorPicker.addComponentThumb(_loc2_,_loc2_.componentThumb,this.currentTheme,this.ccChar);
      }
      
      private function get currentComponentType() : String
      {
         return this._currentComponentType;
      }
      
      private function onUserChooseColor(param1:CcColorPickerEvent) : void
      {
         var _loc2_:CcColor = param1.colorChosen;
         this.ui_ce_container.ui_ce_charPreviewer.updateColor(_loc2_);
         this.ccChar.addUserChosenColor(_loc2_);
         this.addCommand(this.ccChar);
      }
      
      private function onUserEditComponentProperty(param1:CcThumbPropertyEvent) : void
      {
         switch(param1.type)
         {
            case CcThumbPropertyEvent.CCPROP_UP_BUTTON_CLICK:
               --param1.component.y;
               break;
            case CcThumbPropertyEvent.CCPROP_DOWN_BUTTON_CLICK:
               ++param1.component.y;
               break;
            case CcThumbPropertyEvent.CCPROP_LEFT_BUTTON_CLICK:
               ++param1.component.x;
               break;
            case CcThumbPropertyEvent.CCPROP_RIGHT_BUTTON_CLICK:
               --param1.component.x;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEUP_BUTTON_CLICK:
               param1.component.xscale += 0.01;
               param1.component.yscale += 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEDOWN_BUTTON_CLICK:
               param1.component.xscale -= 0.01;
               param1.component.yscale -= 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEXUP_BUTTON_CLICK:
               param1.component.xscale += 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEXDOWN_BUTTON_CLICK:
               param1.component.xscale -= 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEYUP_BUTTON_CLICK:
               param1.component.yscale += 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_SCALEYDOWN_BUTTON_CLICK:
               param1.component.yscale -= 0.01;
               break;
            case CcThumbPropertyEvent.CCPROP_ROTATEUP_BUTTON_CLICK:
               param1.component.rotation += 1;
               break;
            case CcThumbPropertyEvent.CCPROP_ROTATEDOWN_BUTTON_CLICK:
               --param1.component.rotation;
               break;
            case CcThumbPropertyEvent.CCPROP_OFFSETUP_BUTTON_CLICK:
               ++param1.component.offset;
               break;
            case CcThumbPropertyEvent.CCPROP_OFFSETDOWN_BUTTON_CLICK:
               --param1.component.offset;
         }
         this.ui_ce_container.ui_ce_charPreviewer.updateLocation(param1.component);
      }
      
      private function addCommand(param1:CcCharacter) : void
      {
         var _loc2_:Array = this._commands.slice(0,this._currentCommandIndex);
         _loc2_.push(param1.clone());
         this._commands = _loc2_;
         this._currentCommandIndex = this._commands.length;
         this.ui_ce_container.ui_ce_buttonBar.btnUndo.enabled = this._commands.length > 1 ? true : false;
         this.ui_ce_container.ui_ce_buttonBar.btnRedo.enabled = false;
      }
      
      private function get isUserLogined() : Boolean
      {
         return this._isUserLogined;
      }
      
      private function onUserOutDecoration(param1:CcSelectedDecorationEvent) : void
      {
         var _loc2_:CcComponent = param1.ccComponent;
         this.ui_ce_container.ui_ce_charPreviewer.removeHighlightComponent(_loc2_);
      }
      
      private function get userLevel() : int
      {
         return this._userLevel;
      }
      
      private function onUserUpdateComponentProperty(param1:Event) : void
      {
         this.addCommand(this.ccChar);
      }
   }
}
