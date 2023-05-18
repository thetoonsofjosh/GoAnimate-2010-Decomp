package anifire.components.studio
{
   import anifire.color.SelectedColor;
   import anifire.command.ColorAssetCommand;
   import anifire.command.ICommand;
   import anifire.core.Asset;
   import anifire.core.Background;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.Prop;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
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
   import mx.containers.VBox;
   import mx.controls.ColorPicker;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.DropdownEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class PropertiesWindow extends Canvas
   {
       
      
      private var _1480441607_close:Canvas;
      
      private var _picking:Boolean = false;
      
      private var _91078296_main:VBox;
      
      private var _94436_bg:Canvas;
      
      private var _target:Asset;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      public function PropertiesWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_bg",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":0,
                        "y":0,
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "id":"_main",
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 15;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":20,
                        "y":20,
                        "percentWidth":85,
                        "percentHeight":85
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_close",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":10,
                        "y":212.5
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      public function set _close(param1:Canvas) : void
      {
         var _loc2_:Object = this._1480441607_close;
         if(_loc2_ !== param1)
         {
            this._1480441607_close = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_close",_loc2_,param1));
         }
      }
      
      public function set picking(param1:Boolean) : void
      {
         this._picking = param1;
      }
      
      private function loadPhotoComplete(param1:Event) : void
      {
         var _loc2_:Loader = Loader(param1.currentTarget.loader);
         var _loc3_:Canvas = Canvas(_loc2_.parent.parent);
         _loc2_.width = _loc3_.width;
         _loc2_.height = _loc3_.height;
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      public function update() : void
      {
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get target() : Asset
      {
         return this._target;
      }
      
      [Bindable(event="propertyChange")]
      public function get _main() : VBox
      {
         return this._91078296_main;
      }
      
      public function hide() : void
      {
      }
      
      public function refresh() : void
      {
         var _loc1_:HBox = null;
         var _loc2_:Canvas = null;
         var _loc3_:Image = null;
         var _loc4_:Matrix = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:VBox = null;
         var _loc8_:Label = null;
         var _loc9_:HBox = null;
         var _loc10_:Canvas = null;
         var _loc11_:Label = null;
         var _loc12_:Image = null;
         var _loc13_:BitmapData = null;
         var _loc14_:DisplayObject = null;
         var _loc15_:BitmapData = null;
         var _loc16_:Image = null;
         var _loc17_:BitmapData = null;
         var _loc18_:int = 0;
         var _loc19_:HBox = null;
         var _loc20_:Label = null;
         var _loc21_:Canvas = null;
         var _loc22_:VBox = null;
         var _loc23_:Array = null;
         var _loc24_:TextArea = null;
         var _loc25_:StyleSheet = null;
         var _loc26_:ColorPicker = null;
         var _loc27_:Array = null;
         this._main.removeAllChildren();
         this.target = Console.getConsole().currentScene.selectedAsset;
         if(this.target != null)
         {
            _loc1_ = new HBox();
            _loc2_ = new Canvas();
            _loc2_.width = _loc2_.height = 45;
            _loc2_.setStyle("borderStyle","solid");
            _loc2_.scrollRect = new Rectangle(0,0,_loc2_.width - 1,_loc2_.height - 1);
            _loc3_ = new Image();
            if(this.target is Character)
            {
               _loc12_ = this.target.bundle;
               _loc13_ = new BitmapData(this.target.imageObject.width * this.target.scaleX,this.target.imageObject.height * this.target.scaleY);
               (_loc4_ = new Matrix()).translate(_loc13_.width / 2,_loc13_.height / 2);
               _loc13_.draw(_loc12_,_loc4_);
               _loc3_.addChild(new Bitmap(_loc13_));
               _loc5_ = _loc2_.height / _loc13_.height;
               _loc6_ = _loc2_.width / _loc13_.width;
               _loc3_.scaleX = _loc3_.scaleY = _loc5_ > _loc6_ ? _loc6_ : _loc5_;
               _loc3_.x = (_loc2_.width - _loc13_.width * _loc3_.scaleX) / 2;
               _loc3_.y = (_loc2_.height - _loc13_.height * _loc3_.scaleY) / 2;
            }
            else if(this.target is Background)
            {
               _loc14_ = this.target.imageObject;
               (_loc15_ = new BitmapData(_loc14_.width,_loc14_.height)).draw(_loc14_);
               _loc3_.addChild(new Bitmap(_loc15_));
               _loc5_ = _loc2_.height / _loc15_.height;
               _loc6_ = _loc2_.width / _loc15_.width;
               _loc3_.scaleX = _loc3_.scaleY = _loc5_ > _loc6_ ? _loc6_ : _loc5_;
               _loc3_.x = (_loc2_.width - _loc15_.width * _loc3_.scaleX) / 2;
               _loc3_.y = (_loc2_.height - _loc15_.height * _loc3_.scaleY) / 2;
            }
            else if(this.target is Prop)
            {
               _loc16_ = this.target.bundle;
               _loc17_ = new BitmapData(this.target.imageObject.width * this.target.scaleX,this.target.imageObject.height * this.target.scaleY);
               (_loc4_ = new Matrix()).translate(_loc17_.width / 2,_loc17_.height / 2);
               _loc17_.draw(_loc16_,_loc4_);
               _loc3_.addChild(new Bitmap(_loc17_));
               _loc5_ = _loc2_.height / _loc17_.height;
               _loc6_ = _loc2_.width / _loc17_.width;
               _loc3_.scaleX = _loc3_.scaleY = _loc5_ > _loc6_ ? _loc6_ : _loc5_;
               _loc3_.x = (_loc2_.width - _loc17_.width * _loc3_.scaleX) / 2;
               _loc3_.y = (_loc2_.height - _loc17_.height * _loc3_.scaleY) / 2;
            }
            _loc2_.addChild(_loc3_);
            _loc2_.verticalScrollPolicy = _loc2_.horizontalScrollPolicy = "off";
            _loc1_.addChild(_loc2_);
            (_loc7_ = new VBox()).setStyle("verticalGap",-4);
            (_loc8_ = new Label()).text = this.target.thumb.name;
            _loc8_.setStyle("color",3355443);
            _loc8_.setStyle("fontSize",20);
            _loc8_.setStyle("fontWeight","bold");
            (_loc9_ = new HBox()).setStyle("horizontalGap",0);
            (_loc10_ = new Canvas()).styleName = "imgColor";
            _loc10_.width = 18;
            _loc10_.height = 14;
            (_loc11_ = new Label()).text = UtilDict.toDisplay("go","propwin_customize");
            _loc11_.styleName = "propertiesWinSubTitle";
            _loc9_.addChild(_loc10_);
            _loc9_.addChild(_loc11_);
            _loc7_.addChild(_loc8_);
            _loc7_.addChild(_loc9_);
            _loc1_.addChild(_loc7_);
            this._main.addChild(_loc1_);
            if(this.target.isColorable())
            {
               (_loc21_ = new Canvas()).styleName = "propertiesWinColorPan";
               (_loc22_ = new VBox()).setStyle("verticalGap",10);
               _loc22_.label = "Color";
               _loc22_.x = 10;
               _loc22_.y = 20;
               if((_loc23_ = this.target.getColorArea()) != null)
               {
                  _loc18_ = 0;
                  while(_loc18_ < _loc23_.length)
                  {
                     _loc19_ = new HBox();
                     (_loc20_ = new Label()).text = UtilDict.toDisplay("store",_loc23_[_loc18_]) + ":";
                     (_loc26_ = new ColorPicker()).id = _loc23_[_loc18_];
                     _loc26_.buttonMode = true;
                     _loc26_.addEventListener(DropdownEvent.OPEN,this.startPick);
                     _loc26_.addEventListener(DropdownEvent.CLOSE,this.endPick);
                     if(this.target.customColor.getValueByKey(_loc23_[_loc18_]) != null)
                     {
                        _loc26_.selectedColor = SelectedColor(this.target.customColor.getValueByKey(_loc23_[_loc18_])).dstColor;
                     }
                     else
                     {
                        _loc26_.selectedColor = 0;
                     }
                     if(this.target.thumb.colorRef.getValueByKey(_loc23_[_loc18_]) != null)
                     {
                        _loc27_ = String(this.target.thumb.colorRef.getValueByKey(_loc23_[_loc18_])).split(",");
                        _loc26_.dataProvider = _loc27_;
                     }
                     _loc26_.addEventListener(ColorPickerEvent.CHANGE,this.updateColor);
                     _loc19_.addChild(_loc20_);
                     _loc19_.addChild(_loc26_);
                     _loc22_.addChild(_loc19_);
                     _loc18_++;
                  }
               }
               this._main.addChild(_loc21_);
               _loc21_.width = _loc21_.parent.width;
               _loc21_.height = 325;
               _loc21_.addChild(_loc22_);
               _loc24_ = new TextArea();
               (_loc25_ = new StyleSheet()).parseCSS(this.hoverStyles);
               _loc24_.styleSheet = _loc25_;
               _loc24_.htmlText = "<a href=\'#\'>" + UtilDict.toDisplay("go","propwin_restore") + "</a>";
               _loc24_.addEventListener(MouseEvent.CLICK,this.restoreColor);
               _loc24_.x = 160;
               _loc24_.y = 280;
               _loc24_.focusEnabled = false;
               _loc24_.editable = false;
               _loc24_.selectable = false;
               _loc24_.setStyle("borderStyle","none");
               _loc24_.setStyle("backgroundAlpha",0);
               _loc21_.addChild(_loc24_);
               _loc21_.horizontalScrollPolicy = _loc21_.verticalScrollPolicy = "off";
            }
         }
      }
      
      private function endPick(param1:Event) : void
      {
         this.picking = false;
      }
      
      public function get picking() : Boolean
      {
         return this._picking;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
      }
      
      public function set target(param1:Asset) : void
      {
         this._target = param1;
      }
      
      private function startPick(param1:Event) : void
      {
         this.picking = true;
      }
      
      private function updateColor(param1:ColorPickerEvent) : void
      {
         var _loc2_:ICommand = new ColorAssetCommand(this.target.id,ColorPicker(param1.currentTarget).id);
         _loc2_.execute();
         this.target.doChangeColor(ColorPicker(param1.currentTarget).id,param1.color);
      }
      
      private function restoreColor(param1:MouseEvent) : void
      {
         var _loc2_:ICommand = new ColorAssetCommand(this.target.id);
         _loc2_.execute();
         this.target.restoreColor();
         this.refresh();
      }
      
      public function set _main(param1:VBox) : void
      {
         var _loc2_:Object = this._91078296_main;
         if(_loc2_ !== param1)
         {
            this._91078296_main = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_main",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _close() : Canvas
      {
         return this._1480441607_close;
      }
      
      public function show() : void
      {
         this._main.removeAllChildren();
         this._bg.graphics.clear();
         this._close.graphics.clear();
         this.refresh();
         this._bg.graphics.lineStyle(3,StyleManager.getStyleDeclaration(".propertiesWinBg").getStyle("bgBorderColor"));
         this._bg.graphics.beginFill(StyleManager.getStyleDeclaration(".propertiesWinBg").getStyle("bgColor"));
         this._bg.graphics.drawRoundRectComplex(0,0,this._bg.width,this._bg.height,15,0,15,0);
         this._bg.graphics.endFill();
         this._close.graphics.lineStyle(0,0);
         this._close.graphics.beginFill(16777215);
         UtilDraw.drawPoly(this._close,0,0,3,8,0);
         this._close.graphics.endFill();
         this._close.buttonMode = true;
         this._close.scaleY = 1.5;
         var _loc1_:DropShadowFilter = new DropShadowFilter(3,45,0,1,4,4,1,1,true);
         var _loc2_:Array = new Array();
         _loc2_.push(_loc1_);
         this._close.filters = _loc2_;
      }
   }
}
