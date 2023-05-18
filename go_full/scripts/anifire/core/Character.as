package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.AddPropCommand;
   import anifire.command.CcLookAtCameraCommand;
   import anifire.command.ChangeActionCommand;
   import anifire.command.FlipAssetCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveCharacterCommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.command.RemovePropCommand;
   import anifire.command.ResizeCharacterCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.components.containers.GoAlert;
   import anifire.components.studio.ControlButtonBar;
   import anifire.components.studio.MaskPoint;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.control.ControlMgr;
   import anifire.control.myBezierSpline;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import anifire.util.UtilXmlInfo;
   import caurina.transitions.Tweener;
   import com.senocular.display.duplicateDisplayObject;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Character extends Asset
   {
      
      private static const MENU_ITEM_TYPE_MOVEMENT_TAG:String = "movement";
      
      private static const MENU_ITEM_TYPE_COLOR_TAG:String = "color";
      
      private static const MENU_ITEM_POINT_ADD:String = "motionmenu_addpoint";
      
      private static const MENU_ITEM_ACTION:String = "actionmenu_action";
      
      private static const MENU_ITEM_POINT_REMOVE:String = "motionmenu_removepoint";
      
      private static const MENU_ITEM_FACIAL:String = "actionmenu_facial";
      
      private static const MENU_ITEM_PROP_REMOVE:String = "actionmenu_restoreprop";
      
      private static const MENU_ITEM_HEAD:String = "actionmenu_head";
      
      private static const MENU_ITEM_PROP:String = "actionmenu_handheld";
      
      private static const ADD_CONTROL_POINT:String = "addControlPoint";
      
      private static const MENU_ITEM_TYPE_STATE_TAG:String = "state";
      
      private static const MENU_ITEM_TYPE_HEAD_TAG:String = "head";
      
      private static var _logger:ILogger = Log.getLogger("core.Character");
      
      private static const MENU_ITEM_TYPE_PROP_TAG:String = "prop";
      
      private static const BLINK:String = "blink";
      
      private static const MENU_ITEM_TYPE_TAG:String = "itemType";
      
      private static const MENU_ITEM_SLIDE:String = "actionmenu_slide";
      
      private static const MENU_ITEM_MOVEMENT_REMOVE:String = "actionmenu_removeMove";
      
      private static const MENU_ITEM_TYPE_ACTION_TAG:String = "action";
      
      private static const MENU_ITEM_WEAR:String = "actionmenu_headgear";
      
      private static const REMOVE_MOTION:String = "removeMotion";
      
      private static const MENU_ITEM_TYPE_WEAR_TAG:String = "wear";
      
      private static const MENU_ITEM_DEFAULT:String = "actionmenu_default";
      
      public static const XML_NODE_NAME:String = "char";
      
      private static const SLIDE_BACKWARD:String = "slideBackward";
      
      private static const MENU_ITEM_TYPE_FACIAL_TAG:String = "facial";
      
      private static const REMOVE_CONTROL_POINT:String = "removeControlPoint";
      
      private static const SLIDE_FORWARD:String = "slideForward";
      
      private static const MENU_ITEM_MOVEMENT:String = "actionmenu_movement";
      
      private static const MENU_ITEM_HEAD_REMOVE:String = "actionmenu_restorehead";
      
      private static const MENU_ITEM_WEAR_REMOVE:String = "actionmenu_restoremask";
       
      
      private var _buttonBar:ControlButtonBar;
      
      private var _readyToDrag:Boolean = false;
      
      private var _motionDirection:String = "";
      
      private var _prevCharPosX:Number = 0;
      
      private var _prevCharPosY:Number = 0;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _prop:anifire.core.Prop;
      
      private var _loadCount:Number = 0;
      
      private var _actionMenu:ScrollableArrowMenu;
      
      private var _wear:anifire.core.Prop;
      
      private var _checkedMotionItem:Object;
      
      private var _lookAtCameraSupported:Boolean = false;
      
      private var _loadTotal:Number = 0;
      
      private var _colorTrasformOld:ColorTransform;
      
      private var _currControlPointName:String;
      
      private var _controlPoints:Array;
      
      private var _insertingPoint:Number;
      
      private var _head:anifire.core.Prop;
      
      private var _originalRotation:Number = 0;
      
      private var _motionId:String;
      
      private var _motion:anifire.core.Motion;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _spline:myBezierSpline;
      
      private var _checkedActionItem:Object;
      
      private var _facing:String = "left";
      
      private var _orgLoaderScaleX:Number = 1;
      
      private var _orgLoaderScaleY:Number = 1;
      
      private var _isBlink:Boolean = false;
      
      private var _actionMenuXML:XML;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _mouseClickPoint:Point;
      
      private var initCameraHandler:Function = null;
      
      private var _motionShadowChar:anifire.core.Character;
      
      private var _actionId:String;
      
      private var _action:anifire.core.Action;
      
      private var _fromTray:Boolean = false;
      
      private var _isSlide:Boolean = false;
      
      private var _facial:anifire.core.Facial;
      
      private var _byMenu:Boolean = false;
      
      private var _motionMenuXML:XML;
      
      private var _graphic:Sprite;
      
      private var _shadowParent:anifire.core.Character;
      
      private var _motionMenu:ScrollableArrowMenu;
      
      private var _backupSceneXML:XML;
      
      private var _curve:UIComponent;
      
      private var _knots:Array;
      
      private var _hasFacialExpression:Boolean = false;
      
      public function Character(param1:String = "")
      {
         this._spline = new myBezierSpline();
         this._graphic = new Sprite();
         this._knots = new Array();
         this._controlPoints = new Array();
         this._mouseClickPoint = new Point();
         this._curve = new UIComponent();
         super();
         _logger.debug("Character initialized");
         if(param1 == "")
         {
            param1 = "AVATOR" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
         this._colorTrasformOld = this.displayElement.transform.colorTransform;
         this._insertingPoint = -1;
         this._spline.container = this._graphic;
         this._spline.thickness = 4;
         this._spline.containAsset = Asset(this);
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var themeTree:ThemeTree;
         var charNode:XML;
         var themeTrees:UtilHashArray = null;
         var curBehaviourXML:XML = null;
         var charBehaviourXML:XML = null;
         var entry:ZipEntry = null;
         var themeID:String = null;
         var charID:String = null;
         var themeXml:XML = null;
         var defaultActionId:String = null;
         var fileName:String = null;
         var shouldExtractEntryToThemeTree:Boolean = false;
         var byteArray:ByteArray = null;
         var newThemeTree:ThemeTree = null;
         var decryptEngine:UtilCrypto = null;
         var assetXML:XML = param1;
         var zipFile:ZipFile = param2;
         var existingThemeTrees:UtilHashArray = param3;
         themeTrees = new UtilHashArray();
         curBehaviourXML = assetXML.child(anifire.core.Action.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         curBehaviourXML = assetXML.child(anifire.core.Motion.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         themeID = Behavior.getThemeIdFromBehaviourXML(charBehaviourXML);
         charID = Behavior.getCharIdFromBehaviourXML(charBehaviourXML);
         themeTree = existingThemeTrees.getValueByKey(themeID) as ThemeTree;
         if(themeTree != null)
         {
            themeXml = themeTree.getThemeXml();
         }
         if(themeXml == null)
         {
            themeXml = new XML(zipFile.getInput(zipFile.getEntry(themeID + ".xml")).toString());
            if(themeTree != null)
            {
               themeTree.addThemeXml(themeXml);
            }
         }
         charNode = themeXml["char"].(@id == charID)[0];
         defaultActionId = charNode.attribute("default");
         fileName = UtilXmlInfo.generateBehaviourFileName(themeID,charID,charID);
         entry = zipFile.getEntry(fileName);
         shouldExtractEntryToThemeTree = true;
         if(entry == null)
         {
            shouldExtractEntryToThemeTree = false;
         }
         else if(existingThemeTrees.containsKey(themeID) && (existingThemeTrees.getValueByKey(themeID) as ThemeTree).isCharBehaviourExist(charID,defaultActionId,true))
         {
            shouldExtractEntryToThemeTree = false;
         }
         if(shouldExtractEntryToThemeTree)
         {
            byteArray = zipFile.getInput(entry);
            if(themeID != "ugc")
            {
               decryptEngine = new UtilCrypto();
               decryptEngine.decrypt(byteArray);
            }
            newThemeTree = new ThemeTree(themeID);
            newThemeTree.addCharBehaviour(charID,defaultActionId,byteArray,true);
            ThemeTree.mergeThemeTreeToThemeTrees(themeTrees,newThemeTree);
         }
         if(assetXML.child(anifire.core.Prop.XML_NODE_NAME)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,anifire.core.Prop.getThemeTrees(assetXML.child(anifire.core.Prop.XML_NODE_NAME)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(anifire.core.Prop.XML_NODE_NAME_HEAD)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,anifire.core.Prop.getThemeTrees(assetXML.child(anifire.core.Prop.XML_NODE_NAME_HEAD)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(anifire.core.Prop.XML_NODE_NAME_WEAR)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,anifire.core.Prop.getThemeTrees(assetXML.child(anifire.core.Prop.XML_NODE_NAME_WEAR)[0] as XML,zipFile,existingThemeTrees));
         }
         return themeTrees;
      }
      
      internal function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      private function getMotionConstants(param1:String, param2:String, param3:int) : String
      {
         if(param1 == param2)
         {
            if(param3 == 1)
            {
               return AnimeConstants.MOTION_FORWARD;
            }
            return AnimeConstants.MOTION_BACKWARD;
         }
         if(param3 == -1)
         {
            return AnimeConstants.MOTION_FORWARD;
         }
         return AnimeConstants.MOTION_BACKWARD;
      }
      
      internal function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      override public function doChangeColor(param1:String, param2:uint = 4294967295) : Number
      {
         var _loc3_:Number = super.doChangeColor(param1,param2);
         if(_loc3_ > 0)
         {
            if(this.motionShadow != null)
            {
               this.motionShadow.doChangeColor(param1,param2);
            }
         }
         return _loc3_;
      }
      
      internal function updateWearSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.wear != null)
         {
            try
            {
               this.wear.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
               this.wear.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function updateFacing(param1:anifire.core.Character = null) : void
      {
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(this.getFacingDirection(param1) == AnimeConstants.FACING_LEFT)
            {
               this.facing = AnimeConstants.FACING_LEFT;
            }
            else if(this.getFacingDirection(param1) == AnimeConstants.FACING_RIGHT)
            {
               this.facing = AnimeConstants.FACING_RIGHT;
            }
            if(this.motionShadow != null)
            {
               this.motionShadow.updateFacing(this);
            }
         }
      }
      
      private function setMotionProperties(param1:XML) : void
      {
         if(this.shouldHasMotion())
         {
            this.fillMaskPoint();
            this.setMotionFacing(param1.action.@motionface);
            this.addMotionShadow(this._xs,this._ys,this._scaleXs,this._scaleYs,this._facings,this._rotations);
            this.hideMotionShadow();
         }
      }
      
      private function addProptoAll(param1:MouseEvent) : void
      {
         var _loc2_:Array = Button(param1.target).data[0] as Array;
         var _loc3_:Object = Button(param1.target).data[1] as Object;
         var _loc4_:State = Button(param1.target).data[2] as State;
         var _loc5_:String = Button(param1.target).data[3] as String;
         this.addProptoAllByPara(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      override public function doMouseOut(param1:MouseEvent) : void
      {
         if(Console.getConsole().currDragObject is anifire.core.Prop && param1.buttonDown)
         {
            if(this.displayElement != null)
            {
               this.displayElement.filters = [];
            }
         }
         else
         {
            super.doMouseOut(param1);
         }
      }
      
      private function rotateCharacter(param1:Event) : void
      {
         var _loc2_:Control = Control(param1.target);
         var _loc3_:Number = getSceneCanvas().mouseX - this.bundle.x;
         var _loc4_:Number = getSceneCanvas().mouseY - this.bundle.y;
         var _loc5_:Number = Math.atan2(_loc4_,_loc3_);
         var _loc7_:Rectangle;
         var _loc6_:Sprite;
         var _loc8_:Number = (_loc7_ = (_loc6_ = _loc2_.currController).getRect(this.bundle)).x + _loc7_.width / 2;
         var _loc9_:Number = _loc7_.y + _loc7_.height / 2;
         var _loc10_:Number = Math.atan2(_loc9_,_loc8_);
         this.rotation = (_loc5_ - _loc10_) * 180 / Math.PI;
      }
      
      private function removeProp() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         if(this.prop == null)
         {
            return;
         }
         UtilPlain.stopFamily(this.prop.bundle);
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getProp(_loc1_);
            if(_loc3_ != null)
            {
               UtilPlain.removeAllSon(_loc3_);
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getProp(_loc2_);
            if(_loc3_ != null)
            {
               UtilPlain.removeAllSon(_loc3_);
            }
         }
         this.prop.removeDisplayElementListener();
         this.prop = null;
      }
      
      private function refreshControl(... rest) : void
      {
         if(control != null && controlVisible)
         {
            this.control = null;
            this.showControl();
         }
      }
      
      protected function getOrigin() : Point
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc1_:Point = new Point();
         var _loc2_:DisplayObject = DisplayObject(this.imageObject);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.localToGlobal(new Point());
            _loc4_ = scene.canvas.globalToLocal(_loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
         }
         return _loc1_;
      }
      
      override internal function doDragExit(param1:DragEvent) : void
      {
         if(!this.displayElement.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            if(this.displayElement != null)
            {
               this.displayElement.filters = [];
            }
         }
      }
      
      public function get actionId() : String
      {
         return this._actionId;
      }
      
      internal function showMotionShadow() : void
      {
         var _loc1_:anifire.core.Character = this.getMotionShadow();
         if(_loc1_ != null)
         {
            this.hideControlPoint();
            this.showControlPoint();
            _loc1_.bundle.visible = true;
            this.scene.sendToFront(_loc1_.bundle);
            this.drawMotionLine();
            this.updateFacing();
         }
      }
      
      private function removeWear() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         trace("remove wear:" + this.wear);
         if(this.wear == null)
         {
            return;
         }
         UtilPlain.stopFamily(this.wear.bundle);
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc1_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         this.wear.removeDisplayElementListener();
         this.wear = null;
      }
      
      public function getCharMovieClip() : MovieClip
      {
         if(this.displayElement != null)
         {
            if(movieObject != null)
            {
               return Util.getCharacter(MovieClip(movieObject));
            }
         }
         return null;
      }
      
      public function get action() : anifire.core.Action
      {
         return this._action;
      }
      
      private function doChangeAction(param1:MenuEvent) : void
      {
         var _loc9_:anifire.core.Action = null;
         var _loc10_:UtilLoadMgr = null;
         var _loc11_:Array = null;
         this._byMenu = true;
         this.hideButtonBar();
         var _loc2_:ICommand = new ChangeActionCommand();
         _loc2_.execute();
         var _loc3_:String = String(param1.item.@label);
         var _loc4_:String = String(param1.item.@itemType);
         var _loc5_:String = String(param1.item.@actionId);
         var _loc6_:CharThumb;
         var _loc7_:Array = (_loc6_ = CharThumb(this.thumb)).actions;
         param1.item.@toggled = "true";
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            if(_loc5_ == _loc9_.id && this.imageData != null && this.imageData != _loc9_.imageData)
            {
               if(this._checkedActionItem != null)
               {
                  this._checkedActionItem.@toggled = "false";
               }
               if(_loc9_.imageData != null)
               {
                  this.updateAction(_loc9_);
               }
               else
               {
                  _loc10_ = new UtilLoadMgr();
                  (_loc11_ = new Array()).push(_loc9_);
                  _loc10_.setExtraData(_loc11_);
                  _loc10_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc10_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateActionAgain);
                  _loc10_.commit();
                  _loc6_.loadAction(_loc9_);
               }
               this._checkedActionItem = param1.item;
               this.control = null;
               this.scene.selectedAsset = null;
               break;
            }
            _loc8_++;
         }
      }
      
      private function loadAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:UIComponent = null;
         var _loc5_:MovieClip = null;
         var _loc6_:anifire.core.Character = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:PropThumb = null;
         var _loc13_:State = null;
         var _loc14_:UtilLoadMgr = null;
         var _loc15_:Array = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadAssetImageComplete);
         if(this.thumb.isCC)
         {
            this._lookAtCameraSupported = (param1.target as CustomCharacterMaker).lookAtCameraSupported;
         }
         if(this.thumb.isCC)
         {
            _loc2_ = null;
            _loc3_ = this.imageObject;
            _loc4_ = UIComponent(_loc3_.parent);
         }
         else
         {
            _loc2_ = param1.target.loader;
            _loc3_ = _loc2_.content;
            _loc4_ = UIComponent(_loc2_.parent);
         }
         if(_loc4_ != null && _loc3_ != null)
         {
            if((_loc5_ = UtilPlain.getCharacterFlip(MovieClip(_loc3_))) != null)
            {
               _loc5_.visible = false;
            }
            if(this._fromTray)
            {
               this.bundle.width = _loc3_.width;
               this.bundle.height = _loc3_.height;
               this.width = _loc4_.width;
               this.height = _loc4_.height;
               this.scaleX = 1;
               this.scaleY = 1;
               if(Console.getConsole().stageScale > 1)
               {
                  this.scaleX = displayElement.scaleX = 1 / Console.getConsole().stageScale;
                  this.scaleY = displayElement.scaleY = 1 / Console.getConsole().stageScale;
               }
            }
            else
            {
               displayElement.width = this.width;
               displayElement.height = this.height;
               displayElement.scaleX = this.scaleX;
               displayElement.scaleY = this.scaleY;
            }
            if(this.prop != null)
            {
               this.addPropClipToPropContainer(this.prop.displayElement,this.displayElement);
            }
            if(this.head != null)
            {
               this.addHeadClipToHeadContainer(this.head.displayElement,this.displayElement);
            }
            if(this.wear != null)
            {
               this.addWearClipToHeadContainer(this.wear.displayElement,this.displayElement);
            }
            this.refreshProp();
            this.scene.doUpdateTimelineLength(-1,true);
            if(!this.isLoadded)
            {
               if(!capScreenLock)
               {
                  this.changed = true;
               }
            }
            this.isLoadded = false;
            if(this.facing != CharThumb(this.thumb).facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
            {
               UtilPlain.flipObj(imageObject);
            }
            if((_loc6_ = this.scene.getCharacterInPrevSceneById(this.id)) != null && this._fromTray)
            {
               this.action = _loc6_.action;
               this.bundle.x = _loc6_.bundle.x;
               this.bundle.y = _loc6_.bundle.y;
               this.bundle.width = _loc6_.width;
               this.bundle.height = _loc6_.height;
               this.facing = _loc6_.facing;
               this.motionDirection = _loc6_.motionDirection;
               this.width = _loc6_.width;
               this.height = _loc6_.height;
               this.scaleX = _loc6_.scaleX;
               this.scaleY = _loc6_.scaleY;
               this.rotation = _loc6_.rotation;
               displayElement.width = this.width;
               displayElement.height = this.height;
               displayElement.scaleX = this.scaleX;
               displayElement.scaleY = this.scaleY;
               _loc7_ = CharThumb(_loc6_.thumb).motions;
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  if(_loc7_[_loc8_].id == this.action.id)
                  {
                     this.action = CharThumb(this.thumb).defaultAction;
                     break;
                  }
                  _loc8_++;
               }
               if(_loc6_.motionShadow != null && !this.isMotionShadow())
               {
                  this.bundle.x = _loc6_.motionShadow.bundle.x;
                  this.bundle.y = _loc6_.motionShadow.bundle.y;
                  this.bundle.width = _loc6_.motionShadow.bundle.width;
                  this.bundle.height = _loc6_.motionShadow.bundle.height;
                  this.facing = _loc6_.motionShadow.facing;
                  this.width = _loc6_.motionShadow.width;
                  this.height = _loc6_.motionShadow.height;
                  this.scaleX = _loc6_.motionShadow.scaleX;
                  this.scaleY = _loc6_.motionShadow.scaleY;
                  this.rotation = _loc6_.motionShadow.rotation;
                  displayElement.width = this.width;
                  displayElement.height = this.height;
                  displayElement.scaleX = this.scaleX;
                  displayElement.scaleY = this.scaleY;
               }
            }
            if(this.action.propXML != null && this._byMenu)
            {
               _loc9_ = this.thumb.theme.id + "." + this.action.propXML.@id;
               _loc10_ = UtilXmlInfo.getThumbIdFromFileName(_loc9_);
               _loc11_ = _loc9_.split(".").length != 4 ? _loc10_ : UtilXmlInfo.getCharIdFromFileName(_loc9_);
               _loc12_ = this.thumb.theme.getPropThumbById(_loc11_);
               if(_loc10_ != _loc11_)
               {
                  _loc13_ = _loc12_.getStateById(_loc10_);
               }
               if(_loc13_ != null)
               {
                  if(_loc12_.isStateReady(_loc13_))
                  {
                     this.addPropByThumb(_loc12_,_loc13_);
                  }
                  else
                  {
                     _loc14_ = new UtilLoadMgr();
                     (_loc15_ = new Array()).push(_loc2_);
                     _loc15_.push(_loc12_);
                     _loc15_.push(_loc13_);
                     _loc14_.setExtraData(_loc15_);
                     _loc14_.addEventDispatcher(_loc12_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     _loc14_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
                     _loc14_.commit();
                     this.bundle.callLater(_loc12_.loadState,[_loc13_]);
                  }
               }
               else if(_loc12_.isThumbReady())
               {
                  this.addPropByThumb(_loc12_,_loc13_);
               }
               else
               {
                  _loc14_ = new UtilLoadMgr();
                  (_loc15_ = new Array()).push(_loc2_);
                  _loc15_.push(_loc12_);
                  _loc14_.setExtraData(_loc15_);
                  _loc14_.addEventDispatcher(_loc12_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc14_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
                  _loc14_.commit();
                  this.bundle.callLater(_loc12_.loadImageData);
               }
               this._byMenu = false;
            }
            this._fromTray = false;
            if(!this.isMotionShadow())
            {
               UtilPlain.playFamily(DisplayObject(_loc3_));
            }
            else
            {
               UtilPlain.stopFamily(DisplayObject(_loc3_));
            }
         }
         if(_loc3_ != null)
         {
         }
         if(!this.thumb.isCC)
         {
            updateColor();
         }
         this.refreshControl();
         this.displayElement.visible = true;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      private function exchangeProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:anifire.core.Prop = null;
         if(this.imageObject != null)
         {
            _loc1_ = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
            if(_loc1_ != null)
            {
               if(this.prop != null)
               {
                  _loc2_ = Prop(this.prop.clone());
                  this.addPropDataAndClip(_loc2_);
               }
               if(this.head != null)
               {
                  _loc2_ = Prop(this.head.clone());
                  this.addHeadDataAndClip(_loc2_);
               }
               if(this.wear != null)
               {
                  _loc2_ = Prop(this.wear.clone());
                  this.addWearDataAndClip(_loc2_);
                  _loc2_.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               }
            }
         }
      }
      
      private function updateActionAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:anifire.core.Action = _loc3_[0] as anifire.core.Action;
         this.updateAction(_loc4_);
      }
      
      private function doMotionMenuClick(param1:MenuEvent) : void
      {
         this.doChangeMotion(param1);
      }
      
      private function initButtonBar() : ControlButtonBar
      {
         var buttonBar:ControlButtonBar = null;
         buttonBar = new ControlButtonBar();
         if(isColorable() && !this.thumb.isCC)
         {
            buttonBar.callLater(buttonBar.init,[1,2,3,4,-1,-2,0,-8,-3]);
         }
         else if(ServerConstants.isLookAtCameraEnabled() && this._lookAtCameraSupported)
         {
            buttonBar.callLater(function():void
            {
               buttonBar._btnCCLookAtCamera.selected = lookAtCamera;
            });
            buttonBar.callLater(buttonBar.init,[1,2,3,4,-1,-2,-3,-8,0]);
         }
         else
         {
            buttonBar.callLater(buttonBar.init,[0,1,2,3,-1,-2,-3,-8,-4]);
         }
         return buttonBar;
      }
      
      public function playCharacter() : void
      {
         var _loc1_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = movieObject;
            if(_loc1_ != null)
            {
               UtilPlain.playFamily(_loc1_);
               if(this.soundChannel != null)
               {
                  this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
               }
            }
         }
      }
      
      public function get isBlink() : Boolean
      {
         return this._isBlink;
      }
      
      private function isRegardAsMoved(param1:Point, param2:Point) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         if(param2.subtract(param1).length > AnimeConstants.ASSET_MOVE_TOLERANCE)
         {
            return true;
         }
         return false;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null ? 0 : 1;
      }
      
      private function getFacingConstants(param1:String, param2:int) : String
      {
         if(param1 == AnimeConstants.FACING_LEFT)
         {
            return param2 == 1 ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
         }
         return param2 == 1 ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
      }
      
      public function get motionDirection() : String
      {
         return this._motionDirection;
      }
      
      public function toggleLookAtCamera() : void
      {
         var _loc1_:Boolean = this.lookAtCamera;
         this.lookAtCamera = !this.lookAtCamera;
         var _loc2_:ICommand = new CcLookAtCameraCommand(id,_loc1_);
         _loc2_.execute();
      }
      
      public function set action(param1:anifire.core.Action) : void
      {
         trace("set action");
         if(this._action != param1)
         {
            this.dropDefaultActionProp();
            this._action = param1;
            this.actionId = param1.id;
            this.imageData = param1.imageData;
         }
      }
      
      private function doStartMovement(param1:MenuEvent) : void
      {
         this.doChangeAction(param1);
         if(this.motionShadow == null)
         {
            this._originalX = getSceneCanvas().mouseX;
            this._originalY = getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            this.refreshMotionShadow();
            this.snapAsset(this.motionShadow);
            this.refreshMotionShadow();
         }
         this.updateFacing();
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
      
      private function addHeadClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getHead(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getHead(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc5_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 0;
               _loc5_.addChildAt(param1,0);
               this.updateHeadSize(_loc5_);
            }
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getTail(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getTail(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.numChildren)
               {
                  if(_loc5_.getChildAt(_loc6_).name == AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc5_.getChildAt(_loc6_).alpha = 0;
                  }
                  _loc6_++;
               }
            }
         }
      }
      
      public function get motionShadow() : anifire.core.Character
      {
         return this._motionShadowChar;
      }
      
      private function updateAction(param1:anifire.core.Action) : void
      {
         this.action = param1;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.action = param1;
         }
      }
      
      internal function addPropDataAndClip(param1:anifire.core.Prop) : void
      {
         if(this.prop != null)
         {
            this.prop.stopMusic(true);
            this.removeProp();
         }
         this.prop = param1;
         this.addPropClipToPropContainer(this.prop.displayElement,this.displayElement);
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._scaleXs.length,this._scaleYs.length,this._rotations.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      private function updateTimelineMotion() : void
      {
         scene.doUpdateTimelineLength();
      }
      
      override protected function doResizeStart(param1:ControlEvent) : void
      {
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetScaleX = displayElement.scaleX;
         _originalAssetScaleY = displayElement.scaleY;
         this._prevDisplayElementPosX = displayElement.x;
         this._prevDisplayElementPosY = displayElement.y;
      }
      
      private function addWearClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getHead(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getHead(_loc4_);
            }
            if(_loc5_ != null)
            {
               param1.name = AnimeConstants.MOVIECLIP_THE_WEAR;
               _loc5_.addChild(param1);
               this.updateWearSize(_loc5_);
               this.refreshProp();
            }
         }
      }
      
      override public function flipIt() : void
      {
         var _loc1_:ICommand = null;
         var _loc2_:String = this.facing;
         this.facing = this.facing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
         if(this.motionShadow != null)
         {
            this.motionShadow.facing = this.motionShadow.facing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
            this.motionDirection = this.motionDirection == AnimeConstants.MOTION_BACKWARD ? AnimeConstants.MOTION_FORWARD : AnimeConstants.MOTION_BACKWARD;
         }
         this.refreshControl();
         _loc1_ = new FlipAssetCommand(id,_loc2_);
         _loc1_.execute();
      }
      
      private function addMotionMenuListener() : void
      {
         this._curve.addEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         this._curve.addEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      private function removeHead() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(this.head == null)
         {
            return;
         }
         UtilPlain.stopFamily(this.head.bundle);
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc1_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc1_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         this.head.removeDisplayElementListener();
         this.head = null;
         if(this.wear != null)
         {
            this.refreshProp();
         }
      }
      
      private function hideControlPoint() : void
      {
         var _loc1_:Number = Number(scene.dashline.numChildren);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(scene.dashline.getChildAt(_loc2_) is MaskPoint)
            {
               scene.dashline.getChildAt(_loc2_).visible = false;
            }
            _loc2_++;
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
      
      private function deleteMaskPoint(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
         scene.dashline.removeChild(_loc2_);
         var _loc3_:Number = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._knots.length)
         {
            if(this._knots[_loc4_] == _loc2_)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this._knots.splice(_loc3_,1);
         this.drawMotionLine(param1);
      }
      
      public function set isBlink(param1:Boolean) : void
      {
         this._isBlink = param1;
      }
      
      public function get isSlide() : Boolean
      {
         return this._isSlide;
      }
      
      private function feedActionPropAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         var _loc6_:State = _loc3_[2] as State;
         this.addPropByThumb(_loc5_,_loc6_);
      }
      
      private function dropDefaultActionProp() : void
      {
         if(this.action != null)
         {
            if(this.action.propXML != null)
            {
               this.removeProp();
            }
         }
      }
      
      private function getFacingDirection(param1:anifire.core.Character = null) : String
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:int = Console.getConsole().getSceneIndex(scene);
         var _loc3_:Number = this.x;
         if(this.motionShadow != null)
         {
            _loc4_ = this.motionShadow.x;
            if(this._knots.length != 0)
            {
               _loc4_ = this._spline.getX(0.01);
            }
            if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               return _loc3_ < _loc4_ ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
            }
            return _loc4_ < _loc3_ ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
         }
         if(this.isMotionShadow() && param1 != null)
         {
            _loc5_ = param1.x;
            if(param1.knots.length != 0)
            {
               _loc5_ = param1.spline.getX(0.99);
            }
            if(param1.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               return _loc3_ < _loc5_ ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
            }
            return _loc5_ < _loc3_ ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
         }
         return AnimeConstants.FACING_UNKNOW;
      }
      
      private function setMotionFacing(param1:int) : void
      {
         var _loc2_:String = this.facing;
         var _loc3_:int = _loc2_ == this.defaultFacing ? 1 : -1;
         if(_loc3_ != param1)
         {
            this.motionDirection = AnimeConstants.MOTION_BACKWARD;
         }
         else
         {
            this.motionDirection = AnimeConstants.MOTION_FORWARD;
         }
      }
      
      public function serializeMotion(param1:String, param2:anifire.core.Character) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = new Array();
         switch(param1)
         {
            case "x":
               _loc3_.push(Util.roundNum(this.x));
               break;
            case "y":
               _loc3_.push(Util.roundNum(this.y));
               break;
            case "xscale":
               _loc3_.push(Util.roundNum(this.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
               break;
            case "yscale":
               _loc3_.push(Util.roundNum(this.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
               break;
            case "facing":
               _loc3_.push(this.facing == this.defaultFacing ? 1 : -1);
               break;
            case "rotation":
               _loc3_.push(Util.roundNum(this.bundle.rotation));
         }
         if(this._knots.length != 0)
         {
            _loc4_ = 0;
            switch(param1)
            {
               case "x":
                  _loc4_ = 0;
                  while(_loc4_ < this._knots.length)
                  {
                     _loc3_.push(Util.roundNum(MaskPoint(this._knots[_loc4_]).x));
                     _loc4_++;
                  }
                  break;
               case "y":
                  _loc4_ = 0;
                  while(_loc4_ < this._knots.length)
                  {
                     _loc3_.push(Util.roundNum(MaskPoint(this._knots[_loc4_]).y));
                     _loc4_++;
                  }
            }
         }
         if(param2 != null)
         {
            switch(param1)
            {
               case "x":
                  _loc3_.push(Util.roundNum(param2.x));
                  break;
               case "y":
                  _loc3_.push(Util.roundNum(param2.y));
                  break;
               case "xscale":
                  _loc3_.push(Util.roundNum(param2.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "yscale":
                  _loc3_.push(Util.roundNum(param2.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "facing":
                  _loc3_.push(this.motionShadow.facing == this.defaultFacing ? 1 : -1);
                  break;
               case "rotation":
                  _loc3_.push(Util.roundNum(param2.rotation));
            }
         }
         return _loc3_;
      }
      
      override internal function doDragComplete(param1:DragEvent) : void
      {
         this._readyToDrag = false;
         var _loc2_:Image = Image(param1.dragInitiator);
         _loc2_.alpha = 1;
         if(this == this.scene.selectedAsset)
         {
            this.showControl();
         }
      }
      
      override public function set control(param1:Control) : void
      {
         super.control = param1;
         if(param1 == null)
         {
            if(movieObject != null)
            {
               UtilPlain.playFamily(movieObject);
            }
            if(this.soundChannel != null)
            {
               this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
            }
         }
      }
      
      public function isMotionShadow() : Boolean
      {
         if(this.bundle.name.substr(0,12) == "motionShadow")
         {
            return true;
         }
         return false;
      }
      
      public function set prop(param1:anifire.core.Prop) : void
      {
         this._prop = param1;
      }
      
      private function onDashlineClickHandler(param1:MouseEvent) : void
      {
         this.showMotionMenu(param1);
      }
      
      public function set motionDirection(param1:String) : void
      {
         this._motionDirection = param1;
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(param1.buttonDown && this == Console.getConsole().currentScene.selectedAsset)
            {
               if(!param1.ctrlKey)
               {
                  this.updateFacing();
               }
               this.refreshMotionShadow();
            }
         }
      }
      
      public function hideMotionShadow() : void
      {
         var _loc1_:anifire.core.Character = this.getMotionShadow();
         if(_loc1_ != null)
         {
            this.hideControlPoint();
            _loc1_.hideControl();
            _loc1_.bundle.visible = false;
         }
         this.clearMotionLine();
      }
      
      private function startRemoveMotion() : void
      {
         scene.dashline.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         var _loc1_:Number = Number(scene.dashline.numChildren);
         var _loc2_:int = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            if(scene.dashline.getChildAt(_loc2_) is MaskPoint && this._knots.indexOf(scene.dashline.getChildAt(_loc2_)) > -1)
            {
               scene.dashline.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         this._knots.splice(0,this._knots.length);
         if(this.motionShadow != null)
         {
            Tweener.addTween(this.motionShadow.bundle,{
               "x":this.x,
               "y":this.y,
               "alpha":0.25,
               "time":0.7,
               "onComplete":this.removeMotion
            });
         }
      }
      
      internal function addWearDataAndClip(param1:anifire.core.Prop) : void
      {
         if(this.wear != null)
         {
            this.wear.stopMusic(true);
            this.removeWear();
         }
         this.wear = param1;
         this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
         this.addWearClipToHeadContainer(this.wear.displayElement,this.displayElement);
      }
      
      private function getCharToBundleBounds() : Rectangle
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Rectangle = null;
         if(movieObject != null)
         {
            _loc1_ = Util.getCharacter(MovieClip(movieObject));
            return _loc1_.getBounds(this.bundle);
         }
         return new Rectangle();
      }
      
      private function addProptoOne(param1:MouseEvent) : void
      {
         var _loc2_:Object = Button(param1.target).data[0] as Object;
         var _loc3_:State = Button(param1.target).data[1] as State;
         var _loc4_:String = Button(param1.target).data[2] as String;
         this.addPropByThumb(_loc2_,_loc3_,_loc4_);
      }
      
      override public function serialize() : String
      {
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc1_:Canvas = getSceneCanvas();
         var _loc2_:int = this.getMotionFacing();
         var _loc3_:* = "<char id=\"" + this.id + "\" index=\"" + _loc1_.getChildIndex(this.bundle) + "\"" + (CharThumb(this.thumb).isCC ? " isCC=\"Y\"" : "") + ">";
         _loc3_ += "<action face=\"" + this.serializeMotion("facing",this.motionShadow) + "\" motionface=\"" + _loc2_ + "\" >" + this.action.getKey() + "</action>" + (this.prop == null ? "" : this.prop.serialize()) + (this.head == null ? "" : this.head.serialize()) + (this.wear == null ? "" : this.wear.serialize()) + "<x>" + this.serializeMotion("x",this.motionShadow) + "</x>" + "<y>" + this.serializeMotion("y",this.motionShadow) + "</y>" + "<xscale>" + this.serializeMotion("xscale",this.motionShadow) + "</xscale>" + "<yscale>" + this.serializeMotion("yscale",this.motionShadow) + "</yscale>" + "<rotation>" + this.serializeMotion("rotation",this.motionShadow) + "</rotation>";
         if(defaultColorSetId != "")
         {
            _loc3_ += "<dcsn>" + defaultColorSetId + "</dcsn>";
         }
         if(customColor.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < customColor.length)
            {
               _loc3_ += "<color r=\"" + customColor.getKey(_loc4_) + "\"";
               _loc3_ += SelectedColor(customColor.getValueByIndex(_loc4_)).orgColor == uint.MAX_VALUE ? "" : " oc=\"0x" + SelectedColor(customColor.getValueByIndex(_loc4_)).orgColor.toString(16) + "\"";
               _loc3_ += ">";
               _loc3_ += SelectedColor(customColor.getValueByIndex(_loc4_)).dstColor;
               _loc3_ += "</color>";
               _loc4_++;
            }
         }
         _loc3_ += "</char>";
         if(this.lookAtCamera)
         {
            (_loc5_ = XML(_loc3_)).@faceCamera = "true";
            _loc3_ = _loc5_.toString();
         }
         trace("xml:" + _loc3_);
         return _loc3_;
      }
      
      public function set motionId(param1:String) : void
      {
         this._motionId = param1;
      }
      
      override internal function initializeDrag(param1:MouseEvent) : void
      {
         this.onMouseDown(param1);
         this._readyToDrag = true;
         var _loc2_:Image = Image(param1.currentTarget.parent);
         _loc2_.startDrag();
      }
      
      override public function doMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:GlowFilter = null;
         if(Console.getConsole().currDragObject is anifire.core.Prop && param1.buttonDown)
         {
            _loc2_ = Console.getConsole().currDragObject.thumb;
            if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
            {
               if(this.displayElement != null)
               {
                  _loc3_ = new GlowFilter(16742400,1,6,6,5);
                  this.displayElement.filters = [_loc3_];
               }
            }
         }
         else
         {
            super.doMouseOver(param1);
         }
      }
      
      private function doCheckBeforeAddProp(param1:Object, param2:State = null, param3:String = "") : void
      {
         var _loc6_:AnimeScene = null;
         var _loc7_:int = 0;
         var _loc8_:anifire.core.Character = null;
         var _loc9_:GoAlert = null;
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < Console.getConsole().scenes.length)
         {
            _loc6_ = Console.getConsole().scenes.getValueByIndex(_loc5_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.characters.length)
            {
               if((_loc8_ = Character(_loc6_.characters.getValueByIndex(_loc7_))).thumb.id == this.thumb.id)
               {
                  if(_loc8_.customColor.isIdentical(this.customColor))
                  {
                     _loc4_.push(_loc8_);
                  }
               }
               _loc7_++;
            }
            _loc5_++;
         }
         if(Console.getConsole().studioType == Console.FULL_STUDIO || Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            if(_loc4_.length > 1)
            {
               if(this.displayElement != null)
               {
                  this.displayElement.filters = [];
               }
               (_loc9_ = GoAlert(PopUpManager.createPopUp(getSceneCanvas(),GoAlert,true)))._lblConfirm.text = "";
               _loc9_._txtDelete.text = UtilDict.toDisplay("go","goalert_foundsamechar");
               _loc9_._btnDelete.label = UtilDict.toDisplay("go","goalert_addtoall");
               _loc9_._btnDelete.data = new Array(_loc4_,param1,param2,param3);
               _loc9_._btnDelete.addEventListener(MouseEvent.CLICK,this.addProptoAll);
               _loc9_._btnCancel.label = UtilDict.toDisplay("go","goalert_thisoneonly");
               _loc9_._btnCancel.data = new Array(param1,param2,param3);
               _loc9_._btnCancel.addEventListener(MouseEvent.CLICK,this.addProptoOne);
               _loc9_.x = (_loc9_.stage.width - _loc9_.width) / 2;
               _loc9_.y = 100;
            }
            else
            {
               this.addPropByThumb(param1,param2,param3);
            }
         }
         else
         {
            this.addProptoAllByPara(_loc4_,param1,param2,param3);
         }
      }
      
      public function get knots() : Array
      {
         return this._knots;
      }
      
      public function set motionShadow(param1:anifire.core.Character) : void
      {
         this._motionShadowChar = param1;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar._shadowParent = this;
         }
      }
      
      private function refreshProp(... rest) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:DisplayObject = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(this.head)
         {
            if(_loc2_ != null && UtilPlain.getHead(_loc2_) != null)
            {
               if(_loc3_ != null && UtilPlain.isObjectFlipped(Loader(this.imageObject)))
               {
                  _loc4_ = UtilPlain.getTail(_loc3_);
                  _loc5_ = UtilPlain.getTail(UtilPlain.getHead(_loc3_));
               }
               else
               {
                  _loc4_ = UtilPlain.getTail(_loc2_);
                  _loc5_ = UtilPlain.getTail(UtilPlain.getHead(_loc2_));
               }
               if(_loc5_ != null && _loc4_ != null)
               {
                  if(_loc5_ == _loc4_)
                  {
                     _loc5_.visible = false;
                  }
                  else
                  {
                     _loc5_.visible = true;
                     _loc6_ = duplicateDisplayObject(DisplayObject(_loc5_));
                     this.addTailClipToTailContainer(_loc6_,this.displayElement);
                  }
               }
            }
         }
         if(this.wear != null)
         {
            if(_loc2_ != null)
            {
               if(_loc3_ != null && UtilPlain.isObjectFlipped(Loader(this.imageObject)))
               {
                  _loc4_ = UtilPlain.getHead(_loc3_);
               }
               else
               {
                  _loc4_ = UtilPlain.getHead(_loc2_);
               }
               if(_loc4_ != null)
               {
                  this.updateWearPosition(_loc4_);
               }
            }
         }
         updateColor();
         this.refreshControl();
      }
      
      internal function getMotionShadow() : anifire.core.Character
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      public function hasMotion() : Boolean
      {
         if(this.motionShadow == null)
         {
            return false;
         }
         return true;
      }
      
      public function refreshMotionShadow() : void
      {
         var _loc3_:AnimeScene = null;
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = this.hasMotion();
         if(_loc1_)
         {
            this.drawMotionLine();
            if(_loc2_)
            {
               this.showMotionShadow();
            }
            else
            {
               this.addMotionShadow();
               _loc3_ = this.scene;
               _loc3_.doUpdateTimelineLength();
            }
         }
         else if(!_loc1_ && _loc2_)
         {
            this.removeMotionShadow();
         }
      }
      
      public function set wear(param1:anifire.core.Prop) : void
      {
         this._wear = param1;
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
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function loadActionAndMotion(param1:CoreEvent) : void
      {
         this.motion = (this.thumb as CharThumb).defaultMotion;
         if(this._fromTray)
         {
            this.action = CharThumb(this.thumb).defaultAction;
         }
         else
         {
            this.action = CharThumb(this.thumb).getActionById(this.actionId);
         }
      }
      
      public function showMotionMenu(param1:MouseEvent = null) : void
      {
         var _loc2_:Object = param1.currentTarget;
         if(_loc2_.name != "theCurve")
         {
            this._insertingPoint = Number(_loc2_.name);
         }
         this._motionMenu = this.buildMotionMenu(_loc2_ is MaskPoint);
         if(_loc2_ is MaskPoint)
         {
            this._currControlPointName = _loc2_.name;
         }
         var _loc3_:Number = 150;
         this._mouseClickPoint = new Point(scene.dashline.mouseX,scene.dashline.mouseY);
         var _loc4_:Canvas;
         var _loc5_:Point = (_loc4_ = this.getSceneCanvas()).localToGlobal(new Point(0,0));
         if(Console.getConsole().stageScale > 1)
         {
            _loc5_ = new Point(0,68);
         }
         var _loc6_:Number = Number(_loc4_.stage.mouseX);
         var _loc7_:Number = Number(_loc4_.stage.mouseY);
         if(_loc6_ + _loc3_ > _loc5_.x + _loc4_.width)
         {
            _loc6_ = _loc5_.x + _loc4_.width - _loc3_;
         }
         if(!(_loc2_ is MaskPoint && MaskPoint(_loc2_).oPos.equals(new Point(MaskPoint(_loc2_).x,MaskPoint(_loc2_).y)) == false))
         {
            this._motionMenu.show(_loc6_,_loc7_);
         }
      }
      
      override internal function doMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:State = null;
         var _loc4_:int = 0;
         var _loc5_:UtilHashArray = null;
         this.doMouseOut(param1);
         if(Console.getConsole().currDragObject is anifire.core.Prop)
         {
            _loc2_ = Console.getConsole().currDragObject.thumb;
            if(!(PropThumb(_loc2_).headable && this.thumb.isCC))
            {
               if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
               {
                  if(PropThumb(_loc2_).getStateNum() > 0)
                  {
                     _loc3_ = Prop(Console.getConsole().currDragObject).state;
                  }
                  _loc5_ = Prop(Console.getConsole().currDragObject).customColor;
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     addCustomColor(_loc5_.getKey(_loc4_),_loc5_.getValueByIndex(_loc4_));
                     _loc4_++;
                  }
                  this.doCheckBeforeAddProp(_loc2_,_loc3_);
                  Console.getConsole().currDragObject.doKeyUp(null,false);
                  Console.getConsole().currDragObject = null;
               }
            }
         }
      }
      
      private function onDashlineOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(16737792,1,5,5,150,1,true);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         _loc2_ = new GlowFilter(0,1,3,3,250);
         _loc3_.push(_loc2_);
         this._curve.filters = _loc3_;
      }
      
      internal function clearMotionLine() : void
      {
         scene.dashline.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
         scene.dashline.visible = false;
      }
      
      public function removeMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            try
            {
               scene.dashline.graphics.clear();
               if(scene.dashline.contains(this._curve))
               {
                  scene.dashline.removeChild(this._curve);
               }
               scene.canvas.removeChild(this.motionShadow.bundle);
               this.motionShadow = null;
               this.motionDirection = "";
            }
            catch(e:Error)
            {
            }
         }
      }
      
      override protected function doResize(param1:Event) : void
      {
         this.bundle.graphics.clear();
         var _loc2_:Control = Control(param1.target);
         var _loc3_:Object = _loc2_.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         var _loc4_:int = this.facing == this.defaultFacing ? 1 : -1;
         displayElement.scaleX = _loc3_.scaleX * this._orgLoaderScaleX;
         displayElement.scaleY = _loc3_.scaleY * this._orgLoaderScaleY;
      }
      
      private function onMaskPointDown(param1:MouseEvent) : void
      {
         var _loc2_:MaskPoint = MaskPoint(param1.currentTarget);
         _loc2_.oPos = new Point(_loc2_.x,_loc2_.y);
         _loc2_.doDrag(param1);
      }
      
      private function updateWearPosition(param1:DisplayObjectContainer) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(param1,"theTop");
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            if(param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc3_ = param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(param1).y;
            }
            else if(this.head != null && this.head.imageObject != null)
            {
               _loc3_ = this.head.imageObject.getBounds(param1).y;
            }
            _loc2_.y = _loc3_;
         }
      }
      
      protected function drawMotionLine(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:TextArea = null;
         scene.dashline.visible = true;
         this._graphic.graphics.clear();
         UtilPlain.removeAllSon(this._graphic);
         UtilPlain.removeAllSon(this._curve);
         this._curve.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
         this._curve.addChild(this._graphic);
         scene.dashline.addChildAt(this._curve,0);
         if(this.motionShadow != null)
         {
            this._spline.reset();
            if(this._knots.length == 0)
            {
               _loc3_ = this.getOrigin();
               _loc4_ = new Point(this.motionShadow.x,this.motionShadow.y);
               this._curve.graphics.lineStyle(4 / Console.getConsole().stageScale,13421772);
               UtilDraw.drawDashLineWithArrow(this._curve,_loc3_,_loc4_,10 / Console.getConsole().stageScale,5 / Console.getConsole().stageScale,15 / Console.getConsole().stageScale);
               this._curve.name = "theCurve";
               this._curve.addEventListener(MouseEvent.CLICK,this.onDashlineClickHandler);
               _loc2_ = Point.distance(_loc3_,_loc4_);
            }
            else
            {
               this._curve.removeEventListener(MouseEvent.CLICK,this.onDashlineClickHandler);
               this._spline.addControlPoint(this.x,this.y);
               _loc5_ = 0;
               while(_loc5_ < this._knots.length)
               {
                  this._spline.addControlPoint(MaskPoint(this._knots[_loc5_]).x,MaskPoint(this._knots[_loc5_]).y);
                  _loc5_++;
               }
               this._spline.addControlPoint(this.motionShadow.x,this.motionShadow.y);
               this._spline.draw(4 / Console.getConsole().stageScale,10 / Console.getConsole().stageScale,5 / Console.getConsole().stageScale,15 / Console.getConsole().stageScale);
               _loc2_ = this._spline.arcLength() * 2;
            }
            if(_loc2_ > AnimeConstants.ASSET_MOVE_TOLERANCE)
            {
               scene.dashline.addChildAt(motionDistTip,1);
               _loc2_ = Util.roundNum(_loc2_,0);
               (_loc6_ = motionDistTip).setStyle("textAlign","center");
               _loc6_.width = 40;
               _loc6_.height = 18;
               _loc6_.selectable = false;
               _loc6_.text = String(_loc2_) + "px";
               _loc6_.x = this.x - _loc6_.width / 2;
               _loc6_.y = this.y - 18;
            }
            this.onDashlineOutHandler();
            scene.sendToFront(scene.dashline);
         }
         if(param1 != null)
         {
            this.updateFacing();
         }
      }
      
      private function buildMotionMenu(param1:Boolean = false) : ScrollableArrowMenu
      {
         var _loc2_:ScrollableArrowMenu = null;
         var _loc3_:CharThumb = CharThumb(this.thumb);
         var _loc4_:Array = _loc3_.motions;
         var _loc5_:* = "<menuRoot>";
         if(param1)
         {
            _loc5_ += "<menu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_POINT_REMOVE)) + "\" id=\"" + REMOVE_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>";
         }
         else
         {
            _loc5_ += "<menu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_POINT_ADD)) + "\" id=\"" + ADD_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>";
         }
         _loc5_ = (_loc5_ += "<menuItem label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT_REMOVE)) + "\" id=\"" + REMOVE_MOTION + "\" type=\"check\" toggled=\"false\"/>") + "</menuRoot>";
         this._motionMenuXML = new XML(_loc5_);
         _loc2_ = ScrollableArrowMenu.createMenu(null,this._motionMenuXML,false);
         _loc2_.setParentObject(this.getSceneCanvas());
         _loc2_.labelField = "@label";
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doMotionMenuClick);
         _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc2_.maxHeight = this.getSceneCanvas().height;
         return _loc2_;
      }
      
      public function stopCharacter() : void
      {
         var _loc1_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = movieObject;
            if(_loc1_ != null)
            {
               UtilPlain.stopFamily(_loc1_);
               this.stopMusic(false);
            }
         }
      }
      
      public function getDataAndKey() : UtilHashArray
      {
         var _loc2_:UtilHashArray = null;
         var _loc3_:int = 0;
         var _loc1_:UtilHashArray = new UtilHashArray();
         _loc1_.push(this.thumb.theme.id + ".char." + this.thumb.id + "." + this.action.id,this.action.imageData,true);
         if(this.prop != null)
         {
            if(PropThumb(this.prop.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.prop.thumb.theme.id + ".prop." + this.prop.thumb.id,this.prop.thumb.imageData,true);
            }
            else
            {
               _loc2_ = this.prop.getDataAndKey();
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc1_.push(_loc2_.getKey(_loc3_),_loc2_.getValueByIndex(_loc3_),true);
                  _loc3_++;
               }
            }
         }
         if(this.head != null)
         {
            if(PropThumb(this.head.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.head.thumb.theme.id + ".prop." + this.head.thumb.id,this.head.thumb.imageData,true);
            }
            else
            {
               _loc2_ = this.head.getDataAndKey();
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc1_.push(_loc2_.getKey(_loc3_),_loc2_.getValueByIndex(_loc3_),true);
                  _loc3_++;
               }
            }
         }
         if(this.wear != null)
         {
            if(PropThumb(this.wear.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.wear.thumb.theme.id + ".prop." + this.wear.thumb.id,this.wear.thumb.imageData,true);
            }
            else
            {
               _loc2_ = this.wear.getDataAndKey();
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc1_.push(_loc2_.getKey(_loc3_),_loc2_.getValueByIndex(_loc3_),true);
                  _loc3_++;
               }
            }
            _loc1_.push(this.wear.thumb.theme.id + ".prop." + this.wear.thumb.id,this.wear.thumb.imageData,true);
         }
         return _loc1_;
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var obj:Image = null;
         var command:ICommand = null;
         var doShowActionMenuAgain:Function = null;
         var extraData:Object = null;
         var loadMgr:UtilLoadMgr = null;
         var event:MouseEvent = param1;
         var charThumb:CharThumb = this.thumb as CharThumb;
         var curPos:Point = new Point(getSceneCanvas().mouseX,getSceneCanvas().mouseY);
         var originalPos:Point = new Point(this._originalX,this._originalY);
         var isChanged:Boolean = true;
         if(this == this.scene.selectedAsset)
         {
            if(curPos.equals(originalPos))
            {
               if(this.isCharacterThumbsReady() && !this.isMotionShadow() && Boolean(this.bundle.hitTestPoint(event.stageX,event.stageY,true)))
               {
                  this.showActionMenu();
                  isChanged = false;
               }
            }
            else
            {
               command = new MoveCharacterCommand(this._backupSceneXML);
               command.execute();
            }
            this._readyToDrag = false;
            this.showControl();
            if(this.motionShadow != null)
            {
               this.motionShadow.showControl();
            }
         }
         else
         {
            isChanged = false;
         }
         if(Image(event.currentTarget.parent) != null)
         {
            obj = Image(event.currentTarget.parent);
            obj.stopDrag();
         }
         if(Console.getConsole().currDragObject != null)
         {
            obj = Console.getConsole().currDragObject.bundle as Image;
            obj.stopDrag();
            Console.getConsole().currDragObject = null;
            if(this.motionShadow != null && !this.isRegardAsMoved(new Point(this.bundle.x,this.bundle.y),new Point(this.motionShadow.x,this.motionShadow.y)) && !this.isRegardAsMoved(new Point(this.scaleX * 100,this.scaleY * 100),new Point(this.motionShadow.scaleX * 100,this.motionShadow.scaleY * 100)))
            {
               scene.dashline.graphics.clear();
               if(scene.dashline.contains(this._curve))
               {
                  scene.dashline.removeChild(this._curve);
               }
               this.removeMotion();
               this.updateTimelineMotion();
               this.action = CharThumb(this.thumb).defaultAction;
            }
         }
         if(!event.ctrlKey && this.isRegardAsMoved(originalPos,curPos))
         {
            this.updateFacing();
         }
         if(control != null && controlVisible)
         {
            this.control = null;
            this.showControl();
         }
         if(this.motionShadow != null)
         {
            if(this.motionShadow.control != null && this.motionShadow.controlVisible)
            {
               this.motionShadow.control = null;
               this.motionShadow.showControl();
            }
         }
         if(!this.isCharacterThumbsReady())
         {
            doShowActionMenuAgain = function(param1:LoadMgrEvent):void
            {
               var _loc3_:Point = null;
               var _loc4_:Point = null;
               var _loc5_:anifire.core.Character = null;
               var _loc7_:Point = null;
               var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
               var _loc6_:Object;
               _loc3_ = (_loc6_ = _loc2_.getExtraData())["mouseUpPos"];
               _loc4_ = _loc6_["mouseDownPos"];
               if((_loc5_ = _loc6_["char"]) != null)
               {
                  if(_loc5_.getSceneCanvas() != null)
                  {
                     _loc7_ = new Point(_loc5_.getSceneCanvas().mouseX,_loc5_.getSceneCanvas().mouseY);
                     if(_loc3_.equals(_loc4_) && _loc3_.equals(_loc7_))
                     {
                        _loc5_.showActionMenu();
                     }
                  }
               }
            };
            extraData = new Object();
            extraData["mouseUpPos"] = curPos;
            extraData["mouseDownPos"] = originalPos;
            extraData["char"] = this;
            loadMgr = new UtilLoadMgr();
            loadMgr.setExtraData(extraData);
            loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,doShowActionMenuAgain);
            loadMgr.addEventDispatcher(charThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            charThumb.loadActionsAndMotions();
            loadMgr.commit();
         }
         if(isChanged)
         {
            changed = true;
         }
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().thumbTrayActive = true;
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = 75;
         param1.x += -_loc2_;
         if(param1.x < 0)
         {
            param1.x = 0;
         }
      }
      
      public function set isSlide(param1:Boolean) : void
      {
         this._isSlide = param1;
      }
      
      private function removeMotion() : void
      {
         this.removeMotionShadow();
         this.control = null;
         this.hideButtonBar();
         this.changed = true;
      }
      
      override internal function clone(param1:Boolean = false) : Asset
      {
         var newProp:anifire.core.Prop = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var addSceneFlag:Boolean = param1;
         var char:anifire.core.Character = new anifire.core.Character();
         char.id = char.bundle.id = this.id;
         char.scene = this.scene;
         char.thumb = this.thumb;
         if(this.motionShadow == null)
         {
            char.x = this.x;
            char.y = this.y;
            char.width = this.width;
            char.height = this.height;
            char.facing = this.facing;
            char.scaleX = this.scaleX;
            char.scaleY = this.scaleY;
            char.displayElement.scaleX = this.displayElement.scaleX;
            char.displayElement.scaleY = this.displayElement.scaleY;
            char.rotation = this.rotation;
         }
         char.customColor = this.customColor.clone();
         char.defaultColorSet = this.defaultColorSet.clone();
         if(this.motionShadow != null && !this.isMotionShadow())
         {
            char.x = this.motionShadow.x;
            char.y = this.motionShadow.y;
            char.facing = this.motionShadow.facing;
            char.scaleX = this.motionShadow.scaleX;
            char.scaleY = this.motionShadow.scaleY;
            char.rotation = this.motionShadow.rotation;
         }
         char.actionId = this.actionId;
         char.action = this.action;
         char.motion = this.motion;
         char.lookAtCamera = this.lookAtCamera;
         if(this.prop != null)
         {
            newProp = new anifire.core.Prop();
            if(addSceneFlag)
            {
               onAddedPropSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
            }
            newProp.init(PropThumb(this.prop.thumb),char);
            newProp.state = this.prop.state;
            newProp.capScreenLock = this.capScreenLock;
            char.addPropDataAndClip(newProp);
         }
         else
         {
            char.prop = null;
         }
         char._loadCount = 0;
         if(this.head != null)
         {
            newProp = new anifire.core.Prop();
            if(addSceneFlag)
            {
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
            }
            newProp.init(PropThumb(this.head.thumb),char);
            newProp.state = this.head.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addHeadDataAndClip(newProp);
            newProp.lookAtCamera = this.lookAtCamera;
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.head = null;
         }
         if(this.wear != null)
         {
            newProp = new anifire.core.Prop();
            if(addSceneFlag)
            {
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
            }
            newProp.init(PropThumb(this.wear.thumb),char);
            newProp.state = this.wear.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addWearDataAndClip(newProp);
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.wear = null;
         }
         return char;
      }
      
      public function get prop() : anifire.core.Prop
      {
         return this._prop;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc9_:int = 0;
         var _loc12_:XML = null;
         var _loc13_:int = 0;
         var _loc14_:SelectedColor = null;
         var _loc15_:XML = null;
         var _loc16_:anifire.core.Prop = null;
         var _loc17_:XML = null;
         var _loc18_:XML = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBehaviour(param1.action,true);
         var _loc5_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc6_:String = UtilXmlInfo.getCharIdFromFileName(_loc4_);
         var _loc7_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc8_:CharThumb;
         if((_loc8_ = Console.getConsole().getTheme(_loc7_).getCharThumbById(_loc6_)) != null)
         {
            this.scene = param2;
            this.thumb = _loc8_;
            this.actionId = _loc5_;
            this._xs = String(param1.x).split(",");
            this._ys = String(param1.y).split(",");
            this._scaleXs = String(param1.xscale).split(",");
            this._scaleYs = String(param1.yscale).split(",");
            this._rotations = String(param1.rotation).split(",");
            this._facings = String(param1.action.@face).split(",");
            this.lookAtCamera = String(param1.@faceCamera) == "true";
            this.x = this._xs[0];
            this.y = this._ys[0];
            this.scaleX = this._scaleXs[0];
            this.scaleY = this._scaleYs[0];
            this.rotation = this._rotations[0];
            this.facing = this.getFacingConstants(_loc8_.facing,this._facings[0]);
            displayElement.width = this.width;
            displayElement.height = this.height;
            displayElement.scaleX = this.scaleX;
            displayElement.scaleY = this.scaleY;
            if(param3)
            {
               this.action = _loc8_.getActionById(_loc5_);
            }
            else
            {
               this._action = _loc8_.getActionById(_loc5_);
            }
            if(param1.dcsn.length() > 0)
            {
               this.defaultColorSetId = String(param1.dcsn);
               this.defaultColorSet = this.thumb.getColorSetById(this.defaultColorSetId);
            }
            customColor = new UtilHashArray();
            _loc13_ = 0;
            while(_loc13_ < param1.child("color").length())
            {
               _loc12_ = param1.child("color")[_loc13_];
               _loc14_ = new SelectedColor(_loc12_.@r,_loc12_.attribute("oc").length() == 0 ? uint.MAX_VALUE : uint(_loc12_.@oc),uint(_loc12_));
               this.addCustomColor(_loc12_.@r,_loc14_);
               _loc13_++;
            }
            if(this.action != null && this.action.imageData != null)
            {
               this.isLoadded = true;
               _loc15_ = new XML();
               _loc16_ = new anifire.core.Prop();
               _loc9_ = 0;
               while(_loc9_ < param1.prop.length())
               {
                  _loc15_ = param1.prop[_loc9_];
                  (_loc16_ = new anifire.core.Prop()).capScreenLock = this.capScreenLock;
                  _loc16_.deSerialize(_loc15_,this);
                  this.addPropDataAndClip(_loc16_);
                  this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
                  _loc9_++;
               }
            }
         }
         _loc9_ = 0;
         while(_loc9_ < param1.prop.length())
         {
            _loc15_ = param1.prop[_loc9_];
            (_loc16_ = new anifire.core.Prop()).capScreenLock = this.capScreenLock;
            _loc16_.deSerialize(_loc15_,this);
            this.addPropDataAndClip(_loc16_);
            this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < param1.head.length())
         {
            _loc17_ = param1.head[_loc10_];
            (_loc16_ = new anifire.core.Prop()).capScreenLock = this.capScreenLock;
            _loc16_.lookAtCamera = this._lookAtCamera;
            _loc16_.deSerialize(_loc17_,this);
            this.addHeadDataAndClip(_loc16_);
            this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc10_++;
         }
         var _loc11_:int = 0;
         while(_loc11_ < param1.wear.length())
         {
            _loc18_ = param1.wear[_loc11_];
            (_loc16_ = new anifire.core.Prop()).capScreenLock = this.capScreenLock;
            _loc16_.deSerialize(_loc18_,this);
            this.addWearDataAndClip(_loc16_);
            this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc11_++;
         }
         this.bundle.callLater(this.setMotionProperties,[param1]);
      }
      
      public function set motion(param1:anifire.core.Motion) : void
      {
         this._motion = param1;
         if(this._motion == null)
         {
            this.motionId = "";
         }
         else
         {
            this.motionId = this._motion.id;
         }
      }
      
      public function get motionId() : String
      {
         return this._motionId;
      }
      
      private function loadProxyImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         _loc2_.scaleX = getSceneCanvas().parent.scaleX;
         _loc2_.scaleY = getSceneCanvas().parent.scaleY;
         var _loc3_:Image = Image(_loc2_.parent);
         _loc2_.content.width = this.width;
         _loc2_.content.height = this.height;
         var _loc4_:Rectangle = _loc2_.getBounds(this.bundle);
         _loc2_.x -= _loc4_.x * _loc2_.scaleX;
         _loc2_.y -= _loc4_.y * _loc2_.scaleY;
         if(this.prop != null)
         {
            this.addPropClipToPropContainer(this.prop.movieObject,_loc2_);
         }
      }
      
      private function addControlPoint(param1:Point) : void
      {
         var _loc2_:MaskPoint = new MaskPoint();
         _loc2_.scaleX = _loc2_.scaleY = 1 / Console.getConsole().stageScale;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.doubleClickEnabled = true;
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.onMaskPointDown);
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawMotionLine);
         _loc2_.addEventListener(MouseEvent.MOUSE_UP,_loc2_.doMouseUp);
         _loc2_.addEventListener(MouseEvent.CLICK,this.showMotionMenu);
         _loc2_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteMaskPoint);
         scene.dashline.addChild(_loc2_);
         if(this._insertingPoint > -1)
         {
            this._knots.splice(this._insertingPoint,0,_loc2_);
         }
         else
         {
            this._knots.push(_loc2_);
         }
         this.drawMotionLine();
      }
      
      override protected function doResizeComplete(param1:Event) : void
      {
         this.scaleX = displayElement.scaleX;
         this.scaleY = displayElement.scaleY;
         var _loc2_:ICommand = new ResizeCharacterCommand(id,_originalAssetX,_originalAssetY,_originalAssetScaleX,_originalAssetScaleY,this._originalRotation);
         _loc2_.execute();
         this._originalRotation = this.bundle.rotation;
         this.changed = true;
      }
      
      private function addProptoAllByPara(param1:Array, param2:Object, param3:State, param4:String) : void
      {
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            Character(param1[_loc5_]).addPropByThumb(param2,param3,param4);
            _loc5_++;
         }
      }
      
      private function get defaultFacing() : String
      {
         return CharThumb(this.thumb).facing;
      }
      
      override public function addControl() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Boolean = false;
         var _loc4_:Control = null;
         if(movieObject != null)
         {
            UtilPlain.gotoAndStopFamilyAt1(movieObject);
            this.stopMusic(false,true);
            _loc1_ = Util.getCharacter(MovieClip(movieObject));
            _loc2_ = _loc1_.getBounds(this.bundle);
            _loc3_ = false;
            if(_loc3_)
            {
               _loc2_.width = _loc2_.height = 100;
            }
            (_loc4_ = ControlMgr.getControl(movieObject,ControlMgr.NORMAL)).dragable = true;
            _loc4_.setPos(_loc2_.x,_loc2_.y);
            _loc4_.setSize(_loc2_.width,_loc2_.height);
            _loc4_.setOrigin(-_loc2_.x,-_loc2_.y);
            _loc4_.addEventListener(ControlEvent.OUTLINE_DOWN,this.onControlOutlineDownHandler);
            _loc4_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
            _loc4_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
            _loc4_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
            this._prevCharPosX = _loc2_.x;
            this._prevCharPosY = _loc2_.y;
            this._orgLoaderScaleX = Math.abs(displayElement.scaleX);
            this._orgLoaderScaleY = Math.abs(displayElement.scaleY);
            _loc4_.hideControl();
            this.control = _loc4_;
            _loc4_.addEventListener(ControlEvent.ROTATE,this.rotateCharacter);
         }
         this.dispatchEvent(new Event("ControlRdy"));
      }
      
      public function get wear() : anifire.core.Prop
      {
         return this._wear;
      }
      
      private function onDashlineOutHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(0,1,3,3,250);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         this._curve.filters = _loc3_;
      }
      
      private function addPropByThumb(param1:Object, param2:State, param3:String = "") : void
      {
         var newProp:anifire.core.Prop = null;
         var i:int = 0;
         var customColor:UtilHashArray = null;
         var onAddedPropSoundHandler:Function = null;
         var command:ICommand = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var thumb:Object = param1;
         var state:State = param2;
         var colorSetId:String = param3;
         trace("addPropByThumb:" + [thumb,state]);
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.addPropByThumb(thumb,state,colorSetId);
         }
         if(thumb is PropThumb)
         {
            newProp = new anifire.core.Prop();
            if(PropThumb(thumb).holdable == true)
            {
               if(!this.isMotionShadow())
               {
                  command = new AddPropCommand();
                  command.execute();
               }
               onAddedPropSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
               newProp.init(PropThumb(thumb),this);
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               this.addPropDataAndClip(newProp);
               this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            }
            else if(PropThumb(thumb).headable == true)
            {
               if(!this.isMotionShadow())
               {
                  command = new AddPropCommand();
                  command.execute();
               }
               newProp = new anifire.core.Prop();
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
               newProp.init(PropThumb(thumb),this);
               newProp.lookAtCamera = this.lookAtCamera;
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               trace("addPropByThumb add head:" + [newProp,newProp.state]);
               this.addHeadDataAndClip(newProp);
               this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            }
            else if(PropThumb(thumb).wearable == true)
            {
               if(!this.isMotionShadow())
               {
                  command = new AddPropCommand();
                  command.execute();
               }
               newProp = new anifire.core.Prop();
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
               newProp.init(PropThumb(thumb),this);
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               this.addWearDataAndClip(newProp);
               this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            }
         }
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
      
      private function deleteMaskPointByName(param1:String) : void
      {
         var _loc2_:DisplayObject = scene.dashline.getChildByName(param1);
         scene.dashline.removeChild(_loc2_);
         var _loc3_:Number = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._knots.length)
         {
            if(this._knots[_loc4_] == _loc2_)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this._knots.splice(_loc3_,1);
         this.drawMotionLine();
         this.updateFacing();
      }
      
      override public function doKeyUp(param1:KeyboardEvent, param2:Boolean = true) : void
      {
         if(this.scene.selectedAsset == this)
         {
            this.hideMotionShadow();
         }
         super.doKeyUp(param1);
         if(this._actionMenu != null)
         {
            this._actionMenu.hide();
         }
      }
      
      private function addTailClipToTailContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getTail(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getTail(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.numChildren - 1;
               while(_loc6_ >= 0)
               {
                  if((_loc7_ = _loc5_.getChildAt(_loc6_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc5_.removeChildAt(_loc6_);
                  }
                  _loc6_--;
               }
               _loc5_.addChild(param1);
               this.updateHeadSize(_loc5_);
            }
         }
      }
      
      private function showActionMenu() : void
      {
         this._actionMenu = this.buildActionMenu();
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(this._hasFacialExpression == true)
         {
            _loc1_ = 140;
            _loc2_ = 65;
         }
         else
         {
            _loc1_ = 85;
            _loc2_ = 45;
         }
         var _loc3_:Canvas = this.getSceneCanvas();
         var _loc4_:Point = _loc3_.localToGlobal(new Point(0,0));
         if(Console.getConsole().stageScale > 1)
         {
            _loc4_ = new Point(0,68);
         }
         var _loc5_:Number = Number(_loc3_.stage.mouseX);
         var _loc6_:Number = Number(_loc3_.stage.mouseY);
         if(_loc5_ + _loc1_ > _loc4_.x + _loc3_.width)
         {
            _loc5_ = _loc4_.x + _loc3_.width - _loc1_;
         }
         if(_loc6_ + _loc2_ > _loc4_.y + _loc3_.height)
         {
            _loc6_ = _loc4_.y + _loc3_.height - _loc2_;
         }
         this._actionMenu.addEventListener(KeyboardEvent.KEY_UP,Console.getConsole().doKeyUp);
         this._actionMenu.show(_loc5_,_loc6_);
      }
      
      private function getMotionFacing() : int
      {
         var _loc1_:String = this.getFacingDirection();
         var _loc2_:int = _loc1_ == this.defaultFacing ? 1 : -1;
         if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
         {
            return _loc2_;
         }
         return _loc2_ * -1;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!this.isMotionShadow() && this.control != null)
         {
            this.showMotionShadow();
            this.addMotionMenuListener();
            if(!Console.getConsole().isGoWalkerOn())
            {
               this.showButtonBar();
            }
         }
      }
      
      private function removeMotionMenuListener() : void
      {
         this._curve.removeEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         this._curve.removeEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      private function isCharacterThumbsReady() : Boolean
      {
         var _loc1_:CharThumb = this.thumb as CharThumb;
         if(!_loc1_.isThumbReady(this.actionId))
         {
            return false;
         }
         return true;
      }
      
      private function doChangeMotion(param1:MenuEvent) : void
      {
         var _loc9_:ICommand = null;
         var _loc2_:String = String(param1.item.@id);
         var _loc3_:String = String(param1.item.@label);
         var _loc4_:String = String(param1.item.@data);
         var _loc5_:String = String(param1.item.@direction);
         var _loc6_:String = String(param1.item.@itemType);
         var _loc7_:CharThumb;
         var _loc8_:Array = (_loc7_ = CharThumb(this.thumb)).motions;
         if(_loc2_ == REMOVE_MOTION)
         {
            (_loc9_ = new RemoveMotionCommand()).execute();
            this.startRemoveMotion();
            this.updateTimelineMotion();
            if(!this.isSlide)
            {
               this.action = CharThumb(this.thumb).defaultAction;
            }
            this.isSlide = false;
            return;
         }
         if(_loc2_ == ADD_CONTROL_POINT)
         {
            this.addControlPoint(this._mouseClickPoint);
            return;
         }
         if(_loc2_ == REMOVE_CONTROL_POINT)
         {
            this.deleteMaskPointByName(this._currControlPointName);
         }
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         var _loc2_:CharThumb = param1 as CharThumb;
         super.thumb = _loc2_;
         if(this._fromTray)
         {
            this.action = _loc2_.defaultAction;
            this.motion = _loc2_.defaultMotion;
         }
         else
         {
            this.action = _loc2_.getActionById(this.actionId);
            this.motion = _loc2_.getMotionById(this.motionId);
         }
      }
      
      public function set facing(param1:String) : void
      {
         var displayElement:DisplayObject = null;
         var loader:DisplayObject = null;
         var facing:String = param1;
         var doFlip:Boolean = false;
         var newface:Number = 0;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               displayElement = bundle.getChildAt(0) as DisplayObject;
               loader = DisplayObject(this.imageObject);
               newface = UtilPlain.flipObj(loader);
               doFlip = true;
               scaleX = displayElement.scaleX;
               scaleY = displayElement.scaleY;
               if(newface < 0)
               {
                  this._facing = this.defaultFacing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
               }
               else
               {
                  this._facing = this.defaultFacing;
               }
            }
            catch(e:Error)
            {
               trace("E:" + e);
            }
         }
         if(newface == 0)
         {
            this._facing = facing;
         }
         if(doFlip)
         {
            this.exchangeProp();
         }
      }
      
      public function get motion() : anifire.core.Motion
      {
         return this._motion;
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:int = 0;
         var _loc8_:AnimeScene = null;
         var _loc9_:anifire.core.Character = null;
         if(!this.isMotionShadow())
         {
            _loc7_ = Console.getConsole().getSceneIndex(scene);
            _loc8_ = Console.getConsole().getScene(_loc7_);
            if(this.motionShadow == null || !_loc8_.canvas.contains(this.motionShadow.bundle))
            {
               _loc9_ = Character(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null && param5 == null && param6 == null))
               {
                  _loc9_.x = param1[param1.length - 1];
                  _loc9_.y = param2[param2.length - 1];
                  _loc9_.rotation = param6[param6.length - 1];
                  _loc9_.facing = this.getFacingConstants(CharThumb(this.thumb).facing,param5[param5.length - 1]);
                  _loc9_.scaleX = param3[param3.length - 1];
                  _loc9_.scaleY = param4[param4.length - 1];
                  _loc9_.displayElement.scaleX = param3[param3.length - 1];
                  _loc9_.displayElement.scaleY = param4[param4.length - 1];
               }
               this.motionShadow = Character(_loc9_.clone());
               this.motionShadow.fromTray = false;
               this.motionShadow.bundle.alpha = 0.7;
               this.motionShadow.bundle.name = this.motionShadow.id = "motionShadow_" + id;
               this.motionShadow.bundle.buttonMode = true;
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.initializeDrag);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.doDrag);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.doMouseUp);
               _loc8_.canvas.addChildAt(this.motionShadow.bundle,this.getShadowIndex(_loc8_));
            }
            this.showMotionShadow();
         }
      }
      
      override internal function doDragEnter(param1:DragEvent) : void
      {
         var _loc3_:GlowFilter = null;
         var _loc2_:Object = param1.dragSource.dataForFormat("thumb");
         if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
         {
            DragManager.acceptDragDrop(UIComponent(param1.currentTarget));
            if(this.displayElement != null)
            {
               _loc3_ = new GlowFilter(16742400,1,6,6,5);
               this.displayElement.filters = [_loc3_];
            }
         }
      }
      
      override internal function hideControl() : void
      {
         super.hideControl();
         if(!this.isMotionShadow())
         {
            this.hideMotionShadow();
            this.removeMotionMenuListener();
            this.hideButtonBar();
         }
      }
      
      public function set head(param1:anifire.core.Prop) : void
      {
         this._head = param1;
      }
      
      private function fillMaskPoint() : void
      {
         var _loc1_:int = 0;
         if(this._xs.length > 2 && this._xs.length == this._ys.length)
         {
            _loc1_ = 1;
            while(_loc1_ < this._xs.length - 1)
            {
               this.addControlPoint(new Point(this._xs[_loc1_],this._ys[_loc1_]));
               _loc1_++;
            }
         }
      }
      
      private function buildActionMenu() : ScrollableArrowMenu
      {
         var _loc3_:ScrollableArrowMenu = null;
         var _loc13_:int = 0;
         var _loc14_:Object = null;
         var _loc15_:anifire.core.Action = null;
         var _loc16_:Boolean = false;
         var _loc17_:BehaviorCategory = null;
         var _loc18_:int = 0;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:anifire.core.Motion = null;
         var _loc22_:String = null;
         var _loc23_:State = null;
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = true;
         var _loc4_:CharThumb;
         var _loc5_:Array = (_loc4_ = CharThumb(this.thumb)).actions;
         var _loc6_:Array = _loc4_.actionMenuItems;
         var _loc7_:* = "<menuRoot>";
         var _loc8_:Boolean = UtilLicense.isActionNameNeedLowerCase();
         if(_loc6_.length > 0)
         {
            _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_ACTION) + "\" toggled=\"false\">";
            _loc13_ = 0;
            while(_loc13_ < _loc6_.length)
            {
               if((_loc14_ = _loc6_[_loc13_]) is BehaviorCategory)
               {
                  _loc17_ = BehaviorCategory(_loc14_);
                  _loc7_ += "<menuItem label=\"" + UtilDict.toDisplay("store",_loc17_.name) + "\" toggle=\"false\">";
                  _loc18_ = 0;
                  while(_loc18_ < _loc17_.behaviors.length)
                  {
                     if((_loc15_ = Action(_loc17_.getBehaviorByIndex(_loc18_))).id == this.action.id)
                     {
                        _loc16_ = true;
                     }
                     else
                     {
                        _loc16_ = false;
                     }
                     _loc7_ += "<actionItem " + "label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc8_ ? _loc15_.name.toLowerCase() : _loc15_.name)) + "\" " + "type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_ACTION_TAG + "\" " + "actionId=\"" + _loc15_.id + "\" " + "toggled=\"" + _loc16_ + "\"/>";
                     _loc18_++;
                  }
                  _loc7_ += "</menuItem>";
               }
               else if(_loc14_ is anifire.core.Action)
               {
                  if((_loc15_ = Action(_loc14_)).id == this.action.id)
                  {
                     _loc16_ = true;
                  }
                  else
                  {
                     _loc16_ = false;
                  }
                  _loc7_ += "<actionItem " + "label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc8_ ? _loc15_.name.toLowerCase() : _loc15_.name)) + "\" " + "type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_ACTION_TAG + "\" " + "actionId=\"" + _loc15_.id + "\" " + "toggled=\"" + _loc16_ + "\"/>";
               }
               _loc13_++;
            }
            _loc7_ += "</mainMenu>";
         }
         _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT) + "\" toggled=\"false\">";
         var _loc9_:Array = _loc4_.motions;
         var _loc10_:Boolean = false;
         if(_loc9_.length > 0)
         {
            _loc19_ = false;
            _loc20_ = false;
            _loc13_ = 0;
            while(_loc13_ < _loc9_.length)
            {
               _loc21_ = Motion(_loc9_[_loc13_]);
               _loc22_ = this.motionDirection;
               _loc19_ = false;
               _loc20_ = false;
               if(_loc21_ != null)
               {
                  if(_loc21_.id == this.action.id)
                  {
                     if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
                     {
                        _loc19_ = true;
                        _loc10_ = true;
                     }
                     else
                     {
                        _loc20_ = true;
                        _loc10_ = true;
                     }
                  }
                  _loc7_ += "<menuItem label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc8_ ? _loc21_.name.toLowerCase() : _loc21_.name)) + "\" data=\"" + _loc21_.name + "\" direction=\"" + AnimeConstants.MOTION_FORWARD + "\" type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_MOVEMENT_TAG + "\" actionId=\"" + _loc21_.id + "\" toggled=\"" + _loc19_ + "\" enabled=\"" + _loc1_ + "\"/>";
               }
               _loc13_++;
            }
         }
         if(this.hasMotion() && !_loc10_)
         {
            this.isSlide = true;
         }
         var _loc11_:String = UtilDict.toDisplay("go",MENU_ITEM_SLIDE);
         _loc19_ = false;
         _loc20_ = false;
         if(this.isSlide)
         {
            if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               _loc19_ = true;
            }
            else
            {
               _loc20_ = true;
            }
         }
         _loc7_ += "<menuItem label=\"" + _loc11_ + "\" data=\"" + MENU_ITEM_SLIDE + "\" direction=\"" + AnimeConstants.MOTION_FORWARD + "\" type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_MOVEMENT_TAG + "\" toggled=\"" + _loc19_ + "\" enabled=\"" + _loc1_ + "\"/>";
         if(this.motionShadow != null)
         {
            _loc7_ = (_loc7_ += "<menuitem type=\"separator\"/>") + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT_REMOVE) + "\" id=\"" + REMOVE_MOTION + "\" type=\"check\" toggled=\"false\"/>");
         }
         _loc7_ = (_loc7_ += "</mainMenu>") + "<menuitem type=\"separator\"/>";
         var _loc12_:PropThumb;
         if((_loc12_ = this.thumb.theme.getPropThumbById(this.thumb.id + ".head")) != null && (this.head == null || this.head != null && this.head.thumb.id == _loc12_.id))
         {
            this._hasFacialExpression = true;
            _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_FACIAL) + "\" toggled=\"false\">";
            _loc13_ = 0;
            while(_loc13_ < _loc12_.states.length)
            {
               if((_loc23_ = _loc12_.getStateAt(_loc13_)).isEnable)
               {
                  if(this.head != null && _loc23_.id == this.head.stateId)
                  {
                     _loc16_ = true;
                  }
                  else
                  {
                     _loc16_ = false;
                  }
                  _loc7_ += "<menuItem " + "label=\'" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc8_ ? _loc23_.name.toLowerCase() : _loc23_.name)) + "\' " + "value=\'" + _loc23_.id + "\' " + "type=\'check\' " + "itemType=\'" + MENU_ITEM_TYPE_FACIAL_TAG + "\' " + "toggled=\'" + _loc16_ + "\' " + "enabled=\'" + _loc2_ + "\'/>";
               }
               _loc13_++;
            }
            _loc7_ = (_loc7_ += "<menuItem label=\'" + UtilDict.toDisplay("go",MENU_ITEM_DEFAULT) + "\' value=\'" + MENU_ITEM_DEFAULT + "\' type=\'check\' itemType=\'" + MENU_ITEM_TYPE_FACIAL_TAG + "\' toogled=\'false\'/>") + "</mainMenu>";
         }
         if(this.prop != null)
         {
            _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_PROP) + "\" toggled=\"false\">";
            _loc7_ = (_loc7_ = (_loc7_ = this.prop.buildStateMenu(_loc7_,false)) + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_ITEM_PROP_REMOVE) + "\" value=\'" + MENU_ITEM_PROP_REMOVE + "\' type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_PROP_TAG + "\" toggled=\"false\"/>")) + "</mainMenu>";
         }
         if(this.head != null && this.head.thumb.id != this.thumb.id + ".head")
         {
            _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_HEAD) + "\" toggled=\"false\">";
            _loc7_ = (_loc7_ = (_loc7_ = this.head.buildStateMenu(_loc7_,false)) + ("<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_HEAD_REMOVE) + "\" value=\'" + MENU_ITEM_HEAD_REMOVE + "\' type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_HEAD_TAG + "\" toggled=\"false\"/>")) + "</mainMenu>";
         }
         if(this.wear != null)
         {
            _loc7_ += "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_WEAR) + "\" toggled=\"false\">";
            _loc7_ = (_loc7_ = (_loc7_ = this.wear.buildStateMenu(_loc7_,false)) + ("<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_WEAR_REMOVE) + "\" value=\'" + MENU_ITEM_WEAR_REMOVE + "\' type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_WEAR_TAG + "\" toggled=\"false\"/>")) + "</mainMenu>";
         }
         _loc7_ += "</menuRoot>";
         this._actionMenuXML = new XML(_loc7_);
         _loc3_ = ScrollableArrowMenu.createMenu(null,this._actionMenuXML,false);
         _loc3_.setParentObject(this.getSceneCanvas());
         _loc3_.labelField = "@label";
         _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc3_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc3_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc3_.maxHeight = this.getSceneCanvas().height;
         return _loc3_;
      }
      
      private function onControlOutlineDownHandler(param1:ControlEvent) : void
      {
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._readyToDrag = true;
         var _loc2_:Image = Image(this.bundle);
         _loc2_.startDrag();
         if(!this.isMotionShadow())
         {
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         }
         else
         {
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this._shadowParent.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this._shadowParent.onStageMouseUpHandler);
         }
         Console.getConsole().currDragObject = this;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(this.scene.selectedAsset != null)
         {
            this.scene.selectedAsset.hideControl();
            if(this.scene.selectedAsset is anifire.core.Character && Character(this.scene.selectedAsset).motionShadow != null)
            {
               Character(this.scene.selectedAsset).motionShadow.hideControl();
            }
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
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._originalRotation = this.bundle.rotation;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
         Console.getConsole().thumbTrayActive = false;
      }
      
      private function doActionMenuClick(param1:MenuEvent) : void
      {
         var command:ICommand = null;
         var propId:String = null;
         var stateId:String = null;
         var propThumb:PropThumb = null;
         var state:State = null;
         var doAddFacialAgain:Function = null;
         var extraData:Object = null;
         var loadMgr:UtilLoadMgr = null;
         var event:MenuEvent = param1;
         var itemType:String = String(event.item.@itemType);
         var direction:String = String(event.item.@direction);
         var id:String = String(event.item.@id);
         var itemXML:XML = XML(event.item);
         trace("*****:" + itemXML.attribute(MENU_ITEM_TYPE_TAG));
         if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_ACTION_TAG)
         {
            if(this.motionShadow != null && !this.isSlide)
            {
               this.startRemoveMotion();
            }
            this.doChangeAction(event);
         }
         else if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_MOVEMENT_TAG)
         {
            if(itemXML.attribute("data") == MENU_ITEM_SLIDE)
            {
               if(this.motionShadow != null && !this.isSlide)
               {
                  event.item.@label = CharThumb(this.thumb).defaultAction.name;
                  event.item.@actionId = CharThumb(this.thumb).defaultAction.id;
               }
               this.isSlide = true;
            }
            else
            {
               this.isSlide = false;
            }
            if(this.motionDirection == "")
            {
               this.motionDirection = direction;
            }
            this.doStartMovement(event);
         }
         else
         {
            if(id == REMOVE_MOTION)
            {
               command = new RemoveMotionCommand();
               command.execute();
               this.startRemoveMotion();
               this.updateTimelineMotion();
               if(!this.isSlide)
               {
                  this.action = CharThumb(this.thumb).defaultAction;
               }
               this.isSlide = false;
               return;
            }
            if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_PROP_TAG)
            {
               if(itemXML.attribute("value") == MENU_ITEM_PROP_REMOVE)
               {
                  command = new RemovePropCommand();
                  command.execute();
                  this.removeProp();
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.removeProp();
                  }
                  this.refreshControl();
               }
               else
               {
                  this.prop.doChangeState(event);
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.prop.doChangeState(event);
                  }
               }
            }
            else if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_HEAD_TAG)
            {
               if(itemXML.attribute("value") == MENU_ITEM_HEAD_REMOVE)
               {
                  command = new RemovePropCommand();
                  command.execute();
                  this.removeHead();
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.removeHead();
                  }
                  this.refreshControl();
               }
               else
               {
                  this.head.doChangeState(event);
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.head.doChangeState(event);
                  }
               }
            }
            else if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_WEAR_TAG)
            {
               if(itemXML.attribute("value") == MENU_ITEM_WEAR_REMOVE)
               {
                  command = new RemovePropCommand();
                  command.execute();
                  this.removeWear();
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.removeWear();
                  }
                  this.refreshControl();
               }
               else
               {
                  this.wear.doChangeState(event);
                  if(this._motionShadowChar != null)
                  {
                     this._motionShadowChar.wear.doChangeState(event);
                  }
               }
            }
            else if(itemXML.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_FACIAL_TAG)
            {
               if(itemXML.@value == MENU_ITEM_DEFAULT)
               {
                  command = new RemovePropCommand();
                  command.execute();
                  this.removeHead();
               }
               else
               {
                  propId = this.thumb.id + ".head";
                  stateId = itemXML.@value;
                  propThumb = this.thumb.theme.getPropThumbById(propId);
                  if(propThumb.getStateNum() > 0)
                  {
                     state = propThumb.getStateById(stateId);
                  }
                  if(state.imageData != null)
                  {
                     this.addPropByThumb(propThumb,state);
                  }
                  else
                  {
                     doAddFacialAgain = function(param1:LoadMgrEvent):void
                     {
                        var _loc3_:Thumb = null;
                        var _loc4_:State = null;
                        var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
                        var _loc5_:Object;
                        _loc3_ = (_loc5_ = _loc2_.getExtraData())["thumb"];
                        _loc4_ = _loc5_["state"];
                        addPropByThumb(_loc3_,_loc4_);
                     };
                     extraData = new Object();
                     extraData["thumb"] = propThumb;
                     extraData["state"] = state;
                     loadMgr = new UtilLoadMgr();
                     loadMgr.setExtraData(extraData);
                     loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,doAddFacialAgain);
                     loadMgr.addEventDispatcher(propThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     propThumb.loadState(state);
                     loadMgr.commit();
                  }
                  this.hideControl();
               }
            }
         }
         if(Console.getConsole().isGoWalkerOn())
         {
            Console.getConsole().dispatchGoWalkerEvent(4);
         }
      }
      
      private function showControlPoint() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = this._knots.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = Number(scene.dashline.getChildIndex(this._knots[_loc2_]));
            if(_loc3_ >= 0)
            {
               MaskPoint(scene.dashline.getChildAt(_loc3_)).visible = true;
            }
            _loc2_++;
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var loader:Loader = null;
         var self:Asset = null;
         var ccChar:CustomCharacterMaker = null;
         var args:Object = null;
         var i:int = this.displayElement.numChildren - 1;
         if(i >= 0)
         {
            this.displayElement.removeChildAt(i);
         }
         if(!CharThumb(this.thumb).isCC)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadAssetImageComplete);
            loader.loadBytes(ByteArray(this.imageData));
            loader.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(loader);
         }
         else
         {
            self = this;
            ccChar = new CustomCharacterMaker();
            args = this.imageData;
            ccChar.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.loadAssetImageComplete);
            ccChar.lookAtCamera = this.lookAtCamera;
            ccChar.initBySwfs(args["xml"] as XML,args["imageData"] as UtilHashArray);
            if(this.initCameraHandler != null)
            {
               removeEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            }
            this.initCameraHandler = function(param1:ExtraDataEvent):void
            {
               var _loc2_:Boolean = Boolean(param1.getData());
               trace("CcLookAtCamera: " + (_loc2_ ? "ON" : "OFF"));
               head != null && (head.lookAtCamera = _loc2_);
               ccChar.lookAtCamera = _loc2_;
            };
            this.addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            ccChar.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(ccChar);
            this.displayElement.visible = false;
            displayElement.width = this.width;
            displayElement.height = this.height;
            displayElement.scaleX = this.scaleX;
            displayElement.scaleY = this.scaleY;
         }
      }
      
      public function get spline() : myBezierSpline
      {
         return this._spline;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      internal function addHeadDataAndClip(param1:anifire.core.Prop) : void
      {
         if(this.head != null)
         {
            this.head.stopMusic(true);
            this.removeHead();
         }
         this.head = param1;
         this.addHeadClipToHeadContainer(this.head.displayElement,this.displayElement);
      }
      
      public function getActionDefaultTotalFrame() : int
      {
         var _loc1_:CharThumb = null;
         if(this.action != null)
         {
            _loc1_ = this.thumb as CharThumb;
            if(_loc1_ != null && _loc1_.defaultAction != null && this.action.id == _loc1_.defaultAction.id)
            {
               return UtilUnitConvert.pixelToFrame(AnimeConstants.SCENE_LENGTH_DEFAULT);
            }
            return this.action.totalFrame;
         }
         return 1;
      }
      
      public function set actionId(param1:String) : void
      {
         this._actionId = param1;
      }
      
      internal function updateHeadSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.head != null)
         {
            try
            {
               this.head.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
               this.head.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function updatePropSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.prop != null)
         {
            try
            {
               this.prop.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
               this.prop.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
      }
      
      public function get shadowParent() : anifire.core.Character
      {
         return this._shadowParent;
      }
      
      override internal function doDragDrop(param1:DragEvent) : void
      {
         var colorSetId:String = null;
         var doDragDropAgain:Function = null;
         var extraData:Object = null;
         var loadMgr:UtilLoadMgr = null;
         var event:DragEvent = param1;
         var thumb:Object = event.dragSource.dataForFormat("thumb");
         colorSetId = "";
         if(event.dragSource.hasFormat("colorSetId"))
         {
            colorSetId = String(event.dragSource.dataForFormat("colorSetId"));
         }
         if(PropThumb(thumb).id.split(".")[0] == this.thumb.id)
         {
            this.removeHead();
            if(this._motionShadowChar != null)
            {
               this._motionShadowChar.removeHead();
            }
         }
         else if(!(PropThumb(thumb).headable && this.thumb.isCC))
         {
            if(PropThumb(thumb).isThumbReady())
            {
               this.doCheckBeforeAddProp(thumb,null,colorSetId);
            }
            else
            {
               doDragDropAgain = function(param1:LoadMgrEvent):void
               {
                  var _loc3_:Thumb = null;
                  var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
                  var _loc4_:Object;
                  _loc3_ = (_loc4_ = _loc2_.getExtraData())["thumb"];
                  colorSetId = _loc4_["colorSetId"];
                  doCheckBeforeAddProp(_loc3_,null,colorSetId);
               };
               extraData = new Object();
               extraData["thumb"] = thumb;
               extraData["colorSetId"] = colorSetId;
               loadMgr = new UtilLoadMgr();
               loadMgr.setExtraData(extraData);
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,doDragDropAgain);
               loadMgr.addEventDispatcher(PropThumb(thumb).eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               PropThumb(thumb).loadState();
               loadMgr.commit();
            }
         }
      }
      
      private function addPropClipToPropContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getProp(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getProp(_loc4_);
            }
            if(_loc5_ != null)
            {
               UtilPlain.removeAllSon(_loc5_);
               _loc5_.addChild(param1);
               this.updatePropSize(_loc5_);
            }
         }
      }
      
      public function get head() : anifire.core.Prop
      {
         return this._head;
      }
   }
}
