package anifire.components.previewAndSave
{
   import anifire.cc_theme_lib.CcAction;
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcComponent;
   import anifire.cc_theme_lib.CcFacial;
   import anifire.cc_theme_lib.CcRequireComponent;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.event.CcActionChosenEvent;
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
   import mx.collections.ArrayCollection;
   import mx.collections.ICollectionView;
   import mx.collections.IViewCursor;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.containers.HBox;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class CharPreviewOptionBox extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      public var _CharPreviewOptionBox_Label2:Label;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      private var _523537547cbAction:ComboBox;
      
      private var _382745717cbFacial:ComboBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public var _CharPreviewOptionBox_Label1:Label;
      
      public function CharPreviewOptionBox()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"_CharPreviewOptionBox_Label1",
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"lblCommon"};
                  }
               }),new UIComponentDescriptor({
                  "type":ComboBox,
                  "id":"cbAction",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "styleName":"comboBoxCharPreview",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"_CharPreviewOptionBox_Label2",
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"lblCommon"};
                  }
               }),new UIComponentDescriptor({
                  "type":ComboBox,
                  "id":"cbFacial",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "styleName":"comboBoxCharPreview",
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
            this.paddingLeft = 10;
            this.paddingTop = 5;
            this.paddingRight = 10;
            this.paddingBottom = 5;
            this.verticalGap = 6;
            this.verticalAlign = "middle";
         };
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___CharPreviewOptionBox_HBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CharPreviewOptionBox._watcherSetupUtil = param1;
      }
      
      private function facialSelected(param1:Event) : void
      {
         var _loc2_:CcActionChosenEvent = new CcActionChosenEvent(CcActionChosenEvent.FACIAL_CHOSEN,this);
         _loc2_.action_id = this.cbAction.selectedItem.data;
         _loc2_.facial_id = this.cbFacial.selectedItem.data;
         this.dispatchEvent(_loc2_);
      }
      
      public function set saveEnabled(param1:Boolean) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get cbFacial() : ComboBox
      {
         return this._382745717cbFacial;
      }
      
      [Bindable(event="propertyChange")]
      public function get cbAction() : ComboBox
      {
         return this._523537547cbAction;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CharPreviewOptionBox = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CharPreviewOptionBox_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_previewAndSave_CharPreviewOptionBoxWatcherSetupUtil");
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
      
      public function set facial(param1:String) : void
      {
         var _loc2_:ICollectionView = this.cbFacial.dataProvider as ICollectionView;
         var _loc3_:IViewCursor = _loc2_.createCursor();
         while(!_loc3_.afterLast)
         {
            if(_loc3_.current.data == param1)
            {
               this.cbFacial.selectedItem = _loc3_.current;
               return;
            }
            _loc3_.moveNext();
         }
      }
      
      private function onSaveButtonClick() : void
      {
         var _loc1_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_SAVE,this);
         this.dispatchEvent(_loc1_);
      }
      
      private function checkIfRequiredComponentExist(param1:CcCharacter, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:CcRequireComponent = null;
         var _loc7_:Array = null;
         var _loc8_:CcComponent = null;
         var _loc9_:Boolean = false;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ >= param2.length)
            {
               return true;
            }
            _loc6_ = param2[_loc3_] as CcRequireComponent;
            if((_loc7_ = param1.getUserChosenComponentByComponentType(_loc6_.componentType)) == null || _loc7_.length <= 0)
            {
               return false;
            }
            _loc9_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc7_.length)
            {
               _loc8_ = _loc7_[_loc4_] as CcComponent;
               if(_loc6_.componentIds.indexOf(_loc8_.componentThumb.componentId) >= 0)
               {
                  _loc9_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc9_)
            {
               break;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function creationcomplete(param1:Event) : void
      {
      }
      
      public function ___CharPreviewOptionBox_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.creationcomplete(param1);
      }
      
      public function init(param1:CcCharacter, param2:CcTheme) : void
      {
         var _loc16_:CcAction = null;
         var _loc17_:CcFacial = null;
         var _loc3_:Number = param1.bodyShape.getActionNum();
         var _loc4_:ArrayCollection = new ArrayCollection();
         this.cbAction.dataProvider = _loc4_;
         _loc4_.disableAutoUpdate();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            if((_loc16_ = param1.bodyShape.getActionByIndex(_loc5_)).requireComponents.length <= 0 || this.checkIfRequiredComponentExist(param1,_loc16_.requireComponents))
            {
               _loc4_.addItem({
                  "label":UtilDict.toDisplay("store",_loc16_.name),
                  "data":_loc16_.id
               });
            }
            _loc5_++;
         }
         var _loc6_:Number = param2.getFacialNum();
         var _loc7_:ArrayCollection;
         (_loc7_ = new ArrayCollection()).disableAutoUpdate();
         this.cbFacial.dataProvider = _loc7_;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            if((_loc17_ = param2.getFacialByIndex(_loc8_)).requireComponents.length <= 0 || this.checkIfRequiredComponentExist(param1,_loc17_.requireComponents))
            {
               _loc7_.addItem({
                  "label":UtilDict.toDisplay("store",_loc17_.name),
                  "data":_loc17_.facialId
               });
            }
            _loc8_++;
         }
         var _loc9_:SortField;
         (_loc9_ = new SortField()).name = "label";
         _loc9_.caseInsensitive = true;
         var _loc10_:Sort;
         (_loc10_ = new Sort()).fields = [_loc9_];
         _loc4_.sort = _loc10_;
         _loc4_.refresh();
         _loc7_.sort = _loc10_;
         _loc7_.refresh();
         _loc4_.enableAutoUpdate();
         _loc7_.enableAutoUpdate();
         this.cbAction.addEventListener(Event.CHANGE,this.actionSelected);
         this.cbFacial.addEventListener(Event.CHANGE,this.facialSelected);
         var _loc11_:HBox = HBox(this);
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc14_:Number = 0;
         var _loc15_:Number = 0;
         _loc11_.clipContent = false;
         _loc11_.graphics.clear();
         _loc11_.graphics.beginFill(16777215,0.5);
         trace("can.width:" + _loc11_.width);
         _loc11_.graphics.drawRoundRectComplex(0 + _loc12_,-5 + _loc13_,763 + _loc14_,_loc11_.height + 15 + _loc15_,10,10,0,0);
         _loc11_.graphics.endFill();
      }
      
      public function set cbAction(param1:ComboBox) : void
      {
         var _loc2_:Object = this._523537547cbAction;
         if(_loc2_ !== param1)
         {
            this._523537547cbAction = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbAction",_loc2_,param1));
         }
      }
      
      public function set cbFacial(param1:ComboBox) : void
      {
         var _loc2_:Object = this._382745717cbFacial;
         if(_loc2_ !== param1)
         {
            this._382745717cbFacial = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbFacial",_loc2_,param1));
         }
      }
      
      private function actionSelected(param1:Event) : void
      {
         var _loc2_:CcActionChosenEvent = new CcActionChosenEvent(CcActionChosenEvent.ACTION_CHOSEN,this);
         _loc2_.action_id = this.cbAction.selectedItem.data;
         _loc2_.facial_id = this.cbFacial.selectedItem.data;
         this.dispatchEvent(_loc2_);
      }
      
      private function _CharPreviewOptionBox_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","cc_keyword_action");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CharPreviewOptionBox_Label1.text = param1;
         },"_CharPreviewOptionBox_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("cc","cc_keyword_facial");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CharPreviewOptionBox_Label2.text = param1;
         },"_CharPreviewOptionBox_Label2.text");
         result[1] = binding;
         return result;
      }
      
      private function _CharPreviewOptionBox_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("cc","cc_keyword_action");
         _loc1_ = UtilDict.toDisplay("cc","cc_keyword_facial");
      }
      
      public function set action(param1:String) : void
      {
         var _loc2_:ICollectionView = this.cbAction.dataProvider as ICollectionView;
         var _loc3_:IViewCursor = _loc2_.createCursor();
         while(!_loc3_.afterLast)
         {
            if(_loc3_.current.data == param1)
            {
               this.cbAction.selectedItem = _loc3_.current;
               return;
            }
            _loc3_.moveNext();
         }
      }
      
      private function onModifyButtonClick(param1:Event = null) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_CANCEL,this);
         this.dispatchEvent(_loc2_);
      }
   }
}
