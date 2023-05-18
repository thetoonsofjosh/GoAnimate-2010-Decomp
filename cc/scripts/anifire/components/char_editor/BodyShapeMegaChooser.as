package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.component.CCThumb;
   import anifire.core.CcConsole;
   import anifire.event.CcCoreEvent;
   import anifire.event.CcPreMadeCharChooserEvent;
   import anifire.event.CcTemplateChooserEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilPager;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.TabBar;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   
   public class BodyShapeMegaChooser extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _watchers:Array;
      
      public var _BodyShapeMegaChooser_SetProperty1:SetProperty;
      
      private var _3773vs:ViewStack;
      
      private var _704377921charPreviewer:anifire.components.char_editor.CharPreviewer;
      
      private var _416853558btnModify:Button;
      
      private var _1378837878btnBuy:Button;
      
      private var _1455447984_selectedCCChar:CcCharacter = null;
      
      private var _3478mc:Canvas;
      
      public var _BodyShapeMegaChooser_HBox1:HBox;
      
      private var _pager:UtilPager = null;
      
      private var _1981727545templates:anifire.components.char_editor.LatestTemplates;
      
      private var _3497mv:Move;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _832627083previewer:Canvas;
      
      private var _1139886477topTabs:TabBar;
      
      private var _909839514_ce_bodyShapeChooser:anifire.components.char_editor.BodyShapeChooser;
      
      private var _753188901TAB_DATAPROVIDER:ArrayCollection;
      
      mx_internal var _bindings:Array;
      
      private var _1395395193templateSelector:anifire.components.char_editor.TemplateCCSelector;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function BodyShapeMegaChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "x":0,
                        "y":5,
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TabBar,
                           "id":"topTabs",
                           "stylesFactory":function():void
                           {
                              this.firstTabStyleName = "topButtonTabFirst";
                              this.tabStyleName = "topButtonTab";
                              this.horizontalGap = 2;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"buttonMode":true};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vs",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":anifire.components.char_editor.BodyShapeChooser,
                                    "id":"_ce_bodyShapeChooser",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":0,
                                          "y":38,
                                          "percentWidth":100,
                                          "height":235
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"mc",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":3,
                                          "height":218,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":anifire.components.char_editor.LatestTemplates,
                                             "id":"templates",
                                             "stylesFactory":function():void
                                             {
                                                this.verticalCenter = "-20";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"percentWidth":100};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "stylesFactory":function():void
                                             {
                                                this.bottom = "0";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":0,
                                                   "styleName":"templateFrontShark",
                                                   "mouseEnabled":false,
                                                   "width":854,
                                                   "height":70
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
                           "id":"previewer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":anifire.components.char_editor.CharPreviewer,
                                    "id":"charPreviewer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":-20,
                                          "y":65,
                                          "width":428,
                                          "height":329
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":anifire.components.char_editor.TemplateCCSelector,
                                    "id":"templateSelector",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":450,
                                          "y":55
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_BodyShapeMegaChooser_HBox1",
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "middle";
                                       this.horizontalGap = 25;
                                       this.horizontalCenter = "-280";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":450,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnModify",
                                             "events":{"click":"__btnModify_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"templateCCBtnModify",
                                                   "buttonMode":true
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnBuy",
                                             "events":{"click":"__btnBuy_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"templateCCBtnBuy",
                                                   "buttonMode":true
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
               })]};
            }
         });
         this._753188901TAB_DATAPROVIDER = new ArrayCollection([{
            "label":UtilDict.toDisplay("cc","Create Your Own Characters"),
            "data":{"state":""}
         },{
            "label":UtilDict.toDisplay("cc","Specialties"),
            "data":{"state":"preview_professions"}
         },{
            "label":UtilDict.toDisplay("cc","Celebrities"),
            "data":{"state":"preview_celebrities"}
         }]);
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "bgTemplateMain";
         this.states = [this._BodyShapeMegaChooser_State1_c(),this._BodyShapeMegaChooser_State2_c(),this._BodyShapeMegaChooser_State3_c()];
         this._BodyShapeMegaChooser_Move1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         BodyShapeMegaChooser._watcherSetupUtil = param1;
      }
      
      private function _BodyShapeMegaChooser_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._BodyShapeMegaChooser_SetProperty1 = _loc1_;
         _loc1_.name = "selectedChild";
         BindingManager.executeBindings(this,"_BodyShapeMegaChooser_SetProperty1",this._BodyShapeMegaChooser_SetProperty1);
         return _loc1_;
      }
      
      public function ___BodyShapeMegaChooser_State1_enterState(param1:FlexEvent) : void
      {
         this.updatePreviewer(param1);
      }
      
      private function _BodyShapeMegaChooser_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "preview_professions";
         _loc1_.basedOn = "preview";
         _loc1_.addEventListener("enterState",this.___BodyShapeMegaChooser_State3_enterState);
         return _loc1_;
      }
      
      private function tellEveryBodyUserWantToBuy(param1:Event) : void
      {
         Util.gaTracking("/creator/templateThumbBuy",this);
         var _loc2_:CcCharacter = this._selectedCCChar.clone();
         _loc2_.assetId = "";
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.USER_WANT_TO_PREVIEW,this,_loc2_));
      }
      
      public function set charPreviewer(param1:anifire.components.char_editor.CharPreviewer) : void
      {
         var _loc2_:Object = this._704377921charPreviewer;
         if(_loc2_ !== param1)
         {
            this._704377921charPreviewer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"charPreviewer",_loc2_,param1));
         }
      }
      
      public function set vs(param1:ViewStack) : void
      {
         var _loc2_:Object = this._3773vs;
         if(_loc2_ !== param1)
         {
            this._3773vs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vs",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnBuy() : Button
      {
         return this._1378837878btnBuy;
      }
      
      [Bindable(event="propertyChange")]
      public function get topTabs() : TabBar
      {
         return this._1139886477topTabs;
      }
      
      public function init() : void
      {
         var _self:BodyShapeMegaChooser = null;
         var _numCCTotal:int = 0;
         var _numCC:int = 0;
         var _destroyHandler:Boolean = false;
         var _handlerEach:Function = null;
         var _handler:Function = null;
         _self = this;
         _numCCTotal = 9999;
         _numCC = 0;
         _destroyHandler = false;
         _handlerEach = function(param1:CcCoreEvent):void
         {
            var _loc2_:Object = param1.getData();
            if(_loc2_.tag != "latest")
            {
               return;
            }
            templates.addThumbnail(_loc2_.thumbnail as CCThumb,_loc2_.char as CcCharacter);
            if(++_numCC == _numCCTotal)
            {
               CcConsole.getCcConsole().removeEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,_handlerEach);
               _destroyHandler = true;
            }
         };
         _handler = function(param1:CcCoreEvent):void
         {
            var _loc2_:Object = param1.getData();
            if(_loc2_.tag != "latest")
            {
               return;
            }
            _numCCTotal = int(_loc2_.total);
            if(_numCC == _numCCTotal && !_destroyHandler)
            {
               CcConsole.getCcConsole().removeEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,_handlerEach);
            }
            CcConsole.getCcConsole().removeEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_ALL_COMPLETE,_handler);
            mv.play();
         };
         CcConsole.getCcConsole().addEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,_handlerEach);
         CcConsole.getCcConsole().addEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_ALL_COMPLETE,_handler);
         addEventListener(CcTemplateChooserEvent.USER_WANT_TO_PREVIEW,function(param1:CcTemplateChooserEvent):void
         {
            var _loc2_:CcCharacter = param1.getData() as CcCharacter;
            var _loc3_:String = normalizeCategory(_loc2_.category);
            if(_pager == null || normalizeCategory(templateSelector.category) != _loc3_)
            {
               initPagerByCategory(_loc3_);
            }
            _pager.scrollToItem(_loc2_);
            if(_selectedCCChar == null || (param1.getData() as CcCharacter).assetId != _selectedCCChar.assetId)
            {
               _selectedCCChar = param1.getData() as CcCharacter;
               charPreviewer.initByCcChar(_selectedCCChar,_selectedCCChar.thumbnailActionId);
            }
            templateSelector.dispatchEvent(new CcTemplateChooserEvent(CcTemplateChooserEvent.PREVIEW_CHARACTER_CHANGED,_self,_selectedCCChar));
            _self.currentState = _loc2_.category == "" ? "preview_celebrities" : "preview_" + _loc2_.category;
         });
         this.topTabs.addEventListener(ItemClickEvent.ITEM_CLICK,function(param1:ItemClickEvent):void
         {
            _self.currentState = param1.item.data["state"];
         });
         this.addEventListener(CcTemplateChooserEvent.PREVIEW_TAB_CHANGED,function(param1:CcTemplateChooserEvent):void
         {
            _self.currentState = param1.getData() as String;
         });
      }
      
      private function _BodyShapeMegaChooser_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return TAB_DATAPROVIDER;
         },function(param1:Object):void
         {
            topTabs.dataProvider = param1;
         },"topTabs.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width - 6;
         },function(param1:Number):void
         {
            mc.width = param1;
         },"mc.width");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return this.height;
         },function(param1:Number):void
         {
            mc.y = param1;
         },"mc.y");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return _selectedCCChar != null;
         },function(param1:Boolean):void
         {
            _BodyShapeMegaChooser_HBox1.visible = param1;
         },"_BodyShapeMegaChooser_HBox1.visible");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Modify Me!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnModify.label = param1;
         },"btnModify.label");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Buy Me!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnBuy.label = param1;
         },"btnBuy.label");
         result[5] = binding;
         binding = new Binding(this,function():Number
         {
            return -mc.height;
         },function(param1:Number):void
         {
            mv.yBy = param1;
         },"mv.yBy");
         result[6] = binding;
         binding = new Binding(this,function():Object
         {
            return mc;
         },function(param1:Object):void
         {
            mv.target = param1;
         },"mv.target");
         result[7] = binding;
         binding = new Binding(this,function():Object
         {
            return vs;
         },function(param1:Object):void
         {
            _BodyShapeMegaChooser_SetProperty1.target = param1;
         },"_BodyShapeMegaChooser_SetProperty1.target");
         result[8] = binding;
         binding = new Binding(this,function():*
         {
            return previewer;
         },function(param1:*):void
         {
            _BodyShapeMegaChooser_SetProperty1.value = param1;
         },"_BodyShapeMegaChooser_SetProperty1.value");
         result[9] = binding;
         return result;
      }
      
      public function set btnBuy(param1:Button) : void
      {
         var _loc2_:Object = this._1378837878btnBuy;
         if(_loc2_ !== param1)
         {
            this._1378837878btnBuy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnBuy",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mc() : Canvas
      {
         return this._3478mc;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:BodyShapeMegaChooser = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._BodyShapeMegaChooser_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_BodyShapeMegaChooserWatcherSetupUtil");
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
      
      public function get bodyShapeChooser() : anifire.components.char_editor.BodyShapeChooser
      {
         return this._ce_bodyShapeChooser;
      }
      
      [Bindable(event="propertyChange")]
      private function get TAB_DATAPROVIDER() : ArrayCollection
      {
         return this._753188901TAB_DATAPROVIDER;
      }
      
      private function normalizeCategory(param1:String) : String
      {
         return param1 == "" ? "celebrities" : param1;
      }
      
      private function updatePreviewer(param1:FlexEvent) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get mv() : Move
      {
         return this._3497mv;
      }
      
      private function _BodyShapeMegaChooser_SetProperty2_c() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "styleName";
         _loc1_.value = "bgTemplatePreviewer";
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnModify() : Button
      {
         return this._416853558btnModify;
      }
      
      [Bindable(event="propertyChange")]
      public function get templates() : anifire.components.char_editor.LatestTemplates
      {
         return this._1981727545templates;
      }
      
      private function _BodyShapeMegaChooser_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "preview_celebrities";
         _loc1_.basedOn = "preview";
         _loc1_.addEventListener("enterState",this.___BodyShapeMegaChooser_State2_enterState);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get vs() : ViewStack
      {
         return this._3773vs;
      }
      
      public function ___BodyShapeMegaChooser_State3_enterState(param1:FlexEvent) : void
      {
         this.updateCategory("professions");
      }
      
      private function set _selectedCCChar(param1:CcCharacter) : void
      {
         var _loc2_:Object = this._1455447984_selectedCCChar;
         if(_loc2_ !== param1)
         {
            this._1455447984_selectedCCChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectedCCChar",_loc2_,param1));
         }
      }
      
      public function set _ce_bodyShapeChooser(param1:anifire.components.char_editor.BodyShapeChooser) : void
      {
         var _loc2_:Object = this._909839514_ce_bodyShapeChooser;
         if(_loc2_ !== param1)
         {
            this._909839514_ce_bodyShapeChooser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ce_bodyShapeChooser",_loc2_,param1));
         }
      }
      
      private function _BodyShapeMegaChooser_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.TAB_DATAPROVIDER;
         _loc1_ = this.width - 6;
         _loc1_ = this.height;
         _loc1_ = this._selectedCCChar != null;
         _loc1_ = UtilDict.toDisplay("cc","Modify Me!");
         _loc1_ = UtilDict.toDisplay("cc","Buy Me!");
         _loc1_ = -this.mc.height;
         _loc1_ = this.mc;
         _loc1_ = this.vs;
         _loc1_ = this.previewer;
      }
      
      private function set TAB_DATAPROVIDER(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._753188901TAB_DATAPROVIDER;
         if(_loc2_ !== param1)
         {
            this._753188901TAB_DATAPROVIDER = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"TAB_DATAPROVIDER",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ce_bodyShapeChooser() : anifire.components.char_editor.BodyShapeChooser
      {
         return this._909839514_ce_bodyShapeChooser;
      }
      
      private function _BodyShapeMegaChooser_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this.mv = _loc1_;
         BindingManager.executeBindings(this,"mv",this.mv);
         return _loc1_;
      }
      
      public function set templateSelector(param1:anifire.components.char_editor.TemplateCCSelector) : void
      {
         var _loc2_:Object = this._1395395193templateSelector;
         if(_loc2_ !== param1)
         {
            this._1395395193templateSelector = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"templateSelector",_loc2_,param1));
         }
      }
      
      public function set mc(param1:Canvas) : void
      {
         var _loc2_:Object = this._3478mc;
         if(_loc2_ !== param1)
         {
            this._3478mc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mc",_loc2_,param1));
         }
      }
      
      public function __btnModify_click(param1:MouseEvent) : void
      {
         this.tellEveryBodyUserWantToModify(param1);
      }
      
      public function ___BodyShapeMegaChooser_State2_enterState(param1:FlexEvent) : void
      {
         this.updateCategory("celebrities");
      }
      
      public function set templates(param1:anifire.components.char_editor.LatestTemplates) : void
      {
         var _loc2_:Object = this._1981727545templates;
         if(_loc2_ !== param1)
         {
            this._1981727545templates = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"templates",_loc2_,param1));
         }
      }
      
      public function set topTabs(param1:TabBar) : void
      {
         var _loc2_:Object = this._1139886477topTabs;
         if(_loc2_ !== param1)
         {
            this._1139886477topTabs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topTabs",_loc2_,param1));
         }
      }
      
      private function updateCategory(param1:String) : void
      {
         var x:Object;
         var self:BodyShapeMegaChooser = null;
         var xx:Function = null;
         var cat:String = param1;
         if(this._pager == null || this.normalizeCategory(this.templateSelector.category) != cat)
         {
            this.initPagerByCategory(cat);
         }
         x = {
            "celebrities":2,
            "professions":1
         };
         this.topTabs.selectedIndex = x[cat];
         if(this._selectedCCChar == null)
         {
            self = this;
            xx = function(param1:Event):void
            {
               CcConsole.getCcConsole().removeEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_ALL_COMPLETE,xx);
               var _loc2_:CcCharacter = _pager.getView()[0] as CcCharacter;
               if(_selectedCCChar == null && _loc2_ != null)
               {
                  self.dispatchEvent(new CcTemplateChooserEvent(CcTemplateChooserEvent.USER_WANT_TO_PREVIEW,self,_loc2_));
               }
            };
            CcConsole.getCcConsole().addEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_ALL_COMPLETE,xx);
         }
         Util.gaTracking("/creator/templateThumbView/" + (cat == "" ? "unknown" : cat) + "/" + this.templateSelector.pager.pageNumber.toString(),this);
      }
      
      private function initPagerByCategory(param1:String) : void
      {
         var filteredData:Array;
         var console:CcConsole;
         var cat:String = param1;
         this._pager = new UtilPager();
         console = CcConsole.getCcConsole();
         filteredData = console.getTemplateCCPreMadeChars().filter(function(param1:CcCharacter, param2:int, param3:Array):Boolean
         {
            return cat == param1.category || cat == "celebrities" && param1.category == "";
         });
         filteredData.sortOn("createDateTime",Array.DESCENDING);
         this._pager.data = filteredData;
         this._pager.windowSize = 9;
         this.templateSelector.pager = this._pager;
         this.templateSelector.category = cat;
      }
      
      public function set mv(param1:Move) : void
      {
         var _loc2_:Object = this._3497mv;
         if(_loc2_ !== param1)
         {
            this._3497mv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mv",_loc2_,param1));
         }
      }
      
      public function set previewer(param1:Canvas) : void
      {
         var _loc2_:Object = this._832627083previewer;
         if(_loc2_ !== param1)
         {
            this._832627083previewer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"previewer",_loc2_,param1));
         }
      }
      
      public function __btnBuy_click(param1:MouseEvent) : void
      {
         this.tellEveryBodyUserWantToBuy(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get previewer() : Canvas
      {
         return this._832627083previewer;
      }
      
      [Bindable(event="propertyChange")]
      public function get charPreviewer() : anifire.components.char_editor.CharPreviewer
      {
         return this._704377921charPreviewer;
      }
      
      [Bindable(event="propertyChange")]
      public function get templateSelector() : anifire.components.char_editor.TemplateCCSelector
      {
         return this._1395395193templateSelector;
      }
      
      private function _BodyShapeMegaChooser_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "preview";
         _loc1_.overrides = [this._BodyShapeMegaChooser_SetProperty1_i(),this._BodyShapeMegaChooser_SetProperty2_c()];
         _loc1_.addEventListener("enterState",this.___BodyShapeMegaChooser_State1_enterState);
         return _loc1_;
      }
      
      public function set btnModify(param1:Button) : void
      {
         var _loc2_:Object = this._416853558btnModify;
         if(_loc2_ !== param1)
         {
            this._416853558btnModify = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnModify",_loc2_,param1));
         }
      }
      
      private function tellEveryBodyUserWantToModify(param1:Event) : void
      {
         Util.gaTracking("/creator/templateThumbModify",this);
         var _loc2_:CcPreMadeCharChooserEvent = new CcPreMadeCharChooserEvent(CcPreMadeCharChooserEvent.PRE_MADE_CHAR_CHOSEN,this);
         _loc2_.ccCharChosen = this._selectedCCChar.clone();
         _loc2_.ccCharChosen.assetId = "";
         this.dispatchEvent(_loc2_);
      }
      
      [Bindable(event="propertyChange")]
      private function get _selectedCCChar() : CcCharacter
      {
         return this._1455447984_selectedCCChar;
      }
   }
}
