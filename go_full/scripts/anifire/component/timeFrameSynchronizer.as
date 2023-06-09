package anifire.component
{
   import anifire.util.UtilPlain;
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
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class timeFrameSynchronizer extends Canvas
   {
       
      
      private var _315645917streamImg:Image;
      
      private var _2070217628statusLbl:Label;
      
      private var _embed_mxml_timeFrameSynchronizer_24_swf_1702506550:Class;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var isSynOn:Boolean;
      
      public function timeFrameSynchronizer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":222,
                  "height":22,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Image,
                     "id":"streamImg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "source":_embed_mxml_timeFrameSynchronizer_24_swf_1702506550,
                           "width":0,
                           "height":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___timeFrameSynchronizer_Button1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "label":"toggle timeFrame Syn"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"statusLbl",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":160,
                           "y":2,
                           "text":"Label",
                           "width":56
                        };
                     }
                  })]
               };
            }
         });
         this._embed_mxml_timeFrameSynchronizer_24_swf_1702506550 = timeFrameSynchronizer__embed_mxml_timeFrameSynchronizer_24_swf_1702506550;
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 16777215;
         };
         this.width = 222;
         this.height = 22;
         this.addEventListener("creationComplete",this.___timeFrameSynchronizer_Canvas1_creationComplete);
      }
      
      public function ___timeFrameSynchronizer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function ___timeFrameSynchronizer_Button1_click(param1:MouseEvent) : void
      {
         this.toggleSyn(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get statusLbl() : Label
      {
         return this._2070217628statusLbl;
      }
      
      public function startSyn() : void
      {
         UtilPlain.playFamily(this.streamImg);
         this.statusLbl.text = "ON";
         this.isSynOn = true;
      }
      
      public function set statusLbl(param1:Label) : void
      {
         var _loc2_:Object = this._2070217628statusLbl;
         if(_loc2_ !== param1)
         {
            this._2070217628statusLbl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusLbl",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get streamImg() : Image
      {
         return this._315645917streamImg;
      }
      
      public function stopSyn() : void
      {
         UtilPlain.stopFamily(this.streamImg);
         this.statusLbl.text = "OFF";
         this.isSynOn = false;
      }
      
      private function toggleSyn(param1:Event) : void
      {
         if(this.isSynOn)
         {
            this.stopSyn();
         }
         else
         {
            this.startSyn();
         }
      }
      
      private function onCreationComplete(param1:Event) : void
      {
         UtilPlain.stopFamily(this.streamImg);
         this.isSynOn = false;
         this.statusLbl.text = "OFF";
      }
      
      public function set streamImg(param1:Image) : void
      {
         var _loc2_:Object = this._315645917streamImg;
         if(_loc2_ !== param1)
         {
            this._315645917streamImg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"streamImg",_loc2_,param1));
         }
      }
   }
}
