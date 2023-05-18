package anifire.component
{
   import anifire.color.SelectedColor;
   import anifire.constant.CcLibConstant;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.ExtraDataLoader;
   import anifire.util.UtilColor;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class CustomHeadMaker extends MovieClip
   {
      
      public static const COMPONENT_NEEDS_REPLACE:String = "event_replace_comp";
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
      
      public static const STATE_NULL:String = "null";
      
      public static const STATE_LOADING:String = "loading";
       
      
      private const DEFAULTHEAD:String = "defaultHead";
      
      private const LOWERBODY:String = "lower_body";
      
      private var should_decrypt:Boolean = true;
      
      private var _headSwfs:UtilHashArray;
      
      private const CLIPLOWER:String = "theLower";
      
      private var _state:String;
      
      private const BODYSHAPE:String = "bodyshape";
      
      private const LIB_LEFT:String = "Left";
      
      private const SWF_EXT:String = ".swf";
      
      private const UPPERBODY:String = "upper_body";
      
      private var _decorationQueue:Array;
      
      private const CLIPUPPER:String = "theUpper";
      
      private var _componentQueue:Array;
      
      private const LIB_RIGHT:String = "Right";
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private const SKELETON:String = "skeleton";
      
      private var _lookAtCamera:Boolean = false;
      
      private var _headXML:XML;
      
      private const XML_DESC:String = "desc.xml";
      
      private var _eventDispatcher:EventDispatcher;
      
      private const NODE_COMPONENT:String = "component";
      
      private var _componentOrder:Array;
      
      public function CustomHeadMaker()
      {
         this._componentOrder = CcLibConstant.ALL_BODY_COMPONENT_TYPES.concat(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD);
         this._componentQueue = new Array();
         this._decorationQueue = new Array();
         super();
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
      }
      
      private function onReady(param1:Event) : void
      {
         var _loc5_:XML = null;
         var _loc6_:SelectedColor = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onReady);
         var _loc2_:int = this.numChildren;
         while(_loc2_ > 0)
         {
            this.removeChildAt(_loc2_ - 1);
            _loc2_--;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._componentQueue.length)
         {
            if(this._componentQueue[_loc3_] != null)
            {
               this.addChild(this._componentQueue[_loc3_]);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._decorationQueue.length)
         {
            if(this._decorationQueue[_loc4_] != null)
            {
               this.addChild(this._decorationQueue[_loc4_]);
            }
            _loc4_++;
         }
         for each(_loc5_ in this.headXML.child(CcLibConstant.NODE_COLOR))
         {
            _loc6_ = new SelectedColor(_loc5_.@r,String(_loc5_.@oc).length == 0 ? uint(int.MAX_VALUE) : uint(_loc5_.@oc),uint(_loc5_));
            this.changeColor(_loc6_,_loc5_.@targetComponent == null ? "" : _loc5_.@targetComponent);
         }
         UtilPlain.gotoAndStopFamilyAt1(this);
         UtilPlain.playFamily(this);
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
      }
      
      public function changeColor(param1:SelectedColor, param2:String = "") : Number
      {
         var _loc3_:DisplayObject = null;
         if(param2 == "")
         {
            _loc3_ = this;
         }
         else
         {
            _loc3_ = UtilPlain.getInstance(this,param2);
         }
         return UtilColor.setAssetPartColor(_loc3_,param1.areaName,param1.dstColor);
      }
      
      private function get headXML() : XML
      {
         return this._headXML;
      }
      
      private function get state() : String
      {
         return this._state;
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      private function set headXML(param1:XML) : void
      {
         this._headXML = param1;
      }
      
      private function get headSwfs() : UtilHashArray
      {
         return this._headSwfs;
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
      }
      
      private function updateComponentImageData(param1:String, param2:ByteArray, param3:Object, param4:UtilLoadMgr, param5:Array = null, param6:String = "") : void
      {
         var _loc8_:UtilCrypto = null;
         var _loc9_:int = 0;
         if(this.should_decrypt)
         {
            (_loc8_ = new UtilCrypto()).decrypt(param2);
         }
         var _loc7_:ExtraDataLoader = new ExtraDataLoader();
         param4.addEventDispatcher(_loc7_.contentLoaderInfo,Event.COMPLETE);
         _loc7_.extraData = {
            "componentType":param1,
            "properties":param3
         };
         _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadedComponent);
         if(param6.length == 0)
         {
            _loc7_.name = param1;
         }
         else
         {
            _loc7_.name = param6;
         }
         _loc7_.loadBytes(param2);
         if(this._componentOrder.indexOf(param1) != -1)
         {
            _loc9_ = this._componentOrder.indexOf(param1);
            if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) > -1)
            {
               this._decorationQueue.push(_loc7_);
            }
            else
            {
               this._componentQueue[_loc9_] = _loc7_;
            }
         }
      }
      
      private function addDefinition(param1:LoaderInfo, param2:String, param3:Object) : void
      {
         var tmp:Class = null;
         var mytemp:DisplayObjectContainer = null;
         var mytempchild:DisplayObject = null;
         var index:int = 0;
         var loaderinfo:LoaderInfo = param1;
         var name:String = param2;
         var properties:Object = param3;
         var needsReplace:Boolean = false;
         var COMPONENT_RIGHT_NAME:String = name + this.LIB_RIGHT;
         var COMPONENT_LEFT_NAME:String = name + this.LIB_LEFT;
         var COMPONENT_RIGHT_SYMBOL_NAME:String = COMPONENT_RIGHT_NAME;
         var COMPONENT_LEFT_SYMBOL_NAME:String = COMPONENT_LEFT_NAME;
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this.lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_RIGHT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_RIGHT_SYMBOL_NAME += "_Cam";
         }
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this.lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_LEFT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_LEFT_SYMBOL_NAME += "_Cam";
         }
         try
         {
            tmp = loaderinfo.applicationDomain.getDefinition(COMPONENT_RIGHT_SYMBOL_NAME) as Class;
            mytemp = new tmp();
            mytemp.name = COMPONENT_RIGHT_NAME;
            mytempchild = mytemp.getChildAt(0);
            mytemp.x += Number(properties["x"]);
            mytemp.y += Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytemp.x -= Number(properties["offset"]) / 2;
            mytempchild.rotation = Number(properties["rotation"]);
            index = this._componentOrder.indexOf(mytemp.name);
            needsReplace = this._componentQueue[index] != null;
            if(needsReplace)
            {
               dispatchEvent(new ExtraDataEvent(COMPONENT_NEEDS_REPLACE,this,{
                  "old":this._componentQueue[index],
                  "replacement":mytemp
               }));
            }
            this._componentQueue[index] = mytemp;
         }
         catch(e:Error)
         {
         }
         try
         {
            tmp = loaderinfo.applicationDomain.getDefinition(COMPONENT_LEFT_SYMBOL_NAME) as Class;
            mytemp = new tmp();
            mytemp.name = COMPONENT_LEFT_NAME;
            mytempchild = mytemp.getChildAt(0);
            mytemp.x += Number(properties["x"]);
            mytemp.y += Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytemp.x += Number(properties["offset"]) / 2;
            mytempchild.rotation = -Number(properties["rotation"]);
            index = this._componentOrder.indexOf(mytemp.name);
            needsReplace = this._componentQueue[index] != null;
            if(needsReplace)
            {
               dispatchEvent(new ExtraDataEvent(COMPONENT_NEEDS_REPLACE,this,{
                  "old":this._componentQueue[index],
                  "replacement":mytemp
               }));
            }
            this._componentQueue[index] = mytemp;
         }
         catch(e:Error)
         {
         }
      }
      
      private function replaceChild(param1:ExtraDataEvent) : void
      {
         removeChild(param1.getData().old);
         addChild(param1.getData().replacement);
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      public function initBySwfs(param1:XML, param2:UtilHashArray) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:XML = null;
         this.should_decrypt = false;
         this._decorationQueue = new Array();
         this.headXML = param1;
         this.headSwfs = param2;
         var _loc6_:UtilLoadMgr;
         (_loc6_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         for each(_loc5_ in this.headXML.child(this.NODE_COMPONENT))
         {
            if(_loc5_.@type != this.SKELETON && _loc5_.@type != this.BODYSHAPE && _loc5_.@type != this.UPPERBODY && _loc5_.@type != this.LOWERBODY)
            {
               _loc3_ = _loc5_.@theme_id + "." + _loc5_.@type + "." + _loc5_.@component_id + this.SWF_EXT;
               _loc4_ = {
                  "x":_loc5_.@x,
                  "y":_loc5_.@y,
                  "xscale":_loc5_.@xscale,
                  "yscale":_loc5_.@yscale,
                  "offset":_loc5_.@offset,
                  "rotation":_loc5_.@rotation
               };
               this.updateComponentImageData(_loc5_.@type,this.headSwfs.getValueByKey(_loc3_),_loc4_,_loc6_,null,_loc5_.@id);
            }
         }
         _loc6_.commit();
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function set headSwfs(param1:UtilHashArray) : void
      {
         this._headSwfs = param1;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,param1));
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      private function loadedComponent(param1:Event) : void
      {
         var exdata:Object;
         var componentType:String = null;
         var properties:Object = null;
         var loaderInfo:LoaderInfo = null;
         var mytemp:DisplayObject = null;
         var mytempchild:DisplayObject = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.loadedComponent);
         exdata = ExtraDataLoader(LoaderInfo(event.currentTarget).loader).extraData;
         componentType = String(exdata["componentType"]);
         properties = exdata["properties"];
         loaderInfo = LoaderInfo(event.currentTarget);
         if(this._componentOrder.indexOf(componentType) == -1)
         {
            if(componentType == CcLibConstant.COMPONENT_TYPE_EYE && (loaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_RIGHT + "_Cam") || loaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_LEFT + "_Cam")))
            {
               addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  addEventListener(COMPONENT_NEEDS_REPLACE,replaceChild);
                  addDefinition(loaderInfo,componentType,properties);
                  removeEventListener(COMPONENT_NEEDS_REPLACE,replaceChild);
               });
            }
            this.addDefinition(loaderInfo,componentType,properties);
         }
         else
         {
            mytemp = ExtraDataLoader(LoaderInfo(event.currentTarget).loader);
            mytempchild = ExtraDataLoader(LoaderInfo(event.currentTarget).loader).getChildAt(0);
            mytemp.x += Number(properties["x"]);
            mytemp.y += Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytempchild.rotation = Number(properties["rotation"]);
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:int = this.numChildren;
         while(_loc1_ > 0)
         {
            this.removeChildAt(_loc1_ - 1);
            _loc1_--;
         }
         this._componentQueue = new Array();
      }
   }
}
