package anifire.core
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.playback.PlayerConstant;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilURLStream;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class PropThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "prop";
      
      private static var _logger:ILogger = Log.getLogger("core.PropThumb");
       
      
      private var _headable:Boolean = false;
      
      private var _isLoadingState:Boolean = false;
      
      private var _states:Array;
      
      private var _defaultState:anifire.core.State;
      
      private var _stateMenuItems:Array;
      
      private var _wearable:Boolean = false;
      
      private var _isZipLoaded:Boolean = false;
      
      private var _subType:String = "";
      
      private var _placeable:Boolean = false;
      
      private var _holdable:Boolean = false;
      
      private var _facing:String;
      
      public function PropThumb()
      {
         super();
         _logger.info("PropThumb initialized");
         this._states = new Array();
         this._stateMenuItems = new Array();
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = null;
         if(this.thumbId != null)
         {
            if(this.getFileName().indexOf("char/") == -1)
            {
               _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_PROP_STATE,this.thumbId);
            }
            else
            {
               _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_CHAR_FACIAL,this.thumbId);
            }
         }
         else
         {
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_PROP);
         }
         var _loc2_:UtilURLStream = new UtilURLStream();
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.load(_loc1_);
      }
      
      public function get states() : Array
      {
         return this._states;
      }
      
      public function set states(param1:Array) : void
      {
         this._states = param1;
      }
      
      public function loadStates() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingState)
         {
            this._isLoadingState = true;
            Console.getConsole().requestLoadStatus(true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_PROP_EX);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.doLoadStatesCompleted);
            _loc2_.load(_loc1_);
         }
      }
      
      public function get stateMenuItems() : Array
      {
         return this._stateMenuItems;
      }
      
      private function doLoadStatesCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadStatesCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         Console.getConsole().requestLoadStatus(false);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ZipFile = new ZipFile(_loc3_);
         this.initImageData(_loc4_,this.getFolderPathInPropZip());
         this._isLoadingState = false;
         this.setIsZipLoaded(true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function get subType() : String
      {
         return this._subType;
      }
      
      public function get holdable() : Boolean
      {
         return this._holdable;
      }
      
      public function addStateMenuItem(param1:Object) : void
      {
         if(param1 is BehaviorCategory || param1 is anifire.core.State)
         {
            this._stateMenuItems.push(param1);
            this._stateMenuItems.sortOn("name",Array.CASEINSENSITIVE);
         }
      }
      
      public function set defaultState(param1:anifire.core.State) : void
      {
         this._defaultState = param1;
      }
      
      public function getStateNum() : int
      {
         return this.states.length;
      }
      
      public function getFolderPathInPropZip() : String
      {
         return "prop/" + this.id + "/";
      }
      
      public function set facing(param1:String) : void
      {
         this._facing = param1;
      }
      
      public function isThumbReady() : Boolean
      {
         if(this is VideoPropThumb)
         {
            return true;
         }
         if(this.getIsZipLoaded() || !this.states.length > 0 && this.imageData != null)
         {
            return true;
         }
         var _loc1_:XML = this.theme.getThumbNodeFromThemeXML(this.theme.getThemeXML(),this);
         if(_loc1_ == null && this.id.indexOf(".head") == -1)
         {
            return false;
         }
         if(this.states.length > 0)
         {
            if(this.defaultState.imageData == null)
            {
               return false;
            }
            if(_loc1_ != null)
            {
               if(_loc1_.state.length() != this.states.length)
               {
                  return false;
               }
            }
         }
         else if(this.imageData == null)
         {
            return false;
         }
         return true;
      }
      
      public function set holdable(param1:Boolean) : void
      {
         this._holdable = param1;
      }
      
      private function setIsZipLoaded(param1:Boolean) : void
      {
         this._isZipLoaded = param1;
      }
      
      public function set subType(param1:String) : void
      {
         this._subType = param1;
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc5_:UtilCrypto = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadImageDataComplete);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ByteArray = _loc3_;
         if(this.theme.id != "ugc")
         {
            (_loc5_ = new UtilCrypto()).decrypt(_loc4_);
         }
         this.imageData = _loc4_;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function addColorSet(param1:XML) : Number
      {
         colorRef.push(param1.@aid,param1);
         return colorRef.length - 1;
      }
      
      public function get headable() : Boolean
      {
         return this._headable;
      }
      
      public function getIsZipLoaded() : Boolean
      {
         return this._isZipLoaded;
      }
      
      public function set placeable(param1:Boolean) : void
      {
         this._placeable = param1;
      }
      
      public function set wearable(param1:Boolean) : void
      {
         this._wearable = param1;
      }
      
      public function loadState(param1:Behavior = null) : void
      {
         if(param1 == null)
         {
            param1 = this.defaultState;
         }
         if(param1.imageData == null)
         {
            if(this.getFileName().indexOf("char/") == -1)
            {
               param1.loadImageData(ServerConstants.PARAM_PROP_STATE);
            }
            else
            {
               param1.loadImageData(ServerConstants.PARAM_CHAR_FACIAL);
            }
         }
      }
      
      public function getStateById(param1:String) : anifire.core.State
      {
         var _loc2_:anifire.core.State = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._states.length)
         {
            if(State(this._states[_loc3_]).id == param1)
            {
               _loc2_ = State(this._states[_loc3_]);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get defaultState() : anifire.core.State
      {
         return this._defaultState;
      }
      
      public function get wearable() : Boolean
      {
         return this._wearable;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function isStateReady(param1:Behavior) : Boolean
      {
         return param1.imageData != null;
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:XML = null;
         var _loc9_:anifire.core.State = null;
         if(param1.state.length() <= 0)
         {
            this.setFileName("prop/" + param1.@id);
         }
         else
         {
            this.setFileName("prop/" + param1.@id + "/" + param1.@thumb);
            this.thumbId = param1.@thumb;
         }
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = UtilDict.toDisplay("store",param1.@name);
         this.premium = param1.@is_premium == "Y" ? true : false;
         this.cost = [param1.@money,param1.@sharing];
         this.placeable = param1.@placeable == "1" ? true : false;
         this.holdable = param1.@holdable == "1" ? true : false;
         this.headable = param1.@headable == "1" ? true : false;
         this.wearable = param1.@wearable == "1" ? true : false;
         this.enable = param1.@enable == "N" ? false : true;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.enable = false;
         }
         this.theme = param2;
         if(param1.@facing == AnimeConstants.FACING_LEFT || param1.@facing == AnimeConstants.FACING_RIGHT)
         {
            this.facing = param1.@facing;
         }
         else
         {
            this.facing = AnimeConstants.FACING_UNKNOW;
         }
         if(this.theme.id == "ugc")
         {
            this.tags = param1.tags;
            this.isPublished = param1.@published == "1" ? true : false;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.colorset.length())
         {
            _loc4_ = param1.colorset[_loc5_];
            this.addColorSet(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.c_parts.c_area.length())
         {
            _loc6_ = param1.c_parts.c_area[_loc5_];
            if(param1.c_parts.@enable != "N")
            {
               colorParts.push(_loc6_,_loc6_.attribute("oc").length() == 0 ? uint.MAX_VALUE : _loc6_.@oc);
            }
            _loc5_++;
         }
         this._states = new Array();
         _loc5_ = 0;
         while(_loc5_ < param1.state.length())
         {
            _loc8_ = param1.state[_loc5_];
            _loc9_ = new anifire.core.State(this,_loc8_.@id,_loc8_.@name,1,_loc8_.@enable,_loc8_.@aid);
            _loc7_ = "prop/" + this.id + "/" + param1.@id;
            this.addState(_loc9_);
            if(_loc8_.@§default§ == "Y")
            {
               this.defaultState = _loc9_;
            }
            if(_loc9_.isEnable)
            {
               Console.getConsole().addStoreCollection(_loc9_.name);
               this.addStateMenuItem(_loc9_);
            }
            _loc5_++;
         }
         this.subType = param1.@subtype != null ? param1.@subtype : "";
      }
      
      public function get placeable() : Boolean
      {
         return this._placeable;
      }
      
      public function removeStateAndMenuItem(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1 is BehaviorCategory || param1 is anifire.core.State)
         {
            _loc2_ = this._stateMenuItems.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._stateMenuItems.length)
               {
                  this._stateMenuItems[_loc2_] = this._stateMenuItems.pop();
               }
               else
               {
                  this._stateMenuItems.pop();
               }
            }
            _loc2_ = this._states.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._states.length)
               {
                  this._states[_loc2_] = this._states.pop();
               }
               else
               {
                  this._states.pop();
               }
            }
         }
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:Image = null;
         var _loc5_:Loader = null;
         if(Console.getConsole().currentScene.enableClickTimer.running)
         {
            return;
         }
         if(purchased)
         {
            _loc2_ = Image(param1.currentTarget);
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            if(_loc2_.parent is ThumbnailCanvas)
            {
               if(ThumbnailCanvas(_loc2_.parent).colorSetId != "")
               {
                  _loc3_.addData(ThumbnailCanvas(_loc2_.parent).colorSetId,"colorSetId");
               }
            }
            _loc4_ = new Image();
            (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadProxyImageComplete);
            _loc5_.loadBytes(ByteArray(this.imageData));
            _loc4_.addChild(_loc5_);
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currentScene.hideEffects();
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      override internal function loadProxyImageComplete(param1:Event) : void
      {
         var _loc9_:DisplayObject = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadProxyImageComplete);
         var _loc2_:Loader = Loader(param1.target.loader);
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height *= _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width *= _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width *= _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height *= _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x -= _loc8_.left;
         _loc2_.y -= _loc8_.top;
         if(_loc2_.content is MovieClip)
         {
            _loc9_ = DisplayObject(_loc2_.content);
            UtilPlain.stopFamily(_loc9_);
         }
      }
      
      public function getStateAt(param1:int) : anifire.core.State
      {
         return this.states[param1] as anifire.core.State;
      }
      
      public function addState(param1:anifire.core.State) : void
      {
         this._states.push(param1);
         this._states.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      public function set headable(param1:Boolean) : void
      {
         this._headable = param1;
      }
      
      public function initImageData(param1:ZipFile, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ZipEntry = null;
         var _loc7_:UtilCrypto = null;
         var _loc8_:ByteArray = null;
         var _loc9_:ZipFile = null;
         var _loc10_:ZipEntry = null;
         var _loc11_:ByteArray = null;
         var _loc12_:UtilHashArray = null;
         var _loc13_:Object = null;
         var _loc15_:anifire.core.State = null;
         var _loc14_:Boolean = this.theme.id != "ugc" ? true : false;
         _loc3_ = 0;
         while(_loc3_ < this.getStateNum())
         {
            _loc15_ = this.getStateAt(_loc3_);
            _loc5_ = param2 + _loc15_.id;
            _loc6_ = param1.getEntry(_loc5_);
            if(!isCC)
            {
               if(_loc6_ != null)
               {
                  _loc15_.imageData = param1.getInput(param1.getEntry(_loc5_));
                  if(_loc14_)
                  {
                     (_loc7_ = new UtilCrypto()).decrypt(_loc15_.imageData as ByteArray);
                  }
               }
               else
               {
                  trace("state \'" + _loc5_ + "\' not found in zip");
               }
            }
            else if(_loc6_ != null)
            {
               _loc8_ = param1.getInput(_loc6_);
               _loc9_ = new ZipFile(_loc8_);
               _loc12_ = new UtilHashArray();
               _loc13_ = new Object();
               _loc4_ = 0;
               while(_loc4_ < _loc9_.size)
               {
                  if((_loc10_ = _loc9_.entries[_loc4_]).name == PlayerConstant.CHAR_XML_FILENAME)
                  {
                     _loc13_["xml"] = new XML(_loc9_.getInput(_loc10_).toString());
                  }
                  else if(_loc10_.name.substr(_loc10_.name.length - 3,3).toLowerCase() == "swf")
                  {
                     _loc11_ = _loc9_.getInput(_loc10_);
                     (_loc7_ = new UtilCrypto()).decrypt(_loc11_);
                     _loc12_.push(_loc10_.name,_loc11_);
                  }
                  _loc4_++;
               }
               _loc13_["imageData"] = _loc12_;
               _loc15_.imageData = _loc13_;
            }
            else
            {
               trace("state \'" + _loc5_ + "\' not found in zip");
            }
            _loc3_++;
         }
      }
      
      public function mergeThumb(param1:PropThumb) : void
      {
         var _loc2_:anifire.core.State = null;
         var _loc3_:anifire.core.State = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.theme.id == this.theme.id && param1.id == this.id)
         {
            if(this.imageData == null)
            {
               this.imageData = param1.imageData;
            }
            _loc4_ = 0;
            while(_loc4_ < this.states.length)
            {
               _loc2_ = this.states[_loc4_] as anifire.core.State;
               if(_loc2_.imageData == null)
               {
                  _loc5_ = 0;
                  while(_loc5_ < param1.states.length)
                  {
                     _loc3_ = param1.states[_loc5_] as anifire.core.State;
                     if(_loc2_.id == _loc3_.id)
                     {
                        _loc2_.imageData = _loc3_.imageData;
                        break;
                     }
                     _loc5_++;
                  }
               }
               _loc4_++;
            }
         }
      }
   }
}
