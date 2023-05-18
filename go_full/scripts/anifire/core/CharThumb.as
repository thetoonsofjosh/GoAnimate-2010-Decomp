package anifire.core
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.playback.PlayerConstant;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilURLStream;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.controls.Alert;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CharThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "char";
      
      private static var _logger:ILogger = Log.getLogger("core.CharThumb");
       
      
      private var _actions:Array;
      
      private var _actionMenuItems:Array;
      
      private var _isZipLoaded:Boolean = false;
      
      private var _motions:Array;
      
      private var _defaultAction:anifire.core.Action;
      
      private var _defaultMotion:anifire.core.Motion;
      
      private var _isLoadingActionMotion:Boolean = false;
      
      private var _facials:Array;
      
      private var _facialMenuItems:Array;
      
      private var _facing:String = "unknown";
      
      public function CharThumb()
      {
         super();
         _logger.debug("CharThumb initialized");
         this._actions = new Array();
         this._motions = new Array();
         this._facials = new Array();
         this._actionMenuItems = new Array();
         this._facialMenuItems = new Array();
      }
      
      private function doLoadActionsAndMotionsCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         Console.getConsole().requestLoadStatus(false);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ZipFile = new ZipFile(_loc3_);
         this.initImageData(_loc4_,this.getFolderPathInCharZip());
         this._isLoadingActionMotion = false;
         this.setIsZipLoaded(true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:Image = null;
         var _loc5_:Loader = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         if(purchased)
         {
            _loc2_ = Image(param1.currentTarget);
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            _loc3_.addData(param1.localX,"x");
            _loc3_.addData(param1.localY,"y");
            if(_loc2_.parent is ThumbnailCanvas)
            {
               if(ThumbnailCanvas(_loc2_.parent).colorSetId != "")
               {
                  _loc3_.addData(ThumbnailCanvas(_loc2_.parent).colorSetId,"colorSetId");
               }
            }
            _loc4_ = new Image();
            if(!this.isCC)
            {
               (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadProxyImageComplete);
               _loc5_.loadBytes(ByteArray(this.imageData));
               _loc4_.addChild(_loc5_);
            }
            else
            {
               _loc6_ = Util.capturePicture(ThumbnailCanvas(_loc2_.parent).displayObj);
               _loc7_ = new Bitmap(_loc6_);
               _loc4_.addChild(_loc7_);
            }
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      public function get motions() : Array
      {
         return this._motions;
      }
      
      public function getMotionAt(param1:int) : anifire.core.Motion
      {
         return this._motions[param1];
      }
      
      private function doLoadActionsAndMotionsIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsIOError);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Error in loading character action",param1.type);
      }
      
      public function get actionMenuItems() : Array
      {
         return this._actionMenuItems;
      }
      
      private function addFacialMenuItem(param1:Object) : void
      {
         if(param1 is Facial)
         {
            this._facialMenuItems.push(param1);
            this._facialMenuItems.sortOn("name",Array.CASEINSENSITIVE);
         }
      }
      
      public function getFacialAt(param1:int) : Facial
      {
         return this.facials[param1] as Facial;
      }
      
      public function BitmapDataToByteArray(param1:DisplayObject) : ByteArray
      {
         var _loc2_:uint = param1.width;
         var _loc3_:uint = param1.height;
         var _loc4_:BitmapData;
         (_loc4_ = new BitmapData(_loc2_,_loc3_)).draw(param1);
         var _loc5_:ByteArray;
         (_loc5_ = _loc4_.getPixels(new Rectangle(0,0,_loc2_,_loc3_))).writeShort(_loc3_);
         _loc5_.writeShort(_loc2_);
         return _loc5_;
      }
      
      public function getActionById(param1:String) : anifire.core.Action
      {
         var action:anifire.core.Action = null;
         var i:int = 0;
         var id:String = param1;
         try
         {
            i = 0;
            while(i < this._actions.length)
            {
               if(Action(this._actions[i]).id == id)
               {
                  action = Action(this._actions[i]);
                  break;
               }
               i++;
            }
            return action;
         }
         catch(error:Error)
         {
            return action;
         }
      }
      
      public function getMotionById(param1:String) : anifire.core.Motion
      {
         var _loc2_:anifire.core.Motion = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._motions.length)
         {
            if(Motion(this._motions[_loc3_]).id == param1)
            {
               _loc2_ = Motion(this._motions[_loc3_]);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get facials() : Array
      {
         return this._facials;
      }
      
      public function set defaultMotion(param1:anifire.core.Motion) : void
      {
         this._defaultMotion = param1;
      }
      
      public function getFacialById(param1:String) : Facial
      {
         var _loc2_:Facial = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._facials.length)
         {
            if(Facial(this._facials[_loc3_]).id == param1)
            {
               _loc2_ = Facial(this._facials[_loc3_]);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set defaultAction(param1:anifire.core.Action) : void
      {
         this._defaultAction = param1;
      }
      
      public function addMotion(param1:anifire.core.Motion) : void
      {
         this._motions.push(param1);
         this._motions.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc2_:UtilCrypto = null;
         var _loc5_:ZipFile = null;
         var _loc6_:int = 0;
         var _loc7_:ZipEntry = null;
         var _loc8_:Object = null;
         var _loc9_:ByteArray = null;
         var _loc10_:UtilHashArray = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadImageDataComplete);
         trace("char thumb load image complete:" + this.id);
         var _loc3_:URLStream = URLStream(param1.target);
         var _loc4_:ByteArray = new ByteArray();
         _loc3_.readBytes(_loc4_,0,_loc3_.bytesAvailable);
         if(this.isCC)
         {
            _loc5_ = new ZipFile(_loc4_);
            _loc8_ = new Object();
            _loc10_ = new UtilHashArray();
            _loc6_ = 0;
            while(_loc6_ < _loc5_.size)
            {
               if((_loc7_ = _loc5_.entries[_loc6_]).name == PlayerConstant.CHAR_XML_FILENAME)
               {
                  _loc8_["xml"] = new XML(_loc5_.getInput(_loc7_).toString());
               }
               else if(_loc7_.name.substr(_loc7_.name.length - 3,3).toLowerCase() == "swf")
               {
                  _loc9_ = _loc5_.getInput(_loc7_);
                  _loc2_ = new UtilCrypto();
                  _loc2_.decrypt(_loc9_);
                  _loc10_.push(_loc7_.name,_loc9_);
               }
               _loc6_++;
            }
            _loc8_["imageData"] = _loc10_;
            this.imageData = _loc8_;
         }
         else
         {
            this.imageData = _loc4_;
            if(this.theme.id != "ugc" && !this.isCC)
            {
               _loc2_ = new UtilCrypto();
               _loc2_.decrypt(ByteArray(this.imageData));
            }
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function getActionNum() : int
      {
         return this.actions.length;
      }
      
      public function set facing(param1:String) : void
      {
         this._facing = param1;
      }
      
      public function loadAction(param1:Behavior = null) : void
      {
         if(param1 == null)
         {
            param1 = this.defaultAction;
         }
         if(param1.imageData == null)
         {
            if(param1 is anifire.core.Action)
            {
               param1.loadImageData(ServerConstants.PARAM_CHAR_ACTION);
            }
            else if(param1 is Facial)
            {
               param1.loadImageData(ServerConstants.PARAM_CHAR_FACIAL);
            }
         }
      }
      
      public function loadActionsAndMotions() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingActionMotion)
         {
            this._isLoadingActionMotion = true;
            Console.getConsole().requestLoadStatus(true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_CHAR);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.doLoadActionsAndMotionsCompleted);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.doLoadActionsAndMotionsTimeOut);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.doLoadActionsAndMotionsIOError);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doLoadActionsAndMotionsSecurityError);
            _loc2_.load(_loc1_);
         }
      }
      
      public function getMotionNum() : int
      {
         return this.motions.length;
      }
      
      public function get facialMenuItems() : Array
      {
         return this._facialMenuItems;
      }
      
      public function getIsZipLoaded() : Boolean
      {
         return this._isZipLoaded;
      }
      
      private function setIsZipLoaded(param1:Boolean) : void
      {
         this._isZipLoaded = param1;
      }
      
      public function addFacial(param1:Facial) : void
      {
         this._facials.push(param1);
         this._facials.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      public function isThumbReady(param1:String = "") : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:anifire.core.Action = null;
         var _loc5_:anifire.core.Motion = null;
         var _loc2_:XML = this.theme.getThumbNodeFromThemeXML(this.theme.getThemeXML(),this);
         if(this.getIsZipLoaded())
         {
            return true;
         }
         if(_loc2_ == null)
         {
            return false;
         }
         if(this.theme.id != "ugc")
         {
            if(param1 == "")
            {
               param1 = this.defaultAction.id;
            }
            if(this.getActionById(param1).imageData != null)
            {
               return true;
            }
         }
         if(_loc2_.action.length() != this.actions.length)
         {
            return false;
         }
         if(_loc2_.motion.length() != this.motions.length)
         {
            return false;
         }
         if(this.theme.id == "ugc")
         {
            _loc3_ = 0;
            while(_loc3_ < this.actions.length)
            {
               if((_loc4_ = this.actions[_loc3_] as anifire.core.Action).imageData == null)
               {
                  return false;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.motions.length)
            {
               if((_loc5_ = this.motions[_loc3_] as anifire.core.Motion).imageData == null)
               {
                  return false;
               }
               _loc3_++;
            }
         }
         return true;
      }
      
      public function get defaultAction() : anifire.core.Action
      {
         return this._defaultAction;
      }
      
      public function addAction(param1:anifire.core.Action) : void
      {
         this._actions.push(param1);
         this._actions.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      private function doLoadActionsAndMotionsSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsSecurityError);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Error in loading character action",param1.type);
      }
      
      public function get defaultMotion() : anifire.core.Motion
      {
         return this._defaultMotion;
      }
      
      public function getFolderPathInCharZip() : String
      {
         return "char/" + this.id + "/";
      }
      
      public function removeActionAndMenuItem(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1 is BehaviorCategory || param1 is anifire.core.Action)
         {
            _loc2_ = this._actionMenuItems.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._actionMenuItems.length)
               {
                  this._actionMenuItems[_loc2_] = this._actionMenuItems.pop();
               }
               else
               {
                  this._actionMenuItems.pop();
               }
            }
            _loc2_ = this._actions.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._actions.length)
               {
                  this._actions[_loc2_] = this._actions.pop();
               }
               else
               {
                  this._actions.pop();
               }
            }
         }
      }
      
      private function addActionMenuItem(param1:Object) : void
      {
         if(param1 is BehaviorCategory || param1 is anifire.core.Action)
         {
            this._actionMenuItems.push(param1);
            this._actionMenuItems.sortOn("name",Array.CASEINSENSITIVE);
         }
      }
      
      private function doLoadActionCompleted(param1:Event) : void
      {
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:anifire.core.Action = null;
         var _loc10_:Facial = null;
         var _loc14_:XML = null;
         var _loc15_:XML = null;
         var _loc16_:XML = null;
         var _loc17_:BehaviorCategory = null;
         var _loc18_:anifire.core.Motion = null;
         var _loc19_:String = null;
         this.setFileName("char/" + param1.@id + "/" + param1.@thumb);
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = param1.@name;
         this.premium = param1.@is_premium == "Y" ? true : false;
         this.cost = [param1.@money,param1.@sharing];
         this.theme = param2;
         this.enable = param1.@enable != "N" ? true : false;
         this.isCC = param1.@isCC == "Y" ? true : false;
         this.encryptId = param1.@encryptId;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.enable = false;
         }
         if(param1.@facing == AnimeConstants.FACING_LEFT || param1.@facing == AnimeConstants.FACING_RIGHT)
         {
            this.facing = param1.@facing;
         }
         else
         {
            this.facing = AnimeConstants.FACING_UNKNOW;
         }
         if(param1.child("tags").length() > 0)
         {
            this.tags = param1.tags;
         }
         if(this.theme.id == "ugc")
         {
            this.isPublished = param1.@published == "1" ? true : false;
         }
         var _loc11_:int = param1.category.length();
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         this._actions = new Array();
         this._motions = new Array();
         this._facials = new Array();
         this._actionMenuItems = new Array();
         this._facialMenuItems = new Array();
         _loc12_ = 0;
         while(_loc12_ < param1.category.length())
         {
            _loc4_ = param1.category[_loc12_];
            _loc17_ = new BehaviorCategory(_loc4_.@name);
            Console.getConsole().addStoreCollection(_loc4_.@name);
            _loc13_ = 0;
            while(_loc13_ < _loc4_.action.length())
            {
               if((_loc5_ = _loc4_.action[_loc13_]).prop.length() > 0)
               {
                  _loc14_ = _loc5_.prop[0];
                  _loc9_ = new anifire.core.Action(this,_loc5_.@id,_loc5_.@name,_loc5_.@totalframe,_loc5_.@enable,_loc5_.@aid,_loc14_);
               }
               else
               {
                  _loc9_ = new anifire.core.Action(this,_loc5_.@id,_loc5_.@name,_loc5_.@totalframe,_loc5_.@enable,_loc5_.@aid);
               }
               this.addAction(_loc9_);
               if(_loc9_.id == param1.@§default§)
               {
                  this.defaultAction = _loc9_;
               }
               if(_loc9_.isEnable)
               {
                  Console.getConsole().addStoreCollection(_loc9_.name);
                  _loc17_.addBehavior(_loc9_);
               }
               _loc13_++;
            }
            this.addActionMenuItem(_loc17_);
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < param1.action.length())
         {
            if((_loc5_ = param1.action[_loc12_]).prop.length() > 0)
            {
               _loc14_ = _loc5_.prop[0];
               _loc9_ = new anifire.core.Action(this,_loc5_.@id,_loc5_.@name,_loc5_.@totalframe,_loc5_.@enable,_loc5_.@aid,_loc14_);
            }
            else
            {
               _loc9_ = new anifire.core.Action(this,_loc5_.@id,_loc5_.@name,_loc5_.@totalframe,_loc5_.@enable,_loc5_.@aid);
            }
            _loc8_ = "char/" + this.id + "/" + _loc5_.@id;
            this.addAction(_loc9_);
            if(_loc9_.id == param1.@§default§)
            {
               this.defaultAction = _loc9_;
            }
            if(_loc9_.isEnable)
            {
               Console.getConsole().addStoreCollection(_loc9_.name);
               this.addActionMenuItem(_loc9_);
            }
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < param1.motion.length())
         {
            _loc6_ = param1.motion[_loc12_];
            _loc18_ = new anifire.core.Motion(this,_loc6_.@id,_loc6_.@name,_loc6_.@totalframe,_loc6_.@enable,_loc6_.@aid);
            _loc8_ = "char/" + this.id + "/" + _loc6_.@id;
            this.addMotion(_loc18_);
            _loc9_ = new anifire.core.Action(this,_loc6_.@id,_loc6_.@name,_loc6_.@totalframe,_loc6_.@enable,_loc6_.@aid);
            this.addAction(_loc9_);
            Console.getConsole().addStoreCollection(_loc9_.name);
            if(_loc18_.id == param1.@motion)
            {
               this.defaultMotion = _loc18_;
            }
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < param1.colorset.length())
         {
            _loc19_ = (_loc15_ = param1.colorset[_loc12_]).attribute("aid").length() == 0 ? "0" : _loc15_.@aid;
            colorRef.push(_loc19_,_loc15_);
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < param1.c_parts.c_area.length())
         {
            _loc16_ = param1.c_parts.c_area[_loc12_];
            if(param1.c_parts.@enable != "N")
            {
               colorParts.push(_loc16_,_loc16_.attribute("oc").length() == 0 ? uint.MAX_VALUE : _loc16_.@oc);
            }
            _loc12_++;
         }
      }
      
      private function doLoadActionsAndMotionsTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsTimeOut);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Opeation Timeout");
      }
      
      override internal function loadProxyImageComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadProxyImageComplete);
         var _loc2_:Loader = Loader(param1.target.loader);
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
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
         _loc2_.x = AnimeConstants.TILE_CHAR_WIDTH / 2;
         _loc2_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.y -= _loc8_.top;
         var _loc9_:DisplayObject = DisplayObject(_loc2_.content);
         UtilPlain.stopFamily(_loc9_);
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
         var _loc16_:anifire.core.Action = null;
         var _loc17_:anifire.core.Motion = null;
         var _loc18_:State = null;
         var _loc14_:Boolean = this.theme.id != "ugc" ? true : false;
         _loc3_ = 0;
         while(_loc3_ < this.getActionNum())
         {
            _loc16_ = this.getActionAt(_loc3_);
            _loc5_ = param2 + _loc16_.id;
            _loc6_ = param1.getEntry(_loc5_);
            if(!isCC)
            {
               if(_loc6_ != null)
               {
                  _loc16_.imageData = param1.getInput(param1.getEntry(_loc5_));
                  if(_loc14_)
                  {
                     (_loc7_ = new UtilCrypto()).decrypt(_loc16_.imageData as ByteArray);
                  }
               }
               else
               {
                  trace("action \'" + _loc5_ + "\' not found in zip");
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
               _loc16_.imageData = _loc13_;
               trace("curAction:" + [_loc16_.id,_loc16_.imageData]);
            }
            else
            {
               trace("action \'" + _loc5_ + "\' not found in zip");
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.getMotionNum())
         {
            _loc17_ = this.getMotionAt(_loc3_);
            _loc5_ = param2 + _loc17_.id;
            if((_loc6_ = param1.getEntry(_loc5_)) != null)
            {
               _loc17_.imageData = param1.getInput(param1.getEntry(_loc5_));
               if(_loc14_)
               {
                  (_loc7_ = new UtilCrypto()).decrypt(_loc17_.imageData as ByteArray);
               }
            }
            else
            {
               trace("motion \'" + _loc5_ + "\' not found in zip");
            }
            _loc3_++;
         }
         var _loc15_:PropThumb;
         if((_loc15_ = theme.getPropThumbById(id + ".head")) != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc15_.states.length)
            {
               _loc18_ = _loc15_.getStateAt(_loc3_);
               _loc5_ = param2 + "head/" + _loc18_.id;
               _loc6_ = param1.getEntry(_loc5_);
               if(!isCC)
               {
                  if(_loc6_ != null)
                  {
                     _loc18_.imageData = param1.getInput(param1.getEntry(_loc5_));
                     if(_loc14_)
                     {
                        (_loc7_ = new UtilCrypto()).decrypt(_loc18_.imageData as ByteArray);
                     }
                  }
                  else
                  {
                     trace("action \'" + _loc5_ + "\' not found in zip");
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
                  _loc18_.imageData = _loc13_;
               }
               else
               {
                  trace("action \'" + _loc5_ + "\' not found in zip");
               }
               _loc3_++;
            }
         }
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = new UtilURLStream();
         if(this.isCC)
         {
            _loc1_ = UtilNetwork.getGetCcActionRequest(this.id,this.defaultAction.id);
         }
         else
         {
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_CHAR_ACTION,this.defaultAction.id);
         }
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.load(_loc1_);
      }
      
      public function get actions() : Array
      {
         return this._actions;
      }
      
      public function mergeThumb(param1:CharThumb) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Behavior = null;
         var _loc5_:Behavior = null;
         if(param1.theme.id == this.theme.id && param1.id == this.id)
         {
            _loc2_ = 0;
            while(_loc2_ < this.actions.length)
            {
               if((_loc4_ = this.actions[_loc2_] as Behavior).imageData == null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < param1.actions.length)
                  {
                     _loc5_ = param1.actions[_loc3_] as Behavior;
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc4_.imageData = _loc5_.imageData;
                        break;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.motions.length)
            {
               if((_loc4_ = this.motions[_loc2_] as Behavior).imageData == null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < param1.motions.length)
                  {
                     _loc5_ = this.motions[_loc3_] as Behavior;
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc4_.imageData = _loc5_.imageData;
                        break;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.facials.length)
            {
               if((_loc4_ = this.facials[_loc2_] as Behavior).imageData == null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < param1.facials.length)
                  {
                     _loc5_ = param1.facials[_loc3_] as Behavior;
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc4_.imageData = _loc5_.imageData;
                        break;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function getActionAt(param1:int) : anifire.core.Action
      {
         return this.actions[param1] as anifire.core.Action;
      }
   }
}
