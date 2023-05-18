package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleEvent;
   import anifire.bubble.BubbleMgr;
   import anifire.command.ChangeBubbleCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveAssetCommand;
   import anifire.command.MoveBubbleTailCommand;
   import anifire.command.ResizeBubbleCommand;
   import anifire.components.containers.AssetInfoWindow;
   import anifire.components.studio.ControlButtonBar;
   import anifire.constant.AnimeConstants;
   import anifire.control.BubbleControl;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.control.ControlMgr;
   import anifire.control.FontChooser;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.PopUpManager;
   
   public class BubbleAsset extends Asset
   {
      
      public static var XML_NODE_NAME:String = "bubbleAsset";
      
      public static const MENU_LABEL_EDIT:String = "effecttray_edit";
      
      private static var _logger:ILogger = Log.getLogger("core.BubbleAsset");
       
      
      private var _buttonBar:ControlButtonBar;
      
      private var _edtime:Number = -1;
      
      private var _readyToDrag:Boolean = false;
      
      private var _prevTailX:Number;
      
      private var _originalBubbleHeight:Number;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _bubble:Bubble;
      
      private var _fontChooser:FontChooser;
      
      private var _prevTailY:Number;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _originalTailX:Number;
      
      private var _originalTailY:Number;
      
      private var _originalBubbleWidth:Number;
      
      private var _sttime:Number = -1;
      
      private var _originalAssetXML:XML;
      
      private var _editing:Boolean;
      
      private var _fromTray:Boolean = false;
      
      protected var _myBubbleXML:XML = null;
      
      public function BubbleAsset(param1:String = "")
      {
         super();
         _logger.debug("BubbleAsset initialized");
         if(param1 == "")
         {
            param1 = "BUBBLE" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
      }
      
      internal function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene) : void
      {
         var _loc3_:BubbleThumb = new BubbleThumb();
         _loc3_.imageData = param1.bubble;
         this.scene = param2;
         this.x = param1.x;
         this.y = param1.y;
         if(param1.child("st").length() > 0 && param1.child("st").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToSec(param1.st);
            this.edtime = UtilUnitConvert.frameToSec(param1.et);
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         this.thumb = _loc3_;
         this.isLoadded = true;
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_EDIT) + "\"/>" + "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      override public function deleteAsset(param1:Boolean = true) : void
      {
         this.hideFontChooser();
         this.hideControl();
         this.hideButtonBar();
         super.deleteAsset(param1);
      }
      
      public function updateOriginalBubbleSize() : void
      {
         this._originalBubbleWidth = this.bubble.width;
         this._originalBubbleHeight = this.bubble.height;
      }
      
      private function setButtonBarPosition() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._buttonBar != null)
         {
            _loc1_ = this.displayElement.getBounds(this.scene.canvas);
            _loc2_ = 10 / Console.getConsole().stageScale;
            _loc3_ = this._buttonBar.height / Console.getConsole().stageScale;
            _loc4_ = this._buttonBar.width / Console.getConsole().stageScale;
            if(_loc1_.y >= _loc3_ + _loc2_)
            {
               this._buttonBar.x = _loc1_.x - _loc2_ + _loc4_ > this.getSceneCanvas().width ? this.getSceneCanvas().width - _loc4_ : (_loc1_.x - _loc2_ > 0 ? _loc1_.x - _loc2_ : 0);
               this._buttonBar.y = _loc1_.y - _loc3_ - _loc2_;
            }
            else if(this.getSceneCanvas().width - (_loc1_.x + _loc1_.width + _loc2_) >= _loc4_)
            {
               this._buttonBar.x = _loc1_.x + _loc1_.width + _loc2_;
               this._buttonBar.y = _loc1_.y - _loc2_ > 0 ? _loc1_.y - _loc2_ : 0;
            }
            else if(_loc1_.x - _loc2_ >= _loc4_)
            {
               this._buttonBar.x = _loc1_.x - _loc2_ - _loc4_;
               this._buttonBar.y = _loc1_.y - _loc2_ > 0 ? _loc1_.y - _loc2_ : 0;
            }
            else if(this.getSceneCanvas().height - (_loc1_.y + _loc1_.height + _loc2_) >= _loc3_)
            {
               this._buttonBar.x = _loc1_.x - _loc2_ + _loc4_ > this.getSceneCanvas().width ? this.getSceneCanvas().width - _loc4_ : (_loc1_.x - _loc2_ > 0 ? _loc1_.x - _loc2_ : 0);
               this._buttonBar.y = _loc1_.y + _loc1_.height + _loc2_;
            }
            else
            {
               this._buttonBar.x = 0;
               this._buttonBar.y = 0;
            }
         }
      }
      
      override protected function doResizeStart(param1:ControlEvent) : void
      {
         var _loc2_:Bubble = Bubble(param1.target.asset);
         this._originalAssetXML = _loc2_.serialize();
         this._prevDisplayElementPosX = _loc2_.x;
         this._prevDisplayElementPosY = _loc2_.y;
      }
      
      public function get bubble() : Bubble
      {
         return this._bubble;
      }
      
      public function playBubble() : void
      {
         this.bubble.playBubble();
      }
      
      private function doEditComplete(param1:Event = null) : void
      {
         trace("doEditComplete at bubbleAsset:" + [this.bubble.checkCharacterSupport(),this.bubble.textEmbed]);
         if(UtilLicense.isBubbleI18NPermitted())
         {
            if(!this.bubble.checkCharacterSupport() && this.bubble.textEmbed)
            {
               this.bubble.textEmbed = false;
               trace("_fontChooser != null:" + (this._fontChooser != null));
               if(this._fontChooser != null)
               {
                  this.bubble.textFont = this._fontChooser.listFonts()[0].data;
                  trace("this.bubble.textFont :" + this.bubble.textFont);
               }
            }
         }
         this.editComplete(param1);
      }
      
      internal function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      public function setSize(param1:Number) : void
      {
         bundle.x += this.bubble.width / 4;
         bundle.y += this.bubble.height / 4;
         this.bubble.setSize(this.bubble.width * param1,this.bubble.height * param1);
         this.bubble.setTail(this.bubble.tailx * param1,this.bubble.taily * param1);
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
      
      public function set bubble(param1:Bubble) : void
      {
         this._bubble = param1;
      }
      
      private function onCallLaterHandler(param1:ControlEvent) : void
      {
         scene.selectedAsset = this;
         var _loc2_:XML = this.bubble.serialize();
         var _loc3_:ICommand = new ChangeBubbleCommand(id,_loc2_);
         _loc3_.execute();
      }
      
      private function showButtonBar() : void
      {
         if(this._buttonBar == null)
         {
            this._buttonBar = this.initButtonBar();
            this.scene.canvas.addChild(this._buttonBar);
            this._buttonBar.callLater(this.setButtonBarPosition);
         }
      }
      
      public function doMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:XML = XML(param1.item);
         var _loc3_:AssetInfoWindow = AssetInfoWindow(PopUpManager.createPopUp(Console.getConsole().currentScene.canvas,AssetInfoWindow,true));
         _loc3_.type = this.bubble.type;
         _loc3_.thumb = thumb;
         _loc3_.x = (_loc3_.stage.width - _loc3_.width) / 2;
         _loc3_.y = 100;
         _loc3_.mode = _loc3_.LEN_MODE;
         _loc3_.durscene = this.scene.getLength();
         _loc3_.assetId = this.id;
         if(this.sttime > -1 && this.edtime > -1)
         {
            _loc3_.sttime = this.sttime;
            _loc3_.edtime = this.edtime;
         }
      }
      
      override protected function doResize(param1:Event) : void
      {
         if(this._editing)
         {
            this.doEditComplete(param1);
         }
         var _loc2_:Control = Control(param1.target);
         var _loc3_:Bubble = Bubble(_loc2_.asset);
         var _loc4_:Object = _loc2_.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.setSize(_loc4_.w,_loc4_.h);
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(control != null)
         {
            if(!Console.getConsole().isGoWalkerOn())
            {
               this.showButtonBar();
            }
         }
      }
      
      public function getOriginalTailPosition() : Point
      {
         return new Point(this._originalTailX,this._originalTailY);
      }
      
      override public function doKeyDown(param1:KeyboardEvent) : void
      {
         if(this._fontChooser == null)
         {
            if(!this._editing)
            {
               super.doKeyDown(param1);
            }
         }
      }
      
      override public function doKeyUp(param1:KeyboardEvent, param2:Boolean = true) : void
      {
         if(this._fontChooser == null)
         {
            if(!this._editing)
            {
               super.doKeyUp(param1);
            }
         }
      }
      
      public function get text() : String
      {
         return this._bubble.text;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      private function showFontChooser(param1:MouseEvent = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:FontChooser = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this._bubble != null)
         {
            this._bubble.showEditMode();
            this._editing = true;
            if(this._fontChooser == null)
            {
               _loc2_ = this._bubble.showEditMode();
               _loc3_ = FontChooser(new _loc2_.fontChooser());
               this._fontChooser = _loc3_.getChooser(this._bubble,_loc2_.paras);
               this._fontChooser.scaleX = this._fontChooser.scaleY = 1 / Console.getConsole().stageScale;
               this._fontChooser.name = "FONTCHOOSER";
               this._fontChooser.alpha = 1;
               this._fontChooser.addEventListener(ControlEvent.CALL_LATER,this.onCallLaterHandler);
               if(param1 != null)
               {
                  _loc4_ = this._bubble.getBounds(this.scene.canvas);
                  if(this.scene.sizingAsset != null)
                  {
                     _loc5_ = this.scene.sizingAsset.imageObject.getRect(this.scene.canvas);
                  }
                  _loc6_ = (this._fontChooser.width - this._bubble.width) / 2;
                  if(Console.getConsole().stageScale <= 1)
                  {
                     if(_loc4_.x - _loc6_ < AnimeConstants.SCREEN_X)
                     {
                        this._fontChooser.x = AnimeConstants.SCREEN_X;
                     }
                     else if(_loc4_.x + this._bubble.width + _loc6_ > AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH)
                     {
                        this._fontChooser.x = AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH - this._fontChooser.width;
                     }
                     else
                     {
                        this._fontChooser.x = _loc4_.x - _loc6_;
                     }
                     _loc7_ = Number(this.scene.canvas.width);
                     _loc8_ = Number(this.scene.canvas.height);
                     _loc9_ = _loc4_.y + _loc4_.height / 2;
                     _loc10_ = _loc4_.y - (this.control != null ? this.control.lineSize : 0);
                     _loc11_ = _loc8_ - _loc4_.y - _loc4_.height - (this.control != null ? this.control.lineSize : 0);
                     if(_loc9_ >= _loc8_ / 2)
                     {
                        if(_loc10_ > this._fontChooser.height || _loc10_ < this._fontChooser.height && _loc11_ < this._fontChooser.height)
                        {
                           this._fontChooser.y = AnimeConstants.SCREEN_Y;
                        }
                        else
                        {
                           this._fontChooser.y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this._fontChooser.height;
                        }
                     }
                     else if(_loc9_ < _loc8_ / 2)
                     {
                        if(_loc11_ > this._fontChooser.height || _loc11_ < this._fontChooser.height && _loc10_ < this._fontChooser.height)
                        {
                           this._fontChooser.y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this._fontChooser.height;
                        }
                        else
                        {
                           this._fontChooser.y = AnimeConstants.SCREEN_Y;
                        }
                     }
                     if(Console.getConsole().isGoWalkerOn())
                     {
                        this._fontChooser.y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this._fontChooser.height;
                     }
                  }
                  else
                  {
                     this._fontChooser.x = _loc5_.x;
                     this._fontChooser.y = _loc5_.y;
                  }
               }
               this.scene.canvas.addChild(this._fontChooser);
            }
         }
      }
      
      override public function set control(param1:Control) : void
      {
         super.control = param1;
         if(this.control != null)
         {
            this.control.addEventListener(ControlEvent.TAIL_MOVE_START,this.doTailMoveStart);
            this.control.addEventListener(ControlEvent.TAIL_MOVE,this.doTailMove);
            this.control.addEventListener(ControlEvent.TAIL_MOVE_COMPLETE,this.doTailMoveComplete);
         }
      }
      
      override internal function hideControl() : void
      {
         super.hideControl();
         if(this._fontChooser != null && displayElement != null)
         {
            if(!this._fontChooser.hitTestPoint(displayElement.stage.mouseX,displayElement.stage.mouseY) && !this._fontChooser.click)
            {
               this.hideFontChooser();
            }
         }
         this.hideButtonBar();
      }
      
      override internal function doDragComplete(param1:DragEvent) : void
      {
         this._readyToDrag = false;
         var _loc2_:UIComponent = UIComponent(param1.dragInitiator);
         _loc2_.alpha = 1;
         _loc2_.setFocus();
         if(this == this.scene.selectedAsset)
         {
            this.showControl();
         }
      }
      
      private function onTextChangedHandler(param1:BubbleEvent) : void
      {
         trace("onTextChanged");
         this.scene.doUpdateTimelineLength();
         if(Console.getConsole().goWalker.guideMode)
         {
            Console.getConsole().dispatchGoWalkerEvent(15);
            this.hideControl();
         }
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         super.thumb = param1;
         this.imageData = param1.imageData;
      }
      
      internal function doTailMoveComplete(param1:Event) : void
      {
         var _loc2_:ICommand = null;
         if(this._originalAssetXML != this._bubble.serialize())
         {
            _loc2_ = new MoveBubbleTailCommand(id,this._originalAssetXML);
            _loc2_.execute();
         }
      }
      
      private function doEditBubbleTextComplete(param1:Event = null) : void
      {
         var _loc2_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this.bubble.backupText = this.text;
         this.text = _loc2_.filter(this.text);
         if(this.bubble.backupText != this.text)
         {
            this.bubble.redraw();
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         trace("onMouseDown");
         if(this.scene.selectedAsset is BubbleAsset)
         {
            if(!BubbleAsset(this.scene.selectedAsset)._editing)
            {
               this.scene.selectedAsset.hideControl();
            }
         }
         else if(this.scene.selectedAsset != null)
         {
            this.scene.selectedAsset.hideControl();
         }
         if(!this._editing)
         {
            this.hideFontChooser();
         }
         if(UtilUser.isPremium())
         {
            if(!param1.shiftKey)
            {
               this.scene.clearSelectedAssets();
            }
            this.scene.addSelectedAsset(this);
         }
         else if(this.scene.selectedAsset == null || this.scene.selectedAsset != null && this.scene.selectedAsset != this)
         {
            this.scene.selectedAsset = this;
         }
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc9_:ICommand = null;
         var _loc10_:Image = null;
         trace("onStageMouseUpHandler");
         var _loc2_:Number = Number(getSceneCanvas().mouseX);
         var _loc3_:Number = Number(getSceneCanvas().mouseY);
         var _loc4_:Point = new Point(_loc2_,_loc3_);
         var _loc5_:Point = new Point(this._originalX,this._originalY);
         var _loc6_:Number = _loc4_.x - _loc5_.x;
         var _loc7_:Number = _loc4_.y - _loc5_.y;
         var _loc8_:Number = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         if(_loc2_ == this._originalX && _loc3_ == this._originalY)
         {
            if(this.text != this.bubble.backupText)
            {
               this.text = this.bubble.backupText;
               this.bubble.redraw();
            }
            this.showFontChooser(param1);
         }
         else
         {
            (_loc9_ = new MoveAssetCommand(id,_originalAssetX,_originalAssetY)).execute();
         }
         this._readyToDrag = false;
         this.showControl();
         if(Console.getConsole().currDragObject != null)
         {
            if(this.scene.selectedAsset == null)
            {
               this.scene.selectedAsset = this;
            }
            (_loc10_ = this.scene.selectedAsset.bundle as Image).stopDrag();
            Console.getConsole().currDragObject = null;
         }
         changed = true;
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().thumbTrayActive = true;
      }
      
      private function onControlOutlineDownHandler(param1:ControlEvent) : void
      {
         var _loc2_:Image = Image(this.bundle);
         _loc2_.startDrag();
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:Bubble = null;
         var _loc2_:XML = XML(this.imageData);
         if(this._myBubbleXML == null)
         {
            _loc1_ = BubbleMgr.getBubbleByXML(_loc2_);
         }
         else
         {
            _loc1_ = BubbleMgr.getBubbleByXML(XML(this._myBubbleXML));
         }
         _loc1_.addEventListener(BubbleEvent.TEXT_CHANGED,this.onTextChangedHandler);
         this._bubble = _loc1_;
         if(this._fromTray)
         {
            if(this._bubble.text == _loc2_.text.text())
            {
               this._bubble.text = this._bubble.backupText = UtilDict.toDisplay("store",this._bubble.text);
               if(this._bubble.text != _loc2_.text.text())
               {
                  this._bubble.textEmbed = false;
                  this.showFontChooser();
                  this._bubble.textFont = this._fontChooser.listFonts()[0].data;
                  this.hideFontChooser();
               }
            }
         }
         this._bubble.useDeviceFont = true;
         this._bubble.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.doEditComplete);
         this._bubble.addEventListener(FocusEvent.FOCUS_IN,this.doEditBegin);
         this._bubble.addEventListener(FocusEvent.FOCUS_OUT,this.doEditComplete);
         var _loc3_:int = 0;
         while(_loc3_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc3_) is Bubble)
            {
               this.displayElement.removeChildAt(_loc3_);
               break;
            }
            _loc3_++;
         }
         this.displayElement.addChild(_loc1_);
         if(this._fromTray)
         {
            bundle.x -= _loc1_.width / 2;
            bundle.y -= _loc1_.height / 2;
         }
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      public function getOriginalBubbleSize() : Point
      {
         return new Point(this._originalBubbleWidth,this._originalBubbleHeight);
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      public function stopBubble() : void
      {
         this.bubble.stopBubble();
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      override internal function clone(param1:Boolean = false) : Asset
      {
         var _loc2_:BubbleAsset = new BubbleAsset();
         _loc2_._myBubbleXML = this.bubble.serialize();
         _loc2_.id = this.id;
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         _loc2_.scene = this.scene;
         _loc2_.thumb = this.thumb;
         return _loc2_;
      }
      
      public function updateTimeByScene(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 / param2;
         if(this.sttime != -1 && this.edtime != -1)
         {
            this.sttime *= _loc3_;
            this.edtime *= _loc3_;
            this.sttime = Util.roundNum(this.sttime);
            this.edtime = Util.roundNum(this.edtime);
         }
      }
      
      public function set text(param1:String) : void
      {
         this._bubble.text = param1;
      }
      
      public function editComplete(param1:Event = null) : void
      {
         this._editing = false;
         this.doEditBubbleTextComplete();
         this._bubble.hideEditMode();
         if(param1 == null)
         {
            this.hideControl();
         }
         this.scene.doUpdateTimelineLength(-1,true);
      }
      
      override internal function initializeDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         this.onMouseDown(param1);
         this._readyToDrag = true;
         if(!this._editing || this._editing && !this._bubble.isMouseOnLabel())
         {
            _loc2_ = Image(param1.currentTarget.parent);
            _loc2_.startDrag();
            this._originalX = getSceneCanvas().mouseX;
            this._originalY = getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            Console.getConsole().currDragObject = this;
            Console.getConsole().thumbTrayActive = true;
         }
      }
      
      internal function doTailMoveStart(param1:Event) : void
      {
         var _loc2_:Bubble = Bubble(param1.target.asset);
         this._originalAssetXML = _loc2_.serialize();
         this._prevTailX = _loc2_.tailx;
         this._prevTailY = _loc2_.taily;
      }
      
      private function initButtonBar() : ControlButtonBar
      {
         var _loc1_:ControlButtonBar = new ControlButtonBar();
         _loc1_.callLater(_loc1_.init,[-1,0,1,2,-2,-3]);
         return _loc1_;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
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
      
      override public function serialize() : String
      {
         var _loc1_:Canvas = getSceneCanvas();
         var _loc2_:* = "";
         if(this.sttime > -1 && this.edtime > -1)
         {
            if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
            {
               _loc2_ = "<st>" + UtilUnitConvert.secToFrame(this.sttime) + "</st>" + "<et>" + UtilUnitConvert.secToFrame(this.edtime) + "</et>";
            }
         }
         return "<bubbleAsset id=\"" + this.id + "\" index=\"" + _loc1_.getChildIndex(this.bundle) + "\">" + "<x>" + Util.roundNum(this.x) + "</x>" + "<y>" + Util.roundNum(this.y) + "</y>" + _loc2_ + this._bubble.serialize().toXMLString() + "</bubbleAsset>";
      }
      
      public function updateOriginalTailPosition() : void
      {
         this._originalTailX = this.bubble.tailx;
         this._originalTailY = this.bubble.taily;
      }
      
      private function doEditBegin(param1:Event = null) : void
      {
         if(Console.getConsole().isGoWalkerOn())
         {
            Console.getConsole().dispatchGoWalkerEvent(15);
         }
      }
      
      private function hideFontChooser() : void
      {
         if(this._bubble != null)
         {
            this._bubble.hideEditMode();
            this._editing = false;
            Console.getConsole().thumbTrayActive = true;
         }
         if(this._fontChooser != null)
         {
            this.scene.canvas.removeChild(this._fontChooser);
            this._fontChooser = null;
         }
      }
      
      override protected function doResizeComplete(param1:Event) : void
      {
         var _loc2_:ICommand = null;
         this.changed = true;
         if(this._originalAssetXML != this._bubble.serialize())
         {
            _loc2_ = new ResizeBubbleCommand(id,this._originalAssetXML);
            _loc2_.execute();
         }
      }
      
      internal function doTailMove(param1:Event) : void
      {
         if(this._editing)
         {
            this.doEditComplete(param1);
         }
         var _loc2_:Bubble = Bubble(param1.target.asset);
         var _loc3_:Number = Number(param1.target.xTailOffset);
         var _loc4_:Number = Number(param1.target.yTailOffset);
         _loc2_.setTail(this._prevTailX + _loc3_,this._prevTailY + _loc4_);
      }
      
      override public function addControl() : void
      {
         var _loc1_:BubbleControl = ControlMgr.getControl(this._bubble,ControlMgr.BUBBLE) as BubbleControl;
         var _loc2_:Rectangle = this._bubble.getBounds(this.bundle);
         _loc1_.setPos(this._bubble.x,this._bubble.y);
         _loc1_.setOrigin(this._bubble.width / 2,this._bubble.height / 2);
         _loc1_.setTail(this._bubble.tailx,this._bubble.taily);
         _loc1_.addEventListener(ControlEvent.OUTLINE_DOWN,this.onControlOutlineDownHandler);
         _loc1_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
         _loc1_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
         _loc1_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
         _loc1_.hideControl();
         this.control = _loc1_;
      }
   }
}
