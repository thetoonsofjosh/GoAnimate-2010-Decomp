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
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilURLStream;
   import com.senocular.display.CloneUtility;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CustomCharacterMaker extends MovieClip
   {
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
      
      public static const STATE_NULL:String = "null";
      
      public static const LOOK_AT_CAMERA_CHANGED:String = "CcLookAtCamera";
      
      public static const STATE_LOADING:String = "loading";
       
      
      private var should_decrypt:Boolean = true;
      
      private const LOWERBODY:String = "lower_body";
      
      private var _charSwfs:UtilHashArray;
      
      private var _waiting:Array;
      
      private const BODYSHAPE:String = "bodyshape";
      
      private const UPPERBODY:String = "upper_body";
      
      private var _decoArray:Array;
      
      private const CLIPUPPER:String = "theUpper";
      
      private var _componentQueue:Array;
      
      private const SKELETON:String = "skeleton";
      
      private var _componentOrder:Array;
      
      private var _initCameraHandlers:Boolean = false;
      
      private var _lookAtCameraSupported:Boolean = false;
      
      private const DEFAULTHEAD:String = "defaultHead";
      
      private const CLIPLOWER:String = "theLower";
      
      private var _state:String;
      
      private const MC:String = "MC";
      
      private const LIB_LEFT:String = "Left";
      
      private const LIB_RIGHT:String = "Right";
      
      private const SWF_EXT:String = ".swf";
      
      private var _charZip:ZipFile;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var GoColorMapShaderClass:Class;
      
      private var _customColor:UtilHashArray;
      
      private var _charXML:XML;
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private const XML_DESC:String = "desc.xml";
      
      private var _lookAtCamera:Boolean = false;
      
      private const NODE_COMPONENT:String = "component";
      
      public function CustomCharacterMaker()
      {
         this.GoColorMapShaderClass = CustomCharacterMaker_GoColorMapShaderClass;
         this._charXML = ;
         this._componentOrder = CcLibConstant.ALL_BODY_COMPONENT_TYPES.concat(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD);
         this._componentQueue = new Array();
         this._waiting = new Array();
         this._decoArray = new Array();
         super();
         this._customColor = new UtilHashArray();
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
         CloneUtility.registerClass(this);
      }
      
      public function onReady(param1:Event = null) : void
      {
         var _loc2_:XML = null;
         var _loc4_:Date = null;
         var _loc5_:Date = null;
         var _loc6_:SelectedColor = null;
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onReady);
            _loc4_ = new Date();
            _loc5_ = UtilLoadMgr(param1.currentTarget).getExtraData() as Date;
         }
         var _loc3_:UtilHashArray = new UtilHashArray();
         for each(_loc2_ in this.charXML.child(CcLibConstant.NODE_COLOR))
         {
            _loc6_ = new SelectedColor(_loc2_.@r,String(_loc2_.@oc).length == 0 ? uint(int.MAX_VALUE) : uint(_loc2_.@oc),uint(_loc2_));
            this.changeColor(_loc6_,_loc2_.@targetComponent == null ? "" : _loc2_.@targetComponent);
            if(_loc6_.orgColor != int.MAX_VALUE)
            {
               _loc3_.push("0x" + _loc6_.orgColor.toString(16),"0x" + _loc6_.dstColor.toString(16));
            }
         }
         if(_loc3_.length > 0)
         {
            this.changeColorForShader(_loc3_);
         }
         UtilPlain.gotoAndStopFamilyAt1(this);
         if(!this.shouldPauseOnLoadBytesComplete)
         {
            UtilPlain.playFamily(this);
         }
         this._charSwfs = null;
         this.state = STATE_FINISH_LOAD;
         this.dispatchComplete();
      }
      
      public function updateByZip(param1:ByteArray) : void
      {
         var _loc2_:ZipFile = new ZipFile(param1);
         this.charZip = _loc2_;
         this.initByZip(_loc2_);
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
         this._decoArray = new Array();
      }
      
      public function updateColor(param1:Object) : void
      {
         var _loc2_:UtilHashArray = new UtilHashArray();
         var _loc3_:SelectedColor = new SelectedColor(param1["colorReference"],param1["originalColor"],param1["colorValue"]);
         this.changeColor(_loc3_,param1["targetComponentId"]);
         if(param1["originalColor"] != uint.MAX_VALUE)
         {
            this._customColor.push(_loc3_.areaName,_loc3_);
            _loc2_.push("0x" + _loc3_.orgColor.toString(16),"0x" + _loc3_.dstColor.toString(16));
         }
         if(_loc2_.length > 0)
         {
            this.changeColorForShader(_loc2_);
         }
      }
      
      public function initByZip(param1:ZipFile) : void
      {
         var _loc2_:String = null;
         var _loc3_:XML = null;
         var _loc4_:ZipEntry = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Loader = null;
         var _loc7_:ByteArray = null;
         var _loc8_:UtilCrypto = null;
         this.destroy();
         this.charXML = new XML(param1.getInput(param1.getEntry(this.XML_DESC)));
         trace("charXML:" + this.charXML);
         for each(_loc3_ in this.charXML.child(this.NODE_COMPONENT))
         {
            if(_loc3_.@type == this.SKELETON)
            {
               _loc2_ = _loc3_.@theme_id + "." + _loc3_.@type + "." + _loc3_.@component_id + this.SWF_EXT;
            }
         }
         if((_loc4_ = this.charZip.getEntry(_loc2_)) != null)
         {
            _loc5_ = this.charZip.getInput(this.charZip.getEntry(_loc2_));
            (_loc6_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadedSkeleton);
            if(this.should_decrypt)
            {
               _loc7_ = new ByteArray();
               _loc5_.readBytes(_loc7_);
               _loc7_.position = 0;
               (_loc8_ = new UtilCrypto()).decrypt(_loc7_);
               _loc6_.loadBytes(_loc7_);
            }
            else
            {
               _loc6_.loadBytes(_loc5_);
            }
            this.addChild(_loc6_);
         }
         this.visible = false;
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      public function initByLoaders(param1:UtilHashArray) : void
      {
         var _loc4_:ExtraDataLoader = null;
         var _loc2_:UtilLoadMgr = new UtilLoadMgr();
         _loc2_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         _loc2_.setExtraData(new Date());
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.getValueByIndex(_loc3_) as ExtraDataLoader;
            _loc2_.addEventDispatcher(_loc4_,Event.INIT);
            this.doLoadImageData(_loc4_);
            _loc3_++;
         }
         _loc2_.commit();
      }
      
      private function loadedSkeletonBySwfs(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:XML = null;
         this._decoArray = new Array();
         var _loc5_:UtilLoadMgr;
         (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         _loc5_.setExtraData(new Date());
         for each(_loc4_ in this.charXML.child(this.NODE_COMPONENT))
         {
            if(_loc4_.@type != this.BODYSHAPE)
            {
               _loc2_ = _loc4_.@theme_id + "." + _loc4_.@type + "." + _loc4_.@component_id + this.SWF_EXT;
               _loc3_ = {
                  "x":_loc4_.@x,
                  "y":_loc4_.@y,
                  "xscale":_loc4_.@xscale,
                  "yscale":_loc4_.@yscale,
                  "offset":_loc4_.@offset,
                  "rotation":_loc4_.@rotation
               };
               this.updateComponentImageData(_loc4_.@type,this.charSwfs.getValueByKey(_loc2_),_loc3_,_loc5_,null,_loc4_.@id);
            }
         }
         _loc5_.commit();
      }
      
      public function removeComponentById(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         var _loc4_:DisplayObjectContainer;
         var _loc5_:int = (_loc4_ = _loc3_.parent).numChildren - 1;
         while(_loc5_ >= 0)
         {
            if(_loc4_.getChildAt(_loc5_).name == param1)
            {
               _loc4_.removeChildAt(_loc5_);
            }
            _loc5_--;
         }
      }
      
      private function getDecoNumber() : Number
      {
         return this._decoArray.length > 0 ? this._decoArray.length : 100;
      }
      
      private function set charSwfs(param1:UtilHashArray) : void
      {
         this._charSwfs = param1;
      }
      
      private function get waiting() : Array
      {
         return this._waiting;
      }
      
      public function loadZip(param1:String, param2:String, param3:String = "") : void
      {
         var _loc4_:URLRequest = UtilNetwork.getGetCcActionRequest(param1,param2,param3);
         var _loc5_:UtilURLStream;
         (_loc5_ = new UtilURLStream()).addEventListener(Event.COMPLETE,this.doLoadZipComplete);
         _loc5_.load(_loc4_);
      }
      
      public function initBySwfs(param1:XML, param2:UtilHashArray) : void
      {
         if(this.state == STATE_NULL)
         {
            this.state = STATE_LOADING;
         }
         else
         {
            if(this.state == STATE_LOADING)
            {
               return;
            }
            if(this.state == STATE_FINISH_LOAD)
            {
               setTimeout(this.dispatchComplete,100);
               return;
            }
         }
         this.should_decrypt = false;
         this.charXML = param1;
         this.charSwfs = param2;
         this._waiting = new Array();
         this.visible = false;
         this.loadedSkeletonBySwfs(null);
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      private function loadedSkeleton(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:XML = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         this._decoArray = new Array();
         this.redoWaitingImageData();
         var _loc6_:UtilLoadMgr;
         (_loc6_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         for each(_loc5_ in this.charXML.child(this.NODE_COMPONENT))
         {
            if(_loc5_.@type != this.SKELETON && _loc5_.@type != this.BODYSHAPE)
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
               this.updateComponentImageData(_loc5_.@type,this.charZip.getInput(this.charZip.getEntry(_loc3_)),_loc4_,_loc6_,null,_loc5_.@id);
            }
         }
         _loc6_.commit();
      }
      
      private function doLoadedComponent(param1:ExtraDataLoader) : void
      {
         var embedContainer:DisplayObjectContainer = null;
         var componentType:String = null;
         var properties:Object = null;
         var colors:Array = null;
         var mytemp:DisplayObject = null;
         var mytempparent:DisplayObjectContainer = null;
         var i:int = 0;
         var color:Object = null;
         var loader:ExtraDataLoader = param1;
         embedContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         var exdata:Object = loader.extraData;
         componentType = String(exdata["componentType"]);
         properties = exdata["properties"];
         colors = exdata["colors"];
         if(this._componentOrder.indexOf(componentType) == -1)
         {
            if(componentType == CcLibConstant.COMPONENT_TYPE_EYE && (loader.contentLoaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_RIGHT + "_Cam") || loader.contentLoaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_LEFT + "_Cam")))
            {
               this._lookAtCameraSupported = true;
               addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  addDefinition(loader.contentLoaderInfo,componentType,properties,embedContainer,colors);
               });
            }
            this.addDefinition(loader.contentLoaderInfo,componentType,properties,embedContainer,colors);
         }
         else
         {
            if(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD.indexOf(componentType) > -1)
            {
               if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(componentType) == -1)
               {
                  this.updateLocation(componentType,properties);
               }
               else
               {
                  mytemp = loader;
                  mytempparent = loader.parent;
                  mytempparent.x = Number(properties["x"]);
                  mytempparent.y = Number(properties["y"]);
                  mytempparent.rotation = Number(properties["rotation"]);
                  mytempparent.scaleX = Number(properties["xscale"]);
                  mytempparent.scaleY = Number(properties["yscale"]);
               }
            }
            if(colors != null)
            {
               i = 0;
               while(i < colors.length)
               {
                  color = colors[i] as Object;
                  this.updateColor(color);
                  i++;
               }
            }
            loader.dispatchEvent(new Event(Event.INIT));
         }
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         return this._lookAtCameraSupported;
      }
      
      private function loadedComponent(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadedComponent);
         var _loc2_:ExtraDataLoader = ExtraDataLoader(param1.currentTarget);
         this.doLoadedComponent(_loc2_);
      }
      
      public function removeHighlight(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         if(_loc3_ != null)
         {
            _loc3_.filters = new Array();
         }
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
      
      private function get state() : String
      {
         return this._state;
      }
      
      private function doLoadImageData(param1:ExtraDataLoader) : void
      {
         var _loc8_:DisplayObjectContainer = null;
         var _loc9_:DisplayObjectContainer = null;
         var _loc10_:int = 0;
         var _loc11_:DisplayObjectContainer = null;
         var _loc12_:int = 0;
         var _loc2_:Object = param1.extraData;
         var _loc3_:String = String(_loc2_["componentType"]);
         var _loc4_:Object = _loc2_["properties"];
         var _loc5_:Array = _loc2_["colors"];
         var _loc6_:String = String(_loc2_["clipName"]);
         var _loc7_:Number = Number(_loc2_["index"]);
         if(_loc6_ != "")
         {
            _loc8_ = UtilPlain.getInstance(this,_loc6_);
         }
         else
         {
            _loc8_ = this;
         }
         if(_loc8_ != null)
         {
            if(this._componentOrder.indexOf(_loc3_) == -1)
            {
               this.doLoadedComponent(param1);
            }
            else if(_loc6_ == this.DEFAULTHEAD)
            {
               _loc9_ = UtilPlain.getInstance(_loc8_,_loc3_ + this.MC);
               if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(_loc3_) == -1)
               {
                  _loc10_ = _loc9_.numChildren;
                  while(_loc10_ > 0)
                  {
                     _loc9_.removeChildAt(_loc10_ - 1);
                     _loc10_--;
                  }
               }
               param1.addEventListener(Event.ADDED,this.loadedComponent);
               if(_loc7_ != -1)
               {
                  (_loc11_ = _loc9_.getChildAt(_loc7_) as DisplayObjectContainer).name = param1.name;
                  _loc11_.addChild(param1);
               }
               else
               {
                  _loc9_.addChild(param1);
               }
            }
            else
            {
               _loc12_ = _loc8_.numChildren;
               while(_loc12_ > 0)
               {
                  _loc8_.removeChildAt(_loc12_ - 1);
                  _loc12_--;
               }
               param1.addEventListener(Event.ADDED,this.loadedComponent);
               _loc8_.addChild(param1);
               if(_loc8_ == this)
               {
                  this.redoWaitingImageData();
               }
            }
         }
         else
         {
            this.waiting.push(param1);
         }
      }
      
      public function updateLocation(param1:String, param2:Object, param3:String = "") : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(this,this.DEFAULTHEAD)) != null)
         {
            if(this._componentOrder.indexOf(param1) == -1)
            {
               _loc6_ = (_loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.LIB_RIGHT)).getChildAt(0) as DisplayObjectContainer;
               _loc5_.x = Number(param2["x"]);
               _loc5_.y = Number(param2["y"]);
               _loc6_.scaleX = Number(param2["xscale"]);
               _loc6_.scaleY = Number(param2["yscale"]);
               _loc5_.x -= Number(param2["offset"]) / 2;
               _loc6_.rotation = Number(param2["rotation"]);
               _loc6_ = (_loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.LIB_LEFT)).getChildAt(0) as DisplayObjectContainer;
               _loc5_.x = Number(param2["x"]);
               _loc5_.y = Number(param2["y"]);
               _loc6_.scaleX = Number(param2["xscale"]);
               _loc6_.scaleY = Number(param2["yscale"]);
               _loc5_.x += Number(param2["offset"]) / 2;
               _loc6_.rotation = -Number(param2["rotation"]);
            }
            else
            {
               _loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.MC);
               if(param3 != "")
               {
                  _loc6_ = _loc5_.getChildByName(param3) as DisplayObjectContainer;
               }
               else
               {
                  _loc6_ = _loc5_.getChildAt(0) as DisplayObjectContainer;
               }
               if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) > -1)
               {
                  _loc6_.x = Number(param2["x"]);
                  _loc6_.y = Number(param2["y"]);
               }
               else
               {
                  _loc5_.x = Number(param2["x"]);
                  _loc5_.y = Number(param2["y"]);
               }
               _loc6_.scaleX = Number(param2["xscale"]);
               _loc6_.scaleY = Number(param2["yscale"]);
               _loc6_.rotation = Number(param2["rotation"]);
            }
         }
      }
      
      private function get charSwfs() : UtilHashArray
      {
         return this._charSwfs;
      }
      
      private function doLoadZipComplete(param1:Event) : void
      {
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ZipFile = new ZipFile(_loc3_);
         this.charZip = _loc4_;
         this.initByZip(_loc4_);
      }
      
      public function unloadAssetImage() : void
      {
         this.destroy();
      }
      
      public function highlightComponent(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         var _loc4_:GlowFilter = new GlowFilter(16777215);
         var _loc5_:Array;
         (_loc5_ = new Array()).push(_loc4_);
         _loc3_.filters = _loc5_;
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
      }
      
      public function changeColorForShader(param1:UtilHashArray) : Number
      {
         var _loc2_:Number = NaN;
         var _loc8_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc3_:Shader = new Shader();
         _loc3_.byteCode = new this.GoColorMapShaderClass();
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:UtilHashArray = new UtilHashArray();
         _loc8_ = 0;
         while(_loc8_ < this._customColor.length)
         {
            if(SelectedColor(this._customColor.getValueByIndex(_loc8_)).orgColor != uint.MAX_VALUE)
            {
               _loc7_.push("0x" + SelectedColor(this._customColor.getValueByIndex(_loc8_)).orgColor.toString(16),SelectedColor(this._customColor.getValueByIndex(_loc8_)).dstColor);
            }
            _loc8_++;
         }
         _loc7_.insert(0,param1,true);
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc6_.push(uint(_loc7_.getKey(_loc9_)));
            _loc12_ = uint(_loc7_.getValueByIndex(_loc9_)) >> 16 & 255;
            _loc13_ = uint(_loc7_.getValueByIndex(_loc9_)) >> 8 & 255;
            _loc14_ = uint(_loc7_.getValueByIndex(_loc9_)) & 255;
            if(_loc9_ / 4 < 1)
            {
               _loc4_[_loc9_ * 4 + 0] = _loc12_ / 255;
               _loc4_[_loc9_ * 4 + 1] = _loc13_ / 255;
               _loc4_[_loc9_ * 4 + 2] = _loc14_ / 255;
            }
            else
            {
               _loc5_[_loc9_ % 4 * 4 + 0] = _loc12_ / 255;
               _loc5_[_loc9_ % 4 * 4 + 1] = _loc13_ / 255;
               _loc5_[_loc9_ % 4 * 4 + 2] = _loc14_ / 255;
            }
            _loc9_++;
         }
         _loc3_.data["colorValue0"].value = _loc4_;
         _loc3_.data["colorValue1"].value = _loc5_;
         _loc3_.data["colorKey"].value = _loc6_;
         var _loc10_:Array = UtilPlain.getAllShaderObj(this);
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_.length)
         {
            DisplayObject(_loc10_[_loc11_]).blendMode = BlendMode.NORMAL;
            DisplayObject(_loc10_[_loc11_]).blendMode = BlendMode.SHADER;
            DisplayObject(_loc10_[_loc11_]).blendShader = _loc3_;
            _loc11_++;
         }
         return _loc2_;
      }
      
      private function onLoadImageData(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadImageData);
         var _loc2_:ExtraDataLoader = ExtraDataLoader(LoaderInfo(param1.currentTarget).loader);
         this.doLoadImageData(_loc2_);
      }
      
      private function set charXML(param1:XML) : void
      {
         this._charXML = param1;
      }
      
      public function prepareLoaderBySwfs(param1:XML, param2:UtilHashArray) : UtilHashArray
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:XML = null;
         var _loc8_:String = null;
         var _loc9_:ExtraDataLoader = null;
         var _loc6_:UtilLoadMgr = new UtilLoadMgr();
         var _loc7_:UtilHashArray = new UtilHashArray();
         _loc6_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onPrepareLoaderFinish);
         _loc6_.setExtraData(_loc7_);
         for each(_loc5_ in param1.child(this.NODE_COMPONENT))
         {
            if(_loc5_.@type != this.BODYSHAPE)
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
               switch(String(_loc5_.@type))
               {
                  case this.SKELETON:
                     _loc8_ = "";
                     _loc4_ = {
                        "x":0,
                        "y":0,
                        "xscale":1,
                        "yscale":1,
                        "offset":0
                     };
                     break;
                  case this.UPPERBODY:
                     _loc8_ = this.CLIPUPPER;
                     _loc4_ = {
                        "x":0,
                        "y":0,
                        "xscale":1,
                        "yscale":1,
                        "offset":0
                     };
                     break;
                  case this.LOWERBODY:
                     _loc8_ = this.CLIPLOWER;
                     _loc4_ = {
                        "x":0,
                        "y":0,
                        "xscale":1,
                        "yscale":1,
                        "offset":0
                     };
                     break;
                  default:
                     _loc8_ = this.DEFAULTHEAD;
               }
               _loc9_ = new ExtraDataLoader();
               _loc6_.addEventDispatcher(_loc9_.contentLoaderInfo,Event.COMPLETE);
               _loc9_.extraData = {
                  "componentType":String(_loc5_.@type),
                  "properties":_loc4_,
                  "colors":new Array(),
                  "clipName":_loc8_
               };
               _loc9_.loadBytes(param2.getValueByKey(_loc3_));
               _loc7_.push(_loc3_,_loc9_);
            }
         }
         _loc6_.commit();
         return _loc7_;
      }
      
      private function onPrepareLoaderFinish(param1:Event) : void
      {
         this.eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function updateComponentImageData(param1:String, param2:ByteArray, param3:Object, param4:UtilLoadMgr, param5:Array = null, param6:String = "") : void
      {
         var _loc7_:String = null;
         var _loc10_:ByteArray = null;
         var _loc11_:UtilCrypto = null;
         switch(param1)
         {
            case this.SKELETON:
               _loc7_ = "";
               param3 = {
                  "x":0,
                  "y":0,
                  "xscale":1,
                  "yscale":1,
                  "offset":0
               };
               break;
            case this.UPPERBODY:
               _loc7_ = this.CLIPUPPER;
               param3 = {
                  "x":0,
                  "y":0,
                  "xscale":1,
                  "yscale":1,
                  "offset":0
               };
               break;
            case this.LOWERBODY:
               _loc7_ = this.CLIPLOWER;
               param3 = {
                  "x":0,
                  "y":0,
                  "xscale":1,
                  "yscale":1,
                  "offset":0
               };
               break;
            default:
               _loc7_ = this.DEFAULTHEAD;
         }
         var _loc8_:ExtraDataLoader = new ExtraDataLoader();
         var _loc9_:Number = -1;
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) == -1)
         {
            _loc8_.name = param1;
         }
         else
         {
            _loc8_.name = param6;
            _loc9_ = this._decoArray.push(param6) - 1;
         }
         param4.addEventDispatcher(_loc8_,Event.INIT);
         _loc8_.extraData = {
            "componentType":param1,
            "properties":param3,
            "colors":param5,
            "clipName":_loc7_,
            "index":_loc9_
         };
         _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadImageData);
         if(this.should_decrypt)
         {
            _loc10_ = new ByteArray();
            param2.readBytes(_loc10_);
            _loc10_.position = 0;
            param2.position = 0;
            (_loc11_ = new UtilCrypto()).decrypt(_loc10_);
            _loc8_.loadBytes(_loc10_);
         }
         else
         {
            _loc8_.loadBytes(param2);
         }
      }
      
      private function dispatchComplete() : void
      {
         this.visible = true;
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
      }
      
      private function addDefinition(param1:LoaderInfo, param2:String, param3:Object, param4:DisplayObjectContainer, param5:Array) : void
      {
         var tmp:Class = null;
         var mytemp:DisplayObjectContainer = null;
         var mytempchild:DisplayObject = null;
         var index:int = 0;
         var i:int = 0;
         var k:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var colorItems:Array = null;
         var color:Object = null;
         var loaderinfo:LoaderInfo = param1;
         var name:String = param2;
         var properties:Object = param3;
         var container:DisplayObjectContainer = param4;
         var colors:Array = param5;
         var COMPONENT_RIGHT_NAME:String = name + this.LIB_RIGHT;
         var COMPONENT_LEFT_NAME:String = name + this.LIB_LEFT;
         var COMPONENT_RIGHT_SYMBOL_NAME:String = COMPONENT_RIGHT_NAME;
         var COMPONENT_LEFT_SYMBOL_NAME:String = COMPONENT_LEFT_NAME;
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this._lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_RIGHT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_RIGHT_SYMBOL_NAME += "_Cam";
         }
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this._lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_LEFT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_LEFT_SYMBOL_NAME += "_Cam";
         }
         try
         {
            tmp = loaderinfo.applicationDomain.getDefinition(COMPONENT_RIGHT_SYMBOL_NAME) as Class;
            mytemp = new tmp();
            mytemp.name = COMPONENT_RIGHT_NAME;
            mytempchild = mytemp.getChildAt(0);
            mytemp.x = Number(properties["x"]);
            mytemp.y = Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytemp.x -= Number(properties["offset"]) / 2;
            mytempchild.rotation = Number(properties["rotation"]);
            index = this._componentOrder.indexOf(mytemp.name);
            componentContainer = UtilPlain.getInstance(container,mytemp.name + this.MC);
            k = componentContainer.numChildren;
            while(k > 0)
            {
               componentContainer.removeChildAt(k - 1);
               k--;
            }
            componentContainer.addChild(mytemp);
            if(colors != null)
            {
               i = 0;
               while(i < colors.length)
               {
                  color = colors[i];
                  this.updateColor(color);
                  i++;
               }
            }
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
            mytemp.x = Number(properties["x"]);
            mytemp.y = Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytemp.x += Number(properties["offset"]) / 2;
            mytempchild.rotation = -Number(properties["rotation"]);
            index = this._componentOrder.indexOf(mytemp.name);
            componentContainer = UtilPlain.getInstance(container,mytemp.name + this.MC);
            k = componentContainer.numChildren;
            while(k > 0)
            {
               componentContainer.removeChildAt(k - 1);
               k--;
            }
            componentContainer.addChild(mytemp);
            if(colors != null)
            {
               i = 0;
               while(i < colors.length)
               {
                  color = colors[i];
                  this.updateColor(color);
                  i++;
               }
            }
         }
         catch(e:Error)
         {
         }
         loaderinfo.loader.dispatchEvent(new Event(Event.INIT));
      }
      
      private function set charZip(param1:ZipFile) : void
      {
         this._charZip = param1;
      }
      
      private function get charXML() : XML
      {
         return this._charXML;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function get charZip() : ZipFile
      {
         return this._charZip;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         var _loc2_:* = this._lookAtCamera != param1;
         this._lookAtCamera = param1;
         if(_loc2_)
         {
            this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
         }
      }
      
      private function redoWaitingImageData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         var _loc7_:ExtraDataLoader = null;
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         if(_loc1_ != null)
         {
            _loc3_ = 3;
            while(_loc3_ < this._componentOrder.length)
            {
               (_loc4_ = new Sprite()).name = this._componentOrder[_loc3_] + this.MC;
               if(this._componentOrder[_loc3_] == CcLibConstant.COMPONENT_TYPE_FACIAL_DECORATION)
               {
                  _loc5_ = this.getDecoNumber();
                  _loc2_ = 0;
                  while(_loc2_ < _loc5_)
                  {
                     _loc6_ = new Sprite();
                     _loc4_.addChild(_loc6_);
                     _loc2_++;
                  }
               }
               _loc1_.addChild(_loc4_);
               _loc3_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < this.waiting.length)
         {
            _loc7_ = this.waiting[_loc2_] as ExtraDataLoader;
            this.doLoadImageData(_loc7_);
            _loc2_++;
         }
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      private function hideColorItems(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            DisplayObject(param1[_loc2_]).alpha = 0;
            _loc2_++;
         }
      }
   }
}
