package anifire.control
{
   import anifire.bubble.Bubble;
   import anifire.components.containers.HyperLinkWindow;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.util.FontManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
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
   import mx.controls.CheckBox;
   import mx.controls.ColorPicker;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.DropdownEvent;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class FontChooser extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _align:String = "center";
      
      private var _fontMgr:FontManager;
      
      private var _fillRgb:Number = 16777215;
      
      private const SIZE_LIST:Array = [6,8,10,12,14,16,18,20,22,24,26,28,30,32,36,40,44,50,76];
      
      private var _font:String = "Entrails BB";
      
      private var _205984886btnLink:Button;
      
      private var _103471630bgcolor_cp:ColorPicker;
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _FontChooser_Label1:Label;
      
      public var _FontChooser_Label2:Label;
      
      public var _FontChooser_Label3:Label;
      
      private var _italic:Boolean = false;
      
      private var _bold:Boolean = false;
      
      private var _color:Number = 0;
      
      private var _628825399color_cp:ColorPicker;
      
      private var _click:Boolean = false;
      
      private const FONT_LIST:Array = [{
         "label":"Accidental Presidency",
         "data":"Accidental Presidency",
         "source":"go"
      },{
         "label":"BodoniXT",
         "data":"BodoniXT",
         "source":"go"
      },{
         "label":"Boom",
         "data":"BadaBoom BB",
         "source":"go"
      },{
         "label":"Budmo Jiggler",
         "data":"Budmo Jiggler",
         "source":"go"
      },{
         "label":"Budmo Jigglish",
         "data":"Budmo Jigglish",
         "source":"go"
      },{
         "label":"Casual",
         "data":"Blambot Casual",
         "source":"go"
      },{
         "label":"Comic Book",
         "data":"Comic Book",
         "source":"go"
      },{
         "label":"Entrails",
         "data":"Entrails BB",
         "source":"go"
      },{
         "label":"Existence Light",
         "data":"Existence Light",
         "source":"go"
      },{
         "label":"HeartlandRegular",
         "data":"HeartlandRegular",
         "source":"go"
      },{
         "label":"Honey Script",
         "data":"Honey Script",
         "source":"go"
      },{
         "label":"I hate Comic Sans",
         "data":"I hate Comic Sans",
         "source":"go"
      },{
         "label":"Impact Label",
         "data":"Impact Label",
         "source":"go"
      },{
         "label":"loco tv",
         "data":"loco tv",
         "source":"go"
      },{
         "label":"Mail Ray Stuff",
         "data":"Mail Ray Stuff",
         "source":"go"
      },{
         "label":"Shanghai",
         "data":"Shanghai",
         "source":"go"
      },{
         "label":"Tokyo",
         "data":"Tokyo Robot Intl BB",
         "source":"go"
      }];
      
      mx_internal var _watchers:Array;
      
      private var _1912610210bold_btn:Button;
      
      private var _bubble:Bubble;
      
      private var _721006521_embedcb:CheckBox;
      
      private var _url:String = "";
      
      private var _1767455998align_cmb:ComboBox;
      
      private const ALIGN_LIST:Array = [{
         "label":UtilDict.toDisplay("go","fontchooser_left"),
         "data":"left"
      },{
         "label":UtilDict.toDisplay("go","fontchooser_right"),
         "data":"right"
      },{
         "label":UtilDict.toDisplay("go","fontchooser_center"),
         "data":"center"
      }];
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed:Boolean = true;
      
      private var _365952328font_cmb:ComboBox;
      
      private var _size:Number = 12;
      
      private var _949923891italic_btn:Button;
      
      private var _asset:Object;
      
      mx_internal var _bindings:Array;
      
      private var _850390358_btnConvert:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function FontChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":388,
                  "height":70,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Label,
                     "id":"_FontChooser_Label1",
                     "stylesFactory":function():void
                     {
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":17,
                           "y":10
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_FontChooser_Label2",
                     "stylesFactory":function():void
                     {
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":6,
                           "y":39
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_FontChooser_Label3",
                     "stylesFactory":function():void
                     {
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":134,
                           "y":39
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ComboBox,
                     "id":"font_cmb",
                     "events":{
                        "change":"__font_cmb_change",
                        "open":"__font_cmb_open",
                        "close":"__font_cmb_close"
                     },
                     "stylesFactory":function():void
                     {
                        this.fontFamily = "Verdana";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":101,
                           "y":8,
                           "width":167,
                           "focusEnabled":false,
                           "buttonMode":true,
                           "itemRenderer":_FontChooser_ClassFactory1_c()
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ColorPicker,
                     "id":"color_cp",
                     "events":{
                        "change":"__color_cp_change",
                        "open":"__color_cp_open",
                        "close":"__color_cp_close"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":311,
                           "y":8,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ColorPicker,
                     "id":"bgcolor_cp",
                     "events":{
                        "change":"__bgcolor_cp_change",
                        "open":"__bgcolor_cp_open",
                        "close":"__bgcolor_cp_close"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":101,
                           "y":36,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ComboBox,
                     "id":"align_cmb",
                     "events":{
                        "change":"__align_cmb_change",
                        "open":"__align_cmb_open",
                        "close":"__align_cmb_close"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":170,
                           "y":36,
                           "width":97,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"bold_btn",
                     "events":{"click":"__bold_btn_click"},
                     "stylesFactory":function():void
                     {
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":276,
                           "y":8,
                           "toggle":true,
                           "width":27,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"italic_btn",
                     "events":{"click":"__italic_btn_click"},
                     "stylesFactory":function():void
                     {
                        this.fontStyle = "italic";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":325,
                           "y":8,
                           "label":"I",
                           "toggle":true,
                           "width":27,
                           "visible":false,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnLink",
                     "events":{"click":"__btnLink_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":274,
                           "y":36,
                           "styleName":"btnBubbleLink",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnConvert",
                     "events":{"click":"___btnConvert_click"},
                     "stylesFactory":function():void
                     {
                        this.fontSize = 11;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":304,
                           "y":36,
                           "styleName":"btnTTS",
                           "visible":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CheckBox,
                     "id":"_embedcb",
                     "events":{"click":"___embedcb_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":338,
                           "y":8,
                           "label":"EB",
                           "selected":true,
                           "visible":false
                        };
                     }
                  })]
               };
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
            this.backgroundColor = 16316664;
            this.borderStyle = "solid";
            this.dropShadowEnabled = true;
            this.shadowDirection = "right";
         };
         this.width = 388;
         this.height = 70;
         this.focusEnabled = false;
         this.addEventListener("initialize",this.___FontChooser_Canvas1_initialize);
         this.addEventListener("mouseDown",this.___FontChooser_Canvas1_mouseDown);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         FontChooser._watcherSetupUtil = param1;
      }
      
      public function __align_cmb_change(param1:ListEvent) : void
      {
         this.onAlignChange(param1);
      }
      
      private function setupBgcolor() : void
      {
         this.bgcolor_cp.selectedColor = this._fillRgb;
      }
      
      public function __bgcolor_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function set align_cmb(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1767455998align_cmb;
         if(_loc2_ !== param1)
         {
            this._1767455998align_cmb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"align_cmb",_loc2_,param1));
         }
      }
      
      public function set btnLink(param1:Button) : void
      {
         var _loc2_:Object = this._205984886btnLink;
         if(_loc2_ !== param1)
         {
            this._205984886btnLink = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLink",_loc2_,param1));
         }
      }
      
      public function getChooser(param1:Object, param2:Object = null) : FontChooser
      {
         var _loc3_:FontChooser = new FontChooser();
         _loc3_.asset = param1;
         _loc3_.initParameters(param2);
         return _loc3_;
      }
      
      public function __font_cmb_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function listFonts() : Array
      {
         var _loc4_:Font = null;
         var _loc1_:Array = Font.enumerateFonts(true);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(UtilLicense.isBubbleI18NPermitted() || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
            {
               if(_loc4_.fontName == "Arial" || _loc4_.fontName == "Courier New" || _loc4_.fontName == "Tahoma" || _loc4_.fontName == "Times New Roman" || _loc4_.fontName == "新細明體")
               {
                  _loc2_.push({
                     "label":_loc4_.fontName,
                     "data":_loc4_.fontName,
                     "source":"system"
                  });
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      [Bindable(event="propertyChange")]
      public function get bgcolor_cp() : ColorPicker
      {
         return this._103471630bgcolor_cp;
      }
      
      public function ___FontChooser_Canvas1_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function __color_cp_change(param1:ColorPickerEvent) : void
      {
         this.onRgbChange();
      }
      
      public function initParameters(param1:Object = null) : void
      {
         if(param1 != null)
         {
            if(param1.font != null)
            {
               this._font = param1.font;
            }
            if(param1.size != null)
            {
               this._size = param1.size;
            }
            if(param1.color != null)
            {
               this._color = param1.color;
            }
            if(param1.align != null)
            {
               this._align = param1.align;
            }
            if(param1.bold != null)
            {
               this._bold = param1.bold;
            }
            if(param1.italic != null)
            {
               this._italic = param1.italic;
            }
            if(param1.embed != null)
            {
               this._embed = param1.embed;
            }
            if(param1.fillRgb != null)
            {
               this._fillRgb = param1.fillRgb;
            }
            if(param1.bubble != null)
            {
               this._bubble = param1.bubble;
            }
            if(param1.url != null)
            {
               this._url = param1.url;
            }
         }
      }
      
      private function onFontChange() : void
      {
         var _loc1_:String = this.font_cmb.selectedItem.data as String;
         this._fontMgr = FontManager.getFontManager();
         if(this._fontMgr.isFontLoaded(_loc1_) || this.font_cmb.selectedItem.source == "system")
         {
            this._asset.textFont = _loc1_;
            switch(this.font_cmb.selectedItem.source)
            {
               case "go":
                  this._asset.textEmbed = true;
                  break;
               case "system":
                  this._asset.textEmbed = false;
            }
         }
         else
         {
            this._fontMgr.loadFont(_loc1_,this.onFontLoaded);
         }
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function __color_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __font_cmb_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      private function setupItalic() : void
      {
         this.italic_btn.selected = this._italic;
      }
      
      public function __bgcolor_cp_change(param1:ColorPickerEvent) : void
      {
         this.onFillRgbChange();
      }
      
      private function setupFontList() : void
      {
         var _loc1_:Array = null;
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            _loc1_ = this.listFonts();
         }
         else
         {
            _loc1_ = this.FONT_LIST.concat(this.listFonts());
         }
         this.font_cmb.dataProvider = _loc1_;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].data == this._font)
            {
               this.font_cmb.selectedIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
      }
      
      public function set bgcolor_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._103471630bgcolor_cp;
         if(_loc2_ !== param1)
         {
            this._103471630bgcolor_cp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgcolor_cp",_loc2_,param1));
         }
      }
      
      private function onOpenHandler(param1:DropdownEvent) : void
      {
         this._click = true;
      }
      
      public function set bold_btn(param1:Button) : void
      {
         var _loc2_:Object = this._1912610210bold_btn;
         if(_loc2_ !== param1)
         {
            this._1912610210bold_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bold_btn",_loc2_,param1));
         }
      }
      
      private function setupAlignList() : void
      {
         this.align_cmb.dataProvider = this.ALIGN_LIST;
         var _loc1_:uint = 0;
         while(_loc1_ < this.ALIGN_LIST.length)
         {
            if(this.ALIGN_LIST[_loc1_].data == this._align)
            {
               this.align_cmb.selectedIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      private function onSizeChange(param1:ListEvent) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnConvert() : Button
      {
         return this._850390358_btnConvert;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this.startDrag();
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      public function __bgcolor_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function ___FontChooser_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function ___embedcb_click(param1:MouseEvent) : void
      {
         this.onEmbedChange();
      }
      
      [Bindable(event="propertyChange")]
      public function get font_cmb() : ComboBox
      {
         return this._365952328font_cmb;
      }
      
      public function set _embedcb(param1:CheckBox) : void
      {
         var _loc2_:Object = this._721006521_embedcb;
         if(_loc2_ !== param1)
         {
            this._721006521_embedcb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_embedcb",_loc2_,param1));
         }
      }
      
      private function onFontLoaded(param1:Event = null, param2:String = "") : void
      {
         if(param2 != "")
         {
            this._asset.textFont = param2;
            this._asset.textEmbed = true;
         }
      }
      
      private function setupEmbed() : void
      {
         this._embedcb.selected = this._embed;
      }
      
      public function __italic_btn_click(param1:MouseEvent) : void
      {
         this.onItalicChange();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnLink() : Button
      {
         return this._205984886btnLink;
      }
      
      private function onItalicChange() : void
      {
         var _loc1_:Boolean = Boolean(this.italic_btn.selected);
         this._asset.textItalic = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function ___btnConvert_click(param1:MouseEvent) : void
      {
         this.onConvertHandler();
      }
      
      public function get click() : Boolean
      {
         return this._click;
      }
      
      private function onEmbedChange() : void
      {
         var _loc1_:Boolean = Boolean(this._embedcb.selected);
         this._asset.textEmbed = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function __bold_btn_click(param1:MouseEvent) : void
      {
         this.onBoldChange();
      }
      
      private function _FontChooser_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","fontchooser_title");
         _loc1_ = UtilDict.toDisplay("go","fontchooser_bgtitle");
         _loc1_ = UtilDict.toDisplay("go","fontchooser_align");
         _loc1_ = UtilDict.toDisplay("go","fontchooser_bold");
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:FontChooser = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._FontChooser_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_control_FontChooserWatcherSetupUtil");
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
      
      public function set color_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._628825399color_cp;
         if(_loc2_ !== param1)
         {
            this._628825399color_cp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"color_cp",_loc2_,param1));
         }
      }
      
      public function set italic_btn(param1:Button) : void
      {
         var _loc2_:Object = this._949923891italic_btn;
         if(_loc2_ !== param1)
         {
            this._949923891italic_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"italic_btn",_loc2_,param1));
         }
      }
      
      private function onCallLaterHandler() : void
      {
         dispatchEvent(new ControlEvent(ControlEvent.CALL_LATER));
      }
      
      public function __font_cmb_change(param1:ListEvent) : void
      {
         this.onFontChange();
      }
      
      public function set font_cmb(param1:ComboBox) : void
      {
         var _loc2_:Object = this._365952328font_cmb;
         if(_loc2_ !== param1)
         {
            this._365952328font_cmb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"font_cmb",_loc2_,param1));
         }
      }
      
      private function setupBold() : void
      {
         this.bold_btn.selected = this._bold;
      }
      
      public function set _btnConvert(param1:Button) : void
      {
         var _loc2_:Object = this._850390358_btnConvert;
         if(_loc2_ !== param1)
         {
            this._850390358_btnConvert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnConvert",_loc2_,param1));
         }
      }
      
      private function applyFilters() : void
      {
         var _loc1_:BevelFilter = new BevelFilter(5,45,0,0.8,3355443,0.8,5,5,1,BitmapFilterQuality.HIGH,BitmapFilterType.OUTER,false);
         var _loc2_:Array = [_loc1_];
         filters = _loc2_;
      }
      
      public function __align_cmb_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      private function onCloseHandler(param1:DropdownEvent) : void
      {
         this._click = false;
         callLater(this.onCallLaterHandler);
         dispatchEvent(new ControlEvent(DropdownEvent.CLOSE));
      }
      
      private function onAlignChange(param1:ListEvent) : void
      {
         var _loc2_:String = this.align_cmb.selectedItem.data as String;
         this._asset.textAlign = _loc2_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function __btnLink_click(param1:MouseEvent) : void
      {
         this.onBubbleLink(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _embedcb() : CheckBox
      {
         return this._721006521_embedcb;
      }
      
      [Bindable(event="propertyChange")]
      public function get bold_btn() : Button
      {
         return this._1912610210bold_btn;
      }
      
      private function onRgbChange() : void
      {
         var _loc1_:Number = this.color_cp.selectedColor as Number;
         this._asset.textRgb = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this.stopDrag();
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      private function setupFontSizeList() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get italic_btn() : Button
      {
         return this._949923891italic_btn;
      }
      
      [Bindable(event="propertyChange")]
      public function get color_cp() : ColorPicker
      {
         return this._628825399color_cp;
      }
      
      private function _FontChooser_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = FontChooser_inlineComponent1;
         _loc1_.properties = {"outerDocument":this};
         return _loc1_;
      }
      
      public function __align_cmb_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      private function onBoldChange() : void
      {
         var _loc1_:Boolean = Boolean(this.bold_btn.selected);
         this._asset.textBold = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onConvertHandler() : void
      {
         Console.getConsole().showImporterWindow("",this._bubble.text);
      }
      
      private function _FontChooser_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","fontchooser_title");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label1.text = param1;
         },"_FontChooser_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","fontchooser_bgtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label2.text = param1;
         },"_FontChooser_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","fontchooser_align");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label3.text = param1;
         },"_FontChooser_Label3.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","fontchooser_bold");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            bold_btn.label = param1;
         },"bold_btn.label");
         result[3] = binding;
         return result;
      }
      
      private function onBubbleLink(param1:Event) : void
      {
         var _loc2_:HyperLinkWindow = HyperLinkWindow(PopUpManager.createPopUp(this,HyperLinkWindow,true));
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) * 3 / 4;
         _loc2_.y = 100;
         _loc2_.url = this._url;
         _loc2_.fontchooser = this;
      }
      
      private function setupColor() : void
      {
         this.color_cp.selectedColor = this._color;
      }
      
      public function set asset(param1:Object) : void
      {
         this._asset = param1;
      }
      
      public function set url(param1:String) : void
      {
         this._url = param1;
         if(this._bubble != null)
         {
            this._bubble.textURL = param1;
         }
         if(param1 != "" && param1 != null)
         {
            this.btnLink.styleName = "btnBubbleLinkExist";
         }
         else
         {
            this.btnLink.styleName = "btnBubbleLink";
         }
      }
      
      public function get asset() : Object
      {
         return this._asset;
      }
      
      private function initApp() : void
      {
         this.setupFontList();
         this.setupFontSizeList();
         this.setupAlignList();
         this.setupBold();
         this.setupItalic();
         this.setupEmbed();
         this.setupColor();
         this.setupBgcolor();
         this.url = this._url;
         if(Console.getConsole().userHasTTSRight())
         {
            this._btnConvert.visible = true;
         }
      }
      
      public function __color_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      private function onFillRgbChange() : void
      {
         var _loc1_:Number = this.bgcolor_cp.selectedColor as Number;
         this._asset.fillRgb = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      [Bindable(event="propertyChange")]
      public function get align_cmb() : ComboBox
      {
         return this._1767455998align_cmb;
      }
   }
}
