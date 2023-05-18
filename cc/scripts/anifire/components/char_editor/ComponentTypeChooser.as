package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcTheme;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcButtonBarEvent;
   import anifire.event.CcComponentTypeChooserEvent;
   import anifire.util.UtilColor;
   import caurina.transitions.Tweener;
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
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ComponentTypeChooser extends Canvas implements IBindingClient
   {
      
      private static var CAN_CURRENTICON:String = "currentIcon";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static var CAN_CIRCLE:String = "circle";
      
      private static var CAN_ICONIMAGE:String = "iconImage";
      
      private static var CAN_BG:String = "bg";
      
      private static var TRANSITION:String = "easeOut";
      
      private static var CAN_ICONNEXT:String = "iconNext";
      
      private static var CAN_ICONPREVIOUS:String = "iconPrevious";
       
      
      private var _1393249181btnbodyshape:Button;
      
      private var _1378804139btneye:Button;
      
      private var components:Array;
      
      private var _1727648727btnfacedecoration:Button;
      
      private var _206811198btnhair:Button;
      
      private var _549556649canMain:Canvas;
      
      private var _206040943btnNext:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _506036595btnPrevious:Button;
      
      private var _1549469518btnglasses:Button;
      
      private var _1378804870btnear:Button;
      
      private var _149828109btneyebrow:Button;
      
      private var _122760056btnfaceshape:Button;
      
      private var _1725816700btnmustache:Button;
      
      private var _2110750292btnbeard:Button;
      
      private var _1734943114btncomponentGroupClothes:Button;
      
      private var _774909011tagSteps:Button;
      
      mx_internal var _watchers:Array;
      
      private var currentComponentIndex:int;
      
      private var _1644785962canQuickBar:HBox;
      
      private var _94852023cover:Canvas;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _207003695btnnose:Button;
      
      private var _2121226219btnmouth:Button;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ComponentTypeChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":85,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnPrevious",
                           "events":{"click":"__btnPrevious_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"buttonBarLeft",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"canMain",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":76,
                                 "percentWidth":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "clipContent":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnNext",
                           "events":{"click":"__btnNext_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"buttonBarRight",
                                 "buttonMode":true
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"tagSteps",
                  "events":{
                     "mouseOver":"__tagSteps_mouseOver",
                     "mouseOut":"__tagSteps_mouseOut"
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnTypeChooserOpen",
                        "width":30,
                        "height":76
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "id":"canQuickBar",
                  "events":{"creationComplete":"__canQuickBar_creationComplete"},
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 12;
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":544,
                        "width":547,
                        "height":76,
                        "horizontalScrollPolicy":"off",
                        "visible":true,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnbodyshape",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnbodyshape"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btncomponentGroupClothes",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btncomponentGroupClothes"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnfaceshape",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnfaceshape"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnhair",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnhair"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btneye",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btneye"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btneyebrow",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btneyebrow"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnnose",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnnose"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnmustache",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnmustache"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnbeard",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnbeard"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnmouth",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnmouth"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnear",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnear"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnglasses",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnglasses"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnfacedecoration",
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnfacedecoration"};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"cover",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":3,
                        "height":76,
                        "x":544,
                        "y":0
                     };
                  }
               })]};
            }
         });
         this.components = new Array();
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 16711680;
            this.backgroundAlpha = 0;
         };
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___ComponentTypeChooser_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ComponentTypeChooser._watcherSetupUtil = param1;
      }
      
      private function prepare() : void
      {
         var _loc1_:Canvas = new Canvas();
         _loc1_.name = CAN_BG;
         _loc1_.graphics.clear();
         _loc1_.graphics.lineStyle();
         _loc1_.graphics.beginFill(10806267);
         _loc1_.graphics.drawRoundRect(0,0,this.canMain.width,43,15,15);
         _loc1_.graphics.endFill();
         _loc1_.y = (this.canMain.height - 43) / 2;
         this.canMain.addChild(_loc1_);
         var _loc2_:Canvas = new Canvas();
         _loc2_.name = CAN_CIRCLE;
         _loc2_.graphics.clear();
         _loc2_.graphics.lineStyle();
         _loc2_.graphics.beginFill(10806267);
         _loc2_.graphics.drawCircle(0,0,3.8);
         _loc2_.x = this.canMain.width / 2;
         _loc2_.y = this.canMain.height / 2;
         this.canMain.addChild(_loc2_);
         var _loc3_:Canvas = new Canvas();
         _loc3_.name = CAN_CURRENTICON;
         _loc3_.x = this.canMain.width / 2;
         _loc3_.y = this.canMain.height / 2;
         _loc3_.clipContent = false;
         UtilColor.setRGB(_loc3_,16488452);
         var _loc4_:Canvas;
         (_loc4_ = new Canvas()).name = CAN_ICONIMAGE;
         _loc4_.width = _loc4_.height = 76;
         _loc4_.x = _loc4_.y = -38;
         _loc3_.addChild(_loc4_);
         this.canMain.addChild(_loc3_);
         var _loc5_:Canvas;
         (_loc5_ = new Canvas()).name = CAN_ICONPREVIOUS;
         _loc5_.clipContent = false;
         _loc5_.width = _loc5_.height = 60;
         _loc5_.scaleX = _loc5_.scaleY = 0.8;
         _loc5_.x = _loc5_.y = 14;
         _loc5_.useHandCursor = true;
         _loc5_.buttonMode = true;
         _loc5_.addEventListener(MouseEvent.CLICK,this.onBtnClick);
         this.canMain.addChild(_loc5_);
         var _loc6_:Canvas;
         (_loc6_ = new Canvas()).name = CAN_ICONNEXT;
         _loc6_.clipContent = false;
         _loc6_.width = _loc6_.height = 60;
         _loc6_.scaleX = _loc6_.scaleY = 0.8;
         _loc6_.x = this.canMain.width - _loc6_.width;
         _loc6_.y = 14;
         _loc6_.useHandCursor = true;
         _loc6_.buttonMode = true;
         _loc6_.addEventListener(MouseEvent.CLICK,this.onBtnClick);
         this.canMain.addChild(_loc6_);
         var _loc7_:GlowFilter = new GlowFilter(16777215);
         var _loc8_:Array;
         (_loc8_ = new Array()).push(_loc7_);
         this.canMain.filters = _loc8_;
      }
      
      public function set btnmustache(param1:Button) : void
      {
         var _loc2_:Object = this._1725816700btnmustache;
         if(_loc2_ !== param1)
         {
            this._1725816700btnmustache = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnmustache",_loc2_,param1));
         }
      }
      
      private function tellEverybodyComponentTypeChosen(param1:String) : void
      {
         var _loc2_:CcComponentTypeChooserEvent = new CcComponentTypeChooserEvent(CcComponentTypeChooserEvent.COMPONENT_TYPE_CHOSEN,this);
         _loc2_.componentType = param1;
         this.dispatchEvent(_loc2_);
      }
      
      [Bindable(event="propertyChange")]
      public function get btneyebrow() : Button
      {
         return this._149828109btneyebrow;
      }
      
      public function init(param1:CcTheme, param2:Boolean = true) : void
      {
         this.components = new Array();
         var _loc3_:Array = CcLibConstant.COMPONENT_TYPE_CHOOSER_ORDERING;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(CcLibConstant.COMPONENT_TYPE_CHOOSER_COMPONENT_GROUP.indexOf(_loc3_[_loc4_]) >= 0 || param1.getAvailableComponentTypes().indexOf(_loc3_[_loc4_]) > -1)
            {
               this.components.push(_loc3_[_loc4_]);
            }
            _loc4_++;
         }
         trace("components:" + this.components);
         this.currentComponentIndex = 0;
         this.switchToComponentType(this.components[this.currentComponentIndex],param2);
      }
      
      private function doMouseUp(param1:Event) : void
      {
         var _loc2_:Button = param1.currentTarget as Button;
         var _loc3_:String = String(_loc2_.id.substring(3));
         this.currentComponentIndex = this.components.indexOf(_loc3_);
         this.switchToComponentType(this.components[this.currentComponentIndex]);
      }
      
      public function set btnfaceshape(param1:Button) : void
      {
         var _loc2_:Object = this._122760056btnfaceshape;
         if(_loc2_ !== param1)
         {
            this._122760056btnfaceshape = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnfaceshape",_loc2_,param1));
         }
      }
      
      public function set btneyebrow(param1:Button) : void
      {
         var _loc2_:Object = this._149828109btneyebrow;
         if(_loc2_ !== param1)
         {
            this._149828109btneyebrow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btneyebrow",_loc2_,param1));
         }
      }
      
      private function doMouseOut(param1:Event) : void
      {
         var _loc2_:Button = param1.currentTarget as Button;
         UtilColor.setRGB(_loc2_,16777215);
      }
      
      public function set btncomponentGroupClothes(param1:Button) : void
      {
         var _loc2_:Object = this._1734943114btncomponentGroupClothes;
         if(_loc2_ !== param1)
         {
            this._1734943114btncomponentGroupClothes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btncomponentGroupClothes",_loc2_,param1));
         }
      }
      
      private function initQuickBar() : void
      {
         var _loc4_:Button = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.canQuickBar.numChildren)
         {
            (_loc4_ = this.canQuickBar.getChildAt(_loc1_) as Button).addEventListener(MouseEvent.MOUSE_OVER,this.doMouseOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.doMouseOut);
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.doMouseUp);
            _loc4_.buttonMode = true;
            _loc4_.scaleX = _loc4_.scaleY = 0.8;
            _loc1_++;
         }
         this.canQuickBar.y = (this.canQuickBar.parent.height - this.canQuickBar.height) / 2;
         this.canQuickBar.graphics.clear();
         this.canQuickBar.graphics.lineStyle();
         this.canQuickBar.graphics.beginFill(10806267);
         this.canQuickBar.graphics.drawRoundRect(0,0,this.canQuickBar.width,this.canQuickBar.height,15,15);
         this.canQuickBar.graphics.endFill();
         var _loc2_:GlowFilter = new GlowFilter(16777215);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         this.canQuickBar.filters = _loc3_;
         this.canQuickBar.addEventListener(MouseEvent.MOUSE_OUT,this.doQuickBarOut);
      }
      
      [Bindable(event="propertyChange")]
      public function get btnfacedecoration() : Button
      {
         return this._1727648727btnfacedecoration;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnnose() : Button
      {
         return this._207003695btnnose;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnhair() : Button
      {
         return this._206811198btnhair;
      }
      
      public function ___ComponentTypeChooser_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.prepare();
      }
      
      public function switchToComponentType(param1:String = "", param2:Boolean = true) : void
      {
         var _loc3_:Canvas = Canvas(this.canMain.getChildByName(CAN_CURRENTICON));
         var _loc4_:Canvas;
         (_loc4_ = Canvas(_loc3_.getChildByName(CAN_ICONIMAGE))).styleName = "icon" + param1.replace("_","");
         _loc3_.scaleX = _loc3_.scaleY = 1.2;
         Tweener.addTween(_loc3_,{
            "scaleX":1.8,
            "scaleY":1.8,
            "time":0.4,
            "transition":TRANSITION
         });
         this.currentComponentIndex = this.components.indexOf(param1);
         var _loc5_:Canvas = Canvas(this.canMain.getChildByName(CAN_ICONPREVIOUS));
         var _loc6_:Canvas = Canvas(this.canMain.getChildByName(CAN_ICONNEXT));
         if(this.components.indexOf(param1) == 0)
         {
            this.btnPrevious.visible = false;
            _loc5_.visible = false;
         }
         else
         {
            this.btnPrevious.visible = true;
            _loc5_.visible = true;
            _loc5_.styleName = "icon" + String(this.components[this.currentComponentIndex - 1]).replace("_","");
            _loc5_.alpha = 0.5;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "time":0.2
            });
         }
         if(this.components.indexOf(param1) == this.components.length - 1)
         {
            this.btnNext.styleName = "buttonBarRightSave";
            _loc6_.visible = false;
         }
         else
         {
            this.btnNext.styleName = "buttonBarRight";
            _loc6_.visible = true;
            _loc6_.styleName = "icon" + String(this.components[this.currentComponentIndex + 1]).replace("_","");
            _loc6_.alpha = 0.5;
            Tweener.addTween(_loc6_,{
               "alpha":1,
               "time":0.2
            });
         }
         var _loc7_:Canvas;
         (_loc7_ = Canvas(this.canMain.getChildByName(CAN_CIRCLE))).scaleX = 10;
         _loc7_.scaleY = 5;
         Tweener.addTween(_loc7_,{
            "scaleX":20,
            "scaleY":10,
            "time":0.4,
            "transition":TRANSITION
         });
         if(param2)
         {
            this.callLater(this.toCallLater,[param1]);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnglasses() : Button
      {
         return this._1549469518btnglasses;
      }
      
      public function set btnfacedecoration(param1:Button) : void
      {
         var _loc2_:Object = this._1727648727btnfacedecoration;
         if(_loc2_ !== param1)
         {
            this._1727648727btnfacedecoration = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnfacedecoration",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnbeard() : Button
      {
         return this._2110750292btnbeard;
      }
      
      [Bindable(event="propertyChange")]
      public function get btneye() : Button
      {
         return this._1378804139btneye;
      }
      
      public function set btnnose(param1:Button) : void
      {
         var _loc2_:Object = this._207003695btnnose;
         if(_loc2_ !== param1)
         {
            this._207003695btnnose = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnnose",_loc2_,param1));
         }
      }
      
      public function __canQuickBar_creationComplete(param1:FlexEvent) : void
      {
         this.initQuickBar();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnbodyshape() : Button
      {
         return this._1393249181btnbodyshape;
      }
      
      public function set tagSteps(param1:Button) : void
      {
         var _loc2_:Object = this._774909011tagSteps;
         if(_loc2_ !== param1)
         {
            this._774909011tagSteps = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tagSteps",_loc2_,param1));
         }
      }
      
      public function set canMain(param1:Canvas) : void
      {
         var _loc2_:Object = this._549556649canMain;
         if(_loc2_ !== param1)
         {
            this._549556649canMain = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canMain",_loc2_,param1));
         }
      }
      
      public function set cover(param1:Canvas) : void
      {
         var _loc2_:Object = this._94852023cover;
         if(_loc2_ !== param1)
         {
            this._94852023cover = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cover",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnNext() : Button
      {
         return this._206040943btnNext;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnPrevious() : Button
      {
         return this._506036595btnPrevious;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnear() : Button
      {
         return this._1378804870btnear;
      }
      
      public function set btnhair(param1:Button) : void
      {
         var _loc2_:Object = this._206811198btnhair;
         if(_loc2_ !== param1)
         {
            this._206811198btnhair = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnhair",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnmustache() : Button
      {
         return this._1725816700btnmustache;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnfaceshape() : Button
      {
         return this._122760056btnfaceshape;
      }
      
      private function onBtnClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.currentTarget == this.btnPrevious || param1.currentTarget is Canvas && Canvas(param1.currentTarget).name == CAN_ICONPREVIOUS)
         {
            _loc2_ = this.currentComponentIndex - 1;
         }
         else if(param1.currentTarget == this.btnNext || param1.currentTarget is Canvas && Canvas(param1.currentTarget).name == CAN_ICONNEXT)
         {
            _loc2_ = this.currentComponentIndex + 1;
         }
         if(_loc2_ >= this.components.length)
         {
            this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.SAVE_BUTTON_CLICK,this));
         }
         else
         {
            this.switchToComponentType(this.components[_loc2_]);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btncomponentGroupClothes() : Button
      {
         return this._1734943114btncomponentGroupClothes;
      }
      
      private function toCallLater(param1:String) : void
      {
         this.callLater(this.tellEverybodyComponentTypeChosen,[param1]);
      }
      
      private function doQuickBarIn() : void
      {
         Tweener.addTween(this.canQuickBar,{
            "x":-3,
            "time":1
         });
         this.tagSteps.styleName = "btnTypeChooserClose";
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ComponentTypeChooser = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ComponentTypeChooser_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_ComponentTypeChooserWatcherSetupUtil");
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
      
      public function set btnglasses(param1:Button) : void
      {
         var _loc2_:Object = this._1549469518btnglasses;
         if(_loc2_ !== param1)
         {
            this._1549469518btnglasses = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnglasses",_loc2_,param1));
         }
      }
      
      public function set btnbeard(param1:Button) : void
      {
         var _loc2_:Object = this._2110750292btnbeard;
         if(_loc2_ !== param1)
         {
            this._2110750292btnbeard = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnbeard",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canMain() : Canvas
      {
         return this._549556649canMain;
      }
      
      public function set btneye(param1:Button) : void
      {
         var _loc2_:Object = this._1378804139btneye;
         if(_loc2_ !== param1)
         {
            this._1378804139btneye = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btneye",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tagSteps() : Button
      {
         return this._774909011tagSteps;
      }
      
      private function _ComponentTypeChooser_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return canQuickBar.x - tagSteps.width + 2;
         },function(param1:Number):void
         {
            tagSteps.x = param1;
         },"tagSteps.x");
         result[0] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get cover() : Canvas
      {
         return this._94852023cover;
      }
      
      public function set canQuickBar(param1:HBox) : void
      {
         var _loc2_:Object = this._1644785962canQuickBar;
         if(_loc2_ !== param1)
         {
            this._1644785962canQuickBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canQuickBar",_loc2_,param1));
         }
      }
      
      public function set btnbodyshape(param1:Button) : void
      {
         var _loc2_:Object = this._1393249181btnbodyshape;
         if(_loc2_ !== param1)
         {
            this._1393249181btnbodyshape = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnbodyshape",_loc2_,param1));
         }
      }
      
      private function doMouseOver(param1:Event) : void
      {
         var _loc2_:Button = param1.currentTarget as Button;
         UtilColor.setRGB(_loc2_,16488452);
      }
      
      public function __tagSteps_mouseOut(param1:MouseEvent) : void
      {
         this.doQuickBarOut(param1);
      }
      
      public function __btnPrevious_click(param1:MouseEvent) : void
      {
         this.onBtnClick(param1);
      }
      
      public function set btnmouth(param1:Button) : void
      {
         var _loc2_:Object = this._2121226219btnmouth;
         if(_loc2_ !== param1)
         {
            this._2121226219btnmouth = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnmouth",_loc2_,param1));
         }
      }
      
      public function set btnNext(param1:Button) : void
      {
         var _loc2_:Object = this._206040943btnNext;
         if(_loc2_ !== param1)
         {
            this._206040943btnNext = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnNext",_loc2_,param1));
         }
      }
      
      public function __btnNext_click(param1:MouseEvent) : void
      {
         this.onBtnClick(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get canQuickBar() : HBox
      {
         return this._1644785962canQuickBar;
      }
      
      public function set btnPrevious(param1:Button) : void
      {
         var _loc2_:Object = this._506036595btnPrevious;
         if(_loc2_ !== param1)
         {
            this._506036595btnPrevious = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnPrevious",_loc2_,param1));
         }
      }
      
      public function __tagSteps_mouseOver(param1:MouseEvent) : void
      {
         this.doQuickBarIn();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnmouth() : Button
      {
         return this._2121226219btnmouth;
      }
      
      public function set btnear(param1:Button) : void
      {
         var _loc2_:Object = this._1378804870btnear;
         if(_loc2_ !== param1)
         {
            this._1378804870btnear = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnear",_loc2_,param1));
         }
      }
      
      private function _ComponentTypeChooser_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.canQuickBar.x - this.tagSteps.width + 2;
      }
      
      private function doQuickBarOut(param1:Event) : void
      {
         if(!(this.canQuickBar.width >= this.canQuickBar.mouseX && this.canQuickBar.mouseX >= 0 && this.canQuickBar.height - 2 >= this.canQuickBar.mouseY && this.canQuickBar.mouseY >= 0))
         {
            Tweener.addTween(this.canQuickBar,{
               "x":this.canQuickBar.width - 3,
               "time":1
            });
            this.tagSteps.styleName = "btnTypeChooserOpen";
         }
      }
   }
}
