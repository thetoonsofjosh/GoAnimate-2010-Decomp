package anifire.components.studio
{
   import anifire.component.MultilineButton;
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
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
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.states.AddChild;
   import mx.states.RemoveChild;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   
   public class MyCharButton extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _MyCharButton_RemoveChild1:RemoveChild;
      
      public var _MyCharButton_SetProperty1:SetProperty;
      
      public var _MyCharButton_SetProperty2:SetProperty;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _647764506_i18n_btn:MultilineButton;
      
      private var _754073148_eng_btn:Button;
      
      public function MyCharButton()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":93,
                  "height":38,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":MultilineButton,
                     "id":"_i18n_btn",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":93,
                           "height":38,
                           "styleName":"btnMyCharFull"
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
         this.width = 93;
         this.height = 38;
         this.states = [this._MyCharButton_State1_c(),this._MyCharButton_State2_c(),this._MyCharButton_State3_c()];
         this.addEventListener("creationComplete",this.___MyCharButton_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MyCharButton._watcherSetupUtil = param1;
      }
      
      private function _MyCharButton_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _i18n_btn.label = param1;
         },"_i18n_btn.label");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return _i18n_btn;
         },function(param1:Object):void
         {
            _MyCharButton_SetProperty1.target = param1;
         },"_MyCharButton_SetProperty1.target");
         result[1] = binding;
         binding = new Binding(this,function():DisplayObject
         {
            return _i18n_btn;
         },function(param1:DisplayObject):void
         {
            _MyCharButton_RemoveChild1.target = param1;
         },"_MyCharButton_RemoveChild1.target");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return _eng_btn;
         },function(param1:Object):void
         {
            _MyCharButton_SetProperty2.target = param1;
         },"_MyCharButton_SetProperty2.target");
         result[3] = binding;
         return result;
      }
      
      private function _MyCharButton_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Your characters");
         _loc1_ = this._i18n_btn;
         _loc1_ = this._i18n_btn;
         _loc1_ = this._eng_btn;
      }
      
      public function set _i18n_btn(param1:MultilineButton) : void
      {
         var _loc2_:Object = this._647764506_i18n_btn;
         if(_loc2_ !== param1)
         {
            this._647764506_i18n_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_i18n_btn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _eng_btn() : Button
      {
         return this._754073148_eng_btn;
      }
      
      private function _MyCharButton_RemoveChild1_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._MyCharButton_RemoveChild1 = _loc1_;
         BindingManager.executeBindings(this,"_MyCharButton_RemoveChild1",this._MyCharButton_RemoveChild1);
         return _loc1_;
      }
      
      private function _MyCharButton_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MyCharButton_SetProperty1 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_MyCharButton_SetProperty1",this._MyCharButton_SetProperty1);
         return _loc1_;
      }
      
      private function _MyCharButton_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MyCharButton_SetProperty2 = _loc1_;
         _loc1_.name = "styleName";
         _loc1_.value = "btnMyCharFull";
         BindingManager.executeBindings(this,"_MyCharButton_SetProperty2",this._MyCharButton_SetProperty2);
         return _loc1_;
      }
      
      private function _MyCharButton_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "go_english";
         _loc1_.overrides = [this._MyCharButton_SetProperty2_i()];
         return _loc1_;
      }
      
      private function _MyCharButton_AddChild1_c() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MyCharButton_Button1_i);
         return _loc1_;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MyCharButton = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MyCharButton_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MyCharButtonWatcherSetupUtil");
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
      
      private function _MyCharButton_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "go_english";
         _loc1_.overrides = [this._MyCharButton_RemoveChild1_i(),this._MyCharButton_AddChild1_c()];
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _i18n_btn() : MultilineButton
      {
         return this._647764506_i18n_btn;
      }
      
      private function switchFacet() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         if(_loc2_ != null && _loc2_ == "domo")
         {
            currentState = "domo";
         }
         else if(_loc2_ == null && !UtilLicense.isBoxEnvironment() && (_loc3_ == null || _loc3_ == "" || _loc3_ == "en_US"))
         {
            currentState = "go_english";
         }
         else if(UtilLicense.isBoxEnvironment())
         {
            currentState = "hideButton";
         }
      }
      
      private function _MyCharButton_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "hideButton";
         _loc1_.overrides = [this._MyCharButton_SetProperty1_i()];
         return _loc1_;
      }
      
      public function ___MyCharButton_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.switchFacet();
      }
      
      private function _MyCharButton_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         this._eng_btn = _loc1_;
         _loc1_.width = 93;
         _loc1_.height = 38;
         _loc1_.styleName = "btnMyCharFullEng";
         _loc1_.id = "_eng_btn";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      public function set _eng_btn(param1:Button) : void
      {
         var _loc2_:Object = this._754073148_eng_btn;
         if(_loc2_ !== param1)
         {
            this._754073148_eng_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_eng_btn",_loc2_,param1));
         }
      }
   }
}
