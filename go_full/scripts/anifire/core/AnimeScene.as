package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.command.AddAssetCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveAssetsCommand;
   import anifire.command.ResizeAssetsCommand;
   import anifire.components.containers.GoAlert;
   import anifire.components.studio.ControlButtonBar;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.EffectTrayEvent;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.control.ControlMgr;
   import anifire.control.FixedControl;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.event.LoadMgrEvent;
   import anifire.util.FontManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilString;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import caurina.transitions.*;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.List;
   import mx.controls.Menu;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.ResizeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipFile;
   
   public class AnimeScene
   {
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      public static var XML_NODE_NAME:String = "scene";
      
      private static var _sceneNum:int = 0;
      
      private static var _logger:ILogger = Log.getLogger("core.AnimeScene");
      
      private static const ASSET_CREATION_MODE_NULL:String = "nothing";
      
      private static const ASSET_CREATION_MODE_OLD_INSTANCE:String = "old instance";
      
      private static const ASSET_CREATION_MODE_NEW_INSTANCE:String = "new instance";
       
      
      private var _length:Number;
      
      private var _characters:UtilHashArray;
      
      private var _prevCenter:Point;
      
      private var _selectedAsset:anifire.core.Asset;
      
      private var _console:anifire.core.Console;
      
      private var _selectedAssets:Array;
      
      private var _control:Control;
      
      private var _bubbles:UtilHashArray;
      
      private const _DEFAULT_BUBBLE_DALEY:Number = 65;
      
      private var _asset_creation_mode:String = "old instance";
      
      private var _isDragEnter:Boolean;
      
      private var _userLockedTime:Number;
      
      private var _sizingAsset:anifire.core.Asset;
      
      private const BACKGROUND_INDEX:int = 0;
      
      private var _oldMousePosition:Point;
      
      private var _changed:Boolean;
      
      private var _canvas:Canvas;
      
      private var _props:UtilHashArray;
      
      private var _name:String;
      
      public var enableClickTimer:Timer;
      
      private var _asset_creation_thumb:anifire.core.Thumb;
      
      private var _bundle:UIComponent;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _asset_creation_dx:Number;
      
      private var _asset_creation_dy:Number;
      
      private var _cloneableAssetsInfo:UtilHashArray;
      
      private const MULTI_SELECT_BORDER_COLOR:uint = 16492449;
      
      private var _afterComBgAsset:Array;
      
      private const MOTION_TIME:Number = UtilUnitConvert.secToPixel(AnimeConstants.MOTION_DURATION);
      
      private var _id:String;
      
      private var _effects:UtilHashArray;
      
      private var _background:anifire.core.Background;
      
      private var _dashline:UIComponent;
      
      public function AnimeScene(param1:String = "")
      {
         this._afterComBgAsset = new Array();
         this._eventDispatcher = new EventDispatcher();
         super();
         _logger.debug("AnimeScene initialized");
         ++_sceneNum;
         this._id = this.generateNewID(param1);
         this._name = param1;
         this._characters = new UtilHashArray();
         this._bubbles = new UtilHashArray();
         this._props = new UtilHashArray();
         this._effects = new UtilHashArray();
         this._cloneableAssetsInfo = new UtilHashArray();
         this._userLockedTime = -1;
         this.enableClickTimer = new Timer(AnimeConstants.DOUBLE_CLICK_DURATION,0);
         this.enableClickTimer.addEventListener(TimerEvent.TIMER,this.enableClickingAgain);
         this.initialCanvas();
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:UtilHashArray = new UtilHashArray();
         _loc4_ = 0;
         while(_loc4_ < param1.child(anifire.core.Background.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(anifire.core.Background.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,anifire.core.Background.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Character.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Character.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Character.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Prop.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Prop.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Prop.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(EffectAsset.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(EffectAsset.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,EffectAsset.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         return _loc6_;
      }
      
      public function get effects() : UtilHashArray
      {
         return this._effects;
      }
      
      private function doStageMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(this.console != null && this.console.currentScene != null)
         {
            if(_loc2_ == this.console.currentScene.canvas)
            {
               this.selectedAsset = null;
            }
         }
         var _loc3_:Boolean = true;
         _loc2_ = DisplayObject(param1.target);
         if(_loc2_ == anifire.core.Console.getConsole().thumbTray)
         {
            _loc3_ = false;
         }
         else
         {
            while(_loc2_.parent != null)
            {
               _loc2_ = _loc2_.parent;
               if(_loc2_ == anifire.core.Console.getConsole().thumbTray || _loc2_ is List)
               {
                  _loc3_ = false;
                  break;
               }
            }
         }
         if(DragManager.isDragging)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this.console.thumbTray.hide(param1,_loc3_);
         }
      }
      
      private function getControlOnSelectedAssets() : Control
      {
         var _loc5_:anifire.core.Asset = null;
         var _loc1_:Boolean = false;
         var _loc2_:String = ControlMgr.NORMAL;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         for each(_loc5_ in this.selectedAssets)
         {
            if(_loc5_ is EffectAsset)
            {
               _loc3_ = true;
               break;
            }
            if(_loc5_ is BubbleAsset)
            {
               _loc4_ = true;
            }
         }
         if(_loc3_)
         {
            _loc2_ = ControlMgr.FIXED;
            _loc1_ = false;
         }
         else if(_loc4_)
         {
            _loc1_ = false;
         }
         var _loc6_:Control;
         (_loc6_ = ControlMgr.getControl(this._canvas,_loc2_)).setLineColor(this.MULTI_SELECT_BORDER_COLOR);
         _loc6_.dragable = _loc1_;
         return _loc6_;
      }
      
      private function removeProp(param1:Prop) : void
      {
         var _loc2_:int = this._props.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._props.remove(_loc2_,1);
         }
      }
      
      private function removeCharacter(param1:Character) : void
      {
         this._characters.remove(this._characters.getIndex(param1.id),1);
      }
      
      private function dispatchDeserializeComplete(param1:Boolean) : void
      {
         anifire.core.Console.getConsole().doUpdateTimelineByScene(this,true);
         if(param1)
         {
            this.unloadAllAssets();
         }
         this.eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this));
      }
      
      public function set dragEnter(param1:Boolean) : void
      {
         this._isDragEnter = param1;
      }
      
      public function updateEffectTray(param1:Number, param2:Number) : void
      {
         var _loc4_:EffectAsset = null;
         var _loc5_:BubbleAsset = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.bubbles.length)
         {
            (_loc5_ = this.bubbles.getValueByIndex(_loc3_) as BubbleAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.effects.length)
         {
            (_loc4_ = this.effects.getValueByIndex(_loc3_) as EffectAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
      }
      
      private function clearCanvas() : void
      {
         this._canvas.removeAllChildren();
         this._bundle = new UIComponent();
         this._canvas.addChild(this._bundle);
         this._dashline = new UIComponent();
         this._dashline.name = "DASHLINE";
         this._canvas.addChild(this._dashline);
      }
      
      public function get selectedAsset() : anifire.core.Asset
      {
         return this._selectedAsset;
      }
      
      private function getAssetId(param1:anifire.core.Thumb) : AssetLocation
      {
         var _loc5_:int = 0;
         var _loc6_:UtilHashArray = null;
         var _loc7_:anifire.core.Asset = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:anifire.core.Asset = null;
         var _loc10_:UtilHashArray = null;
         var _loc11_:Prop = null;
         var _loc12_:UtilHashArray = null;
         var _loc13_:Prop = null;
         var _loc14_:UtilHashArray = null;
         var _loc15_:EffectAsset = null;
         var _loc2_:String = param1.id;
         var _loc3_:AnimeScene = anifire.core.Console.getConsole().getPrevScene(this);
         var _loc4_:AnimeScene = anifire.core.Console.getConsole().getNextScene(this);
         if(param1 is CharThumb)
         {
            if(_loc3_ != null)
            {
               _loc6_ = _loc3_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc6_.length)
               {
                  _loc7_ = _loc6_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc7_.thumb.id)
                  {
                     if(this.getAssetById(_loc7_.id) == null)
                     {
                        return new AssetLocation(_loc7_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc8_ = _loc4_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.length)
               {
                  _loc9_ = _loc8_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc9_.thumb.id)
                  {
                     if(this.getAssetById(_loc9_.id) == null)
                     {
                        return new AssetLocation(_loc9_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is PropThumb)
         {
            if(_loc3_ != null)
            {
               _loc10_ = _loc3_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc10_.length)
               {
                  _loc11_ = _loc10_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc11_.thumb.id)
                  {
                     if(this.getAssetById(_loc11_.id) == null)
                     {
                        return new AssetLocation(_loc11_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc12_ = _loc4_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc12_.length)
               {
                  _loc13_ = _loc12_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc13_.thumb.id)
                  {
                     if(this.getAssetById(_loc13_.id) == null)
                     {
                        return new AssetLocation(_loc13_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is EffectThumb)
         {
            if(_loc3_ != null)
            {
               if(EffectThumb(param1).getExactType() == EffectThumb.TYPE_ZOOM && EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)) != null)
               {
                  EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
               }
               _loc14_ = _loc3_.effects;
               _loc5_ = 0;
               while(_loc5_ < _loc14_.length)
               {
                  _loc15_ = _loc14_.getValueByIndex(_loc5_);
                  if(EffectThumb(param1).getExactType() == EffectThumb(_loc15_.thumb).getExactType())
                  {
                     if(this.getAssetById(_loc15_.id) == null)
                     {
                        return new AssetLocation(_loc15_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         return null;
      }
      
      public function get sizingAsset() : anifire.core.Asset
      {
         return this._sizingAsset;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      private function doStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(this.console.currentScene != null)
         {
            if(_loc2_ == this.console.currentScene.canvas)
            {
               this.console.currentScene.selectedAsset = null;
            }
            else
            {
               while(_loc2_.parent != null)
               {
                  _loc2_ = _loc2_.parent;
                  if(_loc2_ == this.console.stageViewStage || _loc2_ is Menu)
                  {
                     break;
                  }
                  if(_loc2_ == param1.currentTarget)
                  {
                     this.console.currentScene.selectedAsset = null;
                     break;
                  }
               }
            }
         }
         var _loc3_:Boolean = true;
         _loc2_ = DisplayObject(param1.target);
         if(_loc2_ == anifire.core.Console.getConsole().thumbTray)
         {
            _loc3_ = false;
         }
         else
         {
            while(_loc2_.parent != null)
            {
               _loc2_ = _loc2_.parent;
               if(_loc2_ == this.console.thumbTray)
               {
                  _loc3_ = false;
                  break;
               }
            }
         }
         if(_loc3_)
         {
            this.console.thumbTray.hide(param1,_loc3_);
         }
      }
      
      protected function doResize(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:Bubble = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:SuperEffect = null;
         var _loc2_:Object = this.control.getStuff(0,0);
         var _loc5_:int = 0;
         while(_loc5_ < this.selectedAssets.length)
         {
            if(this.selectedAssets[_loc5_] is BubbleAsset)
            {
               _loc6_ = BubbleAsset(this.selectedAssets[_loc5_]).bubble;
               _loc3_ = BubbleAsset(this.selectedAssets[_loc5_]).getOriginalBubbleSize().x;
               _loc4_ = BubbleAsset(this.selectedAssets[_loc5_]).getOriginalBubbleSize().y;
               _loc7_ = BubbleAsset(this.selectedAssets[_loc5_]).getOriginalTailPosition().x;
               _loc8_ = BubbleAsset(this.selectedAssets[_loc5_]).getOriginalTailPosition().y;
               _loc6_.setSize(_loc3_ * _loc2_.scaleX,_loc4_ * _loc2_.scaleY);
               _loc6_.setTail(_loc7_ * _loc2_.scaleX,_loc8_ * _loc2_.scaleY);
            }
            else if(this.selectedAssets[_loc5_] is EffectAsset)
            {
               _loc9_ = EffectAsset(this.selectedAssets[_loc5_]).effect;
               _loc3_ = EffectAsset(this.selectedAssets[_loc5_]).getOriginalEffectSize().x;
               _loc4_ = EffectAsset(this.selectedAssets[_loc5_]).getOriginalEffectSize().y;
               _loc9_.setSize(_loc3_ * _loc2_.scaleX,_loc4_ * _loc2_.scaleY);
            }
            else
            {
               Asset(this.selectedAssets[_loc5_]).displayElement.scaleX = _loc2_.scaleX * Asset(this.selectedAssets[_loc5_]).getOriginalAssetScale().x;
               Asset(this.selectedAssets[_loc5_]).displayElement.scaleY = _loc2_.scaleY * Asset(this.selectedAssets[_loc5_]).getOriginalAssetScale().y;
            }
            Asset(this.selectedAssets[_loc5_]).bundle.x = (Asset(this.selectedAssets[_loc5_]).getOriginalAssetPosition().x - this._prevCenter.x) * _loc2_.scaleX + this._prevCenter.x;
            Asset(this.selectedAssets[_loc5_]).bundle.y = (Asset(this.selectedAssets[_loc5_]).getOriginalAssetPosition().y - this._prevCenter.y) * _loc2_.scaleY + this._prevCenter.y;
            _loc5_++;
         }
      }
      
      public function deleteAllAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.deleteAsset(false);
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_++;
         }
      }
      
      public function getEffectAssetById(param1:String, param2:Number = 0) : EffectAsset
      {
         var _loc3_:int = this._console.getSceneIndex(this);
         var _loc4_:AnimeScene;
         if((_loc4_ = anifire.core.Console.getConsole().getScene(_loc3_ + param2)) == null)
         {
            return null;
         }
         return EffectAsset(_loc4_.effects.getValueByKey(param1));
      }
      
      private function getCloneableAssetIndex(param1:String) : int
      {
         return this._cloneableAssetsInfo.getIndex(param1);
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc5_:Image = null;
         var _loc2_:Number = this._canvas.mouseX - this._oldMousePosition.x;
         var _loc3_:Number = this._canvas.mouseY - this._oldMousePosition.y;
         var _loc4_:int = 0;
         while(_loc4_ < this.selectedAssets.length)
         {
            (_loc5_ = Image(Asset(this.selectedAssets[_loc4_]).bundle)).x = Asset(this.selectedAssets[_loc4_]).getOriginalAssetPosition().x + _loc2_;
            _loc5_.y = Asset(this.selectedAssets[_loc4_]).getOriginalAssetPosition().y + _loc3_;
            _loc4_++;
         }
      }
      
      public function get userLockedTime() : Number
      {
         return this._userLockedTime;
      }
      
      private function removeAllBubbles() : void
      {
         this._bubbles.removeAll();
      }
      
      public function get background() : anifire.core.Background
      {
         return this._background;
      }
      
      private function getCloeableAssetInfo(param1:String) : String
      {
         return this._cloneableAssetsInfo.getValueByKey(param1);
      }
      
      public function set selectedAsset(param1:anifire.core.Asset) : void
      {
         if(this._selectedAsset != null && param1 != this._selectedAsset)
         {
            if(this._selectedAsset.control != null)
            {
               this._selectedAsset.hideControl();
            }
            this._selectedAsset.control = null;
         }
         this._selectedAsset = param1;
         if(this._selectedAsset != null)
         {
            this._selectedAsset.addControl();
         }
         anifire.core.Console.getConsole().showOverTray(false);
      }
      
      private function bringUpAsset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._afterComBgAsset.length)
         {
            this.sendToFront(this._afterComBgAsset[_loc1_]);
            _loc1_++;
         }
         this._afterComBgAsset = new Array();
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         _existIDs.push(param1,param1);
      }
      
      private function removeBubble(param1:BubbleAsset) : void
      {
         var _loc2_:int = this._bubbles.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._bubbles.remove(_loc2_,1);
            this.refreshEffectTray(anifire.core.Console.getConsole().effectTray);
            this.doUpdateTimelineLength();
         }
      }
      
      private function rotateSelectedAssets(param1:ControlEvent) : void
      {
         var _loc11_:anifire.core.Asset = null;
         var _loc2_:Control = Control(param1.target);
         var _loc3_:Rectangle = this.getRectForMultipleObjects(this.selectedAssets);
         var _loc4_:Number = this.canvas.mouseX - _loc3_.x;
         var _loc5_:Number = this.canvas.mouseY - _loc3_.y;
         var _loc6_:Number = Math.atan2(_loc5_,_loc4_);
         var _loc7_:Number = _loc3_.x + _loc3_.width / 2;
         var _loc8_:Number = _loc3_.y + _loc3_.height / 2;
         var _loc9_:Number = Math.atan2(_loc8_,_loc7_);
         var _loc10_:Number = (_loc6_ - _loc9_) * 180 / Math.PI;
         for each(_loc11_ in this.selectedAssets)
         {
            _loc11_.rotation = _loc10_;
         }
         _loc2_.rotation = _loc10_;
      }
      
      public function loadAllAssets() : void
      {
         var _loc6_:Character = null;
         var _loc7_:BubbleAsset = null;
         var _loc8_:Prop = null;
         var _loc9_:EffectAsset = null;
         this.console.capScreenLock = true;
         var _loc1_:UtilLoadMgr = new UtilLoadMgr();
         _loc1_.setExtraData(new Date());
         _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadAllAssetsComplete);
         if(this._background != null)
         {
            _loc1_.addEventDispatcher(this._background.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            this._background.imageData = this._background.thumb.imageData;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._characters.length)
         {
            _loc6_ = Character(this._characters.getValueByIndex(_loc2_));
            _loc1_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            _loc6_.imageData = _loc6_.action.imageData;
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._bubbles.length)
         {
            _loc7_ = BubbleAsset(this._bubbles.getValueByIndex(_loc3_));
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._props.length)
         {
            _loc8_ = Prop(this._props.getValueByIndex(_loc4_));
            _loc1_.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            if(_loc8_.state != null)
            {
               _loc8_.imageData = _loc8_.state.imageData;
            }
            else
            {
               _loc8_.imageData = _loc8_.thumb.imageData;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this._effects.length)
         {
            if((_loc9_ = this._effects.getValueByIndex(_loc5_) as EffectAsset) is AnimeEffectAsset)
            {
               _loc1_.addEventDispatcher(_loc9_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
               AnimeEffectAsset(_loc9_).imageData = AnimeEffectAsset(_loc9_).thumb.imageData;
            }
            _loc5_++;
         }
         _loc1_.commit();
      }
      
      private function doCreateAssetAtSceneAgain(param1:LoadMgrEvent) : void
      {
         trace("doCreateCharAtSceneAgain");
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:anifire.core.Thumb = _loc3_[0] as anifire.core.Thumb;
         var _loc5_:Number = Number(_loc3_[1]);
         var _loc6_:Number = Number(_loc3_[2]);
         var _loc7_:String = String(_loc3_[3]);
         Util.gaTracking("/gostudio/assets/" + _loc4_.theme.id + "/complete/" + _loc4_.id,anifire.core.Console.getConsole().mainStage.stage);
         this.createAsset(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function getEffectAssetByType(param1:String) : EffectAsset
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function showEffects(param1:Boolean = false) : void
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._effects.length)
         {
            if(this._effects.getValueByIndex(_loc3_) is AnimeEffectAsset)
            {
               _loc2_ = AnimeEffectAsset(this._effects.getValueByIndex(_loc3_));
               if(_loc2_.status == EffectAsset.STATUS_SHOW)
               {
                  _loc2_.showEffect();
               }
            }
            if(param1)
            {
               if(this._effects.getValueByIndex(_loc3_) is ProgramEffectAsset)
               {
                  _loc2_ = ProgramEffectAsset(this._effects.getValueByIndex(_loc3_));
                  if(_loc2_.getExactType() == EffectThumb.TYPE_ZOOM)
                  {
                     _loc2_.status = EffectAsset.STATUS_SHOW;
                     _loc2_.showEffect();
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function doEffectTrayOver(param1:EffectTrayEvent) : void
      {
         var _loc2_:anifire.core.Asset = this.getAssetById(param1.id);
         if(_loc2_ != null && anifire.core.Console.getConsole().currentScene == this)
         {
            this.selectedAsset = _loc2_;
            this.selectedAsset.showControl();
         }
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         this.canvas.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         this.canvas.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         var _loc2_:int = 0;
         while(_loc2_ < this.selectedAssets.length)
         {
            if(!(this.selectedAssets[_loc2_] is BubbleAsset))
            {
               if(this.selectedAssets[_loc2_] is EffectAsset)
               {
                  EffectAsset(this.selectedAssets[_loc2_]).checkEffectAssetSize();
               }
            }
            _loc2_++;
         }
         this.updateSelectedStuffs();
         this.control.stopDrag();
      }
      
      public function getPropById(param1:String) : Prop
      {
         return Prop(this._props.getValueByKey(param1));
      }
      
      public function getPropInPrevSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = anifire.core.Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      private function replaceVideo(param1:Event) : void
      {
         this.deleteAllVideos();
         var _loc2_:Array = Button(param1.currentTarget).data as Array;
         this.createAsset(_loc2_[0],_loc2_[1],_loc2_[2]);
      }
      
      private function doEffectTrayClick(param1:EffectTrayEvent) : void
      {
         var _loc2_:anifire.core.Asset = this.getAssetById(param1.id);
         if(_loc2_ is BubbleAsset)
         {
            (_loc2_ as BubbleAsset).showMenu(this._canvas.stage.mouseX,this._canvas.stage.mouseY);
         }
         else if(_loc2_ is EffectAsset)
         {
            (_loc2_ as EffectAsset).showMenu(this._canvas.stage.mouseX,this._canvas.stage.mouseY);
         }
      }
      
      public function get console() : anifire.core.Console
      {
         return this._console;
      }
      
      public function getNumberOfAssests() : int
      {
         if(this._background == null)
         {
            return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 0;
         }
         return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 1;
      }
      
      public function getAssetById(param1:String) : anifire.core.Asset
      {
         if(param1.indexOf("BG") != -1)
         {
            return this._background;
         }
         if(param1.indexOf("AVATOR") != -1)
         {
            return this.getCharacterById(param1);
         }
         if(param1.indexOf("BUBBLE") != -1)
         {
            return this.getBubbleAssetById(param1);
         }
         if(param1.indexOf("EFFECT") != -1)
         {
            return this.getEffectAssetById(param1);
         }
         if(param1.indexOf("PROP") != -1)
         {
            return this.getPropById(param1);
         }
         return null;
      }
      
      public function createAsset(param1:anifire.core.Thumb, param2:Number = 0, param3:Number = 0, param4:String = "") : void
      {
         var _loc5_:GoAlert = null;
         var _loc6_:anifire.core.Asset = null;
         var _loc7_:anifire.core.Asset = null;
         var _loc8_:UtilLoadMgr = null;
         var _loc9_:Array = null;
         var _loc10_:CharThumb = null;
         var _loc11_:AssetLocation = null;
         var _loc12_:String = null;
         var _loc13_:BackgroundThumb = null;
         var _loc14_:BubbleThumb = null;
         var _loc15_:SoundThumb = null;
         var _loc16_:AnimeScene = null;
         var _loc17_:PropThumb = null;
         var _loc18_:Object = null;
         var _loc19_:AssetLocation = null;
         var _loc20_:String = null;
         var _loc21_:EffectThumb = null;
         var _loc22_:AssetLocation = null;
         var _loc23_:String = null;
         if(param1 is VideoPropThumb && this.isVideoTypeExist())
         {
            (_loc5_ = GoAlert(PopUpManager.createPopUp(this._canvas,GoAlert,true)))._lblConfirm.text = "";
            _loc5_._txtDelete.text = UtilDict.toDisplay("go","goalert_confirmreplacevideo");
            _loc5_._btnDelete.label = UtilDict.toDisplay("go","goalert_confirmreplacevideoyes");
            _loc5_._btnDelete.data = new Array(param1,param2,param3);
            _loc5_._btnDelete.addEventListener(MouseEvent.CLICK,this.replaceVideo);
            _loc5_._btnCancel.label = UtilDict.toDisplay("go","goalert_confirmreplacevideono");
            _loc5_._btnCancel.data = new Array(param1,param2,param3);
            _loc5_.x = (_loc5_.stage.width - _loc5_.width) / 2;
            _loc5_.y = 100;
            return;
         }
         if(anifire.core.Console.getConsole().stageScale > 1)
         {
            _loc6_ = anifire.core.Console.getConsole().currentScene.sizingAsset;
            param2 = param2 / anifire.core.Console.getConsole().stageScale + _loc6_.x;
            param3 = param3 / anifire.core.Console.getConsole().stageScale + _loc6_.y;
         }
         if(anifire.core.Console.getConsole().initCreation == true)
         {
            anifire.core.Console.getConsole().initCreation = false;
            Util.gaTracking("/gostudio/sigAction",anifire.core.Console.getConsole().mainStage.stage);
         }
         if(param3 >= 0)
         {
            if(param1 is CharThumb)
            {
               if(!(_loc10_ = param1 as CharThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  if(_loc10_.theme.id == "ugc")
                  {
                     _loc10_.loadActionsAndMotions();
                  }
                  else
                  {
                     _loc10_.loadAction();
                  }
               }
               else
               {
                  if((_loc11_ = this.getAssetId(param1)) != null)
                  {
                     _loc12_ = _loc11_.assetId;
                  }
                  else
                  {
                     _loc12_ = "";
                  }
                  (_loc7_ = new Character(_loc12_)).x = param2;
                  _loc7_.y = param3;
                  Character(_loc7_).facing = CharThumb(param1).facing;
                  Character(_loc7_).fromTray = true;
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BackgroundThumb)
            {
               if(!(_loc13_ = param1 as BackgroundThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc13_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc13_.loadImageData();
               }
               else
               {
                  (_loc7_ = new anifire.core.Background()).x = AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_Y;
                  _loc7_.width = AnimeConstants.SCREEN_WIDTH;
                  _loc7_.height = AnimeConstants.SCREEN_HEIGHT;
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BubbleThumb)
            {
               (_loc7_ = new BubbleAsset()).x = param2;
               _loc7_.y = param3;
               BubbleAsset(_loc7_).fromTray = true;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               if((_loc14_ = param1 as BubbleThumb).isShowMsg)
               {
                  anifire.core.Console.getConsole().showBubbleMsgWindow(_loc14_,BubbleAsset(_loc7_));
               }
            }
            else if(param1 is SoundThumb)
            {
               _loc15_ = param1 as SoundThumb;
               _loc16_ = this;
               if(_loc15_.isLoading == false)
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
                  anifire.core.Console.getConsole().checkSoundSpaceAtScene(_loc16_,_loc15_);
               }
               else
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is PropThumb)
            {
               _loc17_ = param1 as PropThumb;
               _loc18_ = anifire.core.Console.getConsole().currDragSource.dataForFormat("thumb");
               if(!_loc17_.isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc17_.loadState();
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               }
               else
               {
                  if(!(_loc18_ is PropThumb && PropThumb(_loc18_).placeable == false))
                  {
                     if((_loc19_ = this.getAssetId(param1)) != null)
                     {
                        _loc20_ = _loc19_.assetId;
                     }
                     else
                     {
                        _loc20_ = "";
                     }
                     if(param1 is VideoPropThumb)
                     {
                        _loc7_ = new VideoProp();
                     }
                     else
                     {
                        _loc7_ = new Prop(_loc20_);
                     }
                     _loc7_.x = param2;
                     _loc7_.y = param3;
                     Prop(_loc7_).facing = PropThumb(param1).facing;
                     Prop(_loc7_).fromTray = true;
                  }
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is EffectThumb)
            {
               if((_loc21_ = param1 as EffectThumb).getType() == EffectThumb.TYPE_ANIME)
               {
                  _loc7_ = new AnimeEffectAsset();
               }
               else if(_loc21_.getType() == EffectThumb.TYPE_PROGRAM)
               {
                  if((_loc22_ = this.getAssetId(param1)) != null)
                  {
                     _loc23_ = _loc22_.assetId;
                  }
                  else
                  {
                     _loc23_ = "";
                  }
                  _loc7_ = new ProgramEffectAsset(_loc23_);
               }
               _loc7_.x = param2;
               _loc7_.y = param3;
               _loc7_.resize = _loc21_.getResize() == "true" ? true : false;
               if(!_loc7_.resize)
               {
                  _loc7_.x = AnimeConstants.SCREEN_WIDTH / 2 + AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_HEIGHT / 2 + AnimeConstants.SCREEN_Y;
               }
               EffectAsset(_loc7_).fromTray = true;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,anifire.core.Console.getConsole().mainStage.stage);
            }
            if(_loc7_ != null)
            {
               _loc7_.scene = this;
               _loc7_.thumb = param1;
               if(param4 != "")
               {
                  _loc7_.defaultColorSetId = param4;
                  _loc7_.defaultColorSet = param1.getColorSetById(param4);
               }
               trace("addAsset:" + _loc7_.defaultColorSetId);
               this.addAsset(_loc7_);
            }
         }
      }
      
      public function set background(param1:anifire.core.Background) : void
      {
         this._background = param1;
      }
      
      public function get control() : Control
      {
         return this._control;
      }
      
      private function generateNewID(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(param1 == null)
         {
            _loc4_ = true;
         }
         else if(param1 == "")
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            _loc3_ = _existIDs.length;
            do
            {
               _loc2_ = "SCENE" + _loc3_;
               _loc3_++;
            }
            while(_existIDs.containsKey(_loc2_));
            
         }
         else
         {
            _loc2_ = param1;
         }
         _existIDs.push(_loc2_,_loc2_);
         return _loc2_;
      }
      
      public function get canvas() : Canvas
      {
         return this._canvas;
      }
      
      public function removeAllAssets() : void
      {
         this.removeSound();
         this.removeBackground();
         this.removeAllCharacters();
         this.removeAllBubbles();
         this.removeAllProps();
         this.removeAllEffects();
      }
      
      private function removeEffect(param1:EffectAsset) : void
      {
         var _loc2_:int = this._effects.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._effects.remove(_loc2_,1);
            this.refreshEffectTray(anifire.core.Console.getConsole().effectTray);
         }
         if(param1.getExactType() == EffectThumb.TYPE_ZOOM)
         {
            this._sizingAsset = null;
         }
      }
      
      private function enableClickingAgain(param1:TimerEvent) : void
      {
         anifire.core.Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_UP,this.doStageMouseUp);
         this.enableClickTimer.stop();
         this.enableClickTimer.reset();
      }
      
      internal function clone() : AnimeScene
      {
         var _loc2_:anifire.core.Asset = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:anifire.core.Background = null;
         var _loc7_:Character = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Prop = null;
         var _loc11_:EffectAsset = null;
         var _loc12_:BubbleAsset = null;
         var _loc1_:AnimeScene = new AnimeScene();
         _loc1_.userLockedTime = this.userLockedTime;
         _loc1_.console = this.console;
         var _loc3_:int = 0;
         while(_loc3_ < this._cloneableAssetsInfo.length)
         {
            _loc4_ = String(this._cloneableAssetsInfo.getValueByIndex(_loc3_));
            _loc5_ = String(this._cloneableAssetsInfo.getKey(_loc3_));
            if(_loc4_ == "background")
            {
               if(this._background != null)
               {
                  (_loc6_ = Background(this._background.clone(true))).capScreenLock = this.console.capScreenLock;
                  _loc6_.scene = _loc1_;
                  _loc1_.addAsset(_loc6_);
               }
            }
            else if(_loc4_ == "char")
            {
               (_loc7_ = Character(this._characters.getValueByKey(_loc5_))).capScreenLock = this.console.capScreenLock;
               if(_loc7_ != null)
               {
                  _loc2_ = _loc7_.clone(true);
                  trace("assetimageb:" + _loc2_.bundle.bytesTotal);
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  _loc8_ = CharThumb(Character(_loc2_).thumb).motions;
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_.length)
                  {
                     if(_loc8_[_loc9_].id == Character(_loc2_).action.id)
                     {
                        Character(_loc2_).action = CharThumb(Character(_loc2_).thumb).defaultAction;
                        if(_loc7_.motionShadow != null)
                        {
                           _loc2_.x = _loc7_.motionShadow.x;
                           _loc2_.y = _loc7_.motionShadow.y;
                        }
                        break;
                     }
                     _loc9_++;
                  }
                  trace("assetimage:" + _loc2_.bundle.bytesTotal);
                  Character(_loc2_).updateColor();
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc4_ == "prop")
            {
               (_loc10_ = Prop(this._props.getValueByKey(_loc5_))).capScreenLock = this.console.capScreenLock;
               if(_loc10_ != null)
               {
                  if(_loc10_ is VideoProp)
                  {
                     _loc2_ = VideoProp(_loc10_).clone(true);
                  }
                  else
                  {
                     _loc2_ = _loc10_.clone(true);
                  }
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc4_ == "effect")
            {
               if((_loc11_ = EffectAsset(this._effects.getValueByKey(_loc5_))) != null)
               {
                  _loc2_ = _loc11_.clone(true);
                  _loc2_.scene = _loc1_;
                  if(_loc11_.motionShadow != null)
                  {
                     EffectAsset(_loc2_).fromTray = true;
                     _loc2_.x = _loc11_.motionShadow.x;
                     _loc2_.y = _loc11_.motionShadow.y;
                     EffectAsset(_loc2_).effect.width = _loc11_.motionShadow.effect.width;
                     EffectAsset(_loc2_).effect.height = _loc11_.motionShadow.effect.height;
                  }
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc4_ == "bubble")
            {
               (_loc12_ = BubbleAsset(this._bubbles.getValueByKey(_loc5_))).capScreenLock = this.console.capScreenLock;
               if(_loc12_ != null)
               {
                  _loc2_ = _loc12_.clone(true);
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  _loc1_.addAsset(_loc2_);
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get bubbles() : UtilHashArray
      {
         return this._bubbles;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(param1 && !this.console.capScreenLock)
         {
            this.console.doUpdateTimelineByScene(this);
            this.doUpdateTimelineLength();
         }
      }
      
      public function get characters() : UtilHashArray
      {
         return this._characters;
      }
      
      private function doStageMouseUp(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:anifire.core.Thumb = null;
         var _loc5_:String = null;
         var _loc6_:ICommand = null;
         var _loc2_:Boolean = anifire.core.Console.getConsole().getImporter() == null || anifire.core.Console.getConsole().getImporter() != null && anifire.core.Console.getConsole().swfloader.content.visible == false || anifire.core.Console.getConsole().getViewStackWindow() == null;
         trace("doStageMouseUp:" + _loc2_);
         if(_loc2_)
         {
            anifire.core.Console.getConsole().stageViewStage.stage.removeEventListener(MouseEvent.MOUSE_UP,this.doStageMouseUp);
            this.enableClickTimer.start();
            _loc3_ = DisplayObject(param1.target);
            if(this.console.currentScene != null)
            {
               if(!DragManager.isDragging)
               {
                  if(_loc3_ != this.console.currentScene.canvas)
                  {
                     while(_loc3_.parent != null)
                     {
                        _loc3_ = _loc3_.parent;
                        if(_loc3_ == this.console.stageViewStage || _loc3_ is Menu)
                        {
                           break;
                        }
                        if(_loc3_ == param1.currentTarget)
                        {
                           break;
                        }
                     }
                  }
               }
               else
               {
                  trace("[!_isDragEnter ,Console.getConsole().currentScene==this,Console.getConsole().currDragSource != null]:" + [!this._isDragEnter,anifire.core.Console.getConsole().currentScene == this,anifire.core.Console.getConsole().currDragSource != null]);
                  if(!this._isDragEnter && anifire.core.Console.getConsole().currentScene == this && anifire.core.Console.getConsole().currDragSource != null)
                  {
                     _loc4_ = Thumb(anifire.core.Console.getConsole().currDragSource.dataForFormat("thumb"));
                     _loc5_ = "";
                     if(anifire.core.Console.getConsole().currDragSource.hasFormat("colorSetId"))
                     {
                        _loc5_ = String(anifire.core.Console.getConsole().currDragSource.dataForFormat("colorSetId"));
                     }
                     if(!(_loc4_ is SoundThumb))
                     {
                        (_loc6_ = new AddAssetCommand()).execute();
                     }
                     this.createAsset(_loc4_,param1.stageX,param1.stageY - 50,_loc5_);
                     anifire.core.Console.getConsole().currDragSource = null;
                  }
                  this._isDragEnter = false;
               }
            }
            if(anifire.core.Console.getConsole().currentScene == this)
            {
               this.showEffects();
            }
         }
      }
      
      public function deSerialize(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         var totalLength:Number;
         var loadMgr:UtilLoadMgr;
         var exdata:Object;
         var i:int;
         var actionDelay:Number;
         var index:int;
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var nodeXML:XML = null;
         var item:XML = null;
         var k:int = 0;
         var j:int = 0;
         var sceneNode:XML = param1;
         var removeAll:Boolean = param2;
         var doLoadBytes:Boolean = param3;
         var unloadAfterFinish:Boolean = param4;
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"index");
         if(removeAll)
         {
            this._cloneableAssetsInfo = new UtilHashArray();
            this.deleteAllAssets();
            this.clearCanvas();
            this.removeAllAssets();
         }
         else
         {
            k = 1;
            j = int(sortedIndex.length);
            while(j > 0)
            {
               nodeXML = sceneNode.children().(@index == String(sortedIndex[j - 1]))[0];
               nodeXML.@newIndex = k;
               k++;
               j--;
            }
            nodeXML = sceneNode.children().(@index == "0")[0];
            nodeXML.@newIndex = 0;
            sortedIndex = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"newIndex");
         }
         loadMgr = new UtilLoadMgr();
         exdata = new Object();
         exdata["unloadAfterFinish"] = unloadAfterFinish;
         loadMgr.setExtraData(exdata);
         loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onDeserializeAndAddComplete);
         trace("###################################### Deserialize:" + this.id);
         i = 0;
         while(i < sortedIndex.length)
         {
            if(removeAll)
            {
               nodeXML = sceneNode.children().(@index == String(sortedIndex[i]))[0];
            }
            else
            {
               nodeXML = sceneNode.children().(@newIndex == String(sortedIndex[i]))[0];
            }
            this.deserializeAsset(nodeXML,removeAll,true,doLoadBytes,loadMgr);
            i++;
         }
         loadMgr.commit();
         actionDelay = UtilUnitConvert.frameToPixel(Number(sceneNode.@adelay));
         totalLength = actionDelay;
         if(sceneNode.@lock == "Y")
         {
            this.userLockedTime = totalLength;
         }
         else
         {
            this.userLockedTime = -1;
         }
         index = anifire.core.Console.getConsole().getSceneIndex(this);
         trace("###################################### Deserialize Done:" + this.id);
         trace("deserialize:" + totalLength + "," + this.userLockedTime);
         if(sceneNode.toString() != "")
         {
            this.doUpdateTimelineLength(totalLength);
         }
      }
      
      public function hideEffects(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:EffectAsset = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._effects.length)
         {
            if(this._effects.getValueByIndex(_loc4_) is AnimeEffectAsset)
            {
               _loc3_ = AnimeEffectAsset(this._effects.getValueByIndex(_loc4_));
               if(param2)
               {
                  _loc3_.status = EffectAsset.STATUS_HIDE;
               }
               _loc3_.hideEffect();
            }
            if(param1)
            {
               if(this._effects.getValueByIndex(_loc4_) is ProgramEffectAsset)
               {
                  _loc3_ = ProgramEffectAsset(this._effects.getValueByIndex(_loc4_));
                  if(param2)
                  {
                     _loc3_.status = EffectAsset.STATUS_HIDE;
                  }
                  _loc3_.hideEffect();
               }
            }
            _loc4_++;
         }
      }
      
      public function get props() : UtilHashArray
      {
         return this._props;
      }
      
      public function unloadAllAssets() : void
      {
         var _loc5_:Character = null;
         var _loc6_:BubbleAsset = null;
         var _loc7_:Prop = null;
         var _loc8_:EffectAsset = null;
         if(this._background != null)
         {
            this._background.unloadAssetImage();
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._characters.length)
         {
            (_loc5_ = Character(this._characters.getValueByIndex(_loc1_))).unloadAssetImage();
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._bubbles.length)
         {
            _loc6_ = BubbleAsset(this._bubbles.getValueByIndex(_loc2_));
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._props.length)
         {
            (_loc7_ = Prop(this._props.getValueByIndex(_loc3_))).unloadAssetImage();
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._effects.length)
         {
            if((_loc8_ = this._effects.getValueByIndex(_loc4_) as EffectAsset) is AnimeEffectAsset)
            {
               AnimeEffectAsset(_loc8_).unloadAssetImage();
            }
            _loc4_++;
         }
      }
      
      public function getCharacterInPrevSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = anifire.core.Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      public function muteSound(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc2_)).muteSound(param1);
            _loc2_++;
         }
         if(this.background != null)
         {
            this.background.muteSound(param1);
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc3_)).muteSound(param1);
            if(Character(this._characters.getValueByIndex(_loc3_)).prop != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).prop.muteSound(param1);
            }
            if(Character(this._characters.getValueByIndex(_loc3_)).head != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).head.muteSound(param1);
            }
            if(Character(this._characters.getValueByIndex(_loc3_)).wear != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).wear.muteSound(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc4_)).muteSound(param1);
            _loc4_++;
         }
      }
      
      private function isVideoTypeExist() : Boolean
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function doDragOver(param1:DragEvent) : void
      {
      }
      
      protected function doResizeComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.selectedAssets.length)
         {
            if(!(this.selectedAssets[_loc2_] is BubbleAsset))
            {
               if(this.selectedAssets[_loc2_] is EffectAsset)
               {
                  EffectAsset(this.selectedAssets[_loc2_]).checkEffectAssetSize();
               }
               else
               {
                  Asset(this.selectedAssets[_loc2_]).scaleX = Asset(this.selectedAssets[_loc2_]).displayElement.scaleX;
                  Asset(this.selectedAssets[_loc2_]).scaleY = Asset(this.selectedAssets[_loc2_]).displayElement.scaleY;
               }
            }
            _loc2_++;
         }
         this.updateSelectedStuffs();
      }
      
      protected function doResizeStart(param1:ControlEvent) : void
      {
         var _loc2_:ICommand = new ResizeAssetsCommand();
         _loc2_.execute();
         var _loc3_:Object = this.control.getStuff(0,0);
         var _loc4_:int = 0;
         while(_loc4_ < this.selectedAssets.length)
         {
            Asset(this.selectedAssets[_loc4_]).updateOriginalAssetScale();
            Asset(this.selectedAssets[_loc4_]).updateOriginalAssetPosition();
            if(this.selectedAssets[_loc4_] is BubbleAsset)
            {
               BubbleAsset(this.selectedAssets[_loc4_]).updateOriginalBubbleSize();
               BubbleAsset(this.selectedAssets[_loc4_]).updateOriginalTailPosition();
            }
            else if(this.selectedAssets[_loc4_] is EffectAsset)
            {
               EffectAsset(this.selectedAssets[_loc4_]).updateOriginalEffectSize();
            }
            _loc4_++;
         }
         this._prevCenter = new Point(this.control.x + this.control.assetWidth / 2,this.control.y + this.control.assetHeight / 2);
      }
      
      public function getBubbleAssetById(param1:String) : BubbleAsset
      {
         return BubbleAsset(this._bubbles.getValueByKey(param1));
      }
      
      private function addCharacter(param1:String, param2:Character) : void
      {
         this._characters.push(param1,param2);
      }
      
      public function set userLockedTime(param1:Number) : void
      {
         this._userLockedTime = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getPropInNextSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = anifire.core.Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      private function addEffect(param1:String, param2:EffectAsset) : void
      {
         this._effects.push(param1,param2);
         anifire.core.Console.getConsole().effectTray.addEffect(param1,param2.getType(),param2.thumb.name);
         this.refreshEffectTray(anifire.core.Console.getConsole().effectTray);
      }
      
      private function addBubble(param1:String, param2:BubbleAsset) : void
      {
         this._bubbles.push(param1,param2);
         anifire.core.Console.getConsole().effectTray.addBubble(param1,param2.thumb.name);
         this.refreshEffectTray(anifire.core.Console.getConsole().effectTray);
      }
      
      public function get dashline() : UIComponent
      {
         return this._dashline;
      }
      
      public function meltAllAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.melt();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
      }
      
      private function activeAllSelectedAssets() : void
      {
         var _loc1_:anifire.core.Asset = null;
         for each(_loc1_ in this.selectedAssets)
         {
            UtilPlain.playFamily(_loc1_.movieObject);
         }
      }
      
      private function onCallLaterHandler() : void
      {
         trace("animescene calllater called:" + this);
         anifire.core.Console.getConsole().setCurrentScene(anifire.core.Console.getConsole().getSceneIndex(this));
         this.changed = true;
      }
      
      private function doEffectTrayOut(param1:EffectTrayEvent) : void
      {
      }
      
      public function sendBackward(param1:anifire.core.Asset = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         var _loc2_:int = this._characters.length + this._bubbles.length + this._props.length;
         if(param1 != null && _loc2_ > 1 && !(param1 is anifire.core.Background || param1 is EffectAsset))
         {
            _loc3_ = int(this.canvas.getChildIndex(param1.bundle));
            _loc5_ = _loc4_ = 1;
            _loc6_ = 0;
            _loc6_ = 0;
            while(_loc6_ < this.canvas.numChildren)
            {
               _loc7_ = this.canvas.getChildAt(_loc6_);
               _loc8_ = int(this.canvas.getChildIndex(_loc7_));
               if(Boolean(param1.bundle.hitTestObject(_loc7_)) && this.canvas.getChildIndex(param1.bundle) > _loc8_ && _loc7_ is Image)
               {
                  if(_loc8_ > _loc5_)
                  {
                     _loc5_ = _loc8_;
                     _loc9_ = this.getCloneableAssetIndex(Image(_loc7_).id);
                  }
               }
               _loc6_++;
            }
            if(_loc3_ > _loc5_)
            {
               this.canvas.removeChild(param1.bundle);
               this.canvas.addChildAt(param1.bundle,_loc5_);
               _loc10_ = this.getCloeableAssetInfo(param1.id);
               this.removeCloneableAssetInfo(param1.id);
               this.addCloneableAssetInfo(param1.id,_loc10_,_loc9_);
               return true;
            }
         }
         return false;
      }
      
      private function addProp(param1:String, param2:Prop) : void
      {
         this._props.push(param1,param2);
      }
      
      public function updateSelectedStuffs() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Control = null;
         if(this.selectedAssets.length == 0)
         {
            this.control = null;
            this.selectedAsset = null;
         }
         else if(this.selectedAssets.length == 1)
         {
            this.control = null;
            this.selectedAsset = this.selectedAssets[0];
            this.selectedAsset.showControl();
         }
         else
         {
            this.selectedAsset = null;
            this.deactiveAllSelectedAssets();
            _loc1_ = this.getRectForMultipleObjects(this.selectedAssets);
            _loc2_ = this.getControlOnSelectedAssets();
            _loc2_.setPos(_loc1_.x,_loc1_.y);
            _loc2_.setSize(_loc1_.width,_loc1_.height);
            _loc2_.setOrigin(_loc1_.width / 2,_loc1_.height / 2);
            if(_loc2_ is FixedControl)
            {
               FixedControl(_loc2_).aspectRatio = _loc1_.width / _loc1_.height;
            }
            this.control = _loc2_;
            _loc2_.addEventListener(ControlEvent.OUTLINE_DOWN,this.onControlOutlineDownHandler);
         }
      }
      
      private function indentAsset(param1:XML) : XML
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         do
         {
            _loc5_ = param1.name();
            _loc2_ = false;
            if(_loc5_ == Character.XML_NODE_NAME)
            {
               _loc4_ = 0;
               while(_loc4_ < this._characters.length)
               {
                  _loc6_ = Character(this._characters.getValueByIndex(_loc4_));
                  if(param1.children() == XML(_loc6_.serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc4_++;
               }
            }
            else if(_loc5_ == BubbleAsset.XML_NODE_NAME)
            {
               _loc7_ = 0;
               while(_loc7_ < this._bubbles.length)
               {
                  if(param1.children() == XML(BubbleAsset(this._bubbles.getValueByIndex(_loc7_)).serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc7_++;
               }
            }
            else if(_loc5_ == Prop.XML_NODE_NAME)
            {
               _loc8_ = 0;
               while(_loc8_ < this._props.length)
               {
                  _loc9_ = Prop(this._props.getValueByIndex(_loc8_));
                  if(param1.children() == XML(_loc9_.serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc8_++;
               }
            }
            if(_loc2_)
            {
               _loc3_ = String(param1.child("x")[0]).split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                  _loc4_++;
               }
               param1.child("x")[0] = _loc3_.toString();
               _loc3_ = String(param1.child("y")[0]).split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                  _loc4_++;
               }
               param1.child("y")[0] = _loc3_.toString();
            }
         }
         while(_loc2_);
         
         return param1;
      }
      
      private function removeAllAttachedProps() : void
      {
         var _loc2_:Prop = null;
         var _loc1_:int = this._props.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = Prop(this._props.getValueByIndex(_loc1_));
            if(_loc2_.attachedBg)
            {
               this.removeAsset(_loc2_);
               _loc2_.doKeyUp(null,false);
            }
            _loc1_--;
         }
      }
      
      public function deserializeAsset(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:UtilLoadMgr = null) : void
      {
         var _loc7_:anifire.core.Background = null;
         var _loc8_:Character = null;
         var _loc9_:BubbleAsset = null;
         var _loc10_:Prop = null;
         var _loc11_:EffectAsset = null;
         var _loc6_:String = String(param1.name());
         switch(_loc6_)
         {
            case anifire.core.Background.XML_NODE_NAME:
               (_loc7_ = new anifire.core.Background(param1.@id)).capScreenLock = this.console.capScreenLock;
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc7_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc7_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc7_.deSerialize(param1,this,param4);
               if(_loc7_.thumb != null)
               {
                  this.addAsset(_loc7_);
               }
               break;
            case Character.XML_NODE_NAME:
               (_loc8_ = new Character(param3 ? param1.@id : "")).capScreenLock = this.console.capScreenLock;
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc8_.deSerialize(param1,this,param4);
               if(_loc8_.thumb != null)
               {
                  this.addAsset(_loc8_);
               }
               break;
            case BubbleAsset.XML_NODE_NAME:
               (_loc9_ = new BubbleAsset(param3 ? param1.@id : "")).capScreenLock = this.console.capScreenLock;
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               _loc9_.deSerialize(param1,this);
               this.addAsset(_loc9_);
               break;
            case Prop.XML_NODE_NAME:
               if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  _loc10_ = new VideoProp();
               }
               else
               {
                  _loc10_ = new Prop();
               }
               _loc10_.capScreenLock = this.console.capScreenLock;
               if(!param3 && !(_loc10_ is VideoProp))
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null && !(_loc10_ is VideoProp))
               {
                  param5.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc10_.deSerialize(param1,null,this,param3,param4);
               if(!param2)
               {
                  _loc10_.attachedBg = true;
               }
               if(_loc10_.thumb != null)
               {
                  this.addAsset(_loc10_,_loc10_.attachedBg);
               }
               break;
            case EffectAsset.XML_NODE_NAME:
               if(EffectAsset.getEffectType(param1) == EffectMgr.TYPE_ANIME)
               {
                  _loc11_ = new AnimeEffectAsset(param3 ? param1.@id : null);
               }
               else
               {
                  _loc11_ = new ProgramEffectAsset(param3 ? param1.@id : null);
               }
               _loc11_.capScreenLock = this.console.capScreenLock;
               _loc11_.deSerialize(param1,this,true);
               this.addAsset(_loc11_);
         }
      }
      
      public function clearSelectedAssets() : void
      {
         if(this._selectedAssets != null)
         {
            this.activeAllSelectedAssets();
         }
         this._selectedAssets = new Array();
      }
      
      public function getCharacterInNextSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = anifire.core.Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function playScene() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.playBackground();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).playCharacter();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).playProp();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).playBubble();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).playEffect();
            _loc1_++;
         }
      }
      
      private function doDragEnter(param1:DragEvent) : void
      {
         var _loc3_:Canvas = null;
         this._isDragEnter = true;
         var _loc2_:Object = param1.dragSource.dataForFormat("thumb");
         if(!(_loc2_ is PropThumb && PropThumb(_loc2_).placeable == false))
         {
            _loc3_ = Canvas(param1.target);
            DragManager.acceptDragDrop(_loc3_);
         }
      }
      
      private function initialCanvas() : void
      {
         this._canvas = new Canvas();
         this._canvas.width = AnimeConstants.STAGE_WIDTH;
         this._canvas.height = AnimeConstants.STAGE_HEIGHT;
         this._canvas.scrollRect = new Rectangle(0,0,this._canvas.width,this._canvas.height);
         this._canvas.horizontalScrollPolicy = ScrollPolicy.OFF;
         this._canvas.verticalScrollPolicy = ScrollPolicy.OFF;
         if(anifire.core.Console.getConsole().studioType == anifire.core.Console.FULL_STUDIO || anifire.core.Console.getConsole().studioType == anifire.core.Console.TINY_STUDIO)
         {
            this._canvas.addEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
            this._canvas.addEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
            this._canvas.addEventListener(MouseEvent.CLICK,this.doFocusCanvas);
            this._bundle = new UIComponent();
            this._canvas.addChild(this._bundle);
            this._dashline = new UIComponent();
            this._dashline.buttonMode = true;
            this._dashline.name = "DASHLINE";
            this._canvas.addChild(this._dashline);
            anifire.core.Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_UP,this.doStageMouseUp);
            anifire.core.Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.doStageMouseDown);
         }
      }
      
      public function set console(param1:anifire.core.Console) : void
      {
         this._console = param1;
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
         this._control = param1;
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
         _loc2_.buttonDown = false;
         if(this._control != null)
         {
            this._control.addEventListener(ControlEvent.RESIZE_START,this.doResizeStart);
            this._control.addEventListener(ControlEvent.RESIZE_COMPLETE,this.doResizeComplete);
            this._control.addEventListener(ResizeEvent.RESIZE,this.doResize);
            this._bundle.addChild(this._control);
         }
      }
      
      private function onControlOutlineDownHandler(param1:ControlEvent) : void
      {
         var _loc2_:ICommand = new MoveAssetsCommand();
         _loc2_.execute();
         this._oldMousePosition = new Point(this._canvas.mouseX,this._canvas.mouseY);
         this.canvas.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         this.canvas.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         var _loc3_:int = 0;
         while(_loc3_ < this.selectedAssets.length)
         {
            Asset(this.selectedAssets[_loc3_]).updateOriginalAssetPosition();
            _loc3_++;
         }
         this.control.startDrag();
      }
      
      private function removeAllEffects() : void
      {
         this._effects.removeAll();
      }
      
      public function sendToFront(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.effects.length > 0)
         {
            _loc2_ = this.get1stEffectAssetZorder() - 2;
         }
         else
         {
            _loc2_ = this.canvas.numChildren - 1;
         }
         if(this.canvas.getChildAt(_loc2_) is ControlButtonBar)
         {
            _loc2_--;
         }
         if(this.canvas.getChildAt(_loc2_).name.indexOf("motionShadow") > -1)
         {
         }
         if(_loc2_ > 1)
         {
            if(this.canvas.contains(param1))
            {
               if(this.canvas.getChildIndex(param1) < _loc2_ - 1)
               {
                  this.canvas.removeChild(param1);
                  this.canvas.addChildAt(param1,_loc2_);
                  if(param1.name != "DASHLINE" && !(param1 is ControlButtonBar))
                  {
                     if(param1 is Image)
                     {
                        _loc3_ = this.getCloeableAssetInfo(Image(param1).id);
                        this.removeCloneableAssetInfo(Image(param1).id);
                        this.addCloneableAssetInfo(Image(param1).id,_loc3_);
                     }
                  }
               }
            }
         }
      }
      
      private function removeAllCharacters() : void
      {
         this._characters.removeAll();
      }
      
      private function addCloneableAssetInfo(param1:String, param2:String, param3:int = -1) : void
      {
         var _loc4_:UtilHashArray = null;
         if(param3 == -1)
         {
            this._cloneableAssetsInfo.push(param1,param2);
         }
         else
         {
            (_loc4_ = new UtilHashArray()).push(param1,param2);
            this._cloneableAssetsInfo.insert(param3,_loc4_);
         }
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function addAsset(param1:anifire.core.Asset, param2:Boolean = false) : void
      {
         var onAddedHandler:Function = null;
         var onAddedBGSoundHandler:Function = null;
         var j:int = 0;
         var loadMgr:UtilLoadMgr = null;
         var needToLoad:Boolean = false;
         var extraData:Object = null;
         var assetThemeId:String = null;
         var assetTheme:Theme = null;
         var bgUsedThumbs:UtilHashArray = null;
         var curThumb:anifire.core.Thumb = null;
         var k:Number = NaN;
         var i:int = 0;
         var state:State = null;
         var onAddedCharSoundHandler:Function = null;
         var randomText:String = null;
         var _fontMgr:FontManager = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedPropHandler:Function = null;
         var onAddedEffectSoundHandler:Function = null;
         var needAdd:Boolean = false;
         var programEffAsset:ProgramEffectAsset = null;
         var onAddedZoomEffectHandler:Function = null;
         var asset:anifire.core.Asset = param1;
         var forceAtBottom:Boolean = param2;
         if(asset is anifire.core.Background)
         {
            onAddedBGSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(anifire.core.Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(anifire.core.Console.getConsole().soundMute ? 0 : 1));
               }
               asset.removeEventListener("SoundAdded",onAddedBGSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedBGSoundHandler);
            if(asset.thumb.xml == null)
            {
               if(this._background != null)
               {
                  this._background.hideControl();
                  this._canvas.removeChild(this._background.bundle);
                  this.removeAsset(this._background);
               }
               this._afterComBgAsset = new Array();
               j = 0;
               while(j < this._canvas.numChildren)
               {
                  if(this._canvas.getChildAt(j).name != "DASHLINE" && !(this._canvas.getChildAt(j) is ControlButtonBar))
                  {
                     this._afterComBgAsset.push(this._canvas.getChildAt(j));
                  }
                  j++;
               }
               this._background = Background(asset);
               this.addCloneableAssetInfo(asset.id,"background");
               onAddedHandler = function(param1:Event):void
               {
                  if(Background(asset).customColor.length > 0)
                  {
                     Background(asset).updateColor();
                  }
                  else if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0)
                  {
                     Background(asset).customColor = asset.defaultColorSet.clone();
                     Background(asset).updateColor();
                  }
                  if(anifire.core.Console.getConsole().isGoWalkerOn())
                  {
                     anifire.core.Console.getConsole().dispatchGoWalkerEvent(7);
                  }
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
               this._canvas.addChildAt(this._background.bundle,this.BACKGROUND_INDEX);
            }
            else if(asset.thumb.xml != null)
            {
               loadMgr = new UtilLoadMgr();
               needToLoad = false;
               extraData = new Object();
               assetThemeId = asset.thumb.theme.id;
               assetTheme = anifire.core.Console.getConsole().getTheme(assetThemeId);
               extraData["xml"] = asset.thumb.xml;
               extraData["removeAll"] = "false";
               loadMgr.setExtraData(extraData);
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doDeserialize);
               bgUsedThumbs = new UtilHashArray();
               bgUsedThumbs = asset.thumb.theme.doOutputThumbs(asset.thumb.xml);
               k = 0;
               k = 0;
               while(k < bgUsedThumbs.length)
               {
                  curThumb = bgUsedThumbs.getValueByIndex(k);
                  if(curThumb is BackgroundThumb && !BackgroundThumb(curThumb).isThumbReady())
                  {
                     needToLoad = true;
                     loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     curThumb.loadImageData();
                  }
                  else if(curThumb is PropThumb && !PropThumb(curThumb).isThumbReady())
                  {
                     if(PropThumb(curThumb).states.length > 0)
                     {
                        i = 0;
                        while(i < PropThumb(curThumb).states.length)
                        {
                           state = PropThumb(curThumb).states[i];
                           if(state.imageData == null)
                           {
                              needToLoad = true;
                              loadMgr.addEventDispatcher(state,CoreEvent.LOAD_STATE_COMPLETE);
                              PropThumb(curThumb).loadState(state);
                           }
                           i++;
                        }
                     }
                     else
                     {
                        needToLoad = true;
                        loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                        curThumb.loadImageData();
                     }
                  }
                  k++;
               }
               if(needToLoad)
               {
                  loadMgr.commit();
               }
               if(!needToLoad)
               {
                  this.deSerialize(asset.thumb.xml,false,true,false);
               }
            }
         }
         else if(asset is Character)
         {
            onAddedCharSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(anifire.core.Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(anifire.core.Console.getConsole().soundMute ? 0 : 1));
               }
               asset.removeEventListener("SoundAdded",onAddedCharSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedCharSoundHandler);
            this.addCharacter(asset.id,Character(asset));
            this.addCloneableAssetInfo(asset.id,"char");
            if(this.effects.length > 0)
            {
               this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
            }
            else
            {
               this._canvas.addChild(asset.bundle);
            }
            asset.bundle.buttonMode = true;
            if(Character(asset).fromTray)
            {
               onAddedHandler = function(param1:Event):void
               {
                  trace("on added: thumb.isCC:" + asset.thumb.isCC);
                  if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0 && !asset.thumb.isCC)
                  {
                     Character(asset).customColor = asset.defaultColorSet.clone();
                     trace("on Added, update color");
                     Character(asset).updateColor();
                  }
                  doUpdateTimelineLength();
                  if(anifire.core.Console.getConsole().isGoWalkerOn())
                  {
                     anifire.core.Console.getConsole().dispatchGoWalkerEvent(2);
                  }
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            else
            {
               onAddedHandler = function(param1:Event):void
               {
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            asset.displayElement.addEventListener(DragEvent.DRAG_COMPLETE,asset.doDragComplete);
            asset.displayElement.addEventListener(DragEvent.DRAG_ENTER,asset.doDragEnter);
            asset.displayElement.addEventListener(DragEvent.DRAG_DROP,asset.doDragDrop);
            asset.displayElement.addEventListener(DragEvent.DRAG_EXIT,asset.doDragExit);
            asset.displayElement.addEventListener(MouseEvent.ROLL_OVER,asset.doMouseOver);
            asset.displayElement.addEventListener(MouseEvent.ROLL_OUT,asset.doMouseOut);
            asset.displayElement.addEventListener(MouseEvent.MOUSE_UP,asset.doMouseUp);
         }
         else if(asset is BubbleAsset)
         {
            if((asset as BubbleAsset).fromTray)
            {
               randomText = PresetMsg.getInstance().getRandomMsg(anifire.core.Console.getConsole().thumbTray.getCurrentThemeId());
               if(randomText != "" && randomText != null)
               {
                  (asset as BubbleAsset).text = randomText;
                  (asset as BubbleAsset).bubble.backupText = randomText;
               }
               _fontMgr = FontManager.getFontManager();
               if(!_fontMgr.isFontLoaded((asset as BubbleAsset).bubble.textFont) && (asset as BubbleAsset).bubble.textEmbed == true)
               {
                  _fontMgr.loadFont((asset as BubbleAsset).bubble.textFont,(asset as BubbleAsset).bubble.addedToStageHandler);
               }
               if(anifire.core.Console.getConsole().stageScale > 1)
               {
                  (asset as BubbleAsset).setSize(1 / anifire.core.Console.getConsole().stageScale);
               }
               if(anifire.core.Console.getConsole().isGoWalkerOn())
               {
                  anifire.core.Console.getConsole().dispatchGoWalkerEvent(13);
               }
            }
            this.addBubble(asset.id,BubbleAsset(asset));
            if(BubbleThumb(BubbleAsset(asset).thumb).type == BubbleMgr.BLANK)
            {
               this.addCloneableAssetInfo(asset.id,"bubble");
            }
            if(this.effects.length > 0)
            {
               this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
            }
            else
            {
               this._canvas.addChild(asset.bundle);
            }
            asset.bundle.buttonMode = true;
            BubbleAsset(asset).bubble.buttonMode = true;
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
         }
         else if(asset is Prop)
         {
            if(asset is VideoProp && this.isVideoTypeExist())
            {
               this.deleteAllVideos();
            }
            onAddedPropSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(anifire.core.Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(anifire.core.Console.getConsole().soundMute ? 0 : 1));
               }
               asset.removeEventListener("SoundAdded",onAddedPropSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedPropSoundHandler);
            if(Prop(asset).attachedBg && forceAtBottom)
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop",0);
               this._canvas.addChildAt(asset.bundle,this.BACKGROUND_INDEX + 1);
            }
            else
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop");
               if(this.effects.length > 0)
               {
                  this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
               }
               else
               {
                  this._canvas.addChild(asset.bundle);
               }
            }
            asset.bundle.buttonMode = true;
            if(Prop(asset).fromTray)
            {
               onAddedPropHandler = function(param1:Event):void
               {
                  if(anifire.core.Console.getConsole().soundMute == false)
                  {
                     asset.playMusic();
                  }
                  if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0)
                  {
                     Prop(asset).customColor = asset.defaultColorSet.clone();
                     Prop(asset).updateColor();
                  }
                  doUpdateTimelineLength();
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedPropHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedPropHandler);
            }
            else
            {
               onAddedHandler = function(param1:Event):void
               {
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
         }
         else if(asset is EffectAsset)
         {
            onAddedEffectSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(anifire.core.Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(anifire.core.Console.getConsole().soundMute ? 0 : 1));
               }
               asset.removeEventListener("SoundAdded",onAddedEffectSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedEffectSoundHandler);
            if(asset is AnimeEffectAsset)
            {
               needAdd = true;
            }
            else
            {
               programEffAsset = asset as ProgramEffectAsset;
               if(this.isProgramEffectTypeExist(programEffAsset.getExactType()))
               {
                  needAdd = false;
               }
               else
               {
                  needAdd = true;
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  programEffAsset.needControl = true;
                  if(!needAdd)
                  {
                     if(anifire.core.Console.getConsole().stageScale == 1)
                     {
                        EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
                        needAdd = true;
                     }
                  }
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_FADING)
               {
                  if(!needAdd)
                  {
                     EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_FADING)).deleteAsset(false);
                     needAdd = true;
                  }
               }
            }
            if(needAdd)
            {
               this.addEffect(asset.id,EffectAsset(asset));
               this._canvas.addChild(asset.bundle);
               if(EffectAsset(asset).effect is ZoomEffect)
               {
                  asset.bundle.buttonMode = true;
                  EffectAsset(asset).effect.buttonMode = true;
                  this._sizingAsset = asset;
                  if(EffectAsset(asset).fromTray)
                  {
                     onAddedZoomEffectHandler = function(param1:Event):void
                     {
                        EffectAsset(asset).refreshMotionShadow();
                        param1.currentTarget.removeEventListener(Event.ADDED,onAddedZoomEffectHandler);
                     };
                     asset.bundle.addEventListener(Event.ADDED,onAddedZoomEffectHandler);
                  }
               }
               this.selectedAsset = asset;
            }
            this.addCloneableAssetInfo(asset.id,"effect");
         }
         if(anifire.core.Console.getConsole().studioType == anifire.core.Console.FULL_STUDIO || anifire.core.Console.getConsole().studioType == anifire.core.Console.TINY_STUDIO)
         {
            if(asset != null)
            {
               asset.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,asset.initializeDrag);
               asset.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,asset.doDrag);
               asset.displayElement.addEventListener(MouseEvent.MOUSE_UP,asset.doMouseUp);
               asset.displayElement.addEventListener(MouseEvent.ROLL_OVER,asset.doMouseOver);
               asset.displayElement.addEventListener(MouseEvent.ROLL_OUT,asset.doMouseOut);
            }
            this.console.stageViewStage.stage.addEventListener(KeyboardEvent.KEY_UP,asset.doKeyUp);
            this.console.stageViewStage.stage.addEventListener(KeyboardEvent.KEY_DOWN,asset.doKeyDown);
         }
         if(anifire.core.Console.getConsole().isGoWalkerOn())
         {
         }
      }
      
      private function isEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function removeBackground() : void
      {
         if(this.background != null)
         {
            UtilPlain.stopFamily(this.background.bundle);
            this.background.stopMusic(true);
         }
         this._background = null;
      }
      
      public function removeAsset(param1:anifire.core.Asset) : void
      {
         if(param1 is anifire.core.Background)
         {
            this.removeAllAttachedProps();
            this.removeBackground();
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Character)
         {
            this.removeCharacter(Character(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is BubbleAsset)
         {
            this.removeBubble(BubbleAsset(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Prop)
         {
            this.removeProp(Prop(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is EffectAsset)
         {
            this.removeEffect(EffectAsset(param1));
         }
      }
      
      public function getRectForMultipleObjects(param1:Array) : Rectangle
      {
         var _loc7_:Rectangle = null;
         var _loc2_:Number = 9999999;
         var _loc3_:Number = 9999999;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc2_ = (_loc7_ = Asset(param1[_loc6_]).bundle.getBounds(this._canvas)).x < _loc2_ ? _loc7_.x : _loc2_;
            _loc3_ = _loc7_.y < _loc3_ ? _loc7_.y : _loc3_;
            _loc4_ = _loc7_.x + _loc7_.width > _loc4_ ? _loc7_.x + _loc7_.width : _loc4_;
            _loc5_ = _loc7_.y + _loc7_.height > _loc5_ ? _loc7_.y + _loc7_.height : _loc5_;
            _loc6_++;
         }
         return new Rectangle(_loc2_,_loc3_,_loc4_ - _loc2_,_loc5_ - _loc3_);
      }
      
      public function stopScene() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.stopBackground();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).stopCharacter();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).stopProp();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).stopBubble();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).stopEffect();
            _loc1_++;
         }
      }
      
      private function getFacingFromThemeXMLByThumbId(param1:XML, param2:String) : String
      {
         var charXML:XML = null;
         var themeXML:XML = param1;
         var thumbId:String = param2;
         try
         {
            charXML = themeXML.char.(@id == thumbId)[0];
            if(charXML != null)
            {
               return charXML.@facing;
            }
         }
         catch(e:Error)
         {
            trace(e.message);
         }
         return AnimeConstants.FACING_UNKNOW;
      }
      
      public function bringForward(param1:anifire.core.Asset = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         var _loc2_:int = this._characters.length + this._bubbles.length + this._props.length;
         if(param1 != null && _loc2_ > 1 && !(param1 is anifire.core.Background || param1 is EffectAsset))
         {
            _loc3_ = int(this.canvas.getChildIndex(param1.bundle));
            if(this.effects.length > 0)
            {
               _loc4_ = this.get1stEffectAssetZorder() - 1;
            }
            else
            {
               _loc4_ = this.canvas.numChildren - 1;
            }
            if(this.canvas.getChildIndex(this._dashline) > 2)
            {
               _loc4_ = Math.min(_loc4_,this.canvas.getChildIndex(this._dashline) - 1);
            }
            _loc5_ = _loc4_;
            _loc6_ = 0;
            _loc9_ = -1;
            _loc6_ = 0;
            while(_loc6_ < this.canvas.numChildren)
            {
               _loc7_ = this.canvas.getChildAt(_loc6_);
               _loc8_ = int(this.canvas.getChildIndex(_loc7_));
               if(Boolean(param1.bundle.hitTestObject(_loc7_)) && this.canvas.getChildIndex(param1.bundle) < _loc8_ && _loc7_ is Image)
               {
                  if(_loc8_ < _loc5_)
                  {
                     _loc5_ = _loc8_;
                     _loc9_ = this.getCloneableAssetIndex(Image(_loc7_).id);
                  }
               }
               _loc6_++;
            }
            if(_loc3_ < _loc5_)
            {
               this.canvas.removeChild(param1.bundle);
               this.canvas.addChildAt(param1.bundle,_loc5_);
               _loc10_ = this.getCloeableAssetInfo(param1.id);
               this.removeCloneableAssetInfo(param1.id);
               this.addCloneableAssetInfo(param1.id,_loc10_,_loc9_);
               return true;
            }
         }
         return false;
      }
      
      public function doUpdateTimelineLength(param1:Number = -1, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = anifire.core.Console.getConsole().getSceneIndex(this);
         if(_loc3_ != -1)
         {
            _loc4_ = 0;
            if(param1 == -1)
            {
               _loc4_ += this.getSceneActionLength();
            }
            else
            {
               _loc4_ = param1;
            }
            if(this.userLockedTime < 0)
            {
               if(_loc4_ < AnimeConstants.SCENE_LENGTH_DEFAULT)
               {
                  _loc4_ = AnimeConstants.SCENE_LENGTH_DEFAULT;
               }
               anifire.core.Console.getConsole().timeline.updateSceneLength(_loc4_,_loc3_,param2);
            }
            else
            {
               anifire.core.Console.getConsole().timeline.updateSceneLength(this.userLockedTime,_loc3_,param2);
            }
         }
      }
      
      public function getLength(param1:int = -1, param2:Boolean = true) : Number
      {
         if(param1 < 0)
         {
            param1 = anifire.core.Console.getConsole().getSceneIndex(this);
         }
         return UtilUnitConvert.pixelToFrame(this._console.timeline.getSceneInfoByIndex(param1).actionPixel,param2);
      }
      
      private function doFocusCanvas(param1:MouseEvent) : void
      {
      }
      
      internal function getSceneActionLength() : Number
      {
         var _loc1_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Character = null;
         var _loc2_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            _loc5_ = UtilString.countWord(BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).text);
            _loc6_ = Math.floor(_loc5_ / 5) * this._DEFAULT_BUBBLE_DALEY;
            _loc2_ += _loc6_;
            _loc1_++;
         }
         var _loc3_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            if((_loc7_ = this._characters.getValueByIndex(_loc1_) as Character).getActionDefaultTotalFrame() > _loc3_)
            {
               _loc3_ = _loc7_.getActionDefaultTotalFrame();
            }
            _loc1_++;
         }
         var _loc4_:Number = UtilUnitConvert.frameToPixel(_loc3_);
         if(_loc2_ < _loc4_)
         {
            _loc2_ = _loc4_;
         }
         return _loc2_;
      }
      
      public function serialize(param1:int = -1, param2:Boolean = true) : String
      {
         var _loc8_:EffectAsset = null;
         var _loc10_:Character = null;
         var _loc11_:UtilHashArray = null;
         var _loc12_:int = 0;
         var _loc13_:Prop = null;
         var _loc14_:UtilHashArray = null;
         var _loc15_:int = 0;
         if(param1 < 0)
         {
            param1 = anifire.core.Console.getConsole().getSceneIndex(this);
         }
         var _loc3_:Number = this.getLength(param1,false);
         var _loc4_:* = "<scene id=\"" + this._id + "\" adelay=\"" + Util.roundNum(_loc3_) + "\" lock=\"" + (this.userLockedTime >= 0 ? "Y" : "N") + "\" index=\"" + param1 + "\" " + ">";
         if(this._background != null)
         {
            _loc4_ += this._background.serialize();
            if(param2)
            {
               this.console.putData(this._background.thumb.theme.id + ".bg." + this._background.thumb.id,ByteArray(this._background.thumb.imageData));
            }
         }
         var _loc5_:int = 0;
         while(_loc5_ < this._characters.length)
         {
            _loc10_ = Character(this._characters.getValueByIndex(_loc5_));
            _loc4_ += _loc10_.serialize();
            if(param2)
            {
               _loc11_ = _loc10_.getDataAndKey();
               _loc12_ = 0;
               while(_loc12_ < _loc11_.length)
               {
                  this.console.putData(_loc11_.getKey(_loc12_),_loc11_.getValueByIndex(_loc12_));
                  _loc12_++;
               }
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < this._bubbles.length)
         {
            _loc4_ += BubbleAsset(this._bubbles.getValueByIndex(_loc6_)).serialize();
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this._props.length)
         {
            _loc13_ = Prop(this._props.getValueByIndex(_loc7_));
            _loc4_ += _loc13_.serialize();
            if(param2)
            {
               if(PropThumb(_loc13_.thumb).getStateNum() == 0)
               {
                  this.console.putData(_loc13_.thumb.theme.id + ".prop." + _loc13_.thumb.id,ByteArray(_loc13_.thumb.imageData));
               }
               else
               {
                  _loc14_ = _loc13_.getDataAndKey();
                  _loc15_ = 0;
                  while(_loc15_ < _loc14_.length)
                  {
                     this.console.putData(_loc14_.getKey(_loc15_),_loc14_.getValueByIndex(_loc15_));
                     _loc15_++;
                  }
               }
            }
            _loc7_++;
         }
         var _loc9_:int = 0;
         while(_loc9_ < this._effects.length)
         {
            _loc8_ = this._effects.getValueByIndex(_loc9_) as EffectAsset;
            _loc4_ += _loc8_.serialize();
            if(param2)
            {
               this.console.putData(_loc8_.thumb.theme.id + ".effect." + _loc8_.thumb.id,_loc8_.thumb.imageData as ByteArray);
            }
            _loc9_++;
         }
         return _loc4_ + "</scene>";
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function onDeserializeAndAddComplete(param1:LoadMgrEvent) : void
      {
         var _loc2_:Object = UtilLoadMgr(param1.currentTarget).getExtraData();
         var _loc3_:Boolean = Boolean(_loc2_["unloadAfterFinish"]);
         this.bringUpAsset();
         this.stopScene();
         setTimeout(this.dispatchDeserializeComplete,100,_loc3_);
         trace("###################################### Deserialize Complete:" + this.id);
      }
      
      public function getCharacterById(param1:String) : Character
      {
         return Character(this._characters.getValueByKey(param1));
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._bubbles.length)
         {
            if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text.indexOf(param1) > -1)
            {
               if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText == "")
               {
                  BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText = BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text;
               }
               BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text = UtilString.replace(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text,param1,param2);
               this.canvas.callLater(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight);
               this.canvas.callLater(this.canvas.callLater,[BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight]);
            }
            _loc3_++;
         }
      }
      
      public function refreshEffectTray(param1:EffectTray) : void
      {
         var _loc3_:EffectAsset = null;
         var _loc4_:BubbleAsset = null;
         param1.removeEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
         var _loc2_:int = 0;
         param1.reset();
         _loc2_ = 0;
         while(_loc2_ < this.bubbles.length)
         {
            _loc4_ = this.bubbles.getValueByIndex(_loc2_) as BubbleAsset;
            param1.addBubble(_loc4_.id,_loc4_.thumb.name);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.effects.length)
         {
            _loc3_ = this.effects.getValueByIndex(_loc2_) as EffectAsset;
            param1.addEffect(_loc3_.id,_loc3_.getType(),_loc3_.thumb.name);
            _loc2_++;
         }
         param1.addEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.addEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.addEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
      }
      
      public function removeSound() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).stopMusic(true);
            _loc1_++;
         }
         if(this.background != null)
         {
            this.background.stopMusic(true);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc2_)).stopMusic(true);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc3_)).stopMusic(true);
            _loc3_++;
         }
      }
      
      private function removeCloneableAssetInfo(param1:String) : void
      {
         var _loc2_:int = this._cloneableAssetsInfo.getIndex(param1);
         if(_loc2_ != -1)
         {
            this._cloneableAssetsInfo.remove(_loc2_,1);
         }
      }
      
      private function removeAllProps() : void
      {
         this._props.removeAll();
      }
      
      private function doDeserialize(param1:LoadMgrEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc6_:Object;
         _loc3_ = (_loc6_ = _loc2_.getExtraData())["xml"];
         _loc5_ = (_loc4_ = String(_loc6_["removeAll"])) == "false" ? false : true;
         this.deSerialize(_loc3_,_loc5_,true,false);
      }
      
      private function deleteAllVideos() : void
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               _loc1_.deleteAsset();
               this.removeAsset(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function get1stEffectAssetZorder() : int
      {
         var _loc1_:EffectAsset = null;
         var _loc4_:int = 0;
         var _loc2_:int = int.MAX_VALUE;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc1_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if((_loc4_ = int(this._canvas.getChildIndex(_loc1_.bundle))) < _loc2_)
            {
               _loc2_ = _loc4_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function deactiveAllSelectedAssets() : void
      {
         var _loc1_:anifire.core.Asset = null;
         for each(_loc1_ in this.selectedAssets)
         {
            UtilPlain.gotoAndStopFamilyAt1(_loc1_.movieObject);
         }
      }
      
      private function isProgramEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function freezeAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.freeze();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
      }
      
      public function addSelectedAsset(param1:anifire.core.Asset) : void
      {
         if(this._selectedAssets == null)
         {
            this._selectedAssets = new Array();
         }
         if(param1 != null)
         {
            if(this.selectedAssets.indexOf(param1) == -1)
            {
               this._selectedAssets.push(param1);
            }
            else
            {
               this._selectedAssets.splice(this.selectedAssets.indexOf(param1),1);
            }
         }
         this.updateSelectedStuffs();
         trace("_selectedAssets.length:" + this._selectedAssets.length);
      }
      
      public function set selectedAssets(param1:Array) : void
      {
         this._selectedAssets = param1;
      }
      
      private function doDragDrop(param1:DragEvent) : void
      {
         var _loc6_:ICommand = null;
         this._isDragEnter = true;
         var _loc2_:anifire.core.Thumb = Thumb(param1.dragSource.dataForFormat("thumb"));
         var _loc3_:String = "";
         if(param1.dragSource.hasFormat("colorSetId"))
         {
            _loc3_ = String(param1.dragSource.dataForFormat("colorSetId"));
         }
         if(!(_loc2_ is SoundThumb))
         {
            (_loc6_ = new AddAssetCommand()).execute();
         }
         var _loc4_:Canvas = Canvas(param1.target);
         var _loc5_:DisplayObject;
         if((_loc5_ = DisplayObject(param1.dragInitiator)).parent.parent != this._canvas)
         {
            this.createAsset(_loc2_,param1.localX,param1.localY,_loc3_);
         }
      }
      
      public function get selectedAssets() : Array
      {
         return this._selectedAssets.concat();
      }
      
      private function onLoadAllAssetsComplete(param1:Event) : void
      {
         this.console.capScreenLock = false;
         this.eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this));
         trace("load all assets complete:");
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Date = _loc2_.getExtraData() as Date;
         var _loc4_:Date = new Date();
         trace("time used:" + (_loc4_.time - _loc3_.time));
      }
   }
}

class AssetLocation
{
    
   
   private var _assetId:String;
   
   private var _sceneId:String;
   
   public function AssetLocation(param1:String, param2:String)
   {
      super();
      this._assetId = param1;
      this._sceneId = param2;
   }
   
   public function get sceneId() : String
   {
      return this._sceneId;
   }
   
   public function get assetId() : String
   {
      return this._assetId;
   }
}
