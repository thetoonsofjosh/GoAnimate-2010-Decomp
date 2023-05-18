package anifire.components.char_editor
{
   import anifire.constant.CcLibConstant;
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
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.StringUtil;
   
   public class StatusPanel extends VBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _208279976gopoint:Label;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public var _StatusPanel_Canvas1:Canvas;
      
      private var _1789892366gocoupon:Text;
      
      private var _1240618781gobuck:Label;
      
      mx_internal var _watchers:Array;
      
      private var _106433028panel:HBox;
      
      private var _isUsDollarShown:Boolean;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function StatusPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_StatusPanel_Canvas1",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"gocoupon",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 14;
                              this.color = 6710886;
                              this.textAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"",
                                 "truncateToFit":true,
                                 "percentWidth":100,
                                 "height":42,
                                 "selectable":false
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "id":"panel",
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"imgGoPoint",
                                 "width":0,
                                 "height":36,
                                 "clipContent":false,
                                 "scaleX":0.8,
                                 "scaleY":0.8,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"gopoint",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 18;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"gopoint",
                                 "truncateToFit":true,
                                 "visible":false,
                                 "width":0
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"imgGoBuck",
                                 "width":36,
                                 "height":36,
                                 "clipContent":false,
                                 "scaleX":0.8,
                                 "scaleY":0.8
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"gobuck",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 18;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "text":"gobuck",
                                 "truncateToFit":true
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.clipContent = true;
         this.addEventListener("creationComplete",this.___StatusPanel_VBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         StatusPanel._watcherSetupUtil = param1;
      }
      
      private function _StatusPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = Math.max(this.panel.width,140);
      }
      
      public function set gobuck(param1:Label) : void
      {
         var _loc2_:Object = this._1240618781gobuck;
         if(_loc2_ !== param1)
         {
            this._1240618781gobuck = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gobuck",_loc2_,param1));
         }
      }
      
      public function set panel(param1:HBox) : void
      {
         var _loc2_:Object = this._106433028panel;
         if(_loc2_ !== param1)
         {
            this._106433028panel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"panel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get panel() : HBox
      {
         return this._106433028panel;
      }
      
      [Bindable(event="propertyChange")]
      public function get gocoupon() : Text
      {
         return this._1789892366gocoupon;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:StatusPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._StatusPanel_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_StatusPanelWatcherSetupUtil");
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
      
      public function set isUsDollarShown(param1:Boolean) : void
      {
         this._isUsDollarShown = param1;
      }
      
      public function init() : void
      {
         this.setGobuck(0);
         this.setGopoint(0);
      }
      
      private function _StatusPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return Math.max(panel.width,140);
         },function(param1:Number):void
         {
            _StatusPanel_Canvas1.width = param1;
         },"_StatusPanel_Canvas1.width");
         result[0] = binding;
         return result;
      }
      
      public function setGobuck(param1:Number, param2:int = 0, param3:Boolean = false, param4:int = 0) : void
      {
         trace("value:" + param1);
         var _loc5_:int = param1;
         if(param4 > 0)
         {
            _loc5_ = Math.max(param1 - param4,0);
         }
         if(this.isUsDollarShown)
         {
            this.gobuck.text = _loc5_.toString() + " (US$" + (Math.round(_loc5_) / 100).toString() + ")";
         }
         else
         {
            this.gobuck.text = _loc5_.toString();
         }
         if(!param3 && param2 == CcLibConstant.MONEY_MODE_FREE)
         {
            this.gobuck.text = "0";
         }
         if(param2 == CcLibConstant.MONEY_MODE_DONT_NEED_MONEY)
         {
            this.panel.visible = false;
         }
         var _loc6_:int = 0;
         if(param4 > 0)
         {
            _loc6_ = Math.max(param4 - param1,0);
            if(!param3)
            {
               this.gocoupon.text = StringUtil.substitute(UtilDict.toDisplay("cc","Coupon value left \n{0} GoBucks"),_loc6_.toString());
               this.gocoupon.height = 42;
            }
            else
            {
               this.gocoupon.text = "";
               this.gocoupon.height = 0;
            }
            if(_loc5_ <= 0)
            {
               this.gobuck.text = UtilDict.toDisplay("cc","cc_keyword_free");
            }
         }
         else
         {
            this.gocoupon.text = "";
            this.gocoupon.height = 0;
         }
         this.gobuck.invalidateSize();
      }
      
      public function setGopoint(param1:Number, param2:int = 0, param3:Boolean = false) : void
      {
         this.gopoint.text = param1.toString();
         if(!param3 && param2 == CcLibConstant.MONEY_MODE_FREE)
         {
            this.gopoint.text = "0";
         }
         if(param2 == CcLibConstant.MONEY_MODE_DONT_NEED_MONEY)
         {
            this.panel.visible = false;
         }
         this.gopoint.invalidateSize();
      }
      
      public function ___StatusPanel_VBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get gopoint() : Label
      {
         return this._208279976gopoint;
      }
      
      public function set gocoupon(param1:Text) : void
      {
         var _loc2_:Object = this._1789892366gocoupon;
         if(_loc2_ !== param1)
         {
            this._1789892366gocoupon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gocoupon",_loc2_,param1));
         }
      }
      
      public function get isUsDollarShown() : Boolean
      {
         return this._isUsDollarShown;
      }
      
      public function updateGoPointStyle(param1:String, param2:Object, param3:int = 0) : void
      {
         switch(param3)
         {
            case CcLibConstant.MONEY_MODE_NORMAL:
               this.gopoint.setStyle(param1,param2);
               break;
            case CcLibConstant.MONEY_MODE_DONT_NEED_MONEY:
               this.panel.visible = false;
         }
      }
      
      public function updateGoBuckStyle(param1:String, param2:Object, param3:int = 0) : void
      {
         switch(param3)
         {
            case CcLibConstant.MONEY_MODE_NORMAL:
               this.gobuck.setStyle(param1,param2);
               break;
            case CcLibConstant.MONEY_MODE_DONT_NEED_MONEY:
               this.panel.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gobuck() : Label
      {
         return this._1240618781gobuck;
      }
      
      public function set gopoint(param1:Label) : void
      {
         var _loc2_:Object = this._208279976gopoint;
         if(_loc2_ !== param1)
         {
            this._208279976gopoint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gopoint",_loc2_,param1));
         }
      }
   }
}
