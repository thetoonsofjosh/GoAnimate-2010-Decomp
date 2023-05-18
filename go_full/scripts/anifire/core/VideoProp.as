package anifire.core
{
   import anifire.component.VideoPlayback;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.control.ControlMgr;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   
   public class VideoProp extends Prop
   {
       
      
      private var videoPlayBack:VideoPlayback;
      
      private var _image:Canvas;
      
      public function VideoProp(param1:String = "")
      {
         super();
      }
      
      public function pauseMovie() : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
         }
      }
      
      override public function unloadAssetImage() : void
      {
      }
      
      override public function addControl() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Control = null;
         var _loc1_:Loader = Loader(this.imageObject);
         if(_loc1_ != null)
         {
            this.stopMusic(false,true);
            _loc2_ = _loc1_.getBounds(this.bundle);
            _loc3_ = ControlMgr.getControl(_loc1_,ControlMgr.NORMAL);
            _loc3_.dragable = true;
            _loc3_.setPos(_loc2_.x,_loc2_.y);
            _loc3_.setSize(_loc2_.width,_loc2_.height);
            _loc3_.setOrigin(-_loc2_.x,-_loc2_.y);
            _loc3_.addEventListener(ControlEvent.OUTLINE_DOWN,onControlOutlineDownHandler);
            _loc3_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
            _loc3_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
            _loc3_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
            _prevCharPosX = _loc2_.x;
            _prevCharPosY = _loc2_.y;
            _orgLoaderScaleX = Math.abs(displayElement.scaleX);
            _orgLoaderScaleY = Math.abs(displayElement.scaleY);
            _loc3_.hideControl();
            this.control = _loc3_;
            _loc3_.addEventListener(ControlEvent.ROTATE,rotateProp);
         }
      }
      
      override public function stopProp() : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
         }
      }
      
      override public function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         super.onStageMouseUpHandler(param1);
      }
      
      override public function set imageData(param1:Object) : void
      {
         super.imageData = param1;
         this.loadAssetImage();
      }
      
      public function playMovie() : void
      {
         var _loc3_:int = 0;
         var _loc4_:AnimeScene = null;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:Prop = null;
         trace("on click video");
         var _loc1_:Number = Console.getConsole().getSceneIndex(this.scene);
         var _loc2_:Number = 0;
         if(_loc1_ > 0)
         {
            trace("cIndex:" + _loc1_);
            _loc3_ = _loc1_ - 1;
            while(_loc3_ >= 0)
            {
               _loc5_ = (_loc4_ = Console.getConsole().getScene(_loc3_)).props.length;
               _loc6_ = false;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  if((_loc8_ = _loc4_.props.getValueByIndex(_loc7_) as Prop).thumb == this.thumb)
                  {
                     _loc6_ = true;
                  }
                  _loc7_++;
               }
               if(!_loc6_)
               {
                  break;
               }
               _loc2_ += _loc4_.getLength();
               trace("seekTime:" + _loc2_);
               _loc3_--;
            }
            _loc2_ = UtilUnitConvert.frameToSec(_loc2_);
            trace("seekTime:" + _loc2_);
         }
         if(this.videoPlayBack == null)
         {
            this.videoPlayBack = new VideoPlayback();
            this.videoPlayBack.loadAndSeekPlayVideoByAssetId(this.thumb.id,_loc2_);
            this.displayElement.addChild(this.videoPlayBack);
         }
         else
         {
            this.videoPlayBack.seekAndPlay(_loc2_);
         }
         setTimeout(this.pauseMovie,UtilUnitConvert.frameToSec(this.scene.getLength()) * 1000);
      }
      
      override protected function loadAssetImage() : void
      {
         super.loadAssetImage();
      }
      
      override public function deleteAsset(param1:Boolean = true) : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
            this.displayElement.removeChild(this.videoPlayBack);
         }
         super.deleteAsset(param1);
      }
      
      override public function set facing(param1:String) : void
      {
         var displayElement:DisplayObject = null;
         var image:Canvas = null;
         var facing:String = param1;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               displayElement = bundle.getChildAt(0) as DisplayObject;
               image = this.displayElement.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME) as Canvas;
               image.scaleX *= -1;
               scaleX = displayElement.scaleX;
            }
            catch(e:Error)
            {
            }
         }
         super.facing = facing;
      }
      
      public function set image(param1:Canvas) : void
      {
         this._image = param1;
      }
      
      override public function playProp() : void
      {
      }
      
      override public function loadAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         _loc2_ = param1.target.loader;
         _loc2_.content.width = VideoPropThumb(this.thumb).videoWidth;
         _loc2_.content.height = VideoPropThumb(this.thumb).videoHeight;
         super.loadAssetImageComplete(param1);
      }
      
      override public function isColorable() : Boolean
      {
         return false;
      }
      
      public function get image() : Canvas
      {
         return this._image;
      }
      
      override internal function clone(param1:Boolean = false) : Asset
      {
         var _loc2_:VideoProp = new VideoProp();
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         _loc2_.scaleX = this.scaleX;
         _loc2_.scaleY = this.scaleY;
         _loc2_.rotation = this.rotation;
         _loc2_.scene = this.scene;
         _loc2_.id = _loc2_.bundle.id = this.id;
         _loc2_.attachedBg = this.attachedBg;
         _loc2_.init(this.thumb,null);
         _loc2_.facing = this.facing;
         _loc2_.stateId = this.stateId;
         _loc2_.state = this.state;
         if(this.motionShadow != null)
         {
            _loc2_.x = this.motionShadow.x;
            _loc2_.y = this.motionShadow.y;
            _loc2_.facing = this.motionShadow.facing;
            _loc2_.scaleX = this.motionShadow.scaleX;
            _loc2_.scaleY = this.motionShadow.scaleY;
            _loc2_.rotation = this.motionShadow.rotation;
         }
         return _loc2_;
      }
      
      override protected function getOrigin() : Point
      {
         var _loc1_:Point = new Point();
         var _loc2_:Point = this.displayElement.localToGlobal(new Point());
         var _loc3_:Point = scene.canvas.globalToLocal(_loc2_);
         _loc1_.x = _loc3_.x;
         _loc1_.y = _loc3_.y;
         return _loc1_;
      }
   }
}
