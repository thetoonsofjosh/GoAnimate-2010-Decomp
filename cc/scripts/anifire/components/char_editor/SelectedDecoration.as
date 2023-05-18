package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcComponent;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcComponentThumbnailMouseEvent;
   import anifire.event.CcSelectedDecorationEvent;
   import anifire.util.ExtraDataTimer;
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
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class SelectedDecoration extends Canvas
   {
       
      
      private var _55416058leftBut:Button;
      
      private var _timer:ExtraDataTimer;
      
      private var _1436107067rightBut:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _selectedThumb:anifire.components.char_editor.CcComponentThumbThumbnail;
      
      private var _1754705447selectedList:HBox;
      
      public function SelectedDecoration()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"leftBut",
                           "events":{
                              "mouseDown":"__leftBut_mouseDown",
                              "mouseUp":"__leftBut_mouseUp",
                              "mouseOut":"__leftBut_mouseOut"
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnThumbChooserLeft"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"selectedList",
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 12;
                              this.paddingTop = 4;
                              this.paddingLeft = 5;
                              this.paddingRight = 5;
                              this.verticalAlign = "middle";
                              this.borderStyle = "solid";
                              this.borderColor = 10066329;
                              this.backgroundColor = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":412,
                                 "percentHeight":100,
                                 "horizontalScrollPolicy":"off"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"rightBut",
                           "events":{
                              "mouseDown":"__rightBut_mouseDown",
                              "mouseUp":"__rightBut_mouseUp",
                              "mouseOut":"__rightBut_mouseOut"
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnThumbChooserRight"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___SelectedDecoration_Canvas1_creationComplete);
      }
      
      private function onThumbMouseOut(param1:Event) : void
      {
         var _loc3_:CcSelectedDecorationEvent = null;
         var _loc2_:anifire.components.char_editor.CcComponentThumbThumbnail = param1.currentTarget as anifire.components.char_editor.CcComponentThumbThumbnail;
         _loc3_ = new CcSelectedDecorationEvent(CcSelectedDecorationEvent.DECORATION_MOUSE_OUT,this);
         _loc3_.ccComponent = _loc2_.component;
         this.dispatchEvent(_loc3_);
         if(_loc2_ != this._selectedThumb)
         {
            _loc2_.control.visible = false;
         }
      }
      
      private function startTimer(param1:Number) : void
      {
         this._timer = new ExtraDataTimer(1,0,param1);
         this._timer.addEventListener(TimerEvent.TIMER,this.doTimer);
         this._timer.start();
      }
      
      public function set selectedThumb(param1:anifire.components.char_editor.CcComponentThumbThumbnail) : void
      {
         var _loc2_:Number = Number(this.selectedList.numChildren);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            CcComponentThumbThumbnail(this.selectedList.getChildAt(_loc3_)).control.visible = false;
            _loc3_++;
         }
         this._selectedThumb = param1;
         CcComponentThumbThumbnail(param1).control.visible = true;
      }
      
      private function onMouseUp(param1:Event) : void
      {
         if(this._timer != null && this._timer.running)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.doTimer);
         }
      }
      
      public function __leftBut_mouseDown(param1:MouseEvent) : void
      {
         this.updateScrollPosition(param1);
      }
      
      public function __rightBut_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseUp(param1);
      }
      
      private function addThumbnail(param1:CcComponent, param2:String) : void
      {
         var _loc5_:String = null;
         var _loc3_:anifire.components.char_editor.CcComponentThumbThumbnail = new anifire.components.char_editor.CcComponentThumbThumbnail();
         var _loc4_:CcComponentThumbDetailThumbnail = new CcComponentThumbDetailThumbnail();
         if(param1.componentThumb != null)
         {
            _loc3_.init(_loc4_,CcLibConstant.COMPONENT_THUMB_CHOOSER_THUMBNAIL_WIDTH,CcLibConstant.COMPONENT_THUMB_CHOOSER_THUMBNAIL_HEIGHT,param1.componentThumb,"bgComponentThumb");
         }
         else
         {
            _loc3_.initNullThumbnail(_loc4_,CcLibConstant.COMPONENT_THUMB_CHOOSER_THUMBNAIL_WIDTH,CcLibConstant.COMPONENT_THUMB_CHOOSER_THUMBNAIL_HEIGHT,param2,"bgComponentNullThumb");
         }
         _loc3_.component = param1;
         _loc3_.addEventListener(CcComponentThumbnailMouseEvent.DELETE_RELEASED,this.deleteComponent);
         _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,this.onThumbDown);
         _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.onThumbMouseOver);
         _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.onThumbMouseOut);
         _loc3_.buttonMode = true;
         this.selectedList.addChild(_loc3_);
         _loc4_.clipContent = false;
         _loc4_.visible = false;
         this.selectedThumb = _loc3_;
      }
      
      private function updateScrollPosition(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(param1.currentTarget == this.leftBut)
         {
            _loc2_ = -1;
         }
         else if(param1.currentTarget == this.rightBut)
         {
            _loc2_ = 1;
         }
         this.startTimer(_loc2_);
         this.refreshScrollControl();
      }
      
      public function init() : void
      {
         this.refreshScrollControl();
      }
      
      public function set rightBut(param1:Button) : void
      {
         var _loc2_:Object = this._1436107067rightBut;
         if(_loc2_ !== param1)
         {
            this._1436107067rightBut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rightBut",_loc2_,param1));
         }
      }
      
      public function deleteComponent(param1:Event) : void
      {
         var _loc3_:CcSelectedDecorationEvent = null;
         var _loc2_:anifire.components.char_editor.CcComponentThumbThumbnail = param1.currentTarget as anifire.components.char_editor.CcComponentThumbThumbnail;
         _loc3_ = new CcSelectedDecorationEvent(CcSelectedDecorationEvent.DECORATION_DELETED,this);
         _loc3_.ccComponent = _loc2_.component;
         this.dispatchEvent(_loc3_);
         this.selectedList.removeChild(_loc2_);
         this.refreshScrollControl();
      }
      
      public function ___SelectedDecoration_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __rightBut_mouseDown(param1:MouseEvent) : void
      {
         this.updateScrollPosition(param1);
      }
      
      public function __rightBut_mouseUp(param1:MouseEvent) : void
      {
         this.onMouseUp(param1);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get selectedList() : HBox
      {
         return this._1754705447selectedList;
      }
      
      public function addComponent(param1:CcComponent) : void
      {
         this.addThumbnail(param1,param1.componentThumb.type);
         this.refreshScrollControl();
      }
      
      [Bindable(event="propertyChange")]
      public function get rightBut() : Button
      {
         return this._1436107067rightBut;
      }
      
      private function onThumbMouseOver(param1:Event) : void
      {
         var _loc3_:CcSelectedDecorationEvent = null;
         var _loc2_:anifire.components.char_editor.CcComponentThumbThumbnail = param1.currentTarget as anifire.components.char_editor.CcComponentThumbThumbnail;
         _loc3_ = new CcSelectedDecorationEvent(CcSelectedDecorationEvent.DECORATION_MOUSE_OVER,this);
         _loc3_.ccComponent = _loc2_.component;
         this.dispatchEvent(_loc3_);
         _loc2_.control.visible = true;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         var _loc2_:Number = Number(this.selectedList.numChildren);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            CcComponentThumbThumbnail(this.selectedList.getChildAt(_loc3_)).control.visible = false;
            _loc3_++;
         }
         this._selectedThumb = null;
      }
      
      [Bindable(event="propertyChange")]
      public function get leftBut() : Button
      {
         return this._55416058leftBut;
      }
      
      public function __leftBut_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseUp(param1);
      }
      
      public function set selectedList(param1:HBox) : void
      {
         var _loc2_:Object = this._1754705447selectedList;
         if(_loc2_ !== param1)
         {
            this._1754705447selectedList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectedList",_loc2_,param1));
         }
      }
      
      public function set leftBut(param1:Button) : void
      {
         var _loc2_:Object = this._55416058leftBut;
         if(_loc2_ !== param1)
         {
            this._55416058leftBut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"leftBut",_loc2_,param1));
         }
      }
      
      private function refreshScrollControl() : void
      {
         if(this.selectedList.horizontalScrollPosition <= 0)
         {
            this.leftBut.enabled = false;
         }
         else
         {
            this.leftBut.enabled = true;
         }
         if(this.selectedList.measuredWidth >= this.selectedList.width + this.selectedList.horizontalScrollPosition)
         {
            this.rightBut.enabled = true;
         }
         else
         {
            this.rightBut.enabled = false;
         }
      }
      
      private function onThumbDown(param1:Event) : void
      {
         var _loc3_:CcSelectedDecorationEvent = null;
         var _loc2_:anifire.components.char_editor.CcComponentThumbThumbnail = param1.currentTarget as anifire.components.char_editor.CcComponentThumbThumbnail;
         _loc3_ = new CcSelectedDecorationEvent(CcSelectedDecorationEvent.DECORATION_CHOOSEN,this);
         _loc3_.ccComponent = _loc2_.component;
         this.dispatchEvent(_loc3_);
         this.selectedThumb = _loc2_;
      }
      
      private function doTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = Number(this._timer.getData());
         this.selectedList.horizontalScrollPosition += _loc2_;
         this.refreshScrollControl();
      }
      
      public function __leftBut_mouseUp(param1:MouseEvent) : void
      {
         this.onMouseUp(param1);
      }
      
      public function initByCcChar(param1:CcCharacter) : void
      {
         var _loc3_:CcComponent = null;
         this.selectedList.removeAllChildren();
         var _loc2_:int = 0;
         while(_loc2_ < param1.getUserChosenComponentSize())
         {
            _loc3_ = param1.getUserChosenComponentByIndex(_loc2_);
            if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(_loc3_.componentThumb.type) > -1)
            {
               this.addComponent(_loc3_);
            }
            _loc2_++;
         }
      }
   }
}
