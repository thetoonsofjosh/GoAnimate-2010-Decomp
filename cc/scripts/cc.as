package
{
   import anifire.cc_interface.ICcCharEditorContainer;
   import anifire.cc_interface.ICcMainUiContainer;
   import anifire.cc_interface.ICcPreviewAndSaveContainer;
   import anifire.components.char_editor.BodyShapeChooser;
   import anifire.components.char_editor.BodyShapeMegaChooser;
   import anifire.components.char_editor.ButtonBar;
   import anifire.components.char_editor.CcColorPicker;
   import anifire.components.char_editor.CcThumbPropertyInspector;
   import anifire.components.char_editor.CharPreviewer;
   import anifire.components.char_editor.ClothesChooser;
   import anifire.components.char_editor.ComponentThumbChooser;
   import anifire.components.char_editor.ComponentTypeChooser;
   import anifire.components.char_editor.SelectedDecoration;
   import anifire.components.char_editor.StatusPanel;
   import anifire.components.previewAndSave.CharPreviewOptionBox;
   import anifire.components.previewAndSave.PurchaseBox;
   import anifire.components.previewAndSave.PurchaseCompleteBox;
   import anifire.constant.ServerConstants;
   import anifire.core.CcConsole;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
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
   import mx.containers.ViewStack;
   import mx.core.Application;
   import mx.core.Container;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.styles.*;
   
   public class cc extends Application implements ICcCharEditorContainer, ICcMainUiContainer, ICcPreviewAndSaveContainer, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal static var _cc_StylesInit_done:Boolean = false;
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1995015763ps_interactionViewStack:ViewStack;
      
      private var _931590865_ce_clothesChooser:ClothesChooser;
      
      private var _361540722ccCharPreviewAndSaveScreen:Canvas;
      
      private var _580013481_ce_selectedDecoration:SelectedDecoration;
      
      private var _627432557_ce_colorPicker:CcColorPicker;
      
      private var _267076680_ce_bodyShapeMegaChooser:BodyShapeMegaChooser;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _ccConsole:CcConsole;
      
      private var _806339029ps_purchaseCompleteBox:PurchaseCompleteBox;
      
      private var _1263293821ps_charPreviewer:CharPreviewer;
      
      private var _1970784ps_charPreviewOptionBox:CharPreviewOptionBox;
      
      private var _495053373_ce_buttonBar:ButtonBar;
      
      private var _164421228_ce_mainViewStack:ViewStack;
      
      private var _1163196673_ce_charPreviewer:CharPreviewer;
      
      private var _309190686_ce_componentTypeChooser:ComponentTypeChooser;
      
      private var _1122792149ps_purChaseCompleteContainer:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _1243488953_ce_componentChooserViewStack:ViewStack;
      
      private var _1262756942ps_charPreviewCanvas:Canvas;
      
      private var _1876215540_ce_statusPanel:StatusPanel;
      
      private var _920644200ps_charPurchaseBox:PurchaseBox;
      
      private var _740228964_ce_componentThumbChooser:ComponentThumbChooser;
      
      private var _614936982_ce_thumbPropertyInspector:CcThumbPropertyInspector;
      
      private var _1502809610_bgStatus:Canvas;
      
      private var _1703153366mainViewStack:ViewStack;
      
      private var _678855911_ce_mainEditorComponentsContainer:Canvas;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindings:Array;
      
      public function cc()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function():Object
            {
               return {
                  "width":954,
                  "height":500,
                  "creationPolicy":"none",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"mainViewStack",
                     "stylesFactory":function():void
                     {
                        this.paddingBottom = 0;
                        this.paddingLeft = 0;
                        this.paddingRight = 0;
                        this.paddingTop = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "creationPolicy":"all",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":ViewStack,
                              "id":"_ce_mainViewStack",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":BodyShapeMegaChooser,
                                       "id":"_ce_bodyShapeMegaChooser",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_ce_mainEditorComponentsContainer",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "verticalScrollPolicy":"off",
                                             "horizontalScrollPolicy":"off",
                                             "styleName":"bgCharEditor",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":CharPreviewer,
                                                "id":"_ce_charPreviewer",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":-93,
                                                      "y":45,
                                                      "width":428,
                                                      "height":329
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":ComponentTypeChooser,
                                                "id":"_ce_componentTypeChooser",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":407,
                                                      "y":12,
                                                      "width":547,
                                                      "height":76
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":CcColorPicker,
                                                "id":"_ce_colorPicker",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":430,
                                                      "y":350,
                                                      "width":500,
                                                      "height":121,
                                                      "biggerElementWidth":142,
                                                      "smallerElementWidth":80
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":ButtonBar,
                                                "id":"_ce_buttonBar",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":450,
                                                      "width":300,
                                                      "height":38
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_bgStatus",
                                                "events":{"resize":"___bgStatus_resize"}
                                             }),new UIComponentDescriptor({
                                                "type":StatusPanel,
                                                "id":"_ce_statusPanel",
                                                "stylesFactory":function():void
                                                {
                                                   this.right = "10";
                                                   this.bottom = "10";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "scaleX":0.9,
                                                      "scaleY":0.9,
                                                      "isUsDollarShown":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":CcThumbPropertyInspector,
                                                "id":"_ce_thumbPropertyInspector",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":430,
                                                      "y":272,
                                                      "width":463,
                                                      "height":77
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":SelectedDecoration,
                                                "id":"_ce_selectedDecoration",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":407,
                                                      "y":183,
                                                      "width":463,
                                                      "height":72
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"_ce_componentChooserViewStack",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":407,
                                                      "y":103,
                                                      "width":463,
                                                      "height":157,
                                                      "creationPolicy":"all",
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":ComponentThumbChooser,
                                                         "id":"_ce_componentThumbChooser",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "clipContent":false,
                                                               "biggerHeight":157,
                                                               "smallerHeight":65
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":ClothesChooser,
                                                         "id":"_ce_clothesChooser",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 50;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "y":10,
                                                               "percentWidth":100,
                                                               "height":250,
                                                               "clipContent":false,
                                                               "thumbChooserWidth":463,
                                                               "biggerHeight":70,
                                                               "smallerHeight":70,
                                                               "creationPolicy":"all"
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"ccCharPreviewAndSaveScreen",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "styleName":"bgCharEditor",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":CharPreviewer,
                                       "id":"ps_charPreviewer",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":-93,
                                             "y":26,
                                             "width":428,
                                             "height":348,
                                             "clipContent":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":ViewStack,
                                       "id":"ps_interactionViewStack",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"ps_charPreviewCanvas",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "horizontalScrollPolicy":"off",
                                                      "verticalScrollPolicy":"off",
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":CharPreviewOptionBox,
                                                         "id":"ps_charPreviewOptionBox",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":80,
                                                               "height":40
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":PurchaseBox,
                                                         "id":"ps_charPurchaseBox"
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"ps_purChaseCompleteContainer",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":PurchaseCompleteBox,
                                                      "id":"ps_purchaseCompleteBox",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "x":476,
                                                            "y":160,
                                                            "width":239,
                                                            "height":240
                                                         };
                                                      }
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
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
            this.backgroundAlpha = 0;
            this.backgroundColor = 16777215;
         };
         mx_internal::_cc_StylesInit();
         this.width = 954;
         this.height = 500;
         this.verticalScrollPolicy = "off";
         this.layout = "absolute";
         this.creationPolicy = "none";
         this.addEventListener("preinitialize",this.___cc_Application1_preinitialize);
         this.addEventListener("applicationComplete",this.___cc_Application1_applicationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         cc._watcherSetupUtil = param1;
      }
      
      public function get ui_ps_statusPanel() : StatusPanel
      {
         return this.ps_charPurchaseBox.ps_statusPanel;
      }
      
      public function ___bgStatus_resize(param1:ResizeEvent) : void
      {
         this.onBgReady(param1);
      }
      
      public function set ps_charPreviewer(param1:CharPreviewer) : void
      {
         var _loc2_:Object = this._1263293821ps_charPreviewer;
         if(_loc2_ !== param1)
         {
            this._1263293821ps_charPreviewer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_charPreviewer",_loc2_,param1));
         }
      }
      
      public function get ui_ps_interactionViewStack() : ViewStack
      {
         return this.ps_interactionViewStack;
      }
      
      private function loadClientLocale() : void
      {
         Util.loadClientLocale("cc",this.onClientLocaleComplete);
      }
      
      [Bindable(event="propertyChange")]
      public function get _bgStatus() : Canvas
      {
         return this._1502809610_bgStatus;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_charPreviewer() : CharPreviewer
      {
         return this._1163196673_ce_charPreviewer;
      }
      
      public function get ui_ps_charPreviewCanvas() : Container
      {
         return this.ps_charPreviewCanvas;
      }
      
      public function set _ce_charPreviewer(param1:CharPreviewer) : void
      {
         var _loc2_:Object = this._1163196673_ce_charPreviewer;
         if(_loc2_ !== param1)
         {
            this._1163196673_ce_charPreviewer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_charPreviewer",_loc2_,param1));
         }
      }
      
      public function set ccCharPreviewAndSaveScreen(param1:Canvas) : void
      {
         var _loc2_:Object = this._361540722ccCharPreviewAndSaveScreen;
         if(_loc2_ !== param1)
         {
            this._361540722ccCharPreviewAndSaveScreen = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ccCharPreviewAndSaveScreen",_loc2_,param1));
         }
      }
      
      public function set _ce_colorPicker(param1:CcColorPicker) : void
      {
         var _loc2_:Object = this._627432557_ce_colorPicker;
         if(_loc2_ !== param1)
         {
            this._627432557_ce_colorPicker = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_colorPicker",_loc2_,param1));
         }
      }
      
      public function get ui_main_ccCharPreviewAndSaveScreen() : Container
      {
         return this.ccCharPreviewAndSaveScreen;
      }
      
      public function get ui_ps_charPurchaseBox() : PurchaseBox
      {
         return this.ps_charPurchaseBox;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_purChaseCompleteContainer() : Canvas
      {
         return this._1122792149ps_purChaseCompleteContainer;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_mainEditorComponentsContainer() : Canvas
      {
         return this._678855911_ce_mainEditorComponentsContainer;
      }
      
      public function get ui_ce_bodyShapeChooser() : BodyShapeChooser
      {
         return this._ce_bodyShapeMegaChooser.bodyShapeChooser;
      }
      
      public function set ps_charPurchaseBox(param1:PurchaseBox) : void
      {
         var _loc2_:Object = this._920644200ps_charPurchaseBox;
         if(_loc2_ !== param1)
         {
            this._920644200ps_charPurchaseBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_charPurchaseBox",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_purchaseCompleteBox() : PurchaseCompleteBox
      {
         return this._806339029ps_purchaseCompleteBox;
      }
      
      [Bindable(event="propertyChange")]
      public function get mainViewStack() : ViewStack
      {
         return this._1703153366mainViewStack;
      }
      
      public function get ui_ce_selectedDecoration() : SelectedDecoration
      {
         return this._ce_selectedDecoration;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_charPurchaseBox() : PurchaseBox
      {
         return this._920644200ps_charPurchaseBox;
      }
      
      public function get ui_ce_componentChooserViewStack() : ViewStack
      {
         return this._ce_componentChooserViewStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_componentChooserViewStack() : ViewStack
      {
         return this._1243488953_ce_componentChooserViewStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_bodyShapeMegaChooser() : BodyShapeMegaChooser
      {
         return this._267076680_ce_bodyShapeMegaChooser;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_charPreviewCanvas() : Canvas
      {
         return this._1262756942ps_charPreviewCanvas;
      }
      
      private function _cc_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return _ce_statusPanel.x;
         },function(param1:Number):void
         {
            _bgStatus.x = param1;
         },"_bgStatus.x");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return _ce_statusPanel.y;
         },function(param1:Number):void
         {
            _bgStatus.y = param1;
         },"_bgStatus.y");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return _ce_statusPanel.width;
         },function(param1:Number):void
         {
            _bgStatus.width = param1;
         },"_bgStatus.width");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return _ce_statusPanel.height;
         },function(param1:Number):void
         {
            _bgStatus.height = param1;
         },"_bgStatus.height");
         result[3] = binding;
         binding = new Binding(this,function():Number
         {
            return (this.width - ps_charPreviewOptionBox.width) / 2;
         },function(param1:Number):void
         {
            ps_charPreviewOptionBox.x = param1;
         },"ps_charPreviewOptionBox.x");
         result[4] = binding;
         binding = new Binding(this,function():Number
         {
            return this.height - ps_charPreviewOptionBox.height;
         },function(param1:Number):void
         {
            ps_charPreviewOptionBox.y = param1;
         },"ps_charPreviewOptionBox.y");
         result[5] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width / 2 - 50;
         },function(param1:Number):void
         {
            ps_charPurchaseBox.x = param1;
         },"ps_charPurchaseBox.x");
         result[6] = binding;
         binding = new Binding(this,function():Number
         {
            return this.height / 2 - 110;
         },function(param1:Number):void
         {
            ps_charPurchaseBox.y = param1;
         },"ps_charPurchaseBox.y");
         result[7] = binding;
         return result;
      }
      
      public function get ui_ce_componentThumbChooser() : ComponentThumbChooser
      {
         return this._ce_componentThumbChooser;
      }
      
      public function set mainViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1703153366mainViewStack;
         if(_loc2_ !== param1)
         {
            this._1703153366mainViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainViewStack",_loc2_,param1));
         }
      }
      
      public function set ps_purChaseCompleteContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1122792149ps_purChaseCompleteContainer;
         if(_loc2_ !== param1)
         {
            this._1122792149ps_purChaseCompleteContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_purChaseCompleteContainer",_loc2_,param1));
         }
      }
      
      public function set ps_interactionViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1995015763ps_interactionViewStack;
         if(_loc2_ !== param1)
         {
            this._1995015763ps_interactionViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_interactionViewStack",_loc2_,param1));
         }
      }
      
      public function get ui_ce_mainViewStack() : ViewStack
      {
         return this._ce_mainViewStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_charPreviewOptionBox() : CharPreviewOptionBox
      {
         return this._1970784ps_charPreviewOptionBox;
      }
      
      public function set _ce_selectedDecoration(param1:SelectedDecoration) : void
      {
         var _loc2_:Object = this._580013481_ce_selectedDecoration;
         if(_loc2_ !== param1)
         {
            this._580013481_ce_selectedDecoration = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_selectedDecoration",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_thumbPropertyInspector() : CcThumbPropertyInspector
      {
         return this._614936982_ce_thumbPropertyInspector;
      }
      
      public function get ui_ce_clothesChooser() : ClothesChooser
      {
         return this._ce_clothesChooser;
      }
      
      mx_internal function _cc_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_cc_StylesInit_done)
         {
            return;
         }
         mx_internal::_cc_StylesInit_done = true;
         StyleManager.mx_internal::initProtoChainRoots();
      }
      
      private function initialConsole() : void
      {
         Util.gaTracking("/gostudio/initialCCConsole",this.stage);
         CcConsole.initializeCcConsole(this,this,this);
         this._ce_charPreviewer.scaleX = this._ce_charPreviewer.scaleY = 1.2;
         this.ps_charPreviewer.scaleX = this.ps_charPreviewer.scaleY = 1.2;
         this._ccConsole = CcConsole.getCcConsole();
      }
      
      public function get ui_ce_componentTypeChooser() : ComponentTypeChooser
      {
         return this._ce_componentTypeChooser;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_mainViewStack() : ViewStack
      {
         return this._164421228_ce_mainViewStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_componentThumbChooser() : ComponentThumbChooser
      {
         return this._740228964_ce_componentThumbChooser;
      }
      
      public function get ui_ce_colorPicker() : CcColorPicker
      {
         return this._ce_colorPicker;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_charPreviewer() : CharPreviewer
      {
         return this._1263293821ps_charPreviewer;
      }
      
      public function get ui_ps_userPointStatusPanel() : StatusPanel
      {
         return this.ps_charPurchaseBox.ps_userPointStatusPanel;
      }
      
      private function onBgReady(param1:Event) : void
      {
         var _loc3_:Canvas = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_MONEY_MODE) as String;
         if(_loc2_ != "school")
         {
            _loc3_ = Canvas(param1.currentTarget);
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc3_.clipContent = false;
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(16777215,0.5);
            _loc3_.graphics.drawRoundRectComplex(0 + _loc4_,-5 + _loc5_,_loc3_.width + _loc6_,_loc3_.height + 15 + _loc7_,10,10,0,0);
            _loc3_.graphics.endFill();
         }
         else
         {
            this._ce_statusPanel.visible = false;
         }
      }
      
      public function ___cc_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.initialConsole();
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_colorPicker() : CcColorPicker
      {
         return this._627432557_ce_colorPicker;
      }
      
      public function set _ce_buttonBar(param1:ButtonBar) : void
      {
         var _loc2_:Object = this._495053373_ce_buttonBar;
         if(_loc2_ !== param1)
         {
            this._495053373_ce_buttonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_buttonBar",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:cc = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._cc_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_ccWatcherSetupUtil");
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
      
      public function set ps_charPreviewCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1262756942ps_charPreviewCanvas;
         if(_loc2_ !== param1)
         {
            this._1262756942ps_charPreviewCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_charPreviewCanvas",_loc2_,param1));
         }
      }
      
      public function set _ce_componentChooserViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1243488953_ce_componentChooserViewStack;
         if(_loc2_ !== param1)
         {
            this._1243488953_ce_componentChooserViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_componentChooserViewStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ccCharPreviewAndSaveScreen() : Canvas
      {
         return this._361540722ccCharPreviewAndSaveScreen;
      }
      
      public function set _ce_bodyShapeMegaChooser(param1:BodyShapeMegaChooser) : void
      {
         var _loc2_:Object = this._267076680_ce_bodyShapeMegaChooser;
         if(_loc2_ !== param1)
         {
            this._267076680_ce_bodyShapeMegaChooser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_bodyShapeMegaChooser",_loc2_,param1));
         }
      }
      
      public function set ps_purchaseCompleteBox(param1:PurchaseCompleteBox) : void
      {
         var _loc2_:Object = this._806339029ps_purchaseCompleteBox;
         if(_loc2_ !== param1)
         {
            this._806339029ps_purchaseCompleteBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_purchaseCompleteBox",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_interactionViewStack() : ViewStack
      {
         return this._1995015763ps_interactionViewStack;
      }
      
      public function set _ce_clothesChooser(param1:ClothesChooser) : void
      {
         var _loc2_:Object = this._931590865_ce_clothesChooser;
         if(_loc2_ !== param1)
         {
            this._931590865_ce_clothesChooser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_clothesChooser",_loc2_,param1));
         }
      }
      
      public function get ui_ps_charPreviewOptionBox() : CharPreviewOptionBox
      {
         return this.ps_charPreviewOptionBox;
      }
      
      private function onClientThemeComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onClientThemeComplete);
         createComponentsFromDescriptors();
      }
      
      public function get ui_main_ccCharEditor() : Container
      {
         return this._ce_mainViewStack;
      }
      
      public function set ps_charPreviewOptionBox(param1:CharPreviewOptionBox) : void
      {
         var _loc2_:Object = this._1970784ps_charPreviewOptionBox;
         if(_loc2_ !== param1)
         {
            this._1970784ps_charPreviewOptionBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_charPreviewOptionBox",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_selectedDecoration() : SelectedDecoration
      {
         return this._580013481_ce_selectedDecoration;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_buttonBar() : ButtonBar
      {
         return this._495053373_ce_buttonBar;
      }
      
      public function get ui_ce_buttonBar() : ButtonBar
      {
         return this._ce_buttonBar;
      }
      
      public function get ui_main_ViewStack() : ViewStack
      {
         return this.mainViewStack;
      }
      
      public function set _ce_componentTypeChooser(param1:ComponentTypeChooser) : void
      {
         var _loc2_:Object = this._309190686_ce_componentTypeChooser;
         if(_loc2_ !== param1)
         {
            this._309190686_ce_componentTypeChooser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_componentTypeChooser",_loc2_,param1));
         }
      }
      
      public function get ui_ps_charPreviewer() : CharPreviewer
      {
         return this.ps_charPreviewer;
      }
      
      public function get ui_ce_mainEditorComponentsContainer() : Canvas
      {
         return this._ce_mainEditorComponentsContainer;
      }
      
      public function set _ce_thumbPropertyInspector(param1:CcThumbPropertyInspector) : void
      {
         var _loc2_:Object = this._614936982_ce_thumbPropertyInspector;
         if(_loc2_ !== param1)
         {
            this._614936982_ce_thumbPropertyInspector = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_thumbPropertyInspector",_loc2_,param1));
         }
      }
      
      public function set _ce_componentThumbChooser(param1:ComponentThumbChooser) : void
      {
         var _loc2_:Object = this._740228964_ce_componentThumbChooser;
         if(_loc2_ !== param1)
         {
            this._740228964_ce_componentThumbChooser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_componentThumbChooser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_clothesChooser() : ClothesChooser
      {
         return this._931590865_ce_clothesChooser;
      }
      
      private function _cc_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._ce_statusPanel.x;
         _loc1_ = this._ce_statusPanel.y;
         _loc1_ = this._ce_statusPanel.width;
         _loc1_ = this._ce_statusPanel.height;
         _loc1_ = (this.width - this.ps_charPreviewOptionBox.width) / 2;
         _loc1_ = this.height - this.ps_charPreviewOptionBox.height;
         _loc1_ = this.width / 2 - 50;
         _loc1_ = this.height / 2 - 110;
      }
      
      public function set _ce_mainViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._164421228_ce_mainViewStack;
         if(_loc2_ !== param1)
         {
            this._164421228_ce_mainViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_mainViewStack",_loc2_,param1));
         }
      }
      
      public function get ui_ce_statusPanel() : StatusPanel
      {
         return this._ce_statusPanel;
      }
      
      private function onClientLocaleComplete(param1:Event) : void
      {
         this.loadClientTheme();
      }
      
      public function set _ce_mainEditorComponentsContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._678855911_ce_mainEditorComponentsContainer;
         if(_loc2_ !== param1)
         {
            this._678855911_ce_mainEditorComponentsContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_mainEditorComponentsContainer",_loc2_,param1));
         }
      }
      
      public function set _ce_statusPanel(param1:StatusPanel) : void
      {
         var _loc2_:Object = this._1876215540_ce_statusPanel;
         if(_loc2_ !== param1)
         {
            this._1876215540_ce_statusPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_statusPanel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_componentTypeChooser() : ComponentTypeChooser
      {
         return this._309190686_ce_componentTypeChooser;
      }
      
      public function get ui_ce_bodyShapeMegaChooser() : BodyShapeMegaChooser
      {
         return this._ce_bodyShapeMegaChooser;
      }
      
      public function get ui_ce_charPreviewer() : CharPreviewer
      {
         return this._ce_charPreviewer;
      }
      
      public function get ui_ps_purchaseCompleteBox() : PurchaseCompleteBox
      {
         return this.ps_purchaseCompleteBox;
      }
      
      public function set _bgStatus(param1:Canvas) : void
      {
         var _loc2_:Object = this._1502809610_bgStatus;
         if(_loc2_ !== param1)
         {
            this._1502809610_bgStatus = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bgStatus",_loc2_,param1));
         }
      }
      
      public function get ui_ps_purChaseCompleteContainer() : Container
      {
         return this.ps_purChaseCompleteContainer;
      }
      
      public function ___cc_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.loadClientLocale();
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_statusPanel() : StatusPanel
      {
         return this._1876215540_ce_statusPanel;
      }
      
      public function get ui_ce_thumbPropertyInspector() : CcThumbPropertyInspector
      {
         return this._ce_thumbPropertyInspector;
      }
      
      private function loadClientTheme() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         _loc4_.push("cc");
         _loc5_.push(_loc3_);
         _loc6_.push(_loc2_);
         _loc4_.push("cc");
         _loc5_.push("lang_common");
         _loc6_.push(_loc2_);
         Util.loadClientTheming(_loc4_,_loc5_,_loc6_,this.onClientThemeComplete);
      }
   }
}
