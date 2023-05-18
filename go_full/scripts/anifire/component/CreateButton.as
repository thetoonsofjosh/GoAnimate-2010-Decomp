package anifire.component
{
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
   import mx.controls.LinkButton;
   import mx.core.UITextField;
   import mx.skins.ProgrammaticSkin;
   import mx.styles.*;
   
   public class CreateButton extends LinkButton
   {
       
      
      public function CreateButton()
      {
         super();
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.upSkin = ProgrammaticSkin;
            this.downSkin = ProgrammaticSkin;
            this.overSkin = ProgrammaticSkin;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      override protected function createChildren() : void
      {
         if(!textField)
         {
            textField = new UITextField();
            textField.styleName = this;
            addChild(UITextField(textField));
         }
         super.createChildren();
         UITextField(textField).multiline = true;
         UITextField(textField).wordWrap = true;
         UITextField(textField).autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
   }
}
