package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.component.CCThumb;
   import anifire.core.CcConsole;
   import anifire.event.CcCoreEvent;
   import anifire.event.CcTemplateChooserEvent;
   import anifire.util.Util;
   import anifire.util.UtilPager;
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
   import mx.containers.Tile;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class TemplateCCSelector extends VBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _55416058leftBut:Button;
      
      private var _categoryDisplayed:String = "";
      
      private var _1329765796thumbTile:Tile;
      
      private var _pageNumDisplayed:int = -1;
      
      mx_internal var _watchers:Array;
      
      private var _1436107067rightBut:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1468771644_pager:UtilPager = null;
      
      private var _selectedAssetId:String = null;
      
      private var _category:String = "";
      
      public var _TemplateCCSelector_Label1:Label;
      
      mx_internal var _bindings:Array;
      
      private var _hasHandler:Boolean = false;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function TemplateCCSelector()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":500,
                  "height":440,
                  "childDescriptors":[new UIComponentDescriptor({
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
                              "events":{"click":"__leftBut_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "buttonMode":true,
                                    "styleName":"btnTemplateThumbChooserLeft"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Tile,
                              "id":"thumbTile",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "minWidth":406,
                                    "minHeight":402
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"rightBut",
                              "events":{"click":"__rightBut_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "buttonMode":true,
                                    "styleName":"btnTemplateThumbChooserRight"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_TemplateCCSelector_Label1",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"templateBrowsePageNumber",
                           "percentWidth":100
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
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.width = 500;
         this.height = 440;
         this.addEventListener("initialize",this.___TemplateCCSelector_VBox1_initialize);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TemplateCCSelector._watcherSetupUtil = param1;
      }
      
      public function set pager(param1:UtilPager) : void
      {
         this._pager = param1;
         if(param1 != null)
         {
            this.thumbTile.removeAllChildren();
            if(!this._hasHandler)
            {
               this.initCreationComplete();
            }
            this._pageNumDisplayed = this._pager.pageNumber;
            this._categoryDisplayed = this._category;
            CcConsole.getCcConsole().refreshTemplateCCSelector(param1.getView(),"tile");
         }
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
      
      private function set _pager(param1:UtilPager) : void
      {
         var _loc2_:Object = this._1468771644_pager;
         if(_loc2_ !== param1)
         {
            this._1468771644_pager = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pager",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:TemplateCCSelector = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._TemplateCCSelector_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_TemplateCCSelectorWatcherSetupUtil");
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
      
      private function refreshHighlight() : void
      {
         var _loc1_:CCTemplateCharThumb = null;
         for each(_loc1_ in this.thumbTile.getChildren())
         {
            _loc1_.currentState = _loc1_.character.assetId == this._selectedAssetId ? "selected" : "";
         }
      }
      
      private function init() : void
      {
         addEventListener(CcTemplateChooserEvent.PREVIEW_CHARACTER_CHANGED,function(param1:CcTemplateChooserEvent):void
         {
            _selectedAssetId = (param1.getData() as CcCharacter).assetId;
            if(_pageNumDisplayed != _pager.pageNumber || _categoryDisplayed != _category)
            {
               _pageNumDisplayed = _pager.pageNumber;
               _categoryDisplayed = _category;
               CcConsole.getCcConsole().refreshTemplateCCSelector(_pager.getView(),"tile");
               thumbTile.removeAllChildren();
            }
            else
            {
               refreshHighlight();
            }
         });
      }
      
      public function ___TemplateCCSelector_VBox1_initialize(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get thumbTile() : Tile
      {
         return this._1329765796thumbTile;
      }
      
      private function _TemplateCCSelector_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return _pager.pageNumber > 1;
         },function(param1:Boolean):void
         {
            leftBut.enabled = param1;
         },"leftBut.enabled");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return _pager.pageNumber < _pager.totalPages;
         },function(param1:Boolean):void
         {
            rightBut.enabled = param1;
         },"rightBut.enabled");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _pager.pageNumber + " / " + _pager.totalPages;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _TemplateCCSelector_Label1.text = param1;
         },"_TemplateCCSelector_Label1.text");
         result[2] = binding;
         return result;
      }
      
      public function __leftBut_click(param1:MouseEvent) : void
      {
         this.previous();
      }
      
      public function get pager() : UtilPager
      {
         return this._pager;
      }
      
      [Bindable(event="propertyChange")]
      private function get _pager() : UtilPager
      {
         return this._1468771644_pager;
      }
      
      [Bindable(event="propertyChange")]
      public function get rightBut() : Button
      {
         return this._1436107067rightBut;
      }
      
      public function set thumbTile(param1:Tile) : void
      {
         var _loc2_:Object = this._1329765796thumbTile;
         if(_loc2_ !== param1)
         {
            this._1329765796thumbTile = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"thumbTile",_loc2_,param1));
         }
      }
      
      private function getInsertionIndex(param1:CCTemplateCharThumb) : int
      {
         var addedChars:Array = null;
         var iitemIndex:int = 0;
         var retval:Array = null;
         var iitem:CCTemplateCharThumb = param1;
         addedChars = this.thumbTile.getChildren().map(function(param1:CCTemplateCharThumb, param2:int, param3:Array):Object
         {
            return param1.character;
         });
         iitemIndex = 0;
         var orderings:Array = this._pager.getView().map(function(param1:CcCharacter, param2:int, param3:Array):Object
         {
            if(param1 == iitem.character)
            {
               iitemIndex = param2;
            }
            return {
               "item":param1,
               "index":param2
            };
         });
         retval = [];
         orderings.filter(function(param1:Object, param2:int, param3:Array):Boolean
         {
            return addedChars.indexOf(param1.item) >= 0;
         }).forEach(function(param1:Object, param2:int, param3:Array):void
         {
            if(param1.index - iitemIndex > 0)
            {
               retval.push(param2);
            }
         });
         return retval.length == 0 ? (addedChars.length > 0 ? int(addedChars.length) : 0) : int(retval[0]);
      }
      
      private function _TemplateCCSelector_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._pager.pageNumber > 1;
         _loc1_ = this._pager.pageNumber < this._pager.totalPages;
         _loc1_ = this._pager.pageNumber + " / " + this._pager.totalPages;
      }
      
      private function initCreationComplete() : void
      {
         var self:TemplateCCSelector = null;
         self = this;
         this._hasHandler = true;
         CcConsole.getCcConsole().addEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,function(param1:CcCoreEvent):void
         {
            var char:CcCharacter = null;
            var tthumb:CCTemplateCharThumb = null;
            var e:CcCoreEvent = param1;
            var data:Object = e.getData();
            var thumb:CCThumb = data.thumbnail as CCThumb;
            char = data.char as CcCharacter;
            if(data.tag != "tile" || !_pager.isItemOnCurrentPage(char) || Boolean(thumbTile.getChildren().some(function(param1:CCTemplateCharThumb, param2:int, param3:Array):Boolean
            {
               return param1.character.assetId == char.assetId;
            })))
            {
               return;
            }
            tthumb = new CCTemplateCharThumb();
            tthumb.character = char;
            tthumb.thumbnail = thumb;
            tthumb.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
            {
               Util.gaTracking("/creator/templateThumbClick",self);
               dispatchEvent(new CcTemplateChooserEvent(CcTemplateChooserEvent.USER_WANT_TO_PREVIEW,tthumb,char,true));
            });
            if(tthumb.character.assetId == _selectedAssetId)
            {
               tthumb.currentState = "selected";
            }
            thumbTile.addChildAt(tthumb,getInsertionIndex(tthumb));
            if(_pager.getView().length == thumbTile.getChildren().length)
            {
               refreshHighlight();
            }
         });
      }
      
      public function __rightBut_click(param1:MouseEvent) : void
      {
         this.next();
      }
      
      private function next() : void
      {
         var _loc1_:CcConsole = CcConsole.getCcConsole();
         var _loc2_:int = this._pager.pageNumber;
         this._pager.next();
         if(this._pager.pageNumber != _loc2_ || this._categoryDisplayed != this._category)
         {
            Util.gaTracking("/creator/templateThumbView/" + (this._category == "" ? "unknown" : this._category) + "/" + this._pager.pageNumber.toString(),this);
            this._pageNumDisplayed = this._pager.pageNumber;
            this._categoryDisplayed = this._category;
            _loc1_.refreshTemplateCCSelector(this._pager.getView(),"tile");
            this.thumbTile.removeAllChildren();
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
      
      private function previous() : void
      {
         var _loc1_:CcConsole = CcConsole.getCcConsole();
         var _loc2_:int = this._pager.pageNumber;
         this._pager.previous();
         if(this._pager.pageNumber != _loc2_ || this._categoryDisplayed != this._category)
         {
            Util.gaTracking("/creator/templateThumbView/" + (this._category == "" ? "unknown" : this._category) + "/" + this._pager.pageNumber.toString(),this);
            this._pageNumDisplayed = this._pager.pageNumber;
            this._categoryDisplayed = this._category;
            _loc1_.refreshTemplateCCSelector(this._pager.getView(),"tile");
            this.thumbTile.removeAllChildren();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get leftBut() : Button
      {
         return this._55416058leftBut;
      }
      
      public function set category(param1:String) : void
      {
         this._category = param1;
      }
      
      public function get category() : String
      {
         return this._category;
      }
   }
}
