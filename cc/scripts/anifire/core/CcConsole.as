package anifire.core
{
   import anifire.cc_interface.ICcCharEditorContainer;
   import anifire.cc_interface.ICcMainUiContainer;
   import anifire.cc_interface.ICcPreviewAndSaveContainer;
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.component.CCThumb;
   import anifire.constant.CcLibConstant;
   import anifire.constant.CcServerConstant;
   import anifire.constant.ServerConstants;
   import anifire.event.CcCoreEvent;
   import anifire.event.CcPointUpdateEvent;
   import anifire.event.CcSaveCharEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import mx.managers.CursorManager;
   import mx.utils.Base64Encoder;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CcConsole implements IEventDispatcher
   {
      
      private static var _cc_console:anifire.core.CcConsole;
       
      
      private var _moneyMode:int;
      
      private var _userLevel:int;
      
      private var _original_assetId:String;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _currentThemeId:String;
      
      private var _coupon:int = 0;
      
      private var _ui_mainUiContainer:ICcMainUiContainer;
      
      private var _ccPreviewAndSaveController:anifire.core.CcPreviewAndSaveController;
      
      private var _themes:UtilHashArray;
      
      private var _ccChar:CcCharacter;
      
      private var _isUserLogined:Boolean;
      
      private var _ccCharEditorController:anifire.core.CcCharEditorController;
      
      public function CcConsole(param1:ICcMainUiContainer, param2:ICcCharEditorContainer, param3:ICcPreviewAndSaveContainer)
      {
         super();
         this._ui_mainUiContainer = param1;
         this._eventDispatcher = new EventDispatcher();
         this._themes = new UtilHashArray();
         this.originalAssetId = Util.getFlashVar().getValueByKey("original_asset_id") as String;
         if(this.originalAssetId == null || this.originalAssetId.length <= 0)
         {
            this.originalAssetId = null;
         }
         var _loc4_:String;
         if((_loc4_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_USER_LOGIN_MODE) as String) == "Y")
         {
            this._isUserLogined = true;
         }
         else
         {
            this._isUserLogined = false;
         }
         var _loc5_:String;
         if((_loc5_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_MONEY_MODE) as String) == "free")
         {
            this._moneyMode = CcLibConstant.MONEY_MODE_NORMAL;
            this._coupon = CcLibConstant.COUPON_VALUE;
         }
         else if(_loc5_ == "noneed")
         {
            this._moneyMode = CcLibConstant.MONEY_MODE_DONT_NEED_MONEY;
         }
         else if(_loc5_ == "school")
         {
            this._moneyMode = CcLibConstant.MONEY_MODE_SCHOOL;
         }
         else
         {
            this._moneyMode = CcLibConstant.MONEY_MODE_NORMAL;
         }
         var _loc6_:String;
         if((_loc6_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) as String) == "1")
         {
            this._userLevel = CcLibConstant.USER_LEVEL_SUPER;
         }
         else
         {
            this._userLevel = CcLibConstant.USER_LEVEL_NORMAL;
         }
         this._ccCharEditorController = new anifire.core.CcCharEditorController();
         this.ccCharEditorController.initUi(param2);
         this.ccCharEditorController.addEventListener(CcCoreEvent.USER_WANT_TO_PREVIEW,this.onUserWantToPreview);
         this._ccPreviewAndSaveController = new anifire.core.CcPreviewAndSaveController();
         this.ccPreviewAndSaveController.initUi(param3);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_CANCEL,this.onUserWantToEditAgain);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_CONFIRM,this.onUserWantToConfirm);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_SAVE,this.onUserWantToSave);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_KNOW_HIS_MONEY_STATUS,this.onUserWantToUpdatePoint);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_LEARN_MORE,this.onUserWantToLearnMore);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_GO_TO_CHAR_CREATOR,this.onUserWantToGoToCc);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_GO_TO_STUDIO,this.onUserWantToGoToStudio);
         this.ccPreviewAndSaveController.addEventListener(CcCoreEvent.USER_WANT_TO_BUY_POINT,this.onUserWantToBuyPoint);
         this.loadCcThemeList();
         Util.gaTracking("/creator/initComplete",this.ui_mainUiContainer.ui_main_ViewStack);
      }
      
      public static function getCcConsole() : anifire.core.CcConsole
      {
         if(_cc_console != null)
         {
            return _cc_console;
         }
         throw new Error("CcConsole must be intialized first");
      }
      
      public static function initializeCcConsole(param1:ICcMainUiContainer, param2:ICcCharEditorContainer, param3:ICcPreviewAndSaveContainer) : anifire.core.CcConsole
      {
         if(_cc_console == null)
         {
            _cc_console = new anifire.core.CcConsole(param1,param2,param3);
         }
         return _cc_console;
      }
      
      private function getCurrentThemeId() : String
      {
         return this._currentThemeId;
      }
      
      private function get moneyMode() : int
      {
         return this._moneyMode;
      }
      
      private function doUpdatePreviewStatus(param1:CcPointUpdateEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdatePreviewStatus);
         this.ccPreviewAndSaveController.onUserPointUpdate(param1.gobuck,param1.gopoint);
      }
      
      private function save() : void
      {
         CursorManager.setBusyCursor();
         var _loc1_:ByteArray = this._ccPreviewAndSaveController.saveSnapShot();
         var _loc2_:Base64Encoder = new Base64Encoder();
         _loc2_.encodeBytes(_loc1_);
         var _loc3_:URLLoader = new URLLoader();
         var _loc4_:URLRequest = new URLRequest(CcServerConstant.ACTION_SAVE_CC_CHAR);
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["body"] = this.serialize();
         _loc5_["title"] = "Untitled";
         _loc5_["imagedata"] = _loc2_.flush();
         if(this.ccChar.assetId != "")
         {
            _loc5_["assetId"] = this.ccChar.assetId;
         }
         _loc4_.data = _loc5_;
         _loc4_.method = URLRequestMethod.POST;
         _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc3_.addEventListener(Event.COMPLETE,this.onSaveComplete);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onSaveError);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSaveError);
         _loc3_.load(_loc4_);
      }
      
      private function setCurrentThemeId(param1:String) : void
      {
         this._currentThemeId = param1;
      }
      
      private function doUpdatePreviewStatusAndConfirm(param1:CcPointUpdateEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdatePreviewStatusAndConfirm);
         this.ccPreviewAndSaveController.onUserPointUpdate(param1.gobuck,param1.gopoint,true);
      }
      
      private function loadLatestPreMadeChars(param1:Event) : void
      {
         var preMadeChars:Array;
         var e:Event = param1;
         (e.currentTarget as CcTheme).removeEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.loadLatestPreMadeChars);
         preMadeChars = (e.currentTarget as CcTheme).preMadeChars.slice().filter(function(param1:CcCharacter, param2:int, param3:Array):Boolean
         {
            return "professions" == param1.category;
         });
         preMadeChars.sortOn("createDateTime",Array.DESCENDING);
         this.refreshTemplateCCSelector(preMadeChars.slice(0,6),"latest");
      }
      
      private function getTheme(param1:String) : CcTheme
      {
         return this._themes.getValueByKey(param1) as CcTheme;
      }
      
      public function refreshTemplateCCSelector(param1:Array, param2:String = "default") : void
      {
         var _console:anifire.core.CcConsole = null;
         var char:CcCharacter = null;
         var chars:Array = param1;
         var tag:String = param2;
         _console = this;
         var _numCC:int = int(chars.length);
         var numCCStarted:int = 0;
         for each(char in chars)
         {
            (function():void
            {
               var _ccChar:* = undefined;
               var stream:* = undefined;
               var request:* = undefined;
               var _ccActionHandler:* = undefined;
               _ccChar = char;
               stream = new UtilURLStream();
               _ccActionHandler = function(param1:Event):void
               {
                  stream.removeEventListener(Event.COMPLETE,_ccActionHandler);
                  parseCCActionZipEventHandler({
                     "char":_ccChar,
                     "streamEvent":param1,
                     "tag":tag
                  });
               };
               request = UtilNetwork.getGetCcActionRequest(char.assetId,char.thumbnailActionId + ".zip");
               stream.addEventListener(Event.COMPLETE,_ccActionHandler);
               addEventListener(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,function(param1:CcCoreEvent):void
               {
                  if(--_numCC <= 0)
                  {
                     _console.dispatchEvent(new CcCoreEvent(CcCoreEvent.LOAD_CHARACTER_THUMB_ALL_COMPLETE,_console,{
                        "tag":tag,
                        "total":chars.length
                     }));
                  }
               });
               stream.load(request);
            })();
         }
      }
      
      private function onLoadCcThemeComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCcThemeComplete);
         this.dispatchEvent(new CcCoreEvent(CcCoreEvent.LOAD_THEME_COMPLETE,this));
         Util.gaTracking("/creator/loadCCThemeComplete",this.ui_mainUiContainer.ui_main_ViewStack);
      }
      
      private function loadExistingCharCompositionXml(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLLoader = null;
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_CC_CHAR_COMPOSITION_XML);
         _loc2_.method = URLRequestMethod.POST;
         var _loc4_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc4_);
         _loc4_["assetId"] = param1;
         _loc2_.data = _loc4_;
         _loc3_ = new URLLoader();
         _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadExistingCharCompositionXmlComplete);
         _loc3_.load(_loc2_);
      }
      
      private function get originalAssetId() : String
      {
         return this._original_assetId;
      }
      
      private function loadCcTheme(param1:String) : void
      {
         var _loc2_:CcTheme = new CcTheme();
         _loc2_.id = param1;
         this.addTheme(_loc2_);
         _loc2_.addEventListener(CcCoreEvent.LOAD_THEME_COMPLETE,this.onLoadCcThemeComplete);
         _loc2_.initCcThemeByLoadThemeFile(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      private function doPrepareCcChar(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doPrepareCcChar);
         this._ccChar = new CcCharacter();
         var _loc2_:CcTheme = this.getTheme(this.getCurrentThemeId());
         var _loc3_:Array = _loc2_.getBodyShapeTypes();
         var _loc4_:String = _loc3_[int(Math.floor(Math.random() * _loc2_.getBodyShapeTypes().length))] as String;
         Util.gaTracking("/creator/loadPremadeCharComplete",this.ui_mainUiContainer.ui_main_ViewStack);
      }
      
      private function onUserWantToLearnMore(param1:Event) : void
      {
         navigateToURL(new URLRequest(ServerConstants.FAQ_GOBUCK_PATH),"_blank");
      }
      
      private function get coupon() : int
      {
         return this._coupon;
      }
      
      private function addTheme(param1:CcTheme) : void
      {
         this._themes.push(param1.id,param1);
      }
      
      private function get ui_mainUiContainer() : ICcMainUiContainer
      {
         return this._ui_mainUiContainer;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      private function onUserWantToGoToStudio(param1:Event) : void
      {
         navigateToURL(new URLRequest(ServerConstants.STUDIO_PAGE_PATH + "theme/custom"),"_top");
      }
      
      private function prepareExistingCcChar(param1:String) : void
      {
         this._ccChar = new CcCharacter();
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc2_.push(this.getCurrentThemeId(),this.getTheme(this.getCurrentThemeId()));
         this._ccChar.deserialize(new XML(param1),_loc2_);
      }
      
      private function onUserWantToSave(param1:Event) : void
      {
         this.addEventListener(CcSaveCharEvent.SAVE_CHAR_COMPLETE,this.doTellUserSaveStatus);
         this.addEventListener(CcSaveCharEvent.SAVE_CHAR_NOT_ENOUGH_MONEY_POINT,this.doTellUserSaveStatus);
         this.addEventListener(CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR,this.doTellUserSaveStatus);
         this.save();
      }
      
      private function set originalAssetId(param1:String) : void
      {
         this._original_assetId = param1;
      }
      
      private function isCopyingChar() : Boolean
      {
         return this.originalAssetId == null ? false : true;
      }
      
      private function onLoadCcThemeListComplete() : void
      {
         this.setCurrentThemeId("family");
         this.addEventListener(CcCoreEvent.LOAD_THEME_COMPLETE,this.doLoadPreMadeChar);
         this.loadCcTheme(this.getCurrentThemeId());
      }
      
      private function onUserWantToGoToCc(param1:Event) : void
      {
         Util.gaTracking("/creator/CreateMore",this.ui_mainUiContainer.ui_main_ViewStack);
         navigateToURL(new URLRequest(ServerConstants.CC_PAGE_PATH),"_top");
      }
      
      private function doEnableUserToStartUseCC(param1:Event) : void
      {
         var self:anifire.core.CcConsole = null;
         var proceedHandler:Function = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.doEnableUserToStartUseCC);
         self = this;
         proceedHandler = function(param1:CcCoreEvent):void
         {
            self.removeEventListener(CcCoreEvent.LOAD_EXISTING_CHAR_COMPLETE,proceedHandler);
            onUserWantToStart(event);
         };
         if(this.originalAssetId != null)
         {
            this.addEventListener(CcCoreEvent.LOAD_EXISTING_CHAR_COMPLETE,proceedHandler);
         }
         else
         {
            this.onUserWantToStart(event);
         }
      }
      
      private function loadCcThemeList() : void
      {
         this.onLoadCcThemeListComplete();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      private function doLoadExistingCcChar(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadExistingCcChar);
         this.addEventListener(CcCoreEvent.LOAD_EXISTING_CHAR_COMPLETE,this.doPrepareExistingCcChar);
         this.loadExistingCharCompositionXml(Util.getFlashVar().getValueByKey("original_asset_id") as String);
         Util.gaTracking("/creator/loadExistCharComplete",this.ui_mainUiContainer.ui_main_ViewStack);
      }
      
      private function onUserWantToStart(param1:Event) : void
      {
         this.ui_mainUiContainer.ui_main_ViewStack.selectedChild = this.ui_mainUiContainer.ui_main_ccCharEditor;
         this.ccCharEditorController.initTheme(this.getTheme(this.getCurrentThemeId()));
         this.ccCharEditorController.initMode(this.moneyMode,this.isUserLogined,this.userLevel,this.coupon);
         this.ccCharEditorController.start(this.ccChar,!this.isCopyingChar());
         this.ccPreviewAndSaveController.initTheme(this.getTheme(this.getCurrentThemeId()));
         this.ccPreviewAndSaveController.initMode(this.moneyMode,this.isUserLogined,this.coupon);
         this.ccPreviewAndSaveController.initChar(this.ccChar);
      }
      
      private function get ccPreviewAndSaveController() : anifire.core.CcPreviewAndSaveController
      {
         return this._ccPreviewAndSaveController;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function getTemplateCCPreMadeChars() : Array
      {
         var _loc1_:CcTheme = this.getTheme(this.getCurrentThemeId());
         return _loc1_.preMadeChars;
      }
      
      private function get ccChar() : CcCharacter
      {
         return this._ccChar;
      }
      
      private function onUpdatedUserPointStatus(param1:Event) : void
      {
         var returnString:String;
         var urlLoader:URLLoader;
         var resultEvent:CcPointUpdateEvent = null;
         var xml:XML = null;
         var evt:Event = param1;
         CursorManager.removeBusyCursor();
         (evt.target as IEventDispatcher).removeEventListener(evt.type,this.onUpdatedUserPointStatus);
         urlLoader = evt.target as URLLoader;
         returnString = urlLoader.data as String;
         if(returnString.charAt(0) == "0")
         {
            try
            {
               if(returnString.charAt(0) == "0")
               {
                  resultEvent = new CcPointUpdateEvent(CcPointUpdateEvent.POINT_UPDATE_COMPLETE,this);
               }
               xml = new XML(returnString.substr(1,returnString.length));
               resultEvent.gobuck = Number(xml.@money);
               resultEvent.gopoint = Number(xml.@sharing);
               this.dispatchEvent(resultEvent);
            }
            catch(e:Error)
            {
               this.dispatchEvent(new CcSaveCharEvent(CcPointUpdateEvent.ERROR_OCCUR,this));
            }
         }
         else
         {
            this.dispatchEvent(new CcSaveCharEvent(CcPointUpdateEvent.ERROR_OCCUR,this));
         }
      }
      
      private function onSaveComplete(param1:Event) : void
      {
         var returnString:String;
         var urlLoader:URLLoader;
         var resultEvent:CcSaveCharEvent = null;
         var xml:XML = null;
         var evt:Event = param1;
         CursorManager.removeBusyCursor();
         (evt.target as IEventDispatcher).removeEventListener(evt.type,this.onSaveComplete);
         urlLoader = evt.target as URLLoader;
         returnString = urlLoader.data as String;
         if(returnString.charAt(0) == "0" || returnString.charAt(0) == "2")
         {
            try
            {
               if(returnString.charAt(0) == "0")
               {
                  resultEvent = new CcSaveCharEvent(CcSaveCharEvent.SAVE_CHAR_COMPLETE,this);
               }
               else if(returnString.charAt(0) == "2")
               {
                  resultEvent = new CcSaveCharEvent(CcSaveCharEvent.SAVE_CHAR_NOT_ENOUGH_MONEY_POINT,this);
               }
               xml = new XML(returnString.substr(1,returnString.length));
               resultEvent.gobuck = Number(xml.@money);
               resultEvent.gopoint = Number(xml.@sharing);
               this.dispatchEvent(resultEvent);
            }
            catch(e:Error)
            {
               this.dispatchEvent(new CcSaveCharEvent(CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR,this));
            }
         }
         else
         {
            this.dispatchEvent(new CcSaveCharEvent(CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR,this));
         }
      }
      
      public function updateUserPointStatus() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = UtilNetwork.getPointStatus();
         _loc1_.addEventListener(Event.COMPLETE,this.onUpdatedUserPointStatus);
         _loc1_.load(_loc2_);
         CursorManager.setBusyCursor();
      }
      
      private function get ccCharEditorController() : anifire.core.CcCharEditorController
      {
         return this._ccCharEditorController;
      }
      
      private function serialize() : String
      {
         return "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<cc_char>" + this.ccChar.serialize() + "</cc_char>";
      }
      
      private function onUserWantToEditAgain(param1:Event) : void
      {
         this.ui_mainUiContainer.ui_main_ViewStack.selectedChild = this.ui_mainUiContainer.ui_main_ccCharEditor;
      }
      
      private function doPrepareExistingCcChar(param1:CcCoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doPrepareExistingCcChar);
         this.prepareExistingCcChar(param1.getData() as String);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      private function onUserWantToBuyPoint(param1:Event) : void
      {
         navigateToURL(new URLRequest(ServerConstants.ACTION_BUY_BUCKS),"_blank");
      }
      
      private function onUserWantToConfirm(param1:Event) : void
      {
         if(this.moneyMode != CcLibConstant.MONEY_MODE_SCHOOL)
         {
            this.addEventListener(CcPointUpdateEvent.POINT_UPDATE_COMPLETE,this.doUpdatePreviewStatusAndConfirm);
            this.updateUserPointStatus();
         }
         else
         {
            this.ccPreviewAndSaveController.onUserPointUpdate(0,0,true);
         }
         if(this.isCopyingChar())
         {
            Util.gaTracking("/creator/IntendSave/CopiedChar",this.ui_mainUiContainer.ui_main_ViewStack);
         }
         else
         {
            Util.gaTracking("/creator/IntendSave/NewChar",this.ui_mainUiContainer.ui_main_ViewStack);
         }
         if(this.isCopyingChar())
         {
            Util.gaTracking("/creator/IntendSave/CopiedChar",this.ui_mainUiContainer.ui_main_ViewStack);
         }
         else
         {
            Util.gaTracking("/creator/IntendSave/NewChar",this.ui_mainUiContainer.ui_main_ViewStack);
         }
      }
      
      private function onSaveError(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSaveError);
         this.dispatchEvent(new CcSaveCharEvent(CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR,this));
      }
      
      private function onLoadExistingCharCompositionXmlComplete(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:CcCoreEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadExistingCharCompositionXmlComplete);
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:String = _loc2_.data as String;
         if(_loc3_.charAt(0) == "0")
         {
            _loc4_ = _loc3_.substr(1);
            _loc5_ = new CcCoreEvent(CcCoreEvent.LOAD_EXISTING_CHAR_COMPLETE,this,_loc4_);
            this.dispatchEvent(_loc5_);
         }
      }
      
      private function loadRandomPreMadeChars(param1:Event) : void
      {
         var preMadeChars:Array;
         var randCharList:Array;
         var idx:int = 0;
         var e:Event = param1;
         (e.currentTarget as CcTheme).removeEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.loadRandomPreMadeChars);
         preMadeChars = (e.currentTarget as CcTheme).preMadeChars.slice().filter(function(param1:CcCharacter, param2:int, param3:Array):Boolean
         {
            return "professions" == param1.category;
         });
         randCharList = [];
         if(preMadeChars.length <= 6)
         {
            randCharList = preMadeChars.slice(0,6);
         }
         else
         {
            while(randCharList.length < 6)
            {
               idx = int(Math.random() * preMadeChars.length);
               if(randCharList.indexOf(preMadeChars[idx]) < 0)
               {
                  randCharList.push(preMadeChars[idx]);
               }
            }
         }
         this.refreshTemplateCCSelector(randCharList,"latest");
      }
      
      private function onUserWantToUpdatePoint(param1:Event) : void
      {
         this.addEventListener(CcPointUpdateEvent.POINT_UPDATE_COMPLETE,this.doUpdatePreviewStatus);
         this.updateUserPointStatus();
         Util.gaTracking("/creator/RefreshAgain",this.ui_mainUiContainer.ui_main_ViewStack);
      }
      
      private function onUserWantToPreview(param1:Event) : void
      {
         this.ui_mainUiContainer.ui_main_ViewStack.selectedChild = this.ui_mainUiContainer.ui_main_ccCharPreviewAndSaveScreen;
         this.ccPreviewAndSaveController.proceedToShow();
         if(this.moneyMode != CcLibConstant.MONEY_MODE_SCHOOL)
         {
            this.addEventListener(CcPointUpdateEvent.POINT_UPDATE_COMPLETE,this.doUpdatePreviewStatus);
            this.updateUserPointStatus();
         }
      }
      
      private function doTellUserSaveStatus(param1:CcSaveCharEvent) : void
      {
         this.removeEventListener(CcSaveCharEvent.SAVE_CHAR_COMPLETE,this.doTellUserSaveStatus);
         this.removeEventListener(CcSaveCharEvent.SAVE_CHAR_NOT_ENOUGH_MONEY_POINT,this.doTellUserSaveStatus);
         this.removeEventListener(CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR,this.doTellUserSaveStatus);
         if(param1.type == CcSaveCharEvent.SAVE_CHAR_COMPLETE)
         {
            this.ccPreviewAndSaveController.proceedToSaveComplete(param1.gopoint,param1.gobuck);
            if(this.isCopyingChar())
            {
               Util.gaTracking("/creator/SaveCompleted/CopiedChar",this.ui_mainUiContainer.ui_main_ViewStack);
            }
            else
            {
               Util.gaTracking("/creator/SaveCompleted/NewChar",this.ui_mainUiContainer.ui_main_ViewStack);
            }
         }
         else if(param1.type == CcSaveCharEvent.SAVE_CHAR_NOT_ENOUGH_MONEY_POINT)
         {
            this.ccPreviewAndSaveController.proceedToSaveNotEnoughMoney(param1.gopoint,param1.gobuck);
            Util.gaTracking("/creator/SaveFail/NeedGB",this.ui_mainUiContainer.ui_main_ViewStack);
         }
         else if(param1.type == CcSaveCharEvent.SAVE_CHAR_ERROR_OCCUR)
         {
            this.ccPreviewAndSaveController.proceedToSaveError();
         }
      }
      
      public function parseCCActionZipEventHandler(param1:Object) : void
      {
         var args:Object;
         var ccFileHashArray:UtilHashArray;
         var ccZipFile:ZipFile;
         var ccChar:CcCharacter = null;
         var decryptEngine:UtilCrypto = null;
         var j:int = 0;
         var ccZipEntry:ZipEntry = null;
         var ccFileBytes:ByteArray = null;
         var thumb:CCThumb = null;
         var ccConsole:anifire.core.CcConsole = null;
         var data:Object = param1;
         ccChar = data.char as CcCharacter;
         var event:Event = data.streamEvent as Event;
         var stream:URLStream = URLStream(event.target);
         var swfBytes:ByteArray = new ByteArray();
         stream.readBytes(swfBytes,0,stream.bytesAvailable);
         ccZipFile = new ZipFile(swfBytes);
         args = new Object();
         ccFileHashArray = new UtilHashArray();
         j = 0;
         while(j < ccZipFile.size)
         {
            ccZipEntry = ccZipFile.entries[j];
            if(ccZipEntry.name == CcLibConstant.XML_DESC)
            {
               args["xml"] = new XML(ccZipFile.getInput(ccZipEntry).toString());
            }
            else if(ccZipEntry.name.substr(ccZipEntry.name.length - 3,3).toLowerCase() == "swf")
            {
               ccFileBytes = ccZipFile.getInput(ccZipEntry);
               decryptEngine = new UtilCrypto();
               decryptEngine.decrypt(ccFileBytes);
               ccFileHashArray.push(ccZipEntry.name,ccFileBytes);
            }
            j++;
         }
         args["imageData"] = ccFileHashArray;
         thumb = new CCThumb();
         ccConsole = this;
         thumb.cellWidth = thumb.cellHeight = CcLibConstant.TEMPLATE_CCTHUMB_WIDTH;
         thumb.init(args["xml"],args["imageData"]);
         thumb.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,function(param1:Event):void
         {
            ccConsole.dispatchEvent(new CcCoreEvent(CcCoreEvent.LOAD_CHARACTER_THUMB_COMPLETE,this,{
               "char":ccChar,
               "thumbnail":thumb,
               "tag":data.tag
            }));
         });
      }
      
      private function get userLevel() : int
      {
         return this._userLevel;
      }
      
      private function get isUserLogined() : Boolean
      {
         return this._isUserLogined;
      }
      
      private function doLoadPreMadeChar(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadPreMadeChar);
         var _loc2_:CcTheme = this.getTheme(this.getCurrentThemeId());
         if(this.originalAssetId != null)
         {
            _loc2_.addEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.doLoadExistingCcChar);
         }
         else
         {
            _loc2_.addEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.doPrepareCcChar);
         }
         _loc2_.addEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.doEnableUserToStartUseCC);
         _loc2_.addEventListener(CcCoreEvent.LOAD_PRE_MADE_CHARACTER_COMPLETE,this.loadLatestPreMadeChars);
         _loc2_.initCcThemePreMadeChar();
      }
   }
}
