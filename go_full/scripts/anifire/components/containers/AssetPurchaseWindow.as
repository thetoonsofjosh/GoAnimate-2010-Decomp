package anifire.components.containers
{
   import anifire.component.CustomCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcServerConstant;
   import anifire.constant.ServerConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.CharThumb;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.core.Thumb;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.events.AssetPurchasedEvent;
   import anifire.util.Util;
   import anifire.util.UtilColor;
   import anifire.util.UtilDict;
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
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.Application;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class AssetPurchaseWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _thumbnailCanvas:anifire.components.containers.ThumbnailCanvas;
      
      private var _219346224_lblYouHave:Label;
      
      private var _1373853913_txtTitle:Label;
      
      private var _1071629789_btnAddCredit:Button;
      
      private var _1963069400_lblDesc:Label;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _913359834_textLink:String;
      
      private var _buyBucksIcon:UIComponent;
      
      private var _aid:String;
      
      private var _2124203396_btnAddMe:Button;
      
      private var _840408360_btnBuyContainer:Canvas;
      
      private var _1087376665_assetTitle:String;
      
      private var userPoints:Array;
      
      private var _1370988937_btnCancel:Button;
      
      private var _okPurchase:Boolean = true;
      
      mx_internal var _watchers:Array;
      
      private var _1730757833_btnLink:LinkButton;
      
      private var BuyBucksIcon:Class;
      
      private var _1393874498_btnPurchase:Button;
      
      private var _isMoneyAsset:Boolean;
      
      private var _913601859_textDesc:String;
      
      private var _913622023_textCost:String;
      
      private var _2122753247_btnBuyMe:Button;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _940380787_textYou:String;
      
      private var _thumb:Thumb;
      
      private var _1598053662_labels:Label;
      
      private var _612209595_lblThisAsset:Label;
      
      private var _dobj:DisplayObject;
      
      private var _assetId:String;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function AssetPurchaseWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":502,
                  "height":244,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnPurchase",
                     "events":{"click":"___btnPurchase_click"},
                     "stylesFactory":function():void
                     {
                        this.fontSize = 16;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":146,
                           "y":201,
                           "label":"Purchase",
                           "width":105,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.bottom = "0";
                        this.horizontalAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_btnBuyContainer",
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnBuyMe",
                                    "events":{"click":"___btnBuyMe_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"assetPurchaseBuyMe",
                                          "visible":false,
                                          "buttonMode":true,
                                          "useHandCursor":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnAddMe",
                                    "events":{"click":"___btnAddMe_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"assetPurchaseAddMe",
                                          "visible":false,
                                          "buttonMode":true,
                                          "useHandCursor":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnAddCredit",
                                    "events":{"click":"___btnAddCredit_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnAddCredit",
                                          "visible":false,
                                          "buttonMode":true,
                                          "useHandCursor":true
                                       };
                                    }
                                 })]};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnCancel",
                              "events":{"click":"___btnCancel_click"},
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":105,
                                    "buttonMode":true
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 6;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":10,
                           "y":7,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"_labels",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 20;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"text":""};
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_txtTitle",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 22;
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_lblYouHave",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 16;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":13,
                           "y":136
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_lblThisAsset",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 16;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":13,
                           "y":97
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":LinkButton,
                     "id":"_btnLink",
                     "events":{"click":"___btnLink_click"},
                     "stylesFactory":function():void
                     {
                        this.color = 1794459;
                        this.fontSize = 10;
                        this.themeColor = 16777215;
                        this.textAlign = "left";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":13,
                           "y":157,
                           "buttonMode":true,
                           "useHandCursor":true,
                           "height":16
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_lblDesc",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 14;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":10,
                           "y":44,
                           "height":52,
                           "percentWidth":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HRule,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":191,
                           "percentWidth":100
                        };
                     }
                  })]
               };
            }
         });
         this.BuyBucksIcon = AssetPurchaseWindow_BuyBucksIcon;
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.layout = "absolute";
         this.width = 502;
         this.height = 244;
         this.styleName = "previewWindow";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___AssetPurchaseWindow_TitleWindow1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AssetPurchaseWindow._watcherSetupUtil = param1;
      }
      
      private function purchase() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:URLVariables = null;
         var _loc3_:URLLoader = null;
         var _loc4_:URLVariables = null;
         var _loc5_:URLRequest = null;
         var _loc6_:URLLoader = null;
         if(this._okPurchase)
         {
            this._btnPurchase.enabled = false;
            CursorManager.setBusyCursor();
            if(this.thumb is CharThumb && (this.thumb as CharThumb).isCC)
            {
               _loc1_ = new URLRequest(CcServerConstant.ACTION_SAVE_CC_CHAR);
               _loc2_ = new URLVariables();
               Util.addFlashVarsToURLvar(_loc2_);
               _loc2_["body"] = (this.thumb.imageData as Object)["xml"] as XML;
               _loc2_["title"] = "Untitled";
               _loc2_["useCcCreditFirst"] = "N";
               _loc1_.data = _loc2_;
               _loc1_.method = URLRequestMethod.POST;
               _loc3_ = new URLLoader();
               _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
               _loc3_.addEventListener(Event.COMPLETE,this.purchaseResult);
               _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.purchaseError);
               _loc3_.load(_loc1_);
            }
            else
            {
               _loc4_ = new URLVariables();
               Util.addFlashVarsToURLvar(_loc4_);
               _loc4_["uid"] = Application.application.parameters["userId"];
               _loc4_["aid"] = this.aid;
               (_loc5_ = new URLRequest(ServerConstants.ACTION_PURCHASE_ASSET)).data = _loc4_;
               _loc5_.method = URLRequestMethod.POST;
               (_loc6_ = new URLLoader()).addEventListener(Event.COMPLETE,this.purchaseResult);
               _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.purchaseError);
               _loc6_.load(_loc5_);
            }
         }
      }
      
      private function success() : void
      {
         var ti:Timer;
         this._labels.x = 0;
         this._labels.visible = true;
         this._labels.text = UtilDict.toDisplay("go","Success!");
         this._labels.width = 502;
         this._labels.y = 74;
         this._labels.setStyle("fontSize","32");
         ti = new Timer(1500,1);
         ti.addEventListener(TimerEvent.TIMER_COMPLETE,function():void
         {
            _thumbnailCanvas.closeWindow();
         });
         ti.start();
         this._txtTitle.visible = false;
         this._btnCancel.visible = false;
         this._btnPurchase.visible = false;
         this._btnLink.visible = false;
         this._dobj.visible = false;
         this._lblDesc.visible = false;
         if(this._buyBucksIcon != null)
         {
            this._buyBucksIcon.visible = false;
         }
         this._btnBuyContainer.visible = false;
         this._lblThisAsset.visible = false;
         this._lblYouHave.visible = false;
      }
      
      private function closeWindow() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      [Bindable(event="propertyChange")]
      private function get _assetTitle() : String
      {
         return this._1087376665_assetTitle;
      }
      
      public function ___btnBuyMe_click(param1:MouseEvent) : void
      {
         this.ruSure(param1);
      }
      
      private function init() : void
      {
      }
      
      private function set _textCost(param1:String) : void
      {
         var _loc2_:Object = this._913622023_textCost;
         if(_loc2_ !== param1)
         {
            this._913622023_textCost = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_textCost",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labels() : Label
      {
         return this._1598053662_labels;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBuyMe() : Button
      {
         return this._2122753247_btnBuyMe;
      }
      
      [Bindable(event="propertyChange")]
      private function get _textLink() : String
      {
         return this._913359834_textLink;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTitle() : Label
      {
         return this._1373853913_txtTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblDesc() : Label
      {
         return this._1963069400_lblDesc;
      }
      
      public function get assetId() : String
      {
         return this._assetId;
      }
      
      public function ___btnAddMe_click(param1:MouseEvent) : void
      {
         this.ruSure(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblYouHave() : Label
      {
         return this._219346224_lblYouHave;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnLink() : LinkButton
      {
         return this._1730757833_btnLink;
      }
      
      private function clickedBuyBucks(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(ServerConstants.ACTION_BUY_BUCKS),"_blank");
         this.closeWindow();
      }
      
      public function switchBuyButtonToAddMe() : void
      {
         this._btnPurchase.visible = false;
         this._btnAddMe.visible = true;
         this._btnBuyMe.visible = false;
         this._btnAddCredit.visible = false;
      }
      
      public function get aid() : String
      {
         return this._aid;
      }
      
      private function _AssetPurchaseWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Buy me!");
         _loc1_ = UtilDict.toDisplay("go","Add me!");
         _loc1_ = UtilDict.toDisplay("go","Add GoBucks");
         _loc1_ = UtilDict.toDisplay("go","Cancel");
         _loc1_ = this._assetTitle;
         _loc1_ = this._textYou;
         _loc1_ = this._textCost;
         _loc1_ = this._textLink;
         _loc1_ = this._textDesc;
      }
      
      public function set _btnBuyMe(param1:Button) : void
      {
         var _loc2_:Object = this._2122753247_btnBuyMe;
         if(_loc2_ !== param1)
         {
            this._2122753247_btnBuyMe = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBuyMe",_loc2_,param1));
         }
      }
      
      public function set _labels(param1:Label) : void
      {
         var _loc2_:Object = this._1598053662_labels;
         if(_loc2_ !== param1)
         {
            this._1598053662_labels = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labels",_loc2_,param1));
         }
      }
      
      public function get assetTitle() : String
      {
         return this._assetTitle;
      }
      
      private function set _textLink(param1:String) : void
      {
         var _loc2_:Object = this._913359834_textLink;
         if(_loc2_ !== param1)
         {
            this._913359834_textLink = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_textLink",_loc2_,param1));
         }
      }
      
      public function set _txtTitle(param1:Label) : void
      {
         var _loc2_:Object = this._1373853913_txtTitle;
         if(_loc2_ !== param1)
         {
            this._1373853913_txtTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTitle",_loc2_,param1));
         }
      }
      
      public function set _lblDesc(param1:Label) : void
      {
         var _loc2_:Object = this._1963069400_lblDesc;
         if(_loc2_ !== param1)
         {
            this._1963069400_lblDesc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblDesc",_loc2_,param1));
         }
      }
      
      public function set assetId(param1:String) : void
      {
         this._assetId = param1;
      }
      
      public function ___btnLink_click(param1:MouseEvent) : void
      {
         this.linkHandler();
      }
      
      public function get thumbnailCanvas() : anifire.components.containers.ThumbnailCanvas
      {
         return this._thumbnailCanvas;
      }
      
      public function set _lblYouHave(param1:Label) : void
      {
         var _loc2_:Object = this._219346224_lblYouHave;
         if(_loc2_ !== param1)
         {
            this._219346224_lblYouHave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblYouHave",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _textYou() : String
      {
         return this._940380787_textYou;
      }
      
      public function set _btnLink(param1:LinkButton) : void
      {
         var _loc2_:Object = this._1730757833_btnLink;
         if(_loc2_ !== param1)
         {
            this._1730757833_btnLink = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnLink",_loc2_,param1));
         }
      }
      
      public function set _lblThisAsset(param1:Label) : void
      {
         var _loc2_:Object = this._612209595_lblThisAsset;
         if(_loc2_ !== param1)
         {
            this._612209595_lblThisAsset = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblThisAsset",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      public function set aid(param1:String) : void
      {
         this._aid = param1;
      }
      
      private function set _textDesc(param1:String) : void
      {
         var _loc2_:Object = this._913601859_textDesc;
         if(_loc2_ !== param1)
         {
            this._913601859_textDesc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_textDesc",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddMe() : Button
      {
         return this._2124203396_btnAddMe;
      }
      
      private function purchaseResult(param1:Event) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:AssetPurchasedEvent = null;
         var _loc6_:XML = null;
         var _loc2_:String = URLLoader(param1.target).data as String;
         if(_loc2_.charAt(0) == "0")
         {
            this._thumb.theme.console.subPoints(this._thumb.cost);
            if(!(this.thumb is CharThumb && (this.thumb as CharThumb).isCC))
            {
               this.thumbnailCanvas.changeToPurchased();
            }
            _loc3_ = new XML(_loc2_.substring(1));
            this._thumb.theme.console.setPoints(Number(_loc3_[0].@money),Number(_loc3_[0].@sharing));
            _loc4_ = _loc3_[0].@asset_id;
            this.success();
            (_loc5_ = new AssetPurchasedEvent(AssetPurchasedEvent.ASSET_PURCHASED,this)).assetId = _loc4_;
            this.dispatchEvent(_loc5_);
         }
         else if(_loc2_.indexOf("money") > 0)
         {
            _loc6_ = new XML(_loc2_.substring(1));
            this._thumb.theme.console.setPoints(Number(_loc6_[0].@money),Number(_loc6_[0].@sharing));
            Alert.show(_loc6_[0]);
         }
         else if(_loc2_.indexOf("600001") > 0)
         {
            if(!(this.thumb is CharThumb && (this.thumb as CharThumb).isCC))
            {
               this.thumbnailCanvas.changeToPurchased();
            }
            this.success();
         }
         else
         {
            Alert.show(new XML(_loc2_.substring(1))[0]);
         }
         CursorManager.removeBusyCursor();
      }
      
      public function set _btnPurchase(param1:Button) : void
      {
         var _loc2_:Object = this._1393874498_btnPurchase;
         if(_loc2_ !== param1)
         {
            this._1393874498_btnPurchase = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPurchase",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AssetPurchaseWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AssetPurchaseWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil");
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
      
      private function _AssetPurchaseWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Buy me!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnBuyMe.label = param1;
         },"_btnBuyMe.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add me!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnAddMe.label = param1;
         },"_btnAddMe.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add GoBucks");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnAddCredit.label = param1;
         },"_btnAddCredit.label");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCancel.label = param1;
         },"_btnCancel.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _assetTitle;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtTitle.text = param1;
         },"_txtTitle.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _textYou;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _lblYouHave.text = param1;
         },"_lblYouHave.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _textCost;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _lblThisAsset.text = param1;
         },"_lblThisAsset.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _textLink;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnLink.label = param1;
         },"_btnLink.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _textDesc;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _lblDesc.text = param1;
         },"_lblDesc.text");
         result[8] = binding;
         return result;
      }
      
      private function purchaseError(param1:Event) : void
      {
         Alert.show(param1.toString());
         CursorManager.removeBusyCursor();
      }
      
      public function switchBuyButtonToAddCredit() : void
      {
         this._btnPurchase.visible = false;
         this._btnAddMe.visible = false;
         this._btnBuyMe.visible = false;
         this._btnAddCredit.visible = true;
      }
      
      public function set assetTitle(param1:String) : void
      {
         this._assetTitle = param1;
         if(param1.length > 12)
         {
            this._txtTitle.setStyle("fontSize",20);
            this._txtTitle.y += 1;
         }
         if(param1.length > 16)
         {
            this._txtTitle.setStyle("fontSize",18);
            this._txtTitle.y += 2;
         }
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.closeWindow();
      }
      
      public function ___btnPurchase_click(param1:MouseEvent) : void
      {
         this.ruSure();
      }
      
      public function set thumb(param1:Thumb) : void
      {
         var cost:Number = NaN;
         var youHave:Number = NaN;
         var args:Object = null;
         var ccMaker:CustomCharacterMaker = null;
         var ba:ByteArray = null;
         var loader:Loader = null;
         var thumb:Thumb = param1;
         this._thumb = thumb;
         this.userPoints = thumb.theme.console.getPoints();
         if(thumb is SoundThumb)
         {
            this._textCost = "This Sound costs ";
            this._labels.text = "Buy a Sound";
            this.width = 340;
         }
         else
         {
            if(thumb is CharThumb && (thumb as CharThumb).isCC)
            {
               args = thumb.imageData as Object;
               ccMaker = new CustomCharacterMaker();
               this._dobj = new Image();
               (this._dobj as Image).addChild(ccMaker);
               ccMaker.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,function():void
               {
                  var _loc1_:Number = NaN;
                  var _loc2_:int = 0;
                  var _loc3_:XML = null;
                  var _loc4_:UtilHashArray = null;
                  var _loc5_:int = 0;
                  if(ccMaker.height > ccMaker.width)
                  {
                     _loc1_ = 210 / ccMaker.height;
                     ccMaker.height *= _loc1_;
                     ccMaker.width *= _loc1_;
                     if(_loc1_ < 1)
                     {
                        ccMaker.y += 80;
                     }
                  }
                  else
                  {
                     _loc1_ = 300 / ccMaker.width;
                     ccMaker.height *= _loc1_;
                     ccMaker.width *= _loc1_;
                     if(_loc1_ < 1)
                     {
                        ccMaker.y += 80;
                     }
                  }
                  if(thumbnailCanvas.colorSetId != "")
                  {
                     _loc3_ = thumbnailCanvas.thumb.colorRef.getValueByKey(thumbnailCanvas.colorSetId);
                     _loc4_ = new UtilHashArray();
                     _loc5_ = 0;
                     while(_loc5_ < _loc3_.color.length())
                     {
                        _loc4_.push(_loc3_.color[_loc5_].@r,_loc3_.color[_loc5_]);
                        _loc5_++;
                     }
                     if(_loc4_.length > 0)
                     {
                        _loc2_ = 0;
                        while(_loc2_ < _loc4_.length)
                        {
                           UtilColor.setAssetPartColor(_dobj,_loc4_.getKey(_loc2_),_loc4_.getValueByIndex(_loc2_));
                           _loc2_++;
                        }
                     }
                  }
               });
               ccMaker.initBySwfs(args["xml"] as XML,args["imageData"] as UtilHashArray);
            }
            else
            {
               ba = new ByteArray();
               ba.writeBytes(ByteArray(thumb.imageData));
               loader = new Loader();
               this._dobj = new Image();
               Image(this._dobj).addChild(loader);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function():void
               {
                  var _loc1_:Number = NaN;
                  var _loc2_:int = 0;
                  var _loc3_:BitmapData = null;
                  var _loc4_:Bitmap = null;
                  var _loc5_:XML = null;
                  var _loc6_:UtilHashArray = null;
                  var _loc7_:int = 0;
                  if(thumb is BackgroundThumb)
                  {
                     if((thumb as BackgroundThumb).isComposite)
                     {
                        _loc3_ = Util.capturePicture(loader,new Rectangle(0,0,AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2,AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2));
                     }
                     else
                     {
                        _loc3_ = Util.capturePicture(loader,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
                     }
                     _loc4_ = new Bitmap(_loc3_);
                     _loc1_ = 150 / _loc4_.height;
                     _loc4_.height *= _loc1_;
                     _loc4_.width *= _loc1_;
                     _loc4_.y -= 25;
                     _loc4_.x = -100;
                     Image(_dobj).removeChild(loader);
                     Image(_dobj).addChild(_loc4_);
                  }
                  else if(loader.content.height > loader.content.width)
                  {
                     _loc1_ = 210 / loader.content.height;
                     loader.height *= _loc1_;
                     loader.width *= _loc1_;
                     if(_loc1_ < 1)
                     {
                        loader.content.y += 80;
                     }
                  }
                  else
                  {
                     _loc1_ = 300 / loader.content.width;
                     loader.height *= _loc1_;
                     loader.width *= _loc1_;
                     if(_loc1_ < 1)
                     {
                        loader.content.y += 80;
                     }
                  }
                  if(thumbnailCanvas.colorSetId != "")
                  {
                     _loc5_ = thumbnailCanvas.thumb.colorRef.getValueByKey(thumbnailCanvas.colorSetId);
                     _loc6_ = new UtilHashArray();
                     _loc7_ = 0;
                     while(_loc7_ < _loc5_.color.length())
                     {
                        _loc6_.push(_loc5_.color[_loc7_].@r,_loc5_.color[_loc7_]);
                        _loc7_++;
                     }
                     if(_loc6_.length > 0)
                     {
                        _loc2_ = 0;
                        while(_loc2_ < _loc6_.length)
                        {
                           UtilColor.setAssetPartColor(_dobj,_loc6_.getKey(_loc2_),_loc6_.getValueByIndex(_loc2_));
                           _loc2_++;
                        }
                     }
                  }
               });
               loader.loadBytes(ba);
            }
            this._dobj.x = 390;
            if(thumb is CharThumb)
            {
               this._textDesc = UtilDict.toDisplay("go","# Actions") + ": " + thumb.xml.descendants("action").length() + "\n" + UtilDict.toDisplay("go","# Facial Expressions") + ": " + thumb.xml.child("facial").length();
            }
            this.addChild(this._dobj);
            if(Number(thumb.cost[0]) > 0)
            {
               if(thumb is PropThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Buy a Prop");
               }
               else if(thumb is CharThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Buy a Character");
               }
               else if(thumb is EffectThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Buy an Effect");
               }
               else if(thumb is BackgroundThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Buy a Background");
               }
            }
            else if(Number(thumb.cost[1]) > 0)
            {
               if(thumb is PropThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Get a Prop");
               }
               else if(thumb is CharThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Get a Character");
               }
               else if(thumb is EffectThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Get an Effect");
               }
               else if(thumb is BackgroundThumb)
               {
                  this._labels.text = UtilDict.toDisplay("go","Get a Background");
               }
            }
            this._labels.text += ":";
            this._textCost = UtilDict.toDisplay("go","Cost") + ": ";
            if(Number(thumb.cost[0]) > 0)
            {
               this._lblThisAsset.setStyle("color","#ff7800");
               this._isMoneyAsset = true;
               cost = Number(thumb.cost[0]);
               this._textCost += cost + " GoBucks";
               this._textLink = UtilDict.toDisplay("go","What are GoBucks?");
               if(this.userPoints != null)
               {
                  youHave = Number(this.userPoints[0]);
                  this._textYou = UtilDict.toDisplay("go","Your GoBucks") + ": " + youHave;
                  if(cost > youHave)
                  {
                     this.switchBuyButtonToAddCredit();
                  }
                  if(Number(thumb.cost[0]) > Number(this.userPoints[0]))
                  {
                     this._btnPurchase.enabled = false;
                     this._okPurchase = false;
                     this._lblThisAsset.setStyle("color","#c01111");
                  }
               }
               else
               {
                  this._btnPurchase.enabled = false;
                  this._okPurchase = false;
                  this._lblThisAsset.setStyle("color","#c01111");
               }
            }
            else if(Number(thumb.cost[1]) > 0)
            {
               this._lblThisAsset.setStyle("color","#81ace7");
               cost = Number(thumb.cost[1]);
               this._textCost += cost + " GoPoints";
               this._textLink = UtilDict.toDisplay("go","How do I earn GoPoints?");
               if(this.userPoints != null)
               {
                  youHave = Number(this.userPoints[1]);
                  this._textYou = UtilDict.toDisplay("go","Your GoPoints") + ": " + youHave;
                  if(Number(thumb.cost[1]) > Number(this.userPoints[1]))
                  {
                     this._btnPurchase.enabled = false;
                     this._okPurchase = false;
                     this._lblThisAsset.setStyle("color","#c01111");
                  }
               }
               else
               {
                  this._btnPurchase.enabled = false;
                  this._okPurchase = false;
                  this._lblThisAsset.setStyle("color","#c01111");
               }
            }
         }
      }
      
      public function ___AssetPurchaseWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function doPurchase(param1:CloseEvent) : void
      {
         if(param1.detail == Alert.CANCEL)
         {
            return;
         }
         this.purchase();
      }
      
      public function set _btnAddCredit(param1:Button) : void
      {
         var _loc2_:Object = this._1071629789_btnAddCredit;
         if(_loc2_ !== param1)
         {
            this._1071629789_btnAddCredit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddCredit",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblThisAsset() : Label
      {
         return this._612209595_lblThisAsset;
      }
      
      [Bindable(event="propertyChange")]
      private function get _textDesc() : String
      {
         return this._913601859_textDesc;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPurchase() : Button
      {
         return this._1393874498_btnPurchase;
      }
      
      public function set _btnBuyContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._840408360_btnBuyContainer;
         if(_loc2_ !== param1)
         {
            this._840408360_btnBuyContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBuyContainer",_loc2_,param1));
         }
      }
      
      public function ___btnAddCredit_click(param1:MouseEvent) : void
      {
         this.clickedBuyBucks(param1);
      }
      
      public function set thumbnailCanvas(param1:anifire.components.containers.ThumbnailCanvas) : void
      {
         this._thumbnailCanvas = param1;
      }
      
      private function set _assetTitle(param1:String) : void
      {
         var _loc2_:Object = this._1087376665_assetTitle;
         if(_loc2_ !== param1)
         {
            this._1087376665_assetTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTitle",_loc2_,param1));
         }
      }
      
      public function get thumb() : Thumb
      {
         return this._thumb;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddCredit() : Button
      {
         return this._1071629789_btnAddCredit;
      }
      
      private function hideTextPU(param1:Boolean) : void
      {
         this._txtTitle.visible = param1;
         this._btnPurchase.visible = param1;
         this._btnCancel.visible = param1;
         this._labels.visible = param1;
         this._lblYouHave.visible = param1;
         this._lblThisAsset.visible = param1;
         this._btnLink.visible = param1;
         this._lblDesc.visible = param1;
         if(this._buyBucksIcon != null)
         {
            this._buyBucksIcon.visible = param1;
         }
      }
      
      public function switchBuyButtonToBuyMe() : void
      {
         this._btnPurchase.visible = false;
         this._btnAddMe.visible = false;
         this._btnBuyMe.visible = true;
         this._btnAddCredit.visible = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBuyContainer() : Canvas
      {
         return this._840408360_btnBuyContainer;
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
         }
      }
      
      private function set _textYou(param1:String) : void
      {
         var _loc2_:Object = this._940380787_textYou;
         if(_loc2_ !== param1)
         {
            this._940380787_textYou = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_textYou",_loc2_,param1));
         }
      }
      
      private function linkHandler() : void
      {
         if(this._textLink.charAt(0) == "W")
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqd"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqc"),"_blank");
         }
      }
      
      private function ruSure(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:Alert = null;
         Alert.buttonWidth = 100;
         Alert.buttonHeight = 25;
         Alert.okLabel = UtilDict.toDisplay("go","OK");
         Alert.cancelLabel = UtilDict.toDisplay("go","Cancel");
         if(this._isMoneyAsset)
         {
            if(this._thumb.cost[0] > this.userPoints[0])
            {
               _loc3_ = Alert.show(UtilDict.toDisplay("go","You do not have enough GoBucks."),UtilDict.toDisplay("go","Cannot continue"));
            }
            else
            {
               _loc2_ = UtilDict.toDisplay("go","Remaining balance") + ":  " + (Number(this.userPoints[0]) - Number(this._thumb.cost[0])) + " GoBucks";
               this.purchase();
            }
         }
         else if(this._thumb.cost[1] > this.userPoints[1])
         {
            _loc3_ = Alert.show(UtilDict.toDisplay("go","You do not have enough GoPoints."),UtilDict.toDisplay("go","Cannot continue"));
         }
         else
         {
            _loc2_ = UtilDict.toDisplay("go","Remaining balance") + ":  " + (Number(this.userPoints[1]) - Number(this._thumb.cost[1])) + " GoPoints";
            this.purchase();
         }
         _loc3_.setStyle("backgroundColor",16777215);
         _loc3_.setStyle("color",0);
         _loc3_.setStyle("paddingLeft",0);
         _loc3_.setStyle("borderColor",16777215);
         _loc3_.setStyle("fontSize",13);
      }
      
      [Bindable(event="propertyChange")]
      private function get _textCost() : String
      {
         return this._913622023_textCost;
      }
      
      public function set _btnAddMe(param1:Button) : void
      {
         var _loc2_:Object = this._2124203396_btnAddMe;
         if(_loc2_ !== param1)
         {
            this._2124203396_btnAddMe = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddMe",_loc2_,param1));
         }
      }
   }
}
