package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcComponentThumb;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcComponentThumbnailMouseEvent;
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
   import mx.containers.VBox;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class CcComponentThumbDetailThumbnail extends VBox
   {
       
      
      private var moneyMode:int;
      
      private var _1794379940thumbnailDetailContainer:Canvas;
      
      private var _1074110575componentThumbnail:anifire.components.char_editor.CcComponentThumbThumbnail;
      
      private var _1213926835goBuckPoint:Label;
      
      public var ccComponentThumbThumbnail:anifire.components.char_editor.CcComponentThumbThumbnail;
      
      public var _componentType:String;
      
      public var componentThumb:CcComponentThumb = null;
      
      private var bgStyleName:String;
      
      private var thumbnailHeight:Number;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var thumbnailWidth:Number;
      
      public function CcComponentThumbDetailThumbnail()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":anifire.components.char_editor.CcComponentThumbThumbnail,
                  "id":"componentThumbnail"
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"thumbnailDetailContainer",
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"goBuckPoint",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "x":10,
                              "styleName":"lblComponentThumbGoPoint"
                           };
                        }
                     })]};
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
            this.verticalGap = 2;
         };
      }
      
      public function set componentThumbnail(param1:anifire.components.char_editor.CcComponentThumbThumbnail) : void
      {
         var _loc2_:Object = this._1074110575componentThumbnail;
         if(_loc2_ !== param1)
         {
            this._1074110575componentThumbnail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"componentThumbnail",_loc2_,param1));
         }
      }
      
      public function getZoomCenterPosition() : Point
      {
         return new Point(this.thumbnailWidth / 2,this.thumbnailHeight / 2);
      }
      
      public function set thumbnailDetailContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1794379940thumbnailDetailContainer;
         if(_loc2_ !== param1)
         {
            this._1794379940thumbnailDetailContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"thumbnailDetailContainer",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get goBuckPoint() : Label
      {
         return this._1213926835goBuckPoint;
      }
      
      public function setBgStyleName(param1:String) : void
      {
         this.bgStyleName = param1;
         if(this.componentThumbnail != null)
         {
            this.componentThumbnail.setBgStyleName(this.bgStyleName);
         }
      }
      
      public function get isNullThumbnail() : Boolean
      {
         return this.componentThumb == null ? true : false;
      }
      
      public function init(param1:anifire.components.char_editor.CcComponentThumbThumbnail, param2:Number, param3:Number, param4:CcComponentThumb, param5:String, param6:int) : void
      {
         this.commonInit(param1,param2,param3,param4,param4.type,param5,param6);
      }
      
      public function showGoBuck(param1:Boolean) : void
      {
         this.thumbnailDetailContainer.visible = param1;
      }
      
      public function set goBuckPoint(param1:Label) : void
      {
         var _loc2_:Object = this._1213926835goBuckPoint;
         if(_loc2_ !== param1)
         {
            this._1213926835goBuckPoint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goBuckPoint",_loc2_,param1));
         }
      }
      
      private function commonInit(param1:anifire.components.char_editor.CcComponentThumbThumbnail, param2:Number, param3:Number, param4:CcComponentThumb, param5:String, param6:String, param7:int) : void
      {
         this.componentThumb = param4;
         this.thumbnailWidth = param2;
         this.thumbnailHeight = param3;
         this._componentType = param5;
         this.moneyMode = param7;
         this.setBgStyleName(param6);
         this.ccComponentThumbThumbnail = param1;
         if(this.initialized)
         {
            this.uiComponentInit();
         }
         else
         {
            this.addEventListener(FlexEvent.CREATION_COMPLETE,this.doUiComponentInit);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get thumbnailDetailContainer() : Canvas
      {
         return this._1794379940thumbnailDetailContainer;
      }
      
      public function startMouseOutChecking(param1:Stage) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
      }
      
      private function endMouseEndChecking(param1:Stage) : void
      {
         param1.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
      }
      
      public function get componentType() : String
      {
         return this._componentType;
      }
      
      public function initNullThumbnail(param1:anifire.components.char_editor.CcComponentThumbThumbnail, param2:Number, param3:Number, param4:String, param5:String, param6:int) : void
      {
         this.commonInit(param1,param2,param3,null,param4,param5,param6);
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc4_:CcComponentThumbnailMouseEvent = null;
         var _loc2_:Point = this.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:Rectangle = this.getRect(this);
         if(_loc2_.x < _loc3_.left || _loc2_.x > _loc3_.right || _loc2_.y < _loc3_.top || _loc2_.y > _loc3_.bottom)
         {
            _loc4_ = new CcComponentThumbnailMouseEvent(CcComponentThumbnailMouseEvent.MOUSE_REALLY_OUT,this);
            this.dispatchEvent(_loc4_);
            this.endMouseEndChecking(param1.currentTarget as Stage);
         }
      }
      
      private function uiComponentInit() : void
      {
         if(this.isNullThumbnail)
         {
            this.componentThumbnail.initNullThumbnail(this,this.thumbnailWidth,this.thumbnailHeight,this.componentType,this.bgStyleName);
         }
         else
         {
            this.componentThumbnail.init(this,this.thumbnailWidth,this.thumbnailHeight,this.componentThumb,this.bgStyleName);
         }
         if(this.moneyMode != CcLibConstant.MONEY_MODE_SCHOOL)
         {
            this.thumbnailDetailContainer.width = this.thumbnailWidth;
            this.thumbnailDetailContainer.height = CcLibConstant.COMPONENT_THUMB_CHOOSER_DETAIL_PART_HEIGHT;
            if(this.isNullThumbnail)
            {
               this.goBuckPoint.text = UtilDict.toDisplay("cc","cc_keyword_free");
            }
            else if(this.moneyMode != CcLibConstant.MONEY_MODE_NORMAL)
            {
               this.goBuckPoint.text = UtilDict.toDisplay("cc","cc_keyword_free");
            }
            else if(this.componentThumb.money > 0)
            {
               this.goBuckPoint.text = this.componentThumb.money.toString();
            }
            else if(this.componentThumb.sharingPoint > 0)
            {
               this.goBuckPoint.text = this.componentThumb.sharingPoint.toString();
            }
            else
            {
               this.goBuckPoint.text = UtilDict.toDisplay("cc","cc_keyword_free");
            }
         }
         else
         {
            this.thumbnailDetailContainer.visible = false;
         }
      }
      
      private function doUiComponentInit(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUiComponentInit);
         this.uiComponentInit();
      }
      
      [Bindable(event="propertyChange")]
      public function get componentThumbnail() : anifire.components.char_editor.CcComponentThumbThumbnail
      {
         return this._1074110575componentThumbnail;
      }
   }
}
