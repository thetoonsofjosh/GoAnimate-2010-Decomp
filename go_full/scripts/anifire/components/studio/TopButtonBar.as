package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.events.SelectedAreaEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilNetwork;
   import com.adobe.images.JPGEncoder;
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
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.VRule;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ToolTipManager;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   
   public class TopButtonBar extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _414147301_openStar:Canvas;
      
      private var _buttonArray:Array;
      
      private var _198515965_btnScreenShot:IconTextButton;
      
      mx_internal var _watchers:Array;
      
      private var _1479369800_txtIdea:Label;
      
      private var _1730556742_btnSave:IconTextButton;
      
      private var _152466351_vrSecond:VRule;
      
      private var _419384469_btnPreview:IconTextButton;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1329644227_btnNew:IconTextButton;
      
      private var _1336746749_maskCanvas:Canvas;
      
      private var _91152169_open:Canvas;
      
      mx_internal var _bindings:Array;
      
      public var _TopButtonBar_SetProperty1:SetProperty;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function TopButtonBar()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":358,
                  "height":66,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnScreenShot",
                     "events":{"click":"___btnScreenShot_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":14,
                           "y":0,
                           "styleName":"btnScreenShotFull",
                           "buttonMode":true,
                           "labelPlacement":"bottom"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VRule,
                     "id":"_vrSecond",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":103,
                           "y":15,
                           "height":35
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnSave",
                     "events":{"click":"___btnSave_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":116,
                           "y":15,
                           "width":85,
                           "styleName":"btnSave",
                           "buttonMode":true,
                           "labelPlacement":"bottom"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnNew",
                     "events":{"click":"___btnNew_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":158,
                           "y":15,
                           "styleName":"btnNew",
                           "buttonMode":true,
                           "labelPlacement":"bottom"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnPreview",
                     "events":{"click":"___btnPreview_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":216,
                           "y":15,
                           "styleName":"btnPreview",
                           "buttonMode":true,
                           "labelPlacement":"bottom"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_open",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":4,
                           "height":28,
                           "mouseChildren":false,
                           "buttonMode":true,
                           "useHandCursor":true,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_openStar",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":13,
                                    "y":14
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_txtIdea",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.fontSize = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":21,
                                    "y":7,
                                    "selectable":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":648,
                           "height":66,
                           "alpha":0,
                           "visible":false
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
         this.width = 358;
         this.height = 66;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.states = [this._TopButtonBar_State1_c()];
         this.addEventListener("creationComplete",this.___TopButtonBar_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TopButtonBar._watcherSetupUtil = param1;
      }
      
      public function set _btnNew(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1329644227_btnNew;
         if(_loc2_ !== param1)
         {
            this._1329644227_btnNew = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNew",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:TopButtonBar = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._TopButtonBar_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_TopButtonBarWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      public function get _btnScreenShot() : IconTextButton
      {
         return this._198515965_btnScreenShot;
      }
      
      public function set _btnScreenShot(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._198515965_btnScreenShot;
         if(_loc2_ !== param1)
         {
            this._198515965_btnScreenShot = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnScreenShot",_loc2_,param1));
         }
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         if(param1)
         {
            this._maskCanvas.visible = true;
         }
         else
         {
            this._maskCanvas.visible = false;
         }
      }
      
      public function set _maskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1336746749_maskCanvas;
         if(_loc2_ !== param1)
         {
            this._1336746749_maskCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvas",_loc2_,param1));
         }
      }
      
      private function orderButton(param1:Array, param2:Number, param3:Number, param4:Number = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Number = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(param4 > 0 && DisplayObject(param1[_loc5_]) is Button)
            {
               _loc6_ += param4;
            }
            else
            {
               _loc6_ += DisplayObject(param1[_loc5_]).width;
            }
            _loc5_++;
         }
         var _loc7_:Number;
         var _loc8_:Number = (_loc7_ = param2 - _loc6_) / (param1.length + 1);
         var _loc9_:Number = param3;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc9_ += _loc8_;
            DisplayObject(param1[_loc5_]).x = _loc9_;
            if(param4 > 0 && DisplayObject(param1[_loc5_]) is Button)
            {
               DisplayObject(param1[_loc5_]).x = DisplayObject(param1[_loc5_]).x - (DisplayObject(param1[_loc5_]).width - param4) / 2;
               _loc9_ += param4;
            }
            else
            {
               _loc9_ += DisplayObject(param1[_loc5_]).width;
            }
            _loc5_++;
         }
      }
      
      public function changeToFullSize() : void
      {
         this.invalidateSize();
         this.invalidateDisplayList();
         this._btnSave.styleName = "btnSaveFull";
         this._btnSave.x = 290;
         this._btnSave.y = 0;
         this._btnNew.styleName = "btnNewFull";
         this._btnNew.x = 351;
         this._btnNew.y = 0;
         this._vrSecond.x = 443;
         this._vrSecond.y = 5;
         this._vrSecond.height = 32;
         this._btnPreview.styleName = "btnPreviewFull";
         this._btnPreview.x = 463;
         this._btnPreview.y = 0;
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
         }
         this.orderButton(this._buttonArray,288,18,0);
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            this._btnNew.enabled = false;
            this._btnSave.enabled = false;
            this._btnSave.styleName = "btnSaveFullDisabled";
         }
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         Console.getConsole().showPublishWindow();
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvas() : Canvas
      {
         return this._1336746749_maskCanvas;
      }
      
      public function set _txtIdea(param1:Label) : void
      {
         var _loc2_:Object = this._1479369800_txtIdea;
         if(_loc2_ !== param1)
         {
            this._1479369800_txtIdea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtIdea",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _open() : Canvas
      {
         return this._91152169_open;
      }
      
      [Bindable(event="propertyChange")]
      public function get _openStar() : Canvas
      {
         return this._414147301_openStar;
      }
      
      public function ___btnScreenShot_click(param1:MouseEvent) : void
      {
         this.captureMainStage();
      }
      
      private function _TopButtonBar_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_screenshot");
         _loc1_ = UtilDict.toDisplay("go","Screenshot");
         _loc1_ = UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         _loc1_ = UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_savenshare");
         _loc1_ = UtilDict.toDisplay("go","Save");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_new");
         _loc1_ = UtilDict.toDisplay("go","New");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_preview");
         _loc1_ = UtilDict.toDisplay("go","Preview");
         _loc1_ = this.width - this._open.width;
         _loc1_ = this._txtIdea.width + 25;
         _loc1_ = UtilDict.toDisplay("go","IDEAS");
         _loc1_ = this._btnSave;
         _loc1_ = UtilDict.toDisplay("go","Auto-Saving");
      }
      
      [Bindable(event="propertyChange")]
      public function get _vrSecond() : VRule
      {
         return this._152466351_vrSecond;
      }
      
      public function ___btnNew_click(param1:MouseEvent) : void
      {
         this.clickNewAnimationButton(param1);
      }
      
      public function set _openStar(param1:Canvas) : void
      {
         var _loc2_:Object = this._414147301_openStar;
         if(_loc2_ !== param1)
         {
            this._414147301_openStar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_openStar",_loc2_,param1));
         }
      }
      
      private function captureMainStage() : void
      {
         Util.gaTracking("/gostudio/screenCapture",this.stage);
         var _loc1_:MainStage = Console.getConsole().mainStage;
         Console.getConsole().currentScene.selectedAsset = null;
         Console.getConsole().screenCapTool.addEventListener(SelectedAreaEvent.AREA_SELECTED,this.onSelectedCaptureArea);
         Console.getConsole().screenCapTool.show(_loc1_.x + AnimeConstants.SCREEN_X,_loc1_.y + AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
      }
      
      private function clickNewAnimationButton(param1:MouseEvent) : void
      {
         trace(Console.getConsole().getStoreCollection());
         if((Util.getFlashVar().getValueByKey("apiserver") as String).search("alvin") > 0 && param1.altKey && param1.ctrlKey)
         {
            Console.getConsole().alertSceneXml();
         }
         Console.getConsole().removeGuideBubbles();
         Console.getConsole().doNewAnimation();
      }
      
      private function openInspiration(param1:Event) : void
      {
         Console.getConsole().showInspirationWindow();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : IconTextButton
      {
         return this._1730556742_btnSave;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNew() : IconTextButton
      {
         return this._1329644227_btnNew;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtIdea() : Label
      {
         return this._1479369800_txtIdea;
      }
      
      private function initToolbar() : void
      {
         var _loc1_:Matrix = null;
         var _loc2_:DropShadowFilter = null;
         var _loc3_:Array = null;
         ToolTipManager.showDelay = 200;
         StyleManager.getStyleDeclaration("ToolTip").setStyle("fontSize","14");
         this._buttonArray = new Array(this._btnScreenShot,this._vrSecond,this._btnNew,this._btnPreview,this._btnSave);
         this.orderButton(this._buttonArray,320,0);
         if(UtilLicense.isUploadRelatedButtonShouldBeShown())
         {
         }
         if(!UtilLicense.isInspirationButtonShouldBeShown())
         {
            this._open.visible = false;
         }
         else
         {
            trace("open.width" + this._open.width);
            _loc1_ = new Matrix();
            _loc1_.createGradientBox(this._open.width,this._open.height,90);
            this._open.visible = true;
            this._open.graphics.clear();
            this._open.graphics.beginGradientFill(GradientType.LINEAR,[16567711,16160294],[1,1],[0,255],_loc1_);
            this._open.graphics.drawRoundRectComplex(0,0,this._open.width,this._open.height,20,0,20,0);
            this._open.graphics.endFill();
            _loc2_ = new DropShadowFilter(1,90,0,0.5);
            _loc3_ = new Array();
            _loc3_.push(_loc2_);
            this._open.filters = _loc3_;
            this._open.buttonMode = true;
            this._open.useHandCursor = true;
            this._open.addEventListener(MouseEvent.CLICK,this.openInspiration);
            this._openStar.graphics.clear();
            this._openStar.graphics.lineStyle(3,6710886);
            this._openStar.graphics.moveTo(-2,-2);
            this._openStar.graphics.lineTo(4,0);
            this._openStar.graphics.lineTo(-2,2);
            this._openStar.graphics.endFill();
         }
      }
      
      public function set _open(param1:Canvas) : void
      {
         var _loc2_:Object = this._91152169_open;
         if(_loc2_ !== param1)
         {
            this._91152169_open = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_open",_loc2_,param1));
         }
      }
      
      public function ___btnPreview_click(param1:MouseEvent) : void
      {
         Console.getConsole().preview();
      }
      
      public function set _btnPreview(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._419384469_btnPreview;
         if(_loc2_ !== param1)
         {
            this._419384469_btnPreview = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPreview",_loc2_,param1));
         }
      }
      
      public function set _vrSecond(param1:VRule) : void
      {
         var _loc2_:Object = this._152466351_vrSecond;
         if(_loc2_ !== param1)
         {
            this._152466351_vrSecond = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vrSecond",_loc2_,param1));
         }
      }
      
      private function _TopButtonBar_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "autoSave";
         _loc1_.overrides = [this._TopButtonBar_SetProperty1_i()];
         return _loc1_;
      }
      
      private function _TopButtonBar_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._TopButtonBar_SetProperty1 = _loc1_;
         _loc1_.name = "label";
         BindingManager.executeBindings(this,"_TopButtonBar_SetProperty1",this._TopButtonBar_SetProperty1);
         return _loc1_;
      }
      
      public function ___TopButtonBar_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initToolbar();
      }
      
      public function set _btnSave(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730556742_btnSave;
         if(_loc2_ !== param1)
         {
            this._1730556742_btnSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSave",_loc2_,param1));
         }
      }
      
      private function onSelectedCaptureArea(param1:SelectedAreaEvent) : void
      {
         var _loc5_:BitmapData = null;
         Console.getConsole().screenCapTool.removeEventListener(SelectedAreaEvent.AREA_SELECTED,this.onSelectedCaptureArea);
         var _loc2_:MainStage = Console.getConsole().mainStage;
         var _loc3_:Point = param1.startPt;
         _loc3_.x -= _loc2_.x;
         _loc3_.y -= _loc2_.y;
         var _loc4_:Point = param1.endPt;
         _loc4_.x -= _loc2_.x;
         _loc4_.y -= _loc2_.y;
         var _loc6_:Matrix = new Matrix();
         if(Math.abs(_loc4_.x - _loc3_.x) * Math.abs(_loc4_.y - _loc3_.y) < 100)
         {
            _loc5_ = new BitmapData(AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
            _loc6_.translate(-AnimeConstants.SCREEN_X,-AnimeConstants.SCREEN_Y);
         }
         else
         {
            _loc5_ = new BitmapData(Math.abs(_loc4_.x - _loc3_.x),Math.abs(_loc4_.y - _loc3_.y));
            _loc6_.translate(-_loc3_.x,-_loc3_.y);
         }
         _loc6_.scale(1,1);
         _loc5_.draw(_loc2_,_loc6_);
         var _loc7_:JPGEncoder;
         var _loc8_:ByteArray = (_loc7_ = new JPGEncoder(85)).encode(_loc5_);
         var _loc9_:URLRequest = UtilNetwork.getSaveJpegReuqest("screen.jpg",_loc8_);
         navigateToURL(_loc9_,"_self");
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPreview() : IconTextButton
      {
         return this._419384469_btnPreview;
      }
      
      private function _TopButtonBar_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_screenshot");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnScreenShot.toolTip = param1;
         },"_btnScreenShot.toolTip");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Screenshot");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnScreenShot.label = param1;
         },"_btnScreenShot.label");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         },function(param1:Boolean):void
         {
            _btnScreenShot.visible = param1;
         },"_btnScreenShot.visible");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         },function(param1:Boolean):void
         {
            _vrSecond.visible = param1;
         },"_vrSecond.visible");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_savenshare");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.toolTip = param1;
         },"_btnSave.toolTip");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.label = param1;
         },"_btnSave.label");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_new");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnNew.toolTip = param1;
         },"_btnNew.toolTip");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","New");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnNew.label = param1;
         },"_btnNew.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_preview");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnPreview.toolTip = param1;
         },"_btnPreview.toolTip");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Preview");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnPreview.label = param1;
         },"_btnPreview.label");
         result[9] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width - _open.width;
         },function(param1:Number):void
         {
            _open.x = param1;
         },"_open.x");
         result[10] = binding;
         binding = new Binding(this,function():Number
         {
            return _txtIdea.width + 25;
         },function(param1:Number):void
         {
            _open.width = param1;
         },"_open.width");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","IDEAS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtIdea.text = param1;
         },"_txtIdea.text");
         result[12] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnSave;
         },function(param1:Object):void
         {
            _TopButtonBar_SetProperty1.target = param1;
         },"_TopButtonBar_SetProperty1.target");
         result[13] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Auto-Saving");
         },function(param1:*):void
         {
            _TopButtonBar_SetProperty1.value = param1;
         },"_TopButtonBar_SetProperty1.value");
         result[14] = binding;
         return result;
      }
   }
}
