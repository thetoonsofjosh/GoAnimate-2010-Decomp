package anifire.components.char_editor
{
   import anifire.cc_theme_lib.CcAction;
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcColor;
   import anifire.cc_theme_lib.CcComponent;
   import anifire.cc_theme_lib.CcComponentThumb;
   import anifire.cc_theme_lib.CcFacial;
   import anifire.cc_theme_lib.CcSelection;
   import anifire.cc_theme_lib.CcState;
   import anifire.component.CustomCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcComponentLoadEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import caurina.transitions.Tweener;
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
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.styles.*;
   import nochump.util.zip.ZipFile;
   
   public class CharPreviewer extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private const LOADER:String = "loader";
      
      private const MC:String = "MC";
      
      mx_internal var _watchers:Array;
      
      private var _tarX:Number;
      
      private var _tarY:Number;
      
      private var _customColor:UtilHashArray;
      
      private var myUI:UIComponent;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _orgX:Number;
      
      private var _orgY:Number;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _3141bg:Canvas;
      
      public function CharPreviewer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"bg",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":80,
                        "styleName":"bgCharPreviewerZoom",
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               })]};
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
            this.backgroundColor = 16777215;
            this.backgroundAlpha = 0;
         };
         this.verticalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___CharPreviewer_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CharPreviewer._watcherSetupUtil = param1;
      }
      
      public function set bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._3141bg;
         if(_loc2_ !== param1)
         {
            this._3141bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bg",_loc2_,param1));
         }
      }
      
      public function initByCcCharAfterSkeleton(param1:CcCharacter, param2:String, param3:String = "") : void
      {
         var _loc8_:int = 0;
         var _loc9_:Sprite = null;
         var _loc10_:CcComponent = null;
         var _loc4_:DisplayObjectContainer = UtilPlain.getInstance(this.myUI,AnimeConstants.MOVIECLIP_DEFAULT_HEAD);
         var _loc5_:Array = CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD;
         if(_loc4_ != null)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               (_loc9_ = new Sprite()).name = _loc5_[_loc8_] + this.MC;
               _loc4_.addChild(_loc9_);
               _loc8_++;
            }
         }
         var _loc6_:Number = param1.getUserChosenComponentSize();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc10_ = param1.getUserChosenComponentByIndex(_loc7_);
            trace("component:" + [_loc7_,_loc10_.componentThumb.type]);
            this.switchComponent(_loc10_,param1,param2,param3);
            _loc7_++;
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CharPreviewer = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CharPreviewer_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_char_editor_CharPreviewerWatcherSetupUtil");
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
      
      private function loadCCCharComplete(param1:Event) : void
      {
      }
      
      public function updateColor(param1:CcColor) : void
      {
         var colorObj:Object = null;
         var color:CcColor = param1;
         try
         {
            colorObj = new Object();
            colorObj["colorReference"] = color.ccColorThumb.colorReference;
            colorObj["originalColor"] = color.ccColorThumb.isOriginalColorExist ? color.ccColorThumb.originalColor : uint.MAX_VALUE;
            colorObj["colorValue"] = color.colorValue;
            colorObj["targetComponentId"] = color.ccComponent == null ? "" : color.ccComponent.id;
            CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).updateColor(colorObj);
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateLocation(param1:CcComponent) : void
      {
         var _loc2_:Object = {
            "x":param1.x,
            "y":param1.y,
            "xscale":param1.xscale,
            "yscale":param1.yscale,
            "offset":param1.offset,
            "rotation":param1.rotation
         };
         CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).updateLocation(param1.componentThumb.type,_loc2_,CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1.componentThumb.type) > -1 ? param1.id : "");
      }
      
      public function zoomOutFacial() : void
      {
         Tweener.addTween(this.myUI,{
            "scaleX":1,
            "scaleY":1,
            "x":this._orgX,
            "y":this._orgY,
            "time":0.5,
            "transition":"easeOut"
         });
         Tweener.addTween(this.bg,{
            "alpha":0,
            "time":0.2,
            "transition":"easeOut"
         });
      }
      
      public function switchComponent(param1:CcComponent, param2:CcCharacter, param3:String, param4:String = "") : void
      {
         var _loc5_:CcAction = null;
         var _loc6_:CcSelection = null;
         var _loc7_:CcState = null;
         var _loc8_:CcFacial = null;
         var _loc9_:CcSelection = null;
         var _loc10_:CcSelection = null;
         var _loc11_:CcComponentThumb = null;
         var _loc12_:UtilLoadMgr = null;
         if(param1 != null && param1.componentThumb.type != CcLibConstant.COMPONENT_TYPE_SKELETON && param1.componentThumb.type != CcLibConstant.COMPONENT_TYPE_BODYSHAPE)
         {
            _loc6_ = (_loc5_ = param2.bodyShape.getActionById(param3)).getSelectionByComponentType(param1.componentThumb.type);
            _loc7_ = null;
            if(_loc6_ != null)
            {
               _loc7_ = param1.componentThumb.getStateByStateId(_loc6_.stateId);
            }
            else if(param4 == "")
            {
               _loc10_ = _loc5_.getSelectionByComponentType("facial");
               _loc9_ = (_loc8_ = param2.getFacialByFacialId(_loc10_.facialId)).selections.getValueByKey(param1.componentThumb.type) as CcSelection;
               _loc7_ = param1.componentThumb.getStateByStateId(_loc9_.stateId);
            }
            else
            {
               _loc9_ = (_loc8_ = param2.getFacialByFacialId(param4)).selections.getValueByKey(param1.componentThumb.type) as CcSelection;
               _loc7_ = param1.componentThumb.getStateByStateId(_loc9_.stateId);
            }
            if(_loc7_ != null)
            {
               _loc11_ = param1.componentThumb;
               (_loc12_ = new UtilLoadMgr()).setExtraData({
                  "component":param1,
                  "ccChar":param2,
                  "actionId":param3,
                  "facialId":param4
               });
               if(_loc7_.imageData == null)
               {
                  trace("loadstate:" + [_loc7_.stateId,_loc7_.filename,param1.componentThumb.themeId]);
                  trace("ocomponent.componentThumb:" + param1.componentThumb.type);
                  _loc12_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadStateImageData);
                  _loc12_.addEventDispatcher(_loc7_,CcComponentLoadEvent.LOAD_STATE_IMAGE_DATA_COMPLETE);
                  _loc7_.loadImageData(UtilNetwork.getGetCcComponentStateFileRequest(param1.componentThumb.themeId,param1.componentThumb.type,param1.componentThumb.path,_loc7_.filename));
               }
               else
               {
                  _loc12_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReadyComponent);
                  this.changeComponent(param1,param3,param4,param2,_loc12_);
               }
               _loc12_.commit();
            }
         }
      }
      
      public function changeComponent(param1:CcComponent, param2:String, param3:String, param4:CcCharacter, param5:UtilLoadMgr) : void
      {
         var num:Number;
         var i:int;
         var colors:Array;
         var properties:Object;
         var stateId:String = null;
         var selection:CcSelection = null;
         var state:CcState = null;
         var facialSelection:CcSelection = null;
         var facial:CcFacial = null;
         var fSelection:CcSelection = null;
         var color:CcColor = null;
         var colorObj:Object = null;
         var ccComponent:CcComponent = param1;
         var actionId:String = param2;
         var facialId:String = param3;
         var ccChar:CcCharacter = param4;
         var loadMgr:UtilLoadMgr = param5;
         var action:CcAction = ccChar.bodyShape.getActionById(actionId);
         selection = action.getSelectionByComponentType(ccComponent.componentThumb.type);
         if(selection == null)
         {
            facialSelection = action.getSelectionByComponentType("facial");
            if(facialId != null && facialId.length > 0)
            {
               facial = ccChar.getFacialByFacialId(facialId);
            }
            else
            {
               facial = ccChar.getFacialByFacialId(facialSelection.facialId);
            }
            fSelection = facial.selections.getValueByKey(ccComponent.componentThumb.type) as CcSelection;
            state = ccComponent.componentThumb.getStateByStateId(fSelection.stateId);
            stateId = state.stateId;
         }
         else
         {
            stateId = selection.stateId;
         }
         properties = {
            "x":ccComponent.x,
            "y":ccComponent.y,
            "xscale":ccComponent.xscale,
            "yscale":ccComponent.yscale,
            "offset":ccComponent.offset,
            "rotation":ccComponent.rotation
         };
         colors = new Array();
         num = ccChar.getUserChosenColorNum();
         i = 0;
         while(i < num)
         {
            color = ccChar.getUserChosenColorByIndex(i);
            if(color.ccColorThumb.componentType == ccComponent.componentThumb.type || color.ccColorThumb.colorReference == "ccSkinColor")
            {
               colorObj = new Object();
               colorObj["colorReference"] = color.ccColorThumb.colorReference;
               colorObj["originalColor"] = color.ccColorThumb.isOriginalColorExist ? color.ccColorThumb.originalColor : uint.MAX_VALUE;
               colorObj["colorValue"] = color.colorValue;
               colorObj["targetComponentId"] = color.ccComponent == null ? "" : color.ccComponent.id;
               colors.push(colorObj);
            }
            i++;
         }
         try
         {
            CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).updateComponentImageData(ccComponent.componentThumb.type,ccComponent.componentThumb.getStateByStateId(stateId).imageData,properties,loadMgr,colors,ccComponent.id);
         }
         catch(e:Error)
         {
            trace("###Error:" + e);
         }
      }
      
      public function highlightComponent(param1:CcComponent) : void
      {
         CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).highlightComponent(param1.id);
      }
      
      private function _CharPreviewer_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,this.width,this.height);
         },function(param1:Rectangle):void
         {
            this.scrollRect = param1;
         },"this.scrollRect");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return 1 / 1.3;
         },function(param1:Number):void
         {
            bg.scaleX = param1;
         },"bg.scaleX");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return 1 / 1.27;
         },function(param1:Number):void
         {
            bg.scaleY = param1;
         },"bg.scaleY");
         result[2] = binding;
         return result;
      }
      
      public function initByCcChar(param1:CcCharacter, param2:String, param3:String = "") : void
      {
         var _loc5_:int = 0;
         var _loc6_:CcComponent = null;
         var _loc7_:CcAction = null;
         var _loc8_:CcSelection = null;
         var _loc9_:CcState = null;
         var _loc10_:CcComponentThumb = null;
         var _loc11_:UtilLoadMgr = null;
         CursorManager.setBusyCursor();
         CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).destroy();
         var _loc4_:Number = param1.getUserChosenComponentSize();
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = param1.getUserChosenComponentByIndex(_loc5_)) != null)
            {
               _loc8_ = (_loc7_ = param1.bodyShape.getActionById(param2)).getSelectionByComponentType(_loc6_.componentThumb.type);
               if(_loc6_.componentThumb.type == CcLibConstant.COMPONENT_TYPE_SKELETON && _loc8_ != null)
               {
                  _loc9_ = _loc6_.componentThumb.getStateByStateId(_loc8_.stateId);
                  _loc10_ = _loc6_.componentThumb;
                  (_loc11_ = new UtilLoadMgr()).setExtraData({
                     "component":_loc6_,
                     "ccChar":param1,
                     "actionId":param2,
                     "facialId":param3
                  });
                  if(_loc9_.imageData == null)
                  {
                     _loc11_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadSkeletonImageData);
                     _loc11_.addEventDispatcher(_loc9_,CcComponentLoadEvent.LOAD_STATE_IMAGE_DATA_COMPLETE);
                     _loc9_.loadImageData(UtilNetwork.getGetCcComponentStateFileRequest(_loc6_.componentThumb.themeId,_loc6_.componentThumb.type,_loc6_.componentThumb.path,_loc9_.filename));
                  }
                  else
                  {
                     _loc11_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReadySkeleton);
                     this.changeComponent(_loc6_,param2,param3,param1,_loc11_);
                  }
                  _loc11_.commit();
               }
            }
            _loc5_++;
         }
      }
      
      public function zoomInFacial() : void
      {
         Tweener.addTween(this.myUI,{
            "scaleX":2,
            "scaleY":2,
            "x":this._tarX,
            "y":this._tarY,
            "time":0.5,
            "transition":"easeOut"
         });
         Tweener.addTween(this.bg,{
            "alpha":1,
            "time":0.2,
            "transition":"easeOut"
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get bg() : Canvas
      {
         return this._3141bg;
      }
      
      public function removeHighlightComponent(param1:CcComponent) : void
      {
         CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).removeHighlight(param1.id);
      }
      
      public function reset() : void
      {
      }
      
      private function _CharPreviewer_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = new Rectangle(0,0,this.width,this.height);
         _loc1_ = 1 / 1.3;
         _loc1_ = 1 / 1.27;
      }
      
      public function removeComponent(param1:CcComponent) : void
      {
         CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).removeComponentById(param1.id);
      }
      
      public function ___CharPreviewer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.CharPreview();
      }
      
      private function onLoadStateImageData(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Object = _loc2_.getExtraData();
         var _loc4_:UtilLoadMgr;
         (_loc4_ = new UtilLoadMgr()).setExtraData(_loc3_);
         _loc4_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReadyComponent);
         this.changeComponent(_loc3_["component"],_loc3_["actionId"],_loc3_["facialId"],_loc3_["ccChar"],_loc4_);
         _loc4_.commit();
      }
      
      private function onReadyComponent(param1:LoadMgrEvent) : void
      {
         var event:LoadMgrEvent = param1;
         try
         {
            CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).onReady();
            CustomCharacterMaker(this.myUI.getChildByName(this.LOADER)).visible = true;
         }
         catch(e:Error)
         {
         }
      }
      
      public function initByCharZip(param1:ZipFile) : void
      {
      }
      
      private function onReadySkeleton(param1:LoadMgrEvent) : void
      {
         CursorManager.removeBusyCursor();
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Object = _loc2_.getExtraData();
         this.initByCcCharAfterSkeleton(_loc3_["ccChar"],_loc3_["actionId"],_loc3_["facialId"]);
      }
      
      public function CharPreview() : void
      {
         trace("init char preview");
         this._customColor = new UtilHashArray();
         var _loc1_:CustomCharacterMaker = new CustomCharacterMaker();
         _loc1_.name = this.LOADER;
         _loc1_.scaleX = -1;
         this._orgX = this.width * 0.5;
         this._orgY = this.height * 0.5;
         this._tarX = this.width * 0.6;
         this._tarY = this.height * 0.8;
         this.myUI = new UIComponent();
         this.myUI.addChild(_loc1_);
         this.myUI.x = this._orgX;
         this.myUI.y = this._orgY;
         this.addChild(this.myUI);
         this.zoomOutFacial();
      }
      
      private function onLoadSkeletonImageData(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Object = _loc2_.getExtraData();
         var _loc4_:UtilLoadMgr;
         (_loc4_ = new UtilLoadMgr()).setExtraData(_loc3_);
         _loc4_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReadySkeleton);
         this.changeComponent(_loc3_["component"],_loc3_["actionId"],_loc3_["facialId"],_loc3_["ccChar"],_loc4_);
         _loc4_.commit();
      }
   }
}
