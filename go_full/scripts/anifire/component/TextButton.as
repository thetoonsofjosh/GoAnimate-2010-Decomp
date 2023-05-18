package anifire.component
{
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
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class TextButton extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _442062729_txtWeight:String;
      
      private var _txtSize:Number = 15;
      
      private var _txtAlign:String = "left";
      
      mx_internal var _watchers:Array;
      
      private var _1389382606_txtColor:uint;
      
      private var _clickFunc:Function;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _115312txt:Text;
      
      private var _label:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _widthOverride:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      public function TextButton()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Text,
                  "id":"txt",
                  "stylesFactory":function():void
                  {
                     this.fontSize = 15;
                     this.textAlign = "left";
                     this.textDecoration = "underline";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"hitArea",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               })]};
            }
         });
         this._clickFunc = new Function();
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.autoLayout = true;
         this.addEventListener("creationComplete",this.___TextButton_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TextButton._watcherSetupUtil = param1;
      }
      
      private function _TextButton_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._txtWeight;
         _loc1_ = this._txtColor;
      }
      
      public function set color(param1:uint) : void
      {
         this._txtColor = param1;
         if(this.initialized)
         {
            this.txt.setStyle("fontColor",this._txtColor);
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _txtWeight() : String
      {
         return this._442062729_txtWeight;
      }
      
      override public function set width(param1:Number) : void
      {
         this._widthOverride = true;
         super.width = param1;
      }
      
      private function doRollOut(param1:Event) : void
      {
         this.txt.setStyle("textDecoration","underline");
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:TextButton = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._TextButton_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_TextButtonWatcherSetupUtil");
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
      
      private function set _txtColor(param1:uint) : void
      {
         var _loc2_:Object = this._1389382606_txtColor;
         if(_loc2_ !== param1)
         {
            this._1389382606_txtColor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtColor",_loc2_,param1));
         }
      }
      
      private function _TextButton_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _txtWeight;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            txt.setStyle("fontWeight",param1);
         },"txt.fontWeight");
         result[0] = binding;
         binding = new Binding(this,function():uint
         {
            return _txtColor;
         },function(param1:uint):void
         {
            txt.setStyle("color",param1);
         },"txt.color");
         result[1] = binding;
         return result;
      }
      
      public function set clickFunc(param1:Function) : void
      {
         this._clickFunc = param1;
      }
      
      private function set _txtWeight(param1:String) : void
      {
         var _loc2_:Object = this._442062729_txtWeight;
         if(_loc2_ !== param1)
         {
            this._442062729_txtWeight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWeight",_loc2_,param1));
         }
      }
      
      public function set txtWeight(param1:String) : void
      {
         this._txtWeight = param1;
         if(this.initialized)
         {
            this.txt.setStyle("fontWeight",this._txtWeight);
         }
      }
      
      public function set txt(param1:Text) : void
      {
         var _loc2_:Object = this._115312txt;
         if(_loc2_ !== param1)
         {
            this._115312txt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txt",_loc2_,param1));
         }
      }
      
      public function set txtSize(param1:Number) : void
      {
         this._txtSize = param1;
      }
      
      private function doRollOver(param1:Event) : void
      {
         this.txt.setStyle("textDecoration","none");
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get txt() : Text
      {
         return this._115312txt;
      }
      
      public function set txtAlign(param1:String) : void
      {
         this._txtAlign = param1;
      }
      
      override public function get label() : String
      {
         return this._label;
      }
      
      [Bindable(event="propertyChange")]
      private function get _txtColor() : uint
      {
         return this._1389382606_txtColor;
      }
      
      public function init() : void
      {
         this.txt.text = this._label;
         if(!this._widthOverride)
         {
            if(this.txt.measureText(this.txt.text).width > width)
            {
               this.txt.width = this.txt.measureText(this.txt.text).width + 5;
               this.width = this.txt.width;
            }
         }
         this.txt.selectable = false;
         this.txt.setStyle("fontSize",this._txtSize);
         this.txt.setStyle("textAlign",this._txtAlign);
         hitArea.addEventListener(MouseEvent.ROLL_OVER,this.doRollOver);
         hitArea.addEventListener(MouseEvent.ROLL_OUT,this.doRollOut);
         hitArea.addEventListener(MouseEvent.CLICK,this._clickFunc);
         hitArea.buttonMode = true;
         hitArea.useHandCursor = true;
      }
      
      public function ___TextButton_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
   }
}
