package anifire.components.previewAndSave
{
   import anifire.component.TextButton;
   import anifire.components.char_editor.StatusPanel;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcCoreEvent;
   import anifire.util.UtilDict;
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
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class PurchaseBox extends VBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _238395196btnConfirm:Button;
      
      private var _403552034_haveMoneyBg:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _1697255178ps_statusPanel:StatusPanel;
      
      private var _1155746401_vsControl:ViewStack;
      
      private var _769627786_canRefresh:Canvas;
      
      private var _1754793715_linkModify:TextButton;
      
      private var _167267856_needMoneyBg:Canvas;
      
      private var _1464924181_canAddBuck:Canvas;
      
      private var _47713414_boxStatusPanel:HBox;
      
      private var _1956347456btnAddBuck:Button;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _104067873btnRefresh:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _635300463_canConfirm:Canvas;
      
      private var _1878334242lblHaveMoney:Label;
      
      private var _68526260lblNeedMoney:Label;
      
      mx_internal var _bindings:Array;
      
      private var _2010652631ps_userPointStatusPanel:StatusPanel;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function PurchaseBox()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":400,
                  "height":195,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Spacer,
                     "propertiesFactory":function():Object
                     {
                        return {"height":18};
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "id":"_boxStatusPanel",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":80,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"lblHaveMoney",
                                       "events":{"creationComplete":"__lblHaveMoney_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {"styleName":"lblYouHaveYouNeed"};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_haveMoneyBg",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":159,
                                             "height":38,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":StatusPanel,
                                                "id":"ps_userPointStatusPanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "scaleX":0.9,
                                                      "scaleY":0.9,
                                                      "width":159,
                                                      "height":38
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"lblNeedMoney",
                                       "events":{"creationComplete":"__lblNeedMoney_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {"styleName":"lblYouHaveYouNeed"};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_needMoneyBg",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":177,
                                             "height":38,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":StatusPanel,
                                                "id":"ps_statusPanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "scaleX":0.9,
                                                      "scaleY":0.9,
                                                      "width":177,
                                                      "height":38,
                                                      "isUsDollarShown":true
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
                     "type":ViewStack,
                     "id":"_vsControl",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":350,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_canConfirm",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnConfirm",
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalCenter = "0";
                                          this.verticalCenter = "1";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnConfirmPurchase",
                                             "width":220,
                                             "height":45,
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_canAddBuck",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnAddBuck",
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalCenter = "0";
                                          this.verticalCenter = "1";
                                          this.paddingLeft = 20;
                                          this.paddingRight = 20;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnConfirmPurchase",
                                             "height":45,
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_canRefresh",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnRefresh",
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalCenter = "0";
                                          this.verticalCenter = "1";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnConfirmPurchase",
                                             "width":220,
                                             "height":45,
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TextButton,
                     "id":"_linkModify"
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
            this.horizontalAlign = "center";
            this.verticalGap = 12;
         };
         this.width = 400;
         this.height = 195;
         this.addEventListener("creationComplete",this.___PurchaseBox_VBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PurchaseBox._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _haveMoneyBg() : Canvas
      {
         return this._403552034_haveMoneyBg;
      }
      
      public function __lblNeedMoney_creationComplete(param1:FlexEvent) : void
      {
         this.lblNeedMoney.text = UtilDict.toDisplay("cc","cc_label_you_need");
      }
      
      public function set ps_statusPanel(param1:StatusPanel) : void
      {
         var _loc2_:Object = this._1697255178ps_statusPanel;
         if(_loc2_ !== param1)
         {
            this._1697255178ps_statusPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_statusPanel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_statusPanel() : StatusPanel
      {
         return this._1697255178ps_statusPanel;
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxStatusPanel() : HBox
      {
         return this._47713414_boxStatusPanel;
      }
      
      public function set btnAddBuck(param1:Button) : void
      {
         var _loc2_:Object = this._1956347456btnAddBuck;
         if(_loc2_ !== param1)
         {
            this._1956347456btnAddBuck = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAddBuck",_loc2_,param1));
         }
      }
      
      public function set btnConfirm(param1:Button) : void
      {
         var _loc2_:Object = this._238395196btnConfirm;
         if(_loc2_ !== param1)
         {
            this._238395196btnConfirm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnConfirm",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canRefresh() : Canvas
      {
         return this._769627786_canRefresh;
      }
      
      private function dispatchUserWantToSave(param1:Event) : void
      {
         this.btnConfirm.removeEventListener(MouseEvent.CLICK,this.dispatchUserWantToSave);
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.USER_WANT_TO_CONFIRM,this));
      }
      
      public function ___PurchaseBox_VBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:PurchaseBox = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._PurchaseBox_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_previewAndSave_PurchaseBoxWatcherSetupUtil");
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
      
      public function set _boxStatusPanel(param1:HBox) : void
      {
         var _loc2_:Object = this._47713414_boxStatusPanel;
         if(_loc2_ !== param1)
         {
            this._47713414_boxStatusPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxStatusPanel",_loc2_,param1));
         }
      }
      
      public function set _canRefresh(param1:Canvas) : void
      {
         var _loc2_:Object = this._769627786_canRefresh;
         if(_loc2_ !== param1)
         {
            this._769627786_canRefresh = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canRefresh",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblHaveMoney() : Label
      {
         return this._1878334242lblHaveMoney;
      }
      
      public function updateMoneyBg(param1:Boolean = true) : void
      {
         this._haveMoneyBg.graphics.clear();
         this._needMoneyBg.graphics.clear();
         if(param1)
         {
            this._haveMoneyBg.graphics.lineStyle(1,12303291);
            this._haveMoneyBg.graphics.beginFill(16777215);
            this.updateButtonText(CcLibConstant.MODE_SAVE);
         }
         else
         {
            this._haveMoneyBg.graphics.lineStyle(2,16711680);
            this._haveMoneyBg.graphics.beginFill(16169128);
            this.updateButtonText(CcLibConstant.MODE_ADDBUCKS);
         }
         this._haveMoneyBg.graphics.drawRoundRect(0,0,this._haveMoneyBg.width,this._haveMoneyBg.height,20,20);
         this._haveMoneyBg.graphics.endFill();
         this._needMoneyBg.graphics.beginFill(16777215);
         this._needMoneyBg.graphics.lineStyle(1,12303291);
         this._needMoneyBg.graphics.drawRoundRect(0,0,this._needMoneyBg.width,this._needMoneyBg.height,20,20);
         this._needMoneyBg.graphics.endFill();
      }
      
      public function updateButtonText(param1:int) : void
      {
         if(param1 == CcLibConstant.MODE_SAVE)
         {
            this._vsControl.selectedChild = this._canConfirm;
            this.btnConfirm.addEventListener(MouseEvent.CLICK,this.dispatchUserWantToSave);
         }
         else if(param1 == CcLibConstant.MODE_ADDBUCKS)
         {
            this._vsControl.selectedChild = this._canAddBuck;
            this.btnAddBuck.addEventListener(MouseEvent.CLICK,this.dispatchUserWantToAddBucks);
         }
         else
         {
            this._vsControl.selectedChild = this._canRefresh;
            this.btnRefresh.addEventListener(MouseEvent.CLICK,this.dispatchUserWantToRefresh);
         }
      }
      
      private function _PurchaseBox_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("cc","Save Character");
         _loc1_ = UtilDict.toDisplay("cc","Add GoBucks to Save");
         _loc1_ = UtilDict.toDisplay("cc","Refresh Balance");
      }
      
      [Bindable(event="propertyChange")]
      public function get lblNeedMoney() : Label
      {
         return this._68526260lblNeedMoney;
      }
      
      private function onModifyButtonClick(param1:Event = null) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_CANCEL,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function onCreationComplete() : void
      {
         this.graphics.clear();
         this.graphics.beginFill(15132390,1);
         this.graphics.drawRoundRect(0,0,this.width,this.height,20,20);
         this.graphics.endFill();
         var _loc1_:DropShadowFilter = new DropShadowFilter(5,90,0,0.5);
         var _loc2_:Array = new Array();
         _loc2_.push(_loc1_);
         this.filters = _loc2_;
         this.updateMoneyBg();
         this._linkModify.label = UtilDict.toDisplay("cc","modify");
         this._linkModify.clickFunc = this.onModifyButtonClick;
         this._linkModify.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAddBuck() : Button
      {
         return this._1956347456btnAddBuck;
      }
      
      [Bindable(event="propertyChange")]
      public function get ps_userPointStatusPanel() : StatusPanel
      {
         return this._2010652631ps_userPointStatusPanel;
      }
      
      public function set _vsControl(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1155746401_vsControl;
         if(_loc2_ !== param1)
         {
            this._1155746401_vsControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsControl",_loc2_,param1));
         }
      }
      
      public function set _haveMoneyBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._403552034_haveMoneyBg;
         if(_loc2_ !== param1)
         {
            this._403552034_haveMoneyBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_haveMoneyBg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnConfirm() : Button
      {
         return this._238395196btnConfirm;
      }
      
      public function set btnRefresh(param1:Button) : void
      {
         var _loc2_:Object = this._104067873btnRefresh;
         if(_loc2_ !== param1)
         {
            this._104067873btnRefresh = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRefresh",_loc2_,param1));
         }
      }
      
      private function dispatchUserWantToRefresh(param1:Event) : void
      {
         this.btnRefresh.removeEventListener(MouseEvent.CLICK,this.dispatchUserWantToRefresh);
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.USER_WANT_TO_REFRESH,this));
      }
      
      private function dispatchUserWantToAddBucks(param1:Event) : void
      {
         this.btnAddBuck.removeEventListener(MouseEvent.CLICK,this.dispatchUserWantToAddBucks);
         this.updateButtonText(CcLibConstant.MODE_REFRESH);
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.USER_WANT_TO_BUY_POINT,this));
      }
      
      public function set lblHaveMoney(param1:Label) : void
      {
         var _loc2_:Object = this._1878334242lblHaveMoney;
         if(_loc2_ !== param1)
         {
            this._1878334242lblHaveMoney = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblHaveMoney",_loc2_,param1));
         }
      }
      
      public function __lblHaveMoney_creationComplete(param1:FlexEvent) : void
      {
         this.lblHaveMoney.text = UtilDict.toDisplay("cc","cc_label_you_have");
      }
      
      public function set _canAddBuck(param1:Canvas) : void
      {
         var _loc2_:Object = this._1464924181_canAddBuck;
         if(_loc2_ !== param1)
         {
            this._1464924181_canAddBuck = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canAddBuck",_loc2_,param1));
         }
      }
      
      public function set _canConfirm(param1:Canvas) : void
      {
         var _loc2_:Object = this._635300463_canConfirm;
         if(_loc2_ !== param1)
         {
            this._635300463_canConfirm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canConfirm",_loc2_,param1));
         }
      }
      
      public function set _needMoneyBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._167267856_needMoneyBg;
         if(_loc2_ !== param1)
         {
            this._167267856_needMoneyBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_needMoneyBg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsControl() : ViewStack
      {
         return this._1155746401_vsControl;
      }
      
      public function set _linkModify(param1:TextButton) : void
      {
         var _loc2_:Object = this._1754793715_linkModify;
         if(_loc2_ !== param1)
         {
            this._1754793715_linkModify = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_linkModify",_loc2_,param1));
         }
      }
      
      public function set ps_userPointStatusPanel(param1:StatusPanel) : void
      {
         var _loc2_:Object = this._2010652631ps_userPointStatusPanel;
         if(_loc2_ !== param1)
         {
            this._2010652631ps_userPointStatusPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ps_userPointStatusPanel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canAddBuck() : Canvas
      {
         return this._1464924181_canAddBuck;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRefresh() : Button
      {
         return this._104067873btnRefresh;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canConfirm() : Canvas
      {
         return this._635300463_canConfirm;
      }
      
      [Bindable(event="propertyChange")]
      public function get _needMoneyBg() : Canvas
      {
         return this._167267856_needMoneyBg;
      }
      
      public function set lblNeedMoney(param1:Label) : void
      {
         var _loc2_:Object = this._68526260lblNeedMoney;
         if(_loc2_ !== param1)
         {
            this._68526260lblNeedMoney = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblNeedMoney",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _linkModify() : TextButton
      {
         return this._1754793715_linkModify;
      }
      
      private function _PurchaseBox_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Save Character");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnConfirm.label = param1;
         },"btnConfirm.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Add GoBucks to Save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnAddBuck.label = param1;
         },"btnAddBuck.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Refresh Balance");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnRefresh.label = param1;
         },"btnRefresh.label");
         result[2] = binding;
         return result;
      }
   }
}
