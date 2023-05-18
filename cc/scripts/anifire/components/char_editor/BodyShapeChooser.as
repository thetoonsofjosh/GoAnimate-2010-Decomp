package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcBodyShape;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.event.CcBodyShapeChooserEvent;
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
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class BodyShapeChooser extends VBox
   {
       
      
      private var _ccTheme:CcTheme;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _207474244bodyShapeBtnContainer:HBox;
      
      public function BodyShapeChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"bodyShapeBtnContainer",
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                     this.horizontalAlign = "center";
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.verticalAlign = "middle";
            this.horizontalAlign = "center";
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyShapeBtnContainer() : HBox
      {
         return this._207474244bodyShapeBtnContainer;
      }
      
      public function set bodyShapeBtnContainer(param1:HBox) : void
      {
         var _loc2_:Object = this._207474244bodyShapeBtnContainer;
         if(_loc2_ !== param1)
         {
            this._207474244bodyShapeBtnContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyShapeBtnContainer",_loc2_,param1));
         }
      }
      
      private function get ccTheme() : CcTheme
      {
         return this._ccTheme;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function tellEveryoneBodyShape_choosen(param1:String) : void
      {
         var _loc2_:CcBodyShape = this.ccTheme.getBodyShapeByShapeId(param1);
         var _loc3_:CcBodyShapeChooserEvent = new CcBodyShapeChooserEvent(CcBodyShapeChooserEvent.BODY_SHAPE_CHOSEN,this);
         _loc3_.bodyShapeChosen = _loc2_;
         this.dispatchEvent(_loc3_);
      }
      
      private function onButtonClick(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         var _loc3_:String = String(_loc2_.id);
         this.tellEveryoneBodyShape_choosen(_loc3_);
      }
      
      public function init(param1:CcTheme, param2:int) : void
      {
         var _loc4_:CcBodyShape = null;
         var _loc5_:Button = null;
         this._ccTheme = param1;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.getBodyShapeNum())
         {
            _loc4_ = param1.getBodyShapeByIndex(_loc3_);
            (_loc5_ = new Button()).styleName = "btnBodyShape" + _loc4_.id;
            _loc5_.buttonMode = true;
            _loc5_.id = _loc4_.id;
            _loc5_.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            this.bodyShapeBtnContainer.addChild(_loc5_);
            _loc3_++;
         }
      }
   }
}
