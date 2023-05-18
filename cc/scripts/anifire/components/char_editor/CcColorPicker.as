package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcColor;
   import anifire.cc_theme_lib.CcColorThumb;
   import anifire.cc_theme_lib.CcComponent;
   import anifire.cc_theme_lib.CcComponentThumb;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.event.CcColorPickerEvent;
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
   import mx.containers.Tile;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.styles.*;
   
   public class CcColorPicker extends Tile
   {
       
      
      private const DELAY_BETWEEN_LOADING_EACH_THUMB:Number = 200;
      
      private var colorThumb:CcColorThumb;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _biggerElementWidth:Number;
      
      private var _smallerElementWidth:Number;
      
      public function CcColorPicker()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({"type":Tile});
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 7878228;
            this.backgroundAlpha = 0;
            this.horizontalGap = 4;
         };
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public function addComponentThumb(param1:CcComponent, param2:CcComponentThumb, param3:CcTheme, param4:CcCharacter) : void
      {
         var _loc5_:CcColorPickerElement = null;
         var _loc6_:int = 0;
         var _loc7_:CcColorThumb = null;
         if(param2.getMyOwnColorNum() > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < param2.getMyOwnColorNum())
            {
               _loc5_ = new CcColorPickerElement();
               if((_loc7_ = param2.getMyOwnColorByIndex(_loc6_)).colorChoices.length > 4)
               {
                  _loc5_.width = this._biggerElementWidth;
               }
               else
               {
                  _loc5_.width = this._smallerElementWidth;
               }
               _loc5_.percentHeight = 100;
               _loc5_.addEventListener(CcColorPickerEvent.COLOR_CHOSEN,this.onUserChooseColor);
               _loc5_.callLater(_loc5_.initByColorThumb,[param1,param2.getMyOwnColorByIndex(_loc6_),param3,param4]);
               this.addChild(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function set biggerElementWidth(param1:Number) : void
      {
         this._biggerElementWidth = param1;
      }
      
      public function addComponentType(param1:CcComponent, param2:String, param3:CcTheme, param4:CcCharacter) : void
      {
         var _loc6_:CcColorThumb = null;
         var _loc8_:CcColorPickerElement = null;
         var _loc9_:int = 0;
         var _loc5_:Array = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < param3.getColorThumbNum())
         {
            if((_loc6_ = param3.getColorThumbByIndex(_loc7_)).componentType == param2)
            {
               _loc5_.push(_loc6_);
            }
            _loc7_++;
         }
         if(_loc5_.length > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               _loc6_ = _loc5_[_loc9_] as CcColorThumb;
               _loc8_ = new CcColorPickerElement();
               if(_loc6_.colorChoices.length > 4)
               {
                  _loc8_.width = this._biggerElementWidth;
               }
               else
               {
                  _loc8_.width = this._smallerElementWidth;
               }
               _loc8_.percentHeight = 100;
               _loc8_.addEventListener(CcColorPickerEvent.COLOR_CHOSEN,this.onUserChooseColor);
               _loc8_.callLater(_loc8_.initByColorThumb,[param1,_loc6_,param3,param4]);
               this.addChild(_loc8_);
               _loc9_++;
            }
         }
      }
      
      private function onUserChooseColor(param1:CcColorPickerEvent) : void
      {
         this.tellEveryBodyColorChosen(param1.colorChosen);
      }
      
      public function set smallerElementWidth(param1:Number) : void
      {
         this._smallerElementWidth = param1;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CcColorPickerElement = null;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_) as CcColorPickerElement;
            _loc2_.removeEventListener(CcColorPickerEvent.COLOR_CHOSEN,this.onUserChooseColor);
            _loc1_++;
         }
         this.removeAllChildren();
      }
      
      private function tellEveryBodyColorChosen(param1:CcColor) : void
      {
         var _loc2_:CcColor = param1;
         var _loc3_:CcColorPickerEvent = new CcColorPickerEvent(CcColorPickerEvent.COLOR_CHOSEN,this);
         _loc3_.colorChosen = _loc2_;
         this.dispatchEvent(_loc3_);
      }
   }
}
