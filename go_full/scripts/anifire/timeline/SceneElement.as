package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.event.ExtraDataEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilUnitConvert;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.controls.Alert;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.ToolTip;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.easing.*;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.CursorManager;
   import mx.managers.ToolTipManager;
   import mx.styles.*;
   
   public class SceneElement extends Canvas implements ITimelineElement, IBindingClient
   {
      
      private static const FILTER_SELECTED:GlowFilter = new GlowFilter(16750899,1,3,3,5,1,false,false);
      
      private static const MENU_LABEL_SCENE_LENGTH:String = "timeline_duration";
      
      private static const MENU_LABEL_PASTE_BEFORE:String = "timeline_insertbefore";
      
      private static const MENU_LABEL_DELETE:String = "timeline_delete";
      
      private static const COLOR_SELECTED:String = "0x000000";
      
      private static const SELECTED:int = 0;
      
      private static const MENU_LABEL_PASTE_AFTER:String = "timeline_insertafter";
      
      private static const MENU_LABEL_COPY:String = "timeline_copy";
      
      private static const MENU_LABEL_CLEAR:String = "timeline_clear";
      
      private static const FILTER_UNSELECTED:GlowFilter = new GlowFilter(0,1,3,3,5,1,false,false);
      
      private static const MENU_LABEL_SCENE_LENGTH_INPUT:String = "Enter your own";
      
      private static const COLOR_UNSELECTED:String = "0xAAB3B3";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const UNSELECTED:int = 1;
      
      private static const MENU_LABEL_SCENE_LENGTH_2:String = "timeline_2sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_3:String = "timeline_3sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_4:String = "timeline_4sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_1:String = "timeline_1sec";
       
      
      public const LABEL_COLOR:Number = 0;
      
      private var _bitmapData:BitmapData;
      
      private var _1436079757right_cs:Canvas;
      
      private var _977672194ArrowIcon:Class;
      
      private var _prop:Object;
      
      private var _98309cce:Fade;
      
      private var _motionTime:Number = 0;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1729673616scene_img:Image;
      
      private var _bitmap:Bitmap;
      
      private var _1729676163scene_lbl:Label;
      
      private var _1280011162arrow_cs:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _timelineControl:anifire.timeline.Timeline = null;
      
      private var _indicator:ToolTip;
      
      private var _id:String;
      
      private var isResizing:Boolean = false;
      
      private var _currItem:anifire.timeline.SceneElement;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _focus:Boolean = false;
      
      private var _55443368left_cs:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var cursorID:int;
      
      private var E_Symbol:Class;
      
      private var _label:String = "Blank";
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SceneElement()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":300,
                  "height":52,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"left_cs",
                     "events":{"resize":"__left_cs_resize"},
                     "stylesFactory":function():void
                     {
                        this.left = "2";
                        this.verticalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":50,
                           "percentHeight":100,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"right_cs",
                     "events":{"resize":"__right_cs_resize"},
                     "stylesFactory":function():void
                     {
                        this.right = "2";
                        this.verticalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":50,
                           "percentHeight":100,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Image,
                     "id":"scene_img",
                     "events":{"creationComplete":"__scene_img_creationComplete"},
                     "stylesFactory":function():void
                     {
                        this.horizontalCenter = "0";
                        this.verticalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "maintainAspectRatio":false,
                           "width":76,
                           "height":51
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"scene_lbl",
                     "events":{"creationComplete":"__scene_lbl_creationComplete"},
                     "stylesFactory":function():void
                     {
                        this.horizontalCenter = "0";
                        this.bottom = "4";
                        this.textAlign = "center";
                        this.fontWeight = "bold";
                        this.fontSize = 40;
                        this.verticalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "selectable":false,
                           "buttonMode":true,
                           "useHandCursor":true,
                           "mouseChildren":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"arrow_cs",
                     "events":{
                        "rollOver":"__arrow_cs_rollOver",
                        "rollOut":"__arrow_cs_rollOut",
                        "mouseDown":"__arrow_cs_mouseDown"
                     },
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.right = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "alpha":0,
                           "width":10,
                           "percentHeight":100
                        };
                     }
                  })]
               };
            }
         });
         this._977672194ArrowIcon = SceneElement_ArrowIcon;
         this.E_Symbol = SceneElement_E_Symbol;
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.width = 300;
         this.height = 52;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._SceneElement_Fade1_i();
         this.addEventListener("creationComplete",this.___SceneElement_Canvas1_creationComplete);
         this.addEventListener("mouseDown",this.___SceneElement_Canvas1_mouseDown);
         this.addEventListener("mouseUp",this.___SceneElement_Canvas1_mouseUp);
         this.addEventListener("mouseOver",this.___SceneElement_Canvas1_mouseOver);
         this.addEventListener("mouseOut",this.___SceneElement_Canvas1_mouseOut);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         anifire.timeline.SceneElement._watcherSetupUtil = param1;
      }
      
      private function set ArrowIcon(param1:Class) : void
      {
         var _loc2_:Object = this._977672194ArrowIcon;
         if(_loc2_ !== param1)
         {
            this._977672194ArrowIcon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ArrowIcon",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cce() : Fade
      {
         return this._98309cce;
      }
      
      public function set scene_lbl(param1:Label) : void
      {
         var _loc2_:Object = this._1729676163scene_lbl;
         if(_loc2_ !== param1)
         {
            this._1729676163scene_lbl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_lbl",_loc2_,param1));
         }
      }
      
      private function _SceneElement_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.cce;
         _loc1_ = data.label;
      }
      
      public function set cce(param1:Fade) : void
      {
         var _loc2_:Object = this._98309cce;
         if(_loc2_ !== param1)
         {
            this._98309cce = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cce",_loc2_,param1));
         }
      }
      
      public function __left_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("left");
      }
      
      [Bindable(event="propertyChange")]
      private function get ArrowIcon() : Class
      {
         return this._977672194ArrowIcon;
      }
      
      public function updateImage(param1:BitmapData) : void
      {
         this.scene_img.source = new Bitmap(param1);
      }
      
      override public function get id() : String
      {
         return this._id;
      }
      
      private function doMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:XML = XML(param1.item);
         var _loc3_:Number = Number(this.width);
         var _loc4_:Number = _loc3_;
         switch(_loc2_.attribute("value").toString())
         {
            case MENU_LABEL_SCENE_LENGTH_1:
               _loc4_ = 1 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_2:
               _loc4_ = 2 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_3:
               _loc4_ = 3 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_4:
               _loc4_ = 4 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_INPUT:
               Alert.show("Input here:");
               break;
            case MENU_LABEL_COPY:
               Console.getConsole().copyScene();
               break;
            case MENU_LABEL_DELETE:
               Console.getConsole().doDeleScene();
               break;
            case MENU_LABEL_CLEAR:
               Console.getConsole().doClearScene();
               break;
            case MENU_LABEL_PASTE_BEFORE:
               Console.getConsole().pasteScene(0);
               break;
            case MENU_LABEL_PASTE_AFTER:
               Console.getConsole().pasteScene();
         }
         if(_loc3_ != _loc4_)
         {
            _loc4_ = Math.floor(_loc4_);
            this._timelineControl.updateSceneLength(_loc4_,int(this.id),true);
            this._timelineControl.doPatchSceneResizeComplete(int(this.id));
         }
      }
      
      public function get actionTime() : Number
      {
         return this.totalTime - this.motionTime;
      }
      
      private function drawArrow(param1:String) : void
      {
         var _loc2_:Canvas = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = height / 2;
         if(param1 == "left")
         {
            _loc2_ = this.left_cs;
            _loc3_ = 5;
            _loc4_ = 180;
         }
         else
         {
            _loc2_ = this.right_cs;
            _loc3_ = this.right_cs.width - 5;
            _loc4_ = 0;
         }
         _loc2_.graphics.clear();
         if(width > this.scene_img.width + 6)
         {
            _loc2_.graphics.beginFill(6710886);
            _loc2_.graphics.lineStyle(0,6710886);
            UtilDraw.drawPoly(_loc2_,_loc3_,_loc5_,3,5,_loc4_);
            _loc2_.graphics.moveTo(0,_loc5_);
            _loc2_.graphics.lineTo(_loc2_.width,_loc5_);
            _loc2_.graphics.endFill();
         }
      }
      
      [Bindable(event="dataChange")]
      public function get source() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function __arrow_cs_mouseDown(param1:MouseEvent) : void
      {
         this.enableDragScene(param1);
      }
      
      public function __right_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("right");
      }
      
      public function get totalTime() : Number
      {
         return width;
      }
      
      override public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function set scene_img(param1:Image) : void
      {
         var _loc2_:Object = this._1729673616scene_img;
         if(_loc2_ !== param1)
         {
            this._1729673616scene_img = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_img",_loc2_,param1));
         }
      }
      
      private function _SceneElement_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return cce;
         },function(param1:*):void
         {
            this.setStyle("creationCompleteEffect",param1);
         },"this.creationCompleteEffect");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.label;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            scene_lbl.text = param1;
         },"scene_lbl.text");
         result[1] = binding;
         return result;
      }
      
      private function getLabel(param1:Number = -1, param2:Number = -1) : String
      {
         param1 = param1 < 0 ? Number(x) : param1;
         param2 = param2 < 0 ? Number(width) : param2;
         var _loc3_:Number = Math.round(UtilUnitConvert.pixelToSec(param1) * 100) / 100;
         var _loc4_:Number = Math.round(UtilUnitConvert.pixelToSec(param2) * 100) / 100;
         return "[" + UtilDict.toDisplay("go","timeline_starttime") + ": " + _loc3_ + ", " + UtilDict.toDisplay("go","timeline_duration") + ": " + _loc4_ + "]";
      }
      
      public function set motionTime(param1:Number) : void
      {
         this._motionTime = param1;
      }
      
      public function ___SceneElement_Canvas1_mouseUp(param1:MouseEvent) : void
      {
         this.onMouseUpHandler(param1);
      }
      
      public function ___SceneElement_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      private function _SceneElement_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.cce = _loc1_;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 300;
         return _loc1_;
      }
      
      public function set left_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._55443368left_cs;
         if(_loc2_ !== param1)
         {
            this._55443368left_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"left_cs",_loc2_,param1));
         }
      }
      
      public function __scene_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showLabel();
      }
      
      public function get startTime() : Number
      {
         return x;
      }
      
      public function set source(param1:BitmapData) : void
      {
         this._bitmapData = param1;
         this.showImage();
         dispatchEvent(new Event("dataChange"));
      }
      
      private function getSceneGlobalPosition() : Point
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         _loc1_ = parent.localToGlobal(new Point(x,y));
         if(this._timelineControl != null)
         {
            _loc2_ = this._timelineControl.scene_vb.localToGlobal(new Point(0,0));
            if(_loc1_.x <= _loc2_.x)
            {
               _loc1_.x = _loc2_.x;
            }
         }
         return _loc1_;
      }
      
      [Bindable(event="dataChange")]
      public function get prop() : Object
      {
         return this._prop;
      }
      
      private function showImage() : void
      {
         try
         {
            this._bitmap = new Bitmap(this._bitmapData);
            this.scene_img.source = this._bitmap;
         }
         catch(e:Error)
         {
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_cs() : Canvas
      {
         return this._1280011162arrow_cs;
      }
      
      private function changeArrowCurosr(param1:Boolean) : void
      {
         if(!this.isResizing)
         {
            if(param1)
            {
               this.cursorID = CursorManager.setCursor(this.ArrowIcon,3,-10.5,-6);
            }
            else
            {
               CursorManager.removeCursor(this.cursorID);
            }
         }
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._currItem = param1.currentTarget as anifire.timeline.SceneElement;
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.showIndicator();
      }
      
      private function setState(param1:int) : void
      {
         if(param1 == SELECTED)
         {
            this.scene_lbl.setStyle("color",COLOR_SELECTED);
            this.scene_lbl.filters = [FILTER_SELECTED];
            this.scene_lbl.setStyle("fontSize",54);
         }
         else if(param1 == UNSELECTED)
         {
            this.scene_lbl.setStyle("color",COLOR_UNSELECTED);
            this.scene_lbl.filters = [FILTER_UNSELECTED];
            this.scene_lbl.setStyle("fontSize",32);
         }
      }
      
      private function createIndicator(param1:Number, param2:Number) : ToolTip
      {
         var _loc3_:String = this.getLabel();
         var _loc4_:ToolTip;
         (_loc4_ = ToolTipManager.createToolTip(_loc3_,param1,param2) as ToolTip).setStyle("backgroundColor",16763904);
         return _loc4_;
      }
      
      private function enableDragScene(param1:MouseEvent) : void
      {
         this.isResizing = true;
         this.dispatchEvent(new ExtraDataEvent("ArrowClick",this,param1));
      }
      
      [Bindable(event="propertyChange")]
      public function get right_cs() : Canvas
      {
         return this._1436079757right_cs;
      }
      
      public function ___SceneElement_Canvas1_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOutHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_lbl() : Label
      {
         return this._1729676163scene_lbl;
      }
      
      public function ___SceneElement_Canvas1_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function showIndicator(param1:Number = -1, param2:Number = -1) : void
      {
         var _loc3_:Point = this.getSceneGlobalPosition();
         if(this._indicator == null)
         {
            this._indicator = this.createIndicator(_loc3_.x,_loc3_.y);
         }
         this._indicator.x = _loc3_.x;
         this._indicator.y = _loc3_.y - this._indicator.height;
         this._indicator.text = this.getLabel(param1,param2);
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:anifire.timeline.SceneElement = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._SceneElement_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SceneElementWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      public function __arrow_cs_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function get motionTime() : Number
      {
         return this._motionTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get left_cs() : Canvas
      {
         return this._55443368left_cs;
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
         if(this._focus)
         {
            styleName = "elementClicked";
            this.setState(SELECTED);
         }
         else
         {
            styleName = "elementNormal";
            this.setState(UNSELECTED);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_img() : Image
      {
         return this._1729673616scene_img;
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(!this._focus)
         {
            styleName = "elementNormal";
         }
      }
      
      public function ___SceneElement_Canvas1_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOverHandler(param1);
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(this.isResizing)
         {
            this.isResizing = false;
            CursorManager.removeCursor(this.cursorID);
         }
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            this.removeIndicator();
         }
      }
      
      public function __arrow_cs_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function set prop(param1:Object) : void
      {
         this._prop = param1;
         dispatchEvent(new Event("dataChange"));
      }
      
      public function set arrow_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1280011162arrow_cs;
         if(_loc2_ !== param1)
         {
            this._1280011162arrow_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_cs",_loc2_,param1));
         }
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(Console.getConsole().timeline == null)
         {
            return null;
         }
         return Canvas(Console.getConsole().timeline);
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function set right_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1436079757right_cs;
         if(_loc2_ !== param1)
         {
            this._1436079757right_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"right_cs",_loc2_,param1));
         }
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showLabel();
         dispatchEvent(new Event("dataChange"));
      }
      
      public function setTimelineReferer(param1:anifire.timeline.Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function removeIndicator() : void
      {
         if(this._indicator != null)
         {
            ToolTipManager.destroyToolTip(this._indicator);
            this._indicator = null;
         }
      }
      
      public function __scene_img_creationComplete(param1:FlexEvent) : void
      {
         this.showImage();
      }
      
      [Bindable(event="dataChange")]
      override public function get label() : String
      {
         return this._label;
      }
      
      private function showLabel() : void
      {
         try
         {
            this.scene_lbl.text = this._label;
         }
         catch(e:Error)
         {
         }
      }
      
      private function initApp() : void
      {
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         var _loc6_:String = Console.getConsole().copySceneData != "" ? "true" : "false";
         _loc3_ = "<root>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_COPY) + "\" value=\"" + MENU_LABEL_COPY + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_BEFORE) + "\" value=\"" + MENU_LABEL_PASTE_BEFORE + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_AFTER) + "\" value=\"" + MENU_LABEL_PASTE_AFTER + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_DELETE) + "\" value=\"" + MENU_LABEL_DELETE + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_CLEAR) + "\" value=\"" + MENU_LABEL_CLEAR + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH + "\" >" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_1) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_1 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_2) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_2 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_3) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_3 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_4) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_4 + "\" />" + "</menuItem>" + "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).setParentObject(this.getSceneCanvas());
         _loc5_.labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc5_.arrowScrollPolicy = ScrollPolicy.OFF;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         _loc7_ = 120;
         _loc8_ = 158;
         var _loc9_:Canvas;
         var _loc10_:Point = (_loc9_ = this.getSceneCanvas()).localToGlobal(new Point(0,0));
         var _loc11_:Number = param1;
         var _loc12_:Number = param2 - 90;
         if(_loc11_ + _loc7_ > _loc10_.x + _loc9_.width)
         {
            _loc11_ = _loc10_.x + _loc9_.width - _loc7_;
         }
         if(_loc12_ + _loc8_ > _loc10_.y + _loc9_.height)
         {
            _loc12_ = _loc10_.y + _loc9_.height - _loc8_;
         }
         _loc5_.show(_loc11_,_loc12_);
         this._timelineControl.doPatchSceneResizeStart(int(this.id));
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this._focus)
         {
            styleName = "elementOver";
         }
      }
   }
}
