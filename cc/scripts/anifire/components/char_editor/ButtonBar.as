package anifire.components.char_editor
{
   import anifire.event.CcButtonBarEvent;
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
   import mx.containers.Box;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ButtonBar extends Box implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _206257504btnUndo:Button;
      
      private var _206159482btnRedo:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _206185977btnSave:Button;
      
      mx_internal var _watchers:Array;
      
      private var _547363391btnRandom:Button;
      
      mx_internal var _bindings:Array;
      
      private var _2095990867btnReset:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ButtonBar()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Box,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnUndo",
                  "events":{"click":"__btnUndo_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnBarUndo",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnRedo",
                  "events":{"click":"__btnRedo_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnBarRedo",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnReset",
                  "events":{"click":"__btnReset_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnBarReset",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnRandom",
                  "events":{"click":"__btnRandom_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnBarRandom",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"btnSave",
                  "events":{"click":"__btnSave_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnBarSave",
                        "buttonMode":true
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
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 2310708;
            this.backgroundAlpha = 0;
            this.horizontalGap = 5;
         };
         this.direction = "horizontal";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ButtonBar._watcherSetupUtil = param1;
      }
      
      public function set btnUndo(param1:Button) : void
      {
         var _loc2_:Object = this._206257504btnUndo;
         if(_loc2_ !== param1)
         {
            this._206257504btnUndo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnUndo",_loc2_,param1));
         }
      }
      
      public function set btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._206185977btnSave;
         if(_loc2_ !== param1)
         {
            this._206185977btnSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSave",_loc2_,param1));
         }
      }
      
      public function __btnUndo_click(param1:MouseEvent) : void
      {
         this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.UNDO_BUTTON_CLICK,this));
      }
      
      [Bindable(event="propertyChange")]
      public function get btnReset() : Button
      {
         return this._2095990867btnReset;
      }
      
      private function _ButtonBar_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("cc","Undo");
         _loc1_ = UtilDict.toDisplay("cc","Redo");
         _loc1_ = UtilDict.toDisplay("cc","Reset");
         _loc1_ = UtilDict.toDisplay("cc","Random");
         _loc1_ = UtilDict.toDisplay("cc","Save");
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ButtonBar = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ButtonBar_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_ButtonBarWatcherSetupUtil");
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
      public function get btnUndo() : Button
      {
         return this._206257504btnUndo;
      }
      
      public function __btnSave_click(param1:MouseEvent) : void
      {
         this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.SAVE_BUTTON_CLICK,this));
      }
      
      public function __btnRedo_click(param1:MouseEvent) : void
      {
         this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.REDO_BUTTON_CLICK,this));
      }
      
      public function set btnReset(param1:Button) : void
      {
         var _loc2_:Object = this._2095990867btnReset;
         if(_loc2_ !== param1)
         {
            this._2095990867btnReset = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnReset",_loc2_,param1));
         }
      }
      
      public function __btnRandom_click(param1:MouseEvent) : void
      {
         this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.RANDOMIZE_BUTTON_CLICK,this));
      }
      
      private function _ButtonBar_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Undo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnUndo.toolTip = param1;
         },"btnUndo.toolTip");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Redo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnRedo.toolTip = param1;
         },"btnRedo.toolTip");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Reset");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnReset.toolTip = param1;
         },"btnReset.toolTip");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Random");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnRandom.toolTip = param1;
         },"btnRandom.toolTip");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","Save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            btnSave.toolTip = param1;
         },"btnSave.toolTip");
         result[4] = binding;
         return result;
      }
      
      public function set btnRedo(param1:Button) : void
      {
         var _loc2_:Object = this._206159482btnRedo;
         if(_loc2_ !== param1)
         {
            this._206159482btnRedo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRedo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSave() : Button
      {
         return this._206185977btnSave;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRedo() : Button
      {
         return this._206159482btnRedo;
      }
      
      public function __btnReset_click(param1:MouseEvent) : void
      {
         this.dispatchEvent(new CcButtonBarEvent(CcButtonBarEvent.RESET_BUTTON_CLICK,this));
      }
      
      public function set btnRandom(param1:Button) : void
      {
         var _loc2_:Object = this._547363391btnRandom;
         if(_loc2_ !== param1)
         {
            this._547363391btnRandom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRandom",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRandom() : Button
      {
         return this._547363391btnRandom;
      }
   }
}
