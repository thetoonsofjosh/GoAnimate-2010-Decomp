package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.component.CCThumb;
   import anifire.event.CcTemplateChooserEvent;
   import anifire.util.Util;
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
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class LatestTemplates extends Canvas
   {
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _110363525tiles:HBox;
      
      public function LatestTemplates()
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
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"tiles",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalAlign = "middle";
                              this.horizontalGap = -5;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "events":{"click":"___LatestTemplates_Canvas2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":120,
                                 "height":123,
                                 "styleName":"buoyNext"
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
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function addThumbnail(param1:CCThumb, param2:CcCharacter) : void
      {
         var self:LatestTemplates = null;
         var tthumb:LatestTemplateCharThumb = null;
         var thumb:CCThumb = param1;
         var char:CcCharacter = param2;
         self = this;
         if(this.tiles.getChildren().length < 6)
         {
            tthumb = new LatestTemplateCharThumb();
            tthumb.character = char;
            tthumb.thumbnail = thumb;
            tthumb.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
            {
               Util.gaTracking("/creator/templateThumbClick",self);
               dispatchEvent(new CcTemplateChooserEvent(CcTemplateChooserEvent.USER_WANT_TO_PREVIEW,tthumb,char,true));
            });
            this.tiles.addChild(tthumb);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tiles() : HBox
      {
         return this._110363525tiles;
      }
      
      public function set tiles(param1:HBox) : void
      {
         var _loc2_:Object = this._110363525tiles;
         if(_loc2_ !== param1)
         {
            this._110363525tiles = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tiles",_loc2_,param1));
         }
      }
      
      public function ___LatestTemplates_Canvas2_click(param1:MouseEvent) : void
      {
         dispatchEvent(new CcTemplateChooserEvent(CcTemplateChooserEvent.PREVIEW_TAB_CHANGED,this,"preview_professions",true));
      }
   }
}
