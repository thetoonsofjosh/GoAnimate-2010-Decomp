package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.component.CCThumb;
   import anifire.constant.CcLibConstant;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.StyleManager;
   import mx.utils.ColorUtil;
   
   public class CCTemplateCharThumb extends Canvas
   {
       
      
      private var _char:CcCharacter = null;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _thumb:CCThumb = null;
      
      public function CCTemplateCharThumb()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({"type":Canvas});
         super();
         mx_internal::_document = this;
         this.states = [this._CCTemplateCharThumb_State1_c()];
         this.addEventListener("creationComplete",this.___CCTemplateCharThumb_Canvas1_creationComplete);
      }
      
      public function ___CCTemplateCharThumb_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler();
      }
      
      public function get character() : CcCharacter
      {
         return this._char;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set character(param1:CcCharacter) : void
      {
         this._char = param1;
      }
      
      public function set thumbnail(param1:CCThumb) : void
      {
         this.removeAllChildren();
         this._thumb = param1;
         var _loc2_:UIComponent = new UIComponent();
         _loc2_.addChild(param1);
         _loc2_.width = param1.thumbWidth;
         _loc2_.height = param1.thumbHeight;
         width = CcLibConstant.TEMPLATE_CHAR_THUMB_WIDTH;
         height = CcLibConstant.TEMPLATE_CHAR_THUMB_WIDTH;
         buttonMode = true;
         mouseEnabled = true;
         useHandCursor = true;
         _loc2_.x = (width - _loc2_.width) / 2;
         _loc2_.y = (height - _loc2_.height) / 2;
         addChild(_loc2_);
         styleName = "templateCharThumbNormal";
      }
      
      private function creationCompleteHandler() : void
      {
         var _bgColor:uint = 0;
         var brightenedColor:uint = 0;
         _bgColor = uint(StyleManager.getStyleDeclaration("." + styleName).getStyle("backgroundColor"));
         brightenedColor = uint(ColorUtil.adjustBrightness(_bgColor,32));
         var toggleHighlight:Function = function(param1:MouseEvent):void
         {
            setStyle("backgroundColor",param1.type == MouseEvent.ROLL_OVER ? brightenedColor : _bgColor);
         };
         addEventListener(MouseEvent.ROLL_OVER,toggleHighlight);
         addEventListener(MouseEvent.ROLL_OUT,toggleHighlight);
      }
      
      private function _CCTemplateCharThumb_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "selected";
         _loc1_.overrides = [this._CCTemplateCharThumb_SetProperty1_c()];
         return _loc1_;
      }
      
      private function _CCTemplateCharThumb_SetProperty1_c() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "styleName";
         _loc1_.value = "templateCharThumbSelected";
         return _loc1_;
      }
   }
}
