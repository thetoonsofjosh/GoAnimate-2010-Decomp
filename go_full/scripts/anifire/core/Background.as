package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.components.studio.ControlButtonBar;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Background extends Asset
   {
      
      public static var XML_NODE_NAME:String = "bg";
      
      private static var _logger:ILogger = Log.getLogger("core.Background");
       
      
      private var _buttonBar:ControlButtonBar;
      
      public function Background(param1:String = "")
      {
         super();
         _logger.info("Background initialized");
         if(param1 == "")
         {
            param1 = "BG" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc7_:ByteArray = null;
         var _loc8_:ThemeTree = null;
         var _loc9_:UtilCrypto = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1["file"].toString());
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:ZipEntry;
         if((_loc6_ = param2.getEntry(_loc4_)) != null)
         {
            _loc7_ = param2.getInput(_loc6_);
            if(_loc5_ != "ugc")
            {
               (_loc9_ = new UtilCrypto()).decrypt(_loc7_);
            }
            (_loc8_ = new ThemeTree(_loc5_)).addBgThumb(UtilXmlInfo.getThumbIdFromFileName(_loc4_),_loc7_);
            _loc3_.push(_loc5_,_loc8_);
         }
         return _loc3_;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!Console.getConsole().isGoWalkerOn())
         {
            this.showButtonBar();
         }
      }
      
      override public function addControl() : void
      {
         var _loc1_:Control = ControlMgr.getControl(this.displayElement,ControlMgr.NORMAL);
         _loc1_.x = _loc1_.lineSize;
         _loc1_.y = _loc1_.lineSize;
         _loc1_.setSize(AnimeConstants.PLAYER_WIDTH - _loc1_.lineSize * 2,AnimeConstants.PLAYER_HEIGHT - _loc1_.lineSize * 2);
         _loc1_.disableResize();
         _loc1_.hideControl();
         this.control = _loc1_;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc8_:BackgroundThumb = null;
         var _loc9_:XML = null;
         var _loc10_:int = 0;
         var _loc11_:SelectedColor = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1.file);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc7_:Theme;
         if((_loc7_ = Console.getConsole().getTheme(_loc5_)) != null)
         {
            if((_loc8_ = _loc7_.getBackgroundThumbById(_loc6_)) != null && _loc8_.imageData != null)
            {
               this.x = AnimeConstants.SCREEN_X;
               this.y = AnimeConstants.SCREEN_Y;
               this.width = AnimeConstants.SCREEN_WIDTH;
               this.height = AnimeConstants.SCREEN_HEIGHT;
               this.scene = param2;
               if(param3)
               {
                  this.thumb = _loc8_;
               }
               else
               {
                  super.thumb = _loc8_;
               }
               this.isLoadded = true;
               if(param1.dcsn.length() > 0)
               {
                  this.defaultColorSetId = String(param1.dcsn);
                  this.defaultColorSet = this.thumb.getColorSetById(this.defaultColorSetId);
               }
               customColor = new UtilHashArray();
               _loc10_ = 0;
               while(_loc10_ < param1.child("color").length())
               {
                  _loc9_ = param1.child("color")[_loc10_];
                  _loc11_ = new SelectedColor(_loc9_.@r,_loc9_.attribute("oc").length() == 0 ? uint.MAX_VALUE : uint(_loc9_.@oc),uint(_loc9_));
                  this.addCustomColor(_loc9_.@r,_loc11_);
                  _loc10_++;
               }
               updateColor();
            }
         }
      }
      
      override public function serialize() : String
      {
         var _loc3_:int = 0;
         var _loc1_:Canvas = getSceneCanvas();
         var _loc2_:* = "<bg id=\"" + this.id + "\" index=\"" + _loc1_.getChildIndex(this.bundle) + "\">" + "<file>" + this.thumb.theme.id + "." + this.thumb.id + "</file>";
         if(defaultColorSetId != "")
         {
            _loc2_ += "<dcsn>" + defaultColorSetId + "</dcsn>";
         }
         if(customColor.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < customColor.length)
            {
               _loc2_ += "<color r=\"" + customColor.getKey(_loc3_) + "\"";
               _loc2_ += SelectedColor(customColor.getValueByIndex(_loc3_)).orgColor == uint.MAX_VALUE ? "" : " oc=\"0x" + SelectedColor(customColor.getValueByIndex(_loc3_)).orgColor.toString(16) + "\"";
               _loc2_ += ">";
               _loc2_ += SelectedColor(customColor.getValueByIndex(_loc3_)).dstColor;
               _loc2_ += "</color>";
               _loc3_++;
            }
         }
         return _loc2_ + "</bg>";
      }
      
      private function onMouseDown(param1:Event) : void
      {
         var _loc2_:UIComponent = UIComponent(param1.currentTarget);
         _loc2_.setFocus();
      }
      
      public function playBackground() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               if(_loc1_.content is MovieClip)
               {
                  _loc2_ = DisplayObject(_loc1_.content);
                  UtilPlain.playFamily(_loc2_);
                  if(this.soundChannel != null)
                  {
                     this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
                  }
               }
            }
         }
      }
      
      private function loadAssetImageComplete(param1:Event) : void
      {
         var _loc5_:Canvas = null;
         var _loc6_:Class = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Rectangle = new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         _loc2_.scrollRect = _loc3_;
         var _loc4_:UIComponent;
         if((_loc4_ = UIComponent(_loc2_.parent)) != null)
         {
            _loc5_ = Canvas(_loc4_.parent.parent);
            if(!capScreenLock)
            {
               this.changed = true;
            }
            this.isLoadded = false;
         }
         if(_loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            trace("with sound");
            _loc6_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc6_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         updateColor();
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      private function showButtonBar() : void
      {
         if(this._buttonBar == null)
         {
            this._buttonBar = this.initButtonBar();
            this._buttonBar.x = 10;
            this._buttonBar.y = 0;
            this.scene.canvas.addChild(this._buttonBar);
         }
      }
      
      public function toString() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id;
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         super.thumb = param1;
         if(param1.imageData != null)
         {
            this.imageData = param1.imageData;
         }
      }
      
      override public function doKeyUp(param1:KeyboardEvent, param2:Boolean = true) : void
      {
         super.doKeyUp(param1);
      }
      
      public function stopBackground() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               if(_loc1_.content is MovieClip)
               {
                  _loc2_ = DisplayObject(_loc1_.content);
                  UtilPlain.stopFamily(_loc2_);
                  this.stopMusic(false);
               }
            }
         }
      }
      
      private function initButtonBar() : ControlButtonBar
      {
         var _loc1_:ControlButtonBar = new ControlButtonBar();
         _loc1_.callLater(_loc1_.init,[-4,-3,-2,0,-1,-5,isColorable() ? 1 : -6]);
         return _loc1_;
      }
      
      override internal function doMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Loader = null;
         if(this.scene.selectedAsset == this)
         {
            _loc2_ = Loader(this.displayElement.getChildAt(0));
            this.showControl();
         }
      }
      
      override public function freeze(param1:Boolean = true) : void
      {
         super.freeze(param1);
         if(!param1)
         {
            this.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         else
         {
            this.displayElement.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:Loader = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadAssetImageComplete);
         _loc1_.loadBytes(ByteArray(this.imageData));
         var _loc2_:int = 0;
         while(_loc2_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc2_) is Loader)
            {
               this.displayElement.removeChildAt(_loc2_);
               break;
            }
            _loc2_++;
         }
         _loc1_.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.displayElement.addChild(_loc1_);
      }
      
      override internal function hideControl() : void
      {
         super.hideControl();
         this.hideButtonBar();
      }
      
      override internal function initializeDrag(param1:MouseEvent) : void
      {
         var _loc2_:UIComponent = UIComponent(param1.currentTarget);
         _loc2_.setFocus();
         if(this.scene.selectedAsset != null)
         {
            this.scene.selectedAsset.hideControl();
         }
         if(this.scene.selectedAsset == null || this.scene.selectedAsset != null && this.scene.selectedAsset != this)
         {
            this.scene.selectedAsset = this;
         }
      }
      
      override internal function clone(param1:Boolean = false) : Asset
      {
         var _loc2_:Background = new Background();
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         _loc2_.id = this.id;
         _loc2_.scene = this.scene;
         _loc2_.thumb = this.thumb;
         _loc2_.customColor = this.customColor.clone();
         return _loc2_;
      }
      
      private function hideButtonBar() : void
      {
         if(this._buttonBar != null)
         {
            if(this.scene.canvas.contains(this._buttonBar))
            {
               this.scene.canvas.removeChild(this._buttonBar);
            }
            this._buttonBar = null;
         }
      }
   }
}
