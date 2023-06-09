package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.ICommand;
   import anifire.command.MoveAssetCommand;
   import anifire.command.RemoveAssetCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.CustomHeadMaker;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.util.ExtraDataTimer;
   import anifire.util.UtilArray;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.ResizeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Asset implements IEventDispatcher
   {
      
      private static var _assetCount:int = 0;
      
      private static var _logger:ILogger = Log.getLogger("core.Asset");
       
      
      protected var _originalAssetScaleX:Number;
      
      protected var _originalAssetScaleY:Number;
      
      private var _sound:Sound;
      
      private var _defaultColorSet:UtilHashArray;
      
      private var _defaultColorSetId:String = "";
      
      private var _soundPos:Number = 0;
      
      private var _control:Control;
      
      private var _imageData:Object;
      
      private var _capScreenLock:Boolean = false;
      
      protected var _rotations:Array;
      
      private var _height:Number;
      
      private var _isMovingByKey:Boolean = false;
      
      private var _isLoadded:Boolean;
      
      private var _scaleX:Number = 1;
      
      private var _scaleY:Number = 1;
      
      private var _controlVisible:Boolean;
      
      private var _changed:Boolean;
      
      private var _motionDistTip:TextArea;
      
      private var _scene:anifire.core.AnimeScene;
      
      protected var _widths:Array;
      
      protected var _originalAssetFacing:String;
      
      private var _bundle:Image;
      
      protected var _scaleXs:Array;
      
      private var _eventDispatcher:EventDispatcher;
      
      protected var _xs:Array;
      
      private var _customColor:UtilHashArray;
      
      protected var _originalAssetX:Number;
      
      protected var _ys:Array;
      
      private var _id:String;
      
      protected var _facings:Array;
      
      protected var _originalAssetY:Number;
      
      private var _isMusicPlaying:Boolean = false;
      
      protected var _scaleYs:Array;
      
      private var _width:Number;
      
      private var _isFreeze:Boolean = false;
      
      private var _soundChannel:SoundChannel;
      
      private var _thumb:anifire.core.Thumb;
      
      private var _resize:Boolean;
      
      private var _sizeToolTip:AssetToolTip = null;
      
      protected var _heights:Array;
      
      private var _displayElement:UIComponent;
      
      public function Asset()
      {
         this._eventDispatcher = new EventDispatcher();
         this._motionDistTip = new TextArea();
         super();
         _logger.debug("Asset initialized");
         ++_assetCount;
         this._bundle = new Image();
         this.displayElement = new UIComponent();
         if(this._sizeToolTip == null)
         {
            this._sizeToolTip = new AssetToolTip();
         }
         this.customColor = new UtilHashArray();
         this.defaultColorSet = new UtilHashArray();
      }
      
      public function set y(param1:Number) : void
      {
         this._bundle.y = param1;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.bundle.rotation = param1;
      }
      
      public function deleteAsset(param1:Boolean = true) : void
      {
         var _loc2_:ICommand = null;
         trace("delete:" + this.id);
         if(param1)
         {
            _loc2_ = new RemoveAssetCommand();
            _loc2_.execute();
         }
         this.stopMusic(true);
         if(this.imageObject is Loader)
         {
            Loader(this.imageObject).unloadAndStop();
         }
         this._scene.canvas.removeChild(this.bundle);
         if(this is ProgramEffectAsset && ProgramEffectAsset(this).motionShadow != null)
         {
            this._scene.canvas.removeChild(ProgramEffectAsset(this).motionShadow.bundle);
         }
         this._scene.removeAsset(this);
         this._scene.selectedAsset = null;
         this.changed = true;
      }
      
      public function getColorArea() : Array
      {
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         _loc1_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc1_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc8_ = String((_loc7_ = DisplayObject(_loc1_[_loc6_]).name.split("_"))[1]);
               _loc2_.push(_loc8_);
               _loc6_++;
            }
            _loc3_ = UtilArray.removeDuplicates(_loc2_,true);
         }
         var _loc5_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < this.thumb.colorParts.length)
         {
            _loc5_.push(this.thumb.colorParts.getKey(_loc6_));
            _loc6_++;
         }
         _loc4_ = _loc3_.concat(_loc5_);
         return UtilArray.removeDuplicates(_loc4_,true);
      }
      
      public function doChangeColor(param1:String, param2:uint = 4294967295) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:UtilHashArray = new UtilHashArray();
         return this.changeColor(param1,param2);
      }
      
      protected function onCtrlPointUpHandler(param1:Event) : void
      {
         if(this.sizeToolTip != null && this.scene.canvas.getChildIndex(this.sizeToolTip) != -1)
         {
            this.scene.canvas.removeChild(this.sizeToolTip);
         }
      }
      
      protected function addCustomColor(param1:String, param2:SelectedColor) : void
      {
         this._customColor.push(param1,param2);
      }
      
      public function doMouseOut(param1:MouseEvent) : void
      {
         if(this.control == null)
         {
            if(param1.buttonDown == false)
            {
               this.displayElement.callLater(this.clearFilter);
            }
         }
      }
      
      internal function doMouseUp(param1:MouseEvent) : void
      {
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function setToolTipContent(param1:Number, param2:Number) : void
      {
         if(this.sizeToolTip != null)
         {
            this.sizeToolTip.setToolTipContent(param1,param2);
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      internal function doDragExit(param1:DragEvent) : void
      {
      }
      
      public function melt() : void
      {
         this.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.initializeDrag);
         this.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.doDrag);
         this.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.doMouseUp);
         this.displayElement.addEventListener(MouseEvent.ROLL_OVER,this.doMouseOver);
         this.displayElement.addEventListener(MouseEvent.ROLL_OUT,this.doMouseOut);
         if(this is Character)
         {
            this.displayElement.addEventListener(DragEvent.DRAG_COMPLETE,this.doDragComplete);
            this.displayElement.addEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
            this.displayElement.addEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
            this.displayElement.addEventListener(DragEvent.DRAG_EXIT,this.doDragExit);
         }
         this._isFreeze = false;
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      private function clearFilter() : void
      {
         if(this.control == null)
         {
            if(this.displayElement != null)
            {
               this.displayElement.filters = [];
            }
         }
      }
      
      public function set sound(param1:Sound) : void
      {
         this._sound = param1;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set scene(param1:anifire.core.AnimeScene) : void
      {
         this._scene = param1;
      }
      
      protected function initListeners() : void
      {
      }
      
      public function getOriginalAssetPosition() : Point
      {
         return new Point(this._originalAssetX,this._originalAssetY);
      }
      
      protected function doResize(param1:Event) : void
      {
      }
      
      public function isColorable() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Array = new Array();
         _loc2_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc2_.length > 0)
         {
            _loc1_ = true;
         }
         if(this.thumb.colorParts.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         var _loc2_:RegExp = /\d/;
         var _loc3_:int = int(param1.substr(param1.search(_loc2_)));
         _assetCount = _loc3_ > _assetCount ? _loc3_ : _assetCount;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function getKey() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id + "." + this.id;
      }
      
      private function re_playMusic(param1:TimerEvent) : void
      {
         (param1.currentTarget as ExtraDataTimer).removeEventListener(TimerEvent.TIMER,this.re_playMusic);
         var _loc2_:Object = (param1.currentTarget as ExtraDataTimer).getData();
         var _loc3_:Number = Number(_loc2_.startTime);
         var _loc4_:int = int(_loc2_.loops);
         var _loc5_:SoundTransform = _loc2_.sndTransform;
         this.playMusic(_loc3_,_loc4_,_loc5_);
      }
      
      public function updateColor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SelectedColor = null;
         if(this.customColor.length == 0)
         {
            if(!this.thumb.isCC && this.imageObject != null)
            {
               UtilColor.resetAssetPartsColor(this.movieObject);
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.customColor.length)
            {
               _loc2_ = SelectedColor(this.customColor.getValueByIndex(_loc1_));
               this.changeColor(_loc2_.areaName,_loc2_.dstColor);
               _loc1_++;
            }
         }
      }
      
      private function repeatMusic(param1:Event) : void
      {
         this._isMusicPlaying = false;
         this.playMusic(0,0,this.soundChannel.soundTransform);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function playMusic(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
      {
      }
      
      public function set imageData(param1:Object) : void
      {
         if(this._imageData != param1 || this._imageData == null)
         {
            this._imageData = param1;
            if(param1 != null)
            {
               this.loadAssetImage();
            }
         }
      }
      
      public function get controlVisible() : Boolean
      {
         return this._controlVisible;
      }
      
      public function get control() : Control
      {
         return this._control;
      }
      
      internal function doDrag(param1:MouseEvent) : void
      {
      }
      
      public function get defaultColorSet() : UtilHashArray
      {
         return this._defaultColorSet;
      }
      
      public function set defaultColorSetId(param1:String) : void
      {
         this._defaultColorSetId = param1;
      }
      
      public function stopMusic(param1:Boolean, param2:Boolean = false) : void
      {
         if(this is Character)
         {
            if(Character(this).prop != null)
            {
               Character(this).prop.stopMusic(param1,param2);
            }
            if(Character(this).wear != null)
            {
               Character(this).wear.stopMusic(param1,param2);
            }
            if(Character(this).head != null)
            {
               Character(this).head.stopMusic(param1,param2);
            }
         }
         if(this.sound != null)
         {
            if(this._soundChannel != null)
            {
               if(this._soundChannel.hasEventListener(Event.SOUND_COMPLETE))
               {
                  this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
               }
               if(param2)
               {
                  this.soundPos = 0;
               }
               else
               {
                  this.soundPos = this._soundChannel.position;
               }
               this._soundChannel.stop();
               this._isMusicPlaying = false;
            }
            if(param1)
            {
               this.sound = null;
               this._soundChannel = null;
            }
         }
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         this.scene.changed = param1;
      }
      
      public function set resize(param1:Boolean) : void
      {
         this._resize = param1;
         this._bundle.mouseEnabled = param1;
         this._bundle.mouseChildren = param1;
      }
      
      public function muteSound(param1:Boolean) : void
      {
         if(this.soundChannel != null)
         {
            if(param1)
            {
               this.soundChannel.soundTransform = new SoundTransform(0);
            }
            else
            {
               this.soundChannel.soundTransform = new SoundTransform(1);
            }
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function flipIt() : void
      {
      }
      
      public function get imageObject() : DisplayObject
      {
         if(this.displayElement != null)
         {
            return this.displayElement.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME);
         }
         return null;
      }
      
      public function addControl() : void
      {
      }
      
      public function get rotation() : Number
      {
         return this.bundle.rotation;
      }
      
      public function get motionDistTip() : TextArea
      {
         return this._motionDistTip;
      }
      
      public function get customColor() : UtilHashArray
      {
         return this._customColor;
      }
      
      public function get bundle() : Image
      {
         return this._bundle;
      }
      
      protected function doResizeStart(param1:ControlEvent) : void
      {
      }
      
      public function restoreColor() : void
      {
         if(this.defaultColorSet != null && this.defaultColorSet.length > 0)
         {
            this.customColor = this.defaultColorSet.clone();
            this.updateColor();
         }
         else
         {
            this.customColor.removeAll();
            UtilColor.resetAssetPartsColor(this.movieObject);
         }
      }
      
      public function get y() : Number
      {
         return this._bundle.y;
      }
      
      public function get movieObject() : DisplayObject
      {
         if(this.imageObject is Loader)
         {
            if(this.imageObject != null)
            {
               return Loader(this.imageObject).content;
            }
         }
         else if(this.imageObject is CustomCharacterMaker || this.imageObject is CustomHeadMaker)
         {
            return this.imageObject;
         }
         return null;
      }
      
      public function get x() : Number
      {
         return this._bundle.x;
      }
      
      public function set soundPos(param1:Number) : void
      {
         this._soundPos = param1;
      }
      
      public function updateOriginalAssetScale() : void
      {
         this._originalAssetScaleX = this.displayElement.scaleX;
         this._originalAssetScaleY = this.displayElement.scaleY;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function doKeyUp(param1:KeyboardEvent, param2:Boolean = true) : void
      {
         if(param1 == null)
         {
            this.deleteAsset(param2);
         }
         else if(Console.getConsole().currentScene == this.scene && this.scene.selectedAsset != null && this.scene.selectedAsset == this)
         {
            switch(param1.keyCode)
            {
               case 8:
               case 46:
                  if(!Console.getConsole().pptPanel.picking && Console.getConsole().thumbTray.active)
                  {
                     this.deleteAsset();
                  }
                  break;
               case 37:
               case 38:
               case 39:
               case 40:
                  this._isMovingByKey = false;
            }
         }
      }
      
      public function freeze(param1:Boolean = true) : void
      {
         this.displayElement.removeEventListener(MouseEvent.MOUSE_DOWN,this.initializeDrag);
         this.displayElement.removeEventListener(MouseEvent.MOUSE_MOVE,this.doDrag);
         this.displayElement.removeEventListener(MouseEvent.MOUSE_UP,this.doMouseUp);
         this.displayElement.removeEventListener(MouseEvent.ROLL_OVER,this.doMouseOver);
         this.displayElement.removeEventListener(MouseEvent.ROLL_OUT,this.doMouseOut);
         if(this is Character)
         {
            this.displayElement.removeEventListener(DragEvent.DRAG_COMPLETE,this.doDragComplete);
            this.displayElement.removeEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
            this.displayElement.removeEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
            this.displayElement.removeEventListener(DragEvent.DRAG_EXIT,this.doDragExit);
         }
         this._isFreeze = true;
      }
      
      public function get scene() : anifire.core.AnimeScene
      {
         return this._scene;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this._scaleX = param1;
      }
      
      public function doKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = param1.shiftKey ? 10 : 1;
         if(Console.getConsole().currentScene == this.scene && this.scene.selectedAsset != null && this.scene.selectedAsset == this)
         {
            switch(param1.keyCode)
            {
               case 37:
                  this.moveAsset("x",-_loc2_);
                  break;
               case 38:
                  this.moveAsset("y",-_loc2_);
                  break;
               case 39:
                  this.moveAsset("x",_loc2_);
                  break;
               case 40:
                  this.moveAsset("y",_loc2_);
            }
         }
      }
      
      public function set scaleY(param1:Number) : void
      {
         this._scaleY = param1;
      }
      
      public function updateOriginalAssetPosition() : void
      {
         this._originalAssetX = this.x;
         this._originalAssetY = this.y;
      }
      
      public function showControl() : void
      {
         if(this.control == null)
         {
            this.addControl();
         }
         if(this.control != null)
         {
            this._control.showControl(Console.getConsole().stageScale);
            this._controlVisible = true;
         }
      }
      
      public function get sizeToolTip() : AssetToolTip
      {
         return this._sizeToolTip;
      }
      
      internal function clone(param1:Boolean = false) : Asset
      {
         return null;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function unloadAssetImage() : void
      {
         var _loc1_:CustomCharacterMaker = null;
         var _loc2_:Loader = null;
         if(this.imageObject is Loader)
         {
            Loader(this.imageObject).unloadAndStop();
         }
         else if(this.imageObject is CustomCharacterMaker)
         {
            CustomCharacterMaker(this.imageObject).unloadAssetImage();
         }
         this.displayElement = new UIComponent();
         this.melt();
         if(this.thumb.isCC)
         {
            if(this is Character)
            {
               _loc1_ = new CustomCharacterMaker();
               _loc1_.name = AnimeConstants.IMAGE_OBJECT_NAME;
               this.displayElement.addChild(_loc1_);
            }
         }
         else
         {
            _loc2_ = new Loader();
            _loc2_.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(_loc2_);
         }
         this.imageData = null;
      }
      
      public function get isMusicPlaying() : Boolean
      {
         return this._isMusicPlaying;
      }
      
      public function set thumb(param1:anifire.core.Thumb) : void
      {
         this._thumb = param1;
      }
      
      public function set displayElement(param1:UIComponent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._bundle.numChildren)
         {
            if(this._bundle.getChildAt(_loc2_) == this._displayElement)
            {
               this._bundle.removeChild(this._displayElement);
               break;
            }
            _loc2_++;
         }
         this._displayElement = param1;
         this._bundle.addChild(this._displayElement);
      }
      
      protected function moveAsset(param1:String, param2:Number) : void
      {
         var _loc3_:ICommand = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!(this is Background || this is EffectAsset))
         {
            if(!this._isMovingByKey)
            {
               _loc3_ = new MoveAssetCommand(this.id,this.x,this.y);
               _loc3_.execute();
               this._isMovingByKey = true;
            }
            switch(param1)
            {
               case "x":
                  _loc4_ = this is Character ? this.width / 2 : 0;
                  if(param2 > 0 && this.x + _loc4_ + param2 < AnimeConstants.STAGE_WIDTH || param2 < 0 && this.x + _loc4_ + param2 > AnimeConstants.SCREEN_X)
                  {
                     this.x += param2;
                  }
                  break;
               case "y":
                  _loc5_ = this is Character ? this.height / 2 : 0;
                  if(param2 > 0 && this.y + _loc5_ + param2 < AnimeConstants.STAGE_HEIGHT || param2 < 0 && this.y + _loc5_ + param2 > AnimeConstants.SCREEN_Y)
                  {
                     this.y += param2;
                  }
            }
            this.changed = true;
         }
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function get defaultColorSetId() : String
      {
         return this._defaultColorSetId;
      }
      
      public function set isLoadded(param1:Boolean) : void
      {
         this._isLoadded = param1;
      }
      
      internal function doDragComplete(param1:DragEvent) : void
      {
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function get resize() : Boolean
      {
         return this._resize;
      }
      
      protected function onCtrlPointDownHandler(param1:ExtraDataEvent) : void
      {
         if(this.sizeToolTip != null)
         {
            this.sizeToolTip.x = this.scene.canvas.globalToLocal(param1.getData().globalPt).x;
            this.sizeToolTip.y = this.scene.canvas.globalToLocal(param1.getData().globalPt).y;
            switch(param1.getData().controlName)
            {
               case "leftTop":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "middleTop":
                  this.sizeToolTip.x -= (this.sizeToolTip.width - 10) / 2;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "rightTop":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "leftMiddle":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y -= (this.sizeToolTip.height - 10) / 2;
                  break;
               case "rightMiddle":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y -= (this.sizeToolTip.height - 10) / 2;
                  break;
               case "leftBottom":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y += 10;
                  break;
               case "middleBottom":
                  this.sizeToolTip.x -= (this.sizeToolTip.width - 10) / 2;
                  this.sizeToolTip.y += 10;
                  break;
               case "rightBottom":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y += 10;
            }
            this.scene.canvas.addChild(this.sizeToolTip);
            this.setToolTipContent(param1.getData().assetWidth,param1.getData().assetHeight);
         }
      }
      
      internal function doDragEnter(param1:DragEvent) : void
      {
      }
      
      public function set control(param1:Control) : void
      {
         var _loc3_:int = 0;
         if(this._control != null && this._control != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this._bundle.numChildren)
            {
               if(this._bundle.getChildAt(_loc3_) == this._control)
               {
                  this._bundle.removeChildAt(_loc3_);
                  break;
               }
               _loc3_++;
            }
         }
         if(!this._isFreeze)
         {
            this._control = param1;
         }
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
         _loc2_.buttonDown = false;
         if(this._control != null)
         {
            this._control.addEventListener(ControlEvent.RESIZE_START,this.doResizeStart);
            this._control.addEventListener(ControlEvent.RESIZE_COMPLETE,this.doResizeComplete);
            this._control.addEventListener(ResizeEvent.RESIZE,this.doResize);
            this._bundle.addChild(this._control);
            this.doMouseOver(_loc2_);
         }
         else
         {
            this.doMouseOut(_loc2_);
         }
      }
      
      internal function hideControl() : void
      {
         if(this._control != null)
         {
            this._control.hideControl();
         }
         this._controlVisible = false;
      }
      
      public function get soundPos() : Number
      {
         return this._soundPos;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function doMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:GlowFilter = null;
         if(param1.buttonDown == false)
         {
            if(this.displayElement != null)
            {
               _loc2_ = new GlowFilter(16742400,1,6,6,5);
               this.displayElement.filters = [_loc2_];
            }
         }
      }
      
      protected function loadAssetImage() : void
      {
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(this.bundle == null || this.bundle.parent == null)
         {
            return null;
         }
         return Canvas(this.bundle.parent);
      }
      
      public function get thumb() : anifire.core.Thumb
      {
         return this._thumb;
      }
      
      public function set defaultColorSet(param1:UtilHashArray) : void
      {
         this._defaultColorSet = param1;
      }
      
      public function changeColor(param1:String, param2:uint = 4294967295) : Number
      {
         var _loc4_:uint = 0;
         var _loc5_:SelectedColor = null;
         var _loc3_:uint = UtilColor.setAssetPartColor(this.movieObject,param1,param2);
         if(param2 == uint.MAX_VALUE)
         {
            this.customColor.removeByKey(param1);
         }
         else
         {
            _loc4_ = this.thumb.colorParts.getValueByKey(param1) == null ? uint.MAX_VALUE : this.thumb.colorParts.getValueByKey(param1);
            _loc5_ = new SelectedColor(param1,_loc4_,param2);
            this.addCustomColor(param1,_loc5_);
         }
         return _loc3_;
      }
      
      protected function doResizeComplete(param1:Event) : void
      {
      }
      
      public function serialize() : String
      {
         return null;
      }
      
      public function getOriginalAssetScale() : Point
      {
         return new Point(this._originalAssetScaleX,this._originalAssetScaleY);
      }
      
      internal function initializeDrag(param1:MouseEvent) : void
      {
      }
      
      protected function onCtrlPointMoveHandler(param1:ExtraDataEvent) : void
      {
         if(this.sizeToolTip != null)
         {
            this.sizeToolTip.x = this.scene.canvas.globalToLocal(param1.getData().globalPt).x;
            this.sizeToolTip.y = this.scene.canvas.globalToLocal(param1.getData().globalPt).y;
            switch(param1.getData().controlName)
            {
               case "leftTop":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "middleTop":
                  this.sizeToolTip.x -= (this.sizeToolTip.width - 10) / 2;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "rightTop":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y -= this.sizeToolTip.height;
                  break;
               case "leftMiddle":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y -= (this.sizeToolTip.height - 10) / 2;
                  break;
               case "rightMiddle":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y -= (this.sizeToolTip.height - 10) / 2;
                  break;
               case "leftBottom":
                  this.sizeToolTip.x -= this.sizeToolTip.width;
                  this.sizeToolTip.y += 10;
                  break;
               case "middleBottom":
                  this.sizeToolTip.x -= (this.sizeToolTip.width - 10) / 2;
                  this.sizeToolTip.y += 10;
                  break;
               case "rightBottom":
                  this.sizeToolTip.x += 10;
                  this.sizeToolTip.y += 10;
            }
            this.setToolTipContent(param1.getData().assetWidth,param1.getData().assetHeight);
         }
      }
      
      public function get isLoadded() : Boolean
      {
         return this._isLoadded;
      }
      
      internal function doDragDrop(param1:DragEvent) : void
      {
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function set customColor(param1:UtilHashArray) : void
      {
         this._customColor = param1;
      }
      
      public function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      public function set x(param1:Number) : void
      {
         this._bundle.x = param1;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function get displayElement() : UIComponent
      {
         return this._displayElement;
      }
      
      public function set motionDistTip(param1:TextArea) : void
      {
         this._motionDistTip = param1;
      }
      
      protected function get assetCount() : int
      {
         return _assetCount;
      }
   }
}

import anifire.core.Console;
import anifire.util.UtilDict;
import mx.containers.Box;
import mx.controls.Label;

class AssetToolTip extends Box
{
    
   
   private var _assetToolTipLabel:Label;
   
   public function AssetToolTip()
   {
      super();
      this.name = "AssetToolTip";
      this.height = 22;
      this.width = 113;
      this.setStyle("borderStyle","solid");
      this.setStyle("cornerRadius",8);
      this.setStyle("backgroundColor","white");
      this.setStyle("horizontalAlign","center");
      this.setStyle("verticalAlign","middle");
      this.horizontalScrollPolicy = "none";
      this.verticalScrollPolicy = "none";
      this._assetToolTipLabel = new Label();
      this.addChild(this._assetToolTipLabel);
   }
   
   public function setToolTipContent(param1:Number, param2:Number) : void
   {
      this.scaleX = this.scaleY = 1 / Console.getConsole().stageScale;
      this._assetToolTipLabel.text = UtilDict.toDisplay("go","assettool_width") + ": " + int(param1) + ", " + UtilDict.toDisplay("go","assettool_height") + ": " + int(param2);
   }
}
