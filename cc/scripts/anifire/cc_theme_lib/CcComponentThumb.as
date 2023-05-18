package anifire.cc_theme_lib
{
   import anifire.constant.CcLibConstant;
   import anifire.event.CcComponentLoadEvent;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class CcComponentThumb extends EventDispatcher
   {
      
      public static const XML_NODE_NAME:String = "component";
      
      public static const PARENT_TYPE_THEME:int = 0;
      
      public static const PARENT_TYPE_BODYSHAPE:int = 0;
       
      
      private var _path:String;
      
      private var _themeId:String;
      
      private var _myOwnColors:UtilHashArray;
      
      private var _thumbnailFilename:String;
      
      private var _type:String;
      
      private var _isThumbnailLoading:Boolean = false;
      
      private var _display_order:int;
      
      private var _enable:Boolean;
      
      private var _parentType:int;
      
      private var _states:UtilHashArray;
      
      private var _thumbnailImageData:ByteArray = null;
      
      private var _money:Number;
      
      private var _componentId:String;
      
      private var _parentId:String;
      
      private var _is_randomable:Boolean;
      
      private var _name:String;
      
      private var _sharingPoint:Number;
      
      public function CcComponentThumb(param1:IEventDispatcher = null)
      {
         this._myOwnColors = new UtilHashArray();
         this._states = new UtilHashArray();
         super(param1);
      }
      
      public static function createBodyShapeComponentThumb(param1:CcBodyShape) : CcComponentThumb
      {
         var _loc2_:CcComponentThumb = new CcComponentThumb();
         _loc2_._type = CcLibConstant.COMPONENT_TYPE_BODYSHAPE;
         _loc2_._componentId = param1.id;
         _loc2_._path = param1.id;
         _loc2_._name = param1.name;
         _loc2_._thumbnailFilename = param1.thumbnailPath;
         _loc2_._money = 0;
         _loc2_._sharingPoint = 0;
         _loc2_._enable = false;
         _loc2_._is_randomable = true;
         _loc2_.parentType = PARENT_TYPE_THEME;
         _loc2_.parentId = param1.themeId;
         _loc2_._themeId = param1.themeId;
         return _loc2_;
      }
      
      internal static function generateInternalId(param1:String, param2:String) : String
      {
         return param1 + "_" + param2;
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function get parentType() : int
      {
         return this._parentType;
      }
      
      private function set parentType(param1:int) : void
      {
         this._parentType = param1;
      }
      
      public function get thumbnailFilename() : String
      {
         return this._thumbnailFilename;
      }
      
      public function get sharingPoint() : Number
      {
         return this._sharingPoint;
      }
      
      public function loadThumbnailImageData() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         if(!this._isThumbnailLoading)
         {
            if(this.thumbnailImageData != null)
            {
               this.dispatchEvent(new CcComponentLoadEvent(CcComponentLoadEvent.LOAD_THUMBNAIL_IMAGE_DATA_COMPLETE,this,null));
            }
            else
            {
               this._isThumbnailLoading = true;
               _loc1_ = new URLLoader();
               _loc1_.addEventListener(Event.COMPLETE,this.onLoadThumbnailComplete);
               _loc1_.dataFormat = URLLoaderDataFormat.BINARY;
               _loc2_ = UtilNetwork.getGetCcComponentStateFileRequest(this.themeId,this.type,this.path,this.thumbnailFilename);
               _loc1_.load(_loc2_);
            }
         }
      }
      
      public function get path() : String
      {
         return this._path;
      }
      
      public function getStateByStateId(param1:String) : CcState
      {
         return this._states.getValueByKey(param1) as CcState;
      }
      
      public function get displayOrder() : int
      {
         return this._display_order;
      }
      
      public function get thumbnailImageData() : ByteArray
      {
         return this._thumbnailImageData;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function loadStateImageData(param1:String) : void
      {
         var _loc2_:CcState = this.getStateByStateId(param1);
         _loc2_.addEventListener(CcComponentLoadEvent.LOAD_STATE_IMAGE_DATA_COMPLETE,this.onLoadStateImageDataComplete);
         _loc2_.loadImageData(UtilNetwork.getGetCcComponentStateFileRequest(this.themeId,this.type,this.path,_loc2_.filename));
      }
      
      public function get internalId() : String
      {
         return generateInternalId(this.type,this.componentId);
      }
      
      public function get money() : Number
      {
         return this._money;
      }
      
      public function getMyOwnColorNum() : int
      {
         return this._myOwnColors.length;
      }
      
      private function set parentId(param1:String) : void
      {
         this._parentId = param1;
      }
      
      private function addMyOwnColor(param1:CcColorThumb) : void
      {
         this._myOwnColors.push(param1.internalId,param1);
      }
      
      public function get is_randomable() : Boolean
      {
         return this._is_randomable;
      }
      
      public function get themeId() : String
      {
         return this._themeId;
      }
      
      public function deSerialize(param1:XML, param2:String, param3:int, param4:String) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:CcColorThumb = null;
         var _loc8_:CcState = null;
         this._type = param1.@type;
         this._componentId = param1.@id;
         this._path = param1.@path;
         this._name = param1.@name;
         this._thumbnailFilename = param1.@thumb;
         this._money = Number(param1.@money);
         this._sharingPoint = Number(param1.@sharing);
         this._enable = param1.@enable == "Y" ? true : false;
         this._is_randomable = param1.@random_able == "N" ? false : true;
         this._display_order = int(param1.@display_order);
         this.parentType = param3;
         this.parentId = param4;
         this._themeId = param2;
         for each(_loc5_ in param1.child(CcColorThumb.XML_NODE_NAME))
         {
            (_loc7_ = new CcColorThumb()).deSerialize(_loc5_,this.type);
            this.addMyOwnColor(_loc7_);
         }
         for each(_loc6_ in param1.child(CcState.XML_NODE_NAME))
         {
            (_loc8_ = new CcState()).deserialize(_loc6_);
            this.addState(_loc8_);
         }
      }
      
      private function onLoadThumbnailComplete(param1:Event) : void
      {
         var _loc3_:UtilCrypto = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadThumbnailComplete);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this._thumbnailImageData = _loc2_.data;
         if(CcLibConstant.SHOULD_DECRYPT)
         {
            _loc3_ = new UtilCrypto();
            _loc3_.decrypt(this._thumbnailImageData);
         }
         this._isThumbnailLoading = false;
         this.dispatchEvent(new CcComponentLoadEvent(CcComponentLoadEvent.LOAD_THUMBNAIL_IMAGE_DATA_COMPLETE,this,null));
      }
      
      private function get parentId() : String
      {
         return this._parentId;
      }
      
      private function onLoadStateImageDataComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadStateImageDataComplete);
         var _loc2_:CcState = param1.target as CcState;
         this.dispatchEvent(new CcComponentLoadEvent(CcComponentLoadEvent.LOAD_STATE_IMAGE_DATA_COMPLETE,this,_loc2_.stateId));
      }
      
      private function addState(param1:CcState) : void
      {
         this._states.push(param1.stateId,param1);
      }
      
      public function get componentId() : String
      {
         return this._componentId;
      }
      
      public function getMyOwnColorByIndex(param1:int) : CcColorThumb
      {
         return this._myOwnColors.getValueByIndex(param1);
      }
   }
}
