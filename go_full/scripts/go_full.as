package
{
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.GoWalker;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TopButtonBar;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.timeline.Timeline;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilNetwork;
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
   import mx.controls.ProgressBar;
   import mx.controls.SWFLoader;
   import mx.core.Application;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class go_full extends Application
   {
      
      mx_internal static var _go_full_StylesInit_done:Boolean = false;
       
      
      private var _1820782830_loadProgress:ProgressBar;
      
      public var _console:Console;
      
      private var _1523657885_goWalker:GoWalker;
      
      private var _427053173_topButtonBar:TopButtonBar;
      
      private var _736875266_inspirationloader:SWFLoader;
      
      private var _1490827770_effectTray:EffectTray;
      
      private var _159139667_thumbTray:ThumbTray;
      
      private var _1751026874_mainStage:MainStage;
      
      private var _1149811839_screenCapTool:ScreenCapTool;
      
      private var _619629449_overTray:OverTray;
      
      private var _1592971130_tipsLayer:Canvas;
      
      private var _1576763286_swfloader:SWFLoader;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1986132576_timeline:Timeline;
      
      public function go_full()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function():Object
            {
               return {
                  "width":954,
                  "height":629,
                  "creationPolicy":"none",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Timeline,
                     "id":"_timeline",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":1,
                           "y":470,
                           "styleName":"timeLine",
                           "width":951
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MainStage,
                     "id":"_mainStage",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":306,
                           "y":42,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ThumbTray,
                     "id":"_thumbTray",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":4,
                           "y":0,
                           "height":513,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":OverTray,
                     "id":"_overTray",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":4,
                           "y":40
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TopButtonBar,
                     "id":"_topButtonBar",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":598,
                           "y":0,
                           "width":358,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":EffectTray,
                     "id":"_effectTray",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":903,
                           "y":68
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ProgressBar,
                     "id":"_loadProgress",
                     "events":{"creationComplete":"___loadProgress_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"progressbar",
                           "labelPlacement":"center",
                           "enabled":true,
                           "mode":"manual",
                           "x":633,
                           "y":45,
                           "width":271,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ScreenCapTool,
                     "id":"_screenCapTool",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GoWalker,
                     "id":"_goWalker",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_tipsLayer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":SWFLoader,
                     "id":"_swfloader",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentHeight":100,
                           "percentWidth":100,
                           "visible":false,
                           "autoLoad":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":SWFLoader,
                     "id":"_inspirationloader",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentHeight":100,
                           "percentWidth":100,
                           "visible":false,
                           "autoLoad":false
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundGradientAlphas = [1,1];
            this.backgroundGradientColors = [16777215,16777215];
         };
         mx_internal::_go_full_StylesInit();
         this.layout = "absolute";
         this.width = 954;
         this.height = 629;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "wholeApplication";
         this.creationPolicy = "none";
         this.addEventListener("preinitialize",this.___go_full_Application1_preinitialize);
         this.addEventListener("applicationComplete",this.___go_full_Application1_applicationComplete);
         this.addEventListener("addedToStage",this.___go_full_Application1_addedToStage);
      }
      
      public function ___go_full_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.initialConsole();
      }
      
      public function set _screenCapTool(param1:ScreenCapTool) : void
      {
         var _loc2_:Object = this._1149811839_screenCapTool;
         if(_loc2_ !== param1)
         {
            this._1149811839_screenCapTool = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_screenCapTool",_loc2_,param1));
         }
      }
      
      public function ___go_full_Application1_addedToStage(param1:Event) : void
      {
         this.resetFrameRate();
      }
      
      private function loadClientLocale() : void
      {
         Util.loadClientLocale("go",this.onClientLocaleComplete);
      }
      
      public function set _effectTray(param1:EffectTray) : void
      {
         var _loc2_:Object = this._1490827770_effectTray;
         if(_loc2_ !== param1)
         {
            this._1490827770_effectTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectTray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectTray() : EffectTray
      {
         return this._1490827770_effectTray;
      }
      
      public function set _mainStage(param1:MainStage) : void
      {
         var _loc2_:Object = this._1751026874_mainStage;
         if(_loc2_ !== param1)
         {
            this._1751026874_mainStage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainStage",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _swfloader() : SWFLoader
      {
         return this._1576763286_swfloader;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get _loadProgress() : ProgressBar
      {
         return this._1820782830_loadProgress;
      }
      
      [Bindable(event="propertyChange")]
      public function get _topButtonBar() : TopButtonBar
      {
         return this._427053173_topButtonBar;
      }
      
      [Bindable(event="propertyChange")]
      public function get _goWalker() : GoWalker
      {
         return this._1523657885_goWalker;
      }
      
      [Bindable(event="propertyChange")]
      public function get _timeline() : Timeline
      {
         return this._1986132576_timeline;
      }
      
      [Bindable(event="propertyChange")]
      public function get _overTray() : OverTray
      {
         return this._619629449_overTray;
      }
      
      public function set _loadProgress(param1:ProgressBar) : void
      {
         var _loc2_:Object = this._1820782830_loadProgress;
         if(_loc2_ !== param1)
         {
            this._1820782830_loadProgress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loadProgress",_loc2_,param1));
         }
      }
      
      public function ___loadProgress_creationComplete(param1:FlexEvent) : void
      {
         this._loadProgress.label = UtilDict.toDisplay("go","loading");
      }
      
      mx_internal function _go_full_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_go_full_StylesInit_done)
         {
            return;
         }
         mx_internal::_go_full_StylesInit_done = true;
         StyleManager.mx_internal::initProtoChainRoots();
      }
      
      public function set _swfloader(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._1576763286_swfloader;
         if(_loc2_ !== param1)
         {
            this._1576763286_swfloader = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_swfloader",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _thumbTray() : ThumbTray
      {
         return this._159139667_thumbTray;
      }
      
      public function set _topButtonBar(param1:TopButtonBar) : void
      {
         var _loc2_:Object = this._427053173_topButtonBar;
         if(_loc2_ !== param1)
         {
            this._427053173_topButtonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_topButtonBar",_loc2_,param1));
         }
      }
      
      public function set _overTray(param1:OverTray) : void
      {
         var _loc2_:Object = this._619629449_overTray;
         if(_loc2_ !== param1)
         {
            this._619629449_overTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_overTray",_loc2_,param1));
         }
      }
      
      private function onClientThemeComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onClientThemeComplete);
         createComponentsFromDescriptors();
      }
      
      public function set _goWalker(param1:GoWalker) : void
      {
         var _loc2_:Object = this._1523657885_goWalker;
         if(_loc2_ !== param1)
         {
            this._1523657885_goWalker = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_goWalker",_loc2_,param1));
         }
      }
      
      public function set _timeline(param1:Timeline) : void
      {
         var _loc2_:Object = this._1986132576_timeline;
         if(_loc2_ !== param1)
         {
            this._1986132576_timeline = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timeline",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainStage() : MainStage
      {
         return this._1751026874_mainStage;
      }
      
      public function ___go_full_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.loadClientLocale();
      }
      
      public function set _tipsLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1592971130_tipsLayer;
         if(_loc2_ !== param1)
         {
            this._1592971130_tipsLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tipsLayer",_loc2_,param1));
         }
      }
      
      public function set _thumbTray(param1:ThumbTray) : void
      {
         var _loc2_:Object = this._159139667_thumbTray;
         if(_loc2_ !== param1)
         {
            this._159139667_thumbTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_thumbTray",_loc2_,param1));
         }
      }
      
      private function onClientLocaleComplete(param1:Event) : void
      {
         this.loadClientTheme();
      }
      
      private function resetFrameRate() : void
      {
         if(this.stage)
         {
            this.stage.frameRate = 24;
         }
      }
      
      private function initialConsole() : void
      {
         Util.gaTracking("/gostudio/initialGoFullConsole",this.stage);
         this._thumbTray.hidable = false;
         this._thumbTray.changeToFullSize();
         this._mainStage.changeToFullSize();
         UtilNetwork.loadS3crossDomainXml();
         this._console = Console.initializeConsole(this._mainStage,this._topButtonBar,this._thumbTray,this._effectTray,this._timeline,this._swfloader,this._inspirationloader,this._overTray._pw,this._tipsLayer,this._screenCapTool,this._goWalker,Console.FULL_STUDIO) as Console;
         this._goWalker.console = this._console;
         this._console.initializeLoadingBar(this._loadProgress);
         this._console.boxMode = UtilLicense.isBoxEnvironment();
         this.stage.scaleMode = StageScaleMode.SHOW_ALL;
         this._topButtonBar.changeToFullSize();
         this._mainStage.visible = this._thumbTray.visible = this._topButtonBar.visible = true;
         application.addEventListener(KeyboardEvent.KEY_UP,Console.getConsole().doKeyUp);
         this._swfloader.source = ServerConstants.SERVER_IMPORTER_PATH;
         this._inspirationloader.source = ServerConstants.SERVER_INSPIRATION_PATH;
      }
      
      private function loadClientTheme() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         _loc4_.push("go_full");
         _loc5_.push(_loc3_);
         _loc6_.push(_loc2_);
         _loc4_.push("go_full");
         _loc5_.push("lang_common");
         _loc6_.push(_loc2_);
         Util.loadClientTheming(_loc4_,_loc5_,_loc6_,this.onClientThemeComplete);
      }
      
      [Bindable(event="propertyChange")]
      public function get _tipsLayer() : Canvas
      {
         return this._1592971130_tipsLayer;
      }
      
      public function set _inspirationloader(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._736875266_inspirationloader;
         if(_loc2_ !== param1)
         {
            this._736875266_inspirationloader = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inspirationloader",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _inspirationloader() : SWFLoader
      {
         return this._736875266_inspirationloader;
      }
      
      [Bindable(event="propertyChange")]
      public function get _screenCapTool() : ScreenCapTool
      {
         return this._1149811839_screenCapTool;
      }
   }
}
