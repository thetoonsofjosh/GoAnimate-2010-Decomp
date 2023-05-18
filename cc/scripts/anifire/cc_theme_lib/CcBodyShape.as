package anifire.cc_theme_lib
{
   import anifire.util.UtilHashArray;
   
   public class CcBodyShape
   {
      
      public static const XML_NODE_NAME:String = "bodyshape";
       
      
      private var _themeId:String;
      
      private var _componentsByType:UtilHashArray;
      
      private var _thumbnailActionId:String;
      
      private var _thumbnailFacialId:String;
      
      private var _bodyType:String;
      
      private var _enable:Boolean;
      
      private var _name:String;
      
      private var _thumbnailPath:String;
      
      private var _components:UtilHashArray;
      
      private var _id:String;
      
      private var _shapeType:String;
      
      private var _actions:UtilHashArray;
      
      private var _defaultCharXml:XML;
      
      public function CcBodyShape()
      {
         this._components = new UtilHashArray();
         this._componentsByType = new UtilHashArray();
         this._actions = new UtilHashArray();
         super();
      }
      
      public function get thumbnailPath() : String
      {
         return this._thumbnailPath;
      }
      
      public function getActionNum() : Number
      {
         return this._actions.length;
      }
      
      public function deserialize(param1:XML, param2:String) : void
      {
         var _loc3_:XML = null;
         var _loc4_:CcComponentThumb = null;
         var _loc5_:CcAction = null;
         this._themeId = param2;
         this._id = param1.@id;
         this._name = param1.@name;
         this._thumbnailActionId = param1.@action_thumb;
         this._thumbnailFacialId = param1.@facial_thumb;
         this._thumbnailPath = param1.@thumb_path;
         this._bodyType = param1.@tag;
         this._enable = param1.@enable == "N" ? false : true;
         this._defaultCharXml = param1.child("default_char")[0];
         for each(_loc3_ in param1.child(CcComponentThumb.XML_NODE_NAME))
         {
            (_loc4_ = new CcComponentThumb()).deSerialize(_loc3_,this.themeId,CcComponentThumb.PARENT_TYPE_BODYSHAPE,this.id);
            this.addComponentThumb(_loc4_);
         }
         for each(_loc3_ in param1.child(CcAction.XML_NODE_NAME))
         {
            (_loc5_ = new CcAction()).deserialize(_loc3_);
            this.addAction(_loc5_);
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get thumbnailFacialId() : String
      {
         return this._thumbnailFacialId;
      }
      
      private function addComponentThumb(param1:CcComponentThumb) : void
      {
         this._components.push(param1.internalId,param1);
         var _loc2_:UtilHashArray = this._componentsByType.getValueByKey(param1.type);
         if(_loc2_ == null)
         {
            _loc2_ = new UtilHashArray();
            this._componentsByType.push(param1.type,_loc2_);
         }
         _loc2_.push(param1.internalId,param1);
      }
      
      public function get themeId() : String
      {
         return this._themeId;
      }
      
      public function getDefaultCharXml() : XML
      {
         return this._defaultCharXml;
      }
      
      public function get bodyType() : String
      {
         return this._bodyType;
      }
      
      public function getComponentThumbByType(param1:String) : UtilHashArray
      {
         return this._componentsByType.getValueByKey(param1);
      }
      
      public function getActionById(param1:String) : CcAction
      {
         return this._actions.getValueByKey(param1) as CcAction;
      }
      
      public function getActionByIndex(param1:int) : CcAction
      {
         return this._actions.getValueByIndex(param1) as CcAction;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      private function addAction(param1:CcAction) : void
      {
         this._actions.push(param1.id,param1);
      }
      
      public function get thumbnailActionId() : String
      {
         return this._thumbnailActionId;
      }
   }
}
