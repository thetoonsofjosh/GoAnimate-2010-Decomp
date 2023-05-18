package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.command.AddAssetCommand;
   import anifire.command.AddSceneCommand;
   import anifire.command.AddSoundCommand;
   import anifire.command.BringForwardCommand;
   import anifire.command.ChangeSceneLengthCommand;
   import anifire.command.ChangeSoundLengthCommand;
   import anifire.command.ClearSceneCommand;
   import anifire.command.CommandEvent;
   import anifire.command.CommandStack;
   import anifire.command.ICommand;
   import anifire.command.RemoveSceneCommand;
   import anifire.command.SendBackwardCommand;
   import anifire.components.containers.GoAlert;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.BubbleMsgChooser;
   import anifire.components.studio.BubbleMsgChooserItem;
   import anifire.components.studio.BubbleMsgEvent;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.ExternalPreviewWindowController;
   import anifire.components.studio.GoWalker;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.PropertiesWindow;
   import anifire.components.studio.PublishWindow;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TipWindow;
   import anifire.components.studio.TopButtonBar;
   import anifire.components.studio.ViewStackWindow;
   import anifire.components.studio.noSaveAlertWindow;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.constant.ThemeEmbedConstant;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.event.GoWalkerEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.CopyThumbEvent;
   import anifire.events.LoadCcCharCountEvent;
   import anifire.events.PropertyWindowEvent;
   import anifire.interfaces.IConsoleImportable;
   import anifire.playback.PlayerConstant;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.timeline.ElementInfo;
   import anifire.timeline.SoundContainer;
   import anifire.timeline.Timeline;
   import anifire.timeline.TimelineEvent;
   import anifire.util.*;
   import com.adobe.images.JPGEncoder;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.StyleSheet;
   import flash.text.TextFieldType;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.ProgressBar;
   import mx.controls.SWFLoader;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.Application;
   import mx.core.DragSource;
   import mx.effects.Blur;
   import mx.effects.Fade;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ScrollEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   import mx.managers.SystemManager;
   import mx.utils.Base64Encoder;
   import mx.utils.StringUtil;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   import template.templateApp.classes.Global;
   
   public class Console implements IConsoleImportable, IEventDispatcher
   {
      
      public static const FULL_STUDIO:String = "Full_Studio";
      
      public static const BOX_STUDIO:String = "box_studio";
      
      public static const MESSAGE_STUDIO:String = "message_studio";
      
      private static var _logger:ILogger = Log.getLogger("core.Console");
      
      public static const TINY_STUDIO:String = "tiny_studio";
      
      private static var _console:anifire.core.Console;
       
      
      private var _defaultUpdateAllTimelineImage:Boolean = false;
      
      private var _moneyPoints:Number = 0;
      
      private var _prevSceneLength:Number;
      
      private var _movieXML:XML;
      
      private var _importerOpenedBefore:Boolean = false;
      
      private var _nextCommunityCharPage:int = 0;
      
      private var _currDragSource:DragSource;
      
      private var _copySceneData:String = "";
      
      private var _originalId:String;
      
      private var _published:Boolean = false;
      
      private var _importer:Application;
      
      public var flickrToken:String = null;
      
      private var _currentScene:anifire.core.AnimeScene;
      
      private var _whiteTerms:Array = null;
      
      private var _screenCapTool:ScreenCapTool;
      
      public var excludedIds:UtilHashArray;
      
      private var _isLoaddingCommonTheme:Boolean = false;
      
      private var _headable:Boolean;
      
      private var _goWalker:GoWalker;
      
      private var _thumbTray:ThumbTray;
      
      private var _metaData:anifire.core.MetaData;
      
      private var _isAutoSave:Boolean = false;
      
      private var _isLoaddingCommonThemeBg:Boolean = false;
      
      private var _externalPreviewPlayerController:ExternalPreviewWindowController;
      
      private var _purchaseEnabled:Boolean;
      
      private var _uploadedAssetsEnabled:Boolean;
      
      private var _curTheme:anifire.core.Theme;
      
      private var _boxMode:Boolean = false;
      
      private var _byteArrayReturnFromLoadCcChar:ByteArray = null;
      
      private var _themes:UtilHashArray;
      
      private var _isCopy:Boolean = false;
      
      private var _nextUserCharPage:int = 0;
      
      private var _nextCommunitySoundEffectPage:int = 0;
      
      private var _needGuideBubbles:Boolean = true;
      
      private var _initialized:Boolean = false;
      
      private var _nextCommunitySoundTTSPage:int = 0;
      
      private var _myAnimatedMask:anifire.core.AnimatedMask;
      
      private var _inspirationLoader:SWFLoader;
      
      private var _tempMetaData:anifire.core.MetaData;
      
      private var _isMovieNew:Boolean = false;
      
      private var _redirect:Boolean = false;
      
      private var _groupController:anifire.core.GroupController;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      private var _guideMode:String = "";
      
      private var _loaddingAssetType:String = "prop";
      
      private var _pptPanel:PropertiesWindow;
      
      private var _placeable:Boolean;
      
      private var _changed:Boolean;
      
      private var _communityTheme:anifire.core.Theme;
      
      private var _nextUserBgPage:int = 0;
      
      private var _loadRequestCounter:int = 0;
      
      private var _timeline:Timeline;
      
      private var _nextUserSoundEffectPage:int = 0;
      
      private var _blacklistEnabled:Boolean;
      
      private var _nextCommunitySoundPage:int = 0;
      
      private var _privateShared:Boolean = false;
      
      private var _previewData:UtilHashArray;
      
      private var _tempPrivateShared:Boolean = false;
      
      private var _bubbleSceneGuide:Image;
      
      private var _selectedThumbnailIndex:int = 0;
      
      private var _badTerms:Array = null;
      
      private var _nextCommunityPropPage:int = 0;
      
      private var _prevAllSoundInfo:Array;
      
      private var _tempAsset:anifire.core.Asset;
      
      private var _nextUserSoundPage:int = 0;
      
      private var _effectTray:EffectTray;
      
      private var _currentLicensorName:String = "";
      
      private var _initCreation:Boolean = true;
      
      private var _nextCommunitySoundMusicPage:int = 0;
      
      private var _copyData:String = "";
      
      private var _nextUserSoundMusicPage:int = 0;
      
      private var storecollection:Array;
      
      private var _soundMute:Boolean = true;
      
      private var _nextUserEffectPage:int = 0;
      
      private var _sounds:UtilHashArray;
      
      private var LOCAL_CON:String = "importer_lc";
      
      private var _themeListXML:XML;
      
      private var _nextUserPropPage:int = 0;
      
      private var _nextUserSoundTTSPage:int = 0;
      
      private var _uploadType:String = "bg";
      
      private var _tempPublished:Boolean = true;
      
      private var _lastLoaddedTheme:anifire.core.Theme;
      
      private var _scenes:UtilHashArray;
      
      private var _publishW:PublishWindow;
      
      private var _isCommonThemeLoadded:Boolean = false;
      
      private var _nextUserVideoPropPage:int = 0;
      
      private var _viewStackWindow:ViewStackWindow = null;
      
      private var _eventDispatcher:UtilEventDispatcher;
      
      private var _nextCommunitySoundVoicePage:int = 0;
      
      private var _nextUserSoundVoicePage:int = 0;
      
      private var _filmXML:XML;
      
      private var _sharingPoints:Number = 0;
      
      private var _bubbleThumbGuide:Image;
      
      private var _assetId:Number = 0;
      
      private var _loadProgress:ProgressBar;
      
      private var _capScreenLock:Boolean = false;
      
      private var _isCopyable:Boolean = false;
      
      private var _newlyAddedAssetIds:String = "";
      
      private var _userTheme:anifire.core.Theme;
      
      private var _mainStage:MainStage;
      
      private var _nextCommunityEffectPage:int = 0;
      
      private var _sci:int;
      
      private var _prevSoundInfo:ElementInfo;
      
      private var _ttsEnabled:Boolean;
      
      private var _tipsLayer:Canvas;
      
      private var _currentSceneIndex:int = -1;
      
      private var _currDragObject:anifire.core.Asset;
      
      private var _isLoaddingCommonThemeChar:Boolean = false;
      
      private var _topButtonBar:TopButtonBar;
      
      private var _isLoaddingCommonThemeProp:Boolean = false;
      
      private var _nextCommunityBgPage:int = 0;
      
      private var _stageViewStack:ViewStack;
      
      private var _swfLoader:SWFLoader;
      
      private var _searchedTheme:anifire.core.Theme;
      
      private var _isLoadding:Boolean = false;
      
      private var _studioType:String;
      
      public var fbAuthToken:String = null;
      
      private var _siteId:String;
      
      private var _uploadedAssetXML:XML;
      
      private var _purchasedAssetsXML:XMLList;
      
      private var _holdable:Boolean;
      
      public function Console(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:SWFLoader, param7:SWFLoader, param8:PropertiesWindow, param9:Canvas, param10:ScreenCapTool, param11:GoWalker = null, param12:String = "tiny_studio")
      {
         var _loc13_:CommandStack = null;
         var _loc14_:UtilHashArray = null;
         var _loc15_:Number = NaN;
         this._externalPreviewPlayerController = new ExternalPreviewWindowController();
         this.storecollection = new Array();
         super();
         if(param1 != null && param2 != null && param3 != null && param5 != null)
         {
            this._myAnimatedMask = anifire.core.AnimatedMask.getInstance();
            Util.initLog();
            _logger.debug("Console initialized");
            this._mainStage = param1;
            this._topButtonBar = param2;
            this.enableRedo(false);
            this._thumbTray = param3;
            this._timeline = param5;
            this._effectTray = param4;
            this._swfLoader = param6;
            this._inspirationLoader = param7;
            this.pptPanel = param8;
            this._tipsLayer = param9;
            this.screenCapTool = param10;
            this.goWalker = param11;
            this._studioType = param12;
            this._timeline.addEventListener(TimelineEvent.SCENE_MOUSE_DOWN,this.onSceneDownHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_START,this.onSceneResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_COMPLETE,this.onSceneResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_CLICK,this.onSoundClickHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOVE,this.onSoundMoveHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE,this.onSoundResizeHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_START,this.onSoundResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_COMPLETE,this.onSoundResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_DOWN,this.onSoundMouseDownHandler);
            this._previewData = new UtilHashArray();
            this._scenes = new UtilHashArray();
            this._sounds = new UtilHashArray();
            this._metaData = new anifire.core.MetaData();
            this._tempMetaData = new anifire.core.MetaData();
            this._tempMetaData.lang = Util.preferLanguageShortCode();
            this._metaData.lang = Util.preferLanguageShortCode();
            this._eventDispatcher = new UtilEventDispatcher();
            this._stageViewStack = this._mainStage.stageViewStack;
            this._themes = new UtilHashArray();
            this._userTheme = new anifire.core.Theme();
            this._userTheme.id = "ugc";
            this._communityTheme = new anifire.core.Theme();
            this._communityTheme.id = "ugc";
            this._lastLoaddedTheme = new anifire.core.Theme();
            this._lastLoaddedTheme.id = "ugc";
            this._searchedTheme = new anifire.core.Theme();
            this._searchedTheme.id = "ugc";
            (_loc13_ = CommandStack.getInstance()).addEventListener(CommandEvent.ADDED,this.onCommandAddedHandler);
            _loc14_ = Util.getFlashVar();
            this._ttsEnabled = _loc14_.getValueByKey("tts_enabled") == "1";
            this._purchaseEnabled = _loc14_.getValueByKey("pts") == "1";
            this._uploadedAssetsEnabled = _loc14_.getValueByKey("upl") != "0";
            this._blacklistEnabled = _loc14_.getValueByKey("hb") == "1";
            this._siteId = _loc14_.getValueByKey("siteId");
            if(this._siteId == "" || this._siteId == null)
            {
               this._siteId = Util.getFlashVar().getValueByKey("siteId");
            }
            if(!this._uploadedAssetsEnabled)
            {
               this._mainStage._uiLblUpload.visible = false;
               this._thumbTray.disallowUploadedAssets();
            }
            this._thumbTray.initThumbTrayDefaultTab(this.studioType != MESSAGE_STUDIO);
            this._thumbTray.addEventListener(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this.doGoToCopyChar);
            if(!this.isUserAlreadyLogin())
            {
               ExternalInterface.addCallback("onUserLogined",this.onUserLogined);
               ExternalInterface.addCallback("onUserLoginCancel",this.onUserLoginCancel);
            }
            this.addEventListener(CoreEvent.LOAD_THEMELIST_COMPLETE,this.doLoadDefaultTheme);
            _loc15_ = 1;
            if(this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO)
            {
               this.initAutoSave();
            }
            else if(this.studioType == MESSAGE_STUDIO)
            {
               _loc15_ = 1;
            }
            if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_NEW)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_NEW;
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_SEMI)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_SEMI;
            }
            this.groupController = new anifire.core.GroupController();
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID) != null)
            {
               this.groupController.currentGroup = new Group(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID),Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_NAME));
            }
            this.loadThemeList(_loc15_);
         }
      }
      
      public static function getConsole() : anifire.core.Console
      {
         if(_console != null)
         {
            return _console;
         }
         throw new Error("Console must be intialized first");
      }
      
      public static function initializeConsole(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:SWFLoader, param7:SWFLoader, param8:PropertiesWindow, param9:Canvas, param10:ScreenCapTool, param11:GoWalker = null, param12:String = "tiny_studio") : Object
      {
         if(_console == null)
         {
            _console = new anifire.core.Console(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         }
         return _console;
      }
      
      private function doAddSoundAtSceneAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:anifire.core.AnimeScene = _loc3_[0] as anifire.core.AnimeScene;
         var _loc5_:SoundThumb = _loc3_[1] as SoundThumb;
         var _loc6_:AnimeSound = _loc3_[2] as AnimeSound;
         var _loc7_:Point = _loc3_[3] as Point;
         this.addSoundAtScene(_loc4_,_loc5_,_loc7_,_loc6_);
         Util.gaTracking("/gostudio/assets/" + _loc5_.theme.id + "/loaded/" + _loc5_.id,anifire.core.Console.getConsole().mainStage.stage);
      }
      
      public function deleteAsset(param1:MouseEvent = null) : void
      {
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
               this.lookOut();
            }
         }
         if(this._currentScene != null)
         {
            if(this._currentScene.selectedAsset != null)
            {
               this._currentScene.selectedAsset.deleteAsset();
            }
            else if(this._tempAsset != null)
            {
               this._tempAsset.deleteAsset();
               this._tempAsset = null;
            }
         }
      }
      
      private function hideGuideBubble(param1:Image) : void
      {
         var _loc2_:Fade = null;
         _loc2_ = new Fade();
         _loc2_.target = param1;
         _loc2_.alphaFrom = 1;
         _loc2_.alphaTo = 0;
         _loc2_.easingFunction = Exponential.easeOut;
         _loc2_.addEventListener(EffectEvent.EFFECT_END,this.removeGuideBubbleAfterFade);
         _loc2_.play();
      }
      
      private function doLoadMovieComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var bytesLoaded:ByteArray = null;
         var checkCode:int = 0;
         var zip:ZipFile = null;
         var sceneXML:XML = null;
         var bubbleXML:XML = null;
         var _fontManager:FontManager = null;
         var i:int = 0;
         var loadMgr:UtilLoadMgr = null;
         var themeTrees:UtilHashArray = null;
         var curThemeId:String = null;
         var j:int = 0;
         var filename:String = null;
         var curThemeXml:XML = null;
         var th:anifire.core.Theme = null;
         var bytes:ByteArray = null;
         var event:Event = param1;
         urlLoader = event.target as URLLoader;
         bytesLoaded = urlLoader.data as ByteArray;
         checkCode = bytesLoaded.readByte();
         if(checkCode == 0)
         {
            zip = new ZipFile(bytesLoaded);
            this._movieXML = new XML(zip.getInput(zip.getEntry(AnimeConstants.MOVIE_XML_FILENAME)));
            if(this._movieXML != null)
            {
               _fontManager = FontManager.getFontManager();
               i = 0;
               while(i < this._movieXML.child(anifire.core.AnimeScene.XML_NODE_NAME).length())
               {
                  sceneXML = this._movieXML.child(anifire.core.AnimeScene.XML_NODE_NAME)[i];
                  j = 0;
                  while(j < sceneXML.child(BubbleAsset.XML_NODE_NAME).length())
                  {
                     bubbleXML = sceneXML.child(BubbleAsset.XML_NODE_NAME)[j];
                     if(!_fontManager.isFontLoaded(bubbleXML.child("bubble")[0].child("text")[0].@font) && bubbleXML.child("bubble")[0].child("text")[0].@embed != "false")
                     {
                        filename = _fontManager.nameToFileName(bubbleXML.child("bubble")[0].child("text")[0].@font) + ".swf";
                        _fontManager.getFonts().push(bubbleXML.child("bubble")[0].child("text")[0].@font,zip.getInput(zip.getEntry(filename)),true);
                     }
                     j++;
                  }
                  i++;
               }
               loadMgr = new UtilLoadMgr();
               themeTrees = this.getThemeTrees(this._movieXML,zip);
               i = 0;
               while(i < themeTrees.length)
               {
                  curThemeId = (themeTrees.getValueByIndex(i) as ThemeTree).getThemeID();
                  if(this.getTheme(curThemeId) == null)
                  {
                     th = new anifire.core.Theme();
                     this.addTheme(curThemeId,th);
                     th.modifyPremiumContent(this._purchasedAssetsXML.(@theme == curThemeId));
                  }
                  curThemeXml = new XML(zip.getInput(zip.getEntry(curThemeId + ".xml")).toString());
                  loadMgr.addEventDispatcher(this.getTheme(curThemeId).eventDispatcher,CoreEvent.LOAD_THEMETREE_COMPLETE);
                  this.getTheme(curThemeId).initThemeByThemeTree(themeTrees.getValueByIndex(i) as ThemeTree,curThemeXml,zip,this);
                  i++;
               }
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doInitFonts);
               loadMgr.commit();
            }
         }
         else
         {
            bytes = new ByteArray();
            bytesLoaded.readBytes(bytes);
            _logger.error("return code is:" + checkCode + "\n error message: \n" + bytes.toString());
            Alert.show("the return code is: " + checkCode + "\n error message: \n" + bytes.toString());
         }
      }
      
      private function sceneChangeEffect() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Glow = null;
         var _loc3_:Blur = null;
         var _loc4_:Parallel = null;
         _loc1_ = 800;
         _loc2_ = new Glow();
         _loc2_.duration = 800;
         _loc2_.blurXFrom = 0;
         _loc2_.blurXTo = 60;
         _loc2_.blurYFrom = 0;
         _loc2_.blurYTo = 60;
         _loc2_.color = 0;
         _loc3_ = new Blur();
         _loc3_.duration = 500;
         _loc3_.blurXFrom = 5;
         _loc3_.blurXTo = 0;
         _loc3_.blurYFrom = 5;
         _loc3_.blurYTo = 0;
         (_loc4_ = new Parallel()).duration = _loc1_;
         _loc4_.targets = [this._stageViewStack];
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.play();
      }
      
      public function getTheme(param1:String) : anifire.core.Theme
      {
         return this._themes.getValueByKey(param1) as anifire.core.Theme;
      }
      
      public function setCurrentScene(param1:int) : void
      {
         if(this._currentSceneIndex != -1)
         {
            if(this.stageScale > 1)
            {
               this.lookOut();
            }
            this._currentSceneIndex = param1;
            this._stageViewStack.selectedIndex = this._currentSceneIndex;
            this._stageViewStack.validateNow();
            this.currentScene = AnimeScene(this._scenes.getValueByIndex(param1));
         }
         if(this._currentScene != null)
         {
            this._timeline.setCurrentSceneByIndex(param1);
            this._currentScene.playScene();
            this._currentScene.refreshEffectTray(this.effectTray);
            this._mainStage.sceneIndexStr = param1 >= 0 ? "" + (param1 + 1) : "";
         }
         this.soundMute = this.soundMute;
         this.dispatchEvent(new IndexChangedEvent(IndexChangedEvent.CHANGE));
      }
      
      public function get initCreation() : Boolean
      {
         return this._initCreation;
      }
      
      public function getSoundInfoById(param1:String) : ElementInfo
      {
         return this.timeline.getSoundInfoById(param1);
      }
      
      private function loadThemeListComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var zip:ZipFile = null;
         var themeListXML:XML = null;
         var defaultZipEntry:ZipEntry = null;
         var commonZipEntry:ZipEntry = null;
         var BAD_TERMS_XML_NODE_NAME:String = null;
         var GOOD_TERMS_XML_NODE_NAME:String = null;
         var excludeAssetIds:Array = null;
         var aid:String = null;
         var node:XML = null;
         var i:int = 0;
         var j:int = 0;
         var ts:XMLList = null;
         var group:Group = null;
         var event:Event = param1;
         this.requestLoadStatus(false,true);
         if(Util.isDebugMode)
         {
            Alert.show("load theme list complete ");
         }
         try
         {
            urlLoader = event.target as URLLoader;
            zip = new ZipFile(urlLoader.data as ByteArray);
            themeListXML = new XML(zip.getInput(zip.getEntry("themelist.xml")).toString());
            ThemeEmbedConstant.defaultThemeId = themeListXML.child("theme")[0].attribute("id");
            this.currentLicensorName = themeListXML.child("theme")[0].attribute("name");
            defaultZipEntry = zip.getEntry(ThemeEmbedConstant.defaultThemeId + ".zip");
            if(defaultZipEntry != null)
            {
               ThemeEmbedConstant.defaultThemeZip = zip.getInput(defaultZipEntry);
            }
            commonZipEntry = zip.getEntry("common.zip");
            if(commonZipEntry != null)
            {
               ThemeEmbedConstant.commonThemeZip = zip.getInput(commonZipEntry);
            }
            BAD_TERMS_XML_NODE_NAME = "word";
            GOOD_TERMS_XML_NODE_NAME = "whiteword";
            if(themeListXML.child(BAD_TERMS_XML_NODE_NAME).length() > 0 && Util.getFlashVar().getValueByKey("hb") == "1")
            {
               this.setBadTerms(themeListXML.child(BAD_TERMS_XML_NODE_NAME)[0].toString());
               this.setWhiteTerms(themeListXML.child(GOOD_TERMS_XML_NODE_NAME)[0].toString());
            }
            else
            {
               this.setBadTerms("");
               this.setWhiteTerms("");
            }
            excludeAssetIds = String(themeListXML.excludeAssetIDs).split(",");
            this.excludedIds = new UtilHashArray();
            for each(aid in excludeAssetIds)
            {
               aid = StringUtil.trim(aid);
               if(aid != "")
               {
                  this.excludedIds.push(aid,aid);
               }
            }
            if(this._purchaseEnabled)
            {
               this._purchasedAssetsXML = themeListXML.child("premium");
               ts = themeListXML.child("points");
               if(ts.length() > 0)
               {
                  this._moneyPoints = themeListXML.child("points")[0].@money;
                  this._sharingPoints = themeListXML.child("points")[0].@sharing;
               }
               if(this._purchasedAssetsXML.length() != 0)
               {
                  this._userTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  this._lastLoaddedTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  this._searchedTheme.modifyPremiumContent(this._purchasedAssetsXML);
               }
               else
               {
                  this._purchasedAssetsXML = new XMLList();
               }
            }
            else
            {
               this._purchasedAssetsXML = new XMLList();
            }
            i = 0;
            while(i < themeListXML.child("school").length())
            {
               node = themeListXML.child("school")[i];
               this.groupController.schoolId = node.attribute("id");
               i++;
            }
            j = 0;
            while(j < themeListXML.child("group").length())
            {
               node = themeListXML.child("group")[j];
               group = new Group(node.attribute("id"),node.attribute("name"));
               this.groupController.addGroup(group);
               j++;
            }
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEMELIST_COMPLETE,this,themeListXML));
         }
         catch(e:TypeError)
         {
            _logger.error("Could not parse text into xml." + e.message);
            Alert.show(e.message + " ");
         }
         catch(e:Error)
         {
            _logger.error(e.getStackTrace());
            Alert.show(e.message + " ");
         }
      }
      
      private function onSceneDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.index);
         if(this.currentSceneIndex != _loc2_)
         {
            this.currentScene.unloadAllAssets();
            this.setCurrentScene(_loc2_);
            this.currentScene.loadAllAssets();
         }
      }
      
      public function set boxMode(param1:Boolean) : void
      {
         this._boxMode = param1;
      }
      
      public function pasteAsset() : void
      {
         var _loc1_:ICommand = null;
         if(this.copyData.length > 0)
         {
            _loc1_ = new AddAssetCommand();
            _loc1_.execute();
            this.currentScene.deserializeAsset(XML(this.copyData),true,false);
         }
      }
      
      public function set initCreation(param1:Boolean) : void
      {
         this._initCreation = param1;
      }
      
      public function onBubbleMsgChoosen(param1:BubbleMsgEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBubbleMsgChoosen);
         var _loc2_:BubbleMsgChooser = param1.target as BubbleMsgChooser;
         _loc2_.closeWindow();
         var _loc3_:BubbleMsgChooserItem = param1.bubbleMsgItem;
         if(_loc3_.isBubble)
         {
            this.changeBubbleMsg(_loc3_.bubbleAsset,_loc3_.msg);
         }
         if(_loc3_.isSound)
         {
            this.currentScene.createAsset(_loc3_.soundThumb);
         }
      }
      
      public function deleteTempProp() : void
      {
         ThumbnailCanvas(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId))).deleteThumbnail(false);
      }
      
      public function onUserLogined(param1:String) : void
      {
         Util.setFlashVar("u_info",param1);
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_COMPLETE,this));
      }
      
      public function loadThemeBg(param1:String) : void
      {
         var _loc2_:anifire.core.Theme = null;
         if(this._themes.containsKey(param1))
         {
            _loc2_ = this.getTheme(param1);
         }
         else
         {
            _loc2_ = null;
            trace("Error: theme not found when loading bg zip with themeId:" + param1);
         }
         if(_loc2_.isBgZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/backgrounds",anifire.core.Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/backgrounds",anifire.core.Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeBg = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc2_.loadBg();
      }
      
      public function getStoreCollection() : Array
      {
         return this.storecollection;
      }
      
      private function closeThemeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         _loc2_.visible = false;
      }
      
      private function alertClickHandler(param1:MouseEvent) : void
      {
         if(Button(param1.currentTarget).id == "_btnDelete")
         {
            if(ServerConstants.APPCODE == "go")
            {
               ExternalInterface.call("newAnimation");
            }
            else
            {
               this.newAnimation();
            }
         }
      }
      
      public function lookOut(param1:MouseEvent = null) : void
      {
         var _loc2_:Number = NaN;
         this.currentScene.showEffects(true);
         _loc2_ = 1;
         this.stageViewStage.clipContent = true;
         this.stageViewStage.selectedChild.clipContent = true;
         this.stageViewStage.selectedChild.scaleX = this.stageViewStage.selectedChild.scaleY = _loc2_;
         this.stageViewStage.x = 0;
         this.stageViewStage.y = 0;
         this.mainStage.drawDashBorder(false);
         this.mainStage._lookInToolBar.visible = false;
      }
      
      private function onSceneResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         this._prevSceneLength = _loc2_.totalPixel;
         this._prevAllSoundInfo = Timeline(param1.currentTarget).getAllSoundInfo();
      }
      
      public function askUserToGoToCcCreator() : void
      {
         var _loc1_:GoAlert = null;
         _loc1_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc1_._lblConfirm.text = "";
         _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_goToCcCreator");
         _loc1_._txtDelete.setStyle("textAlign","left");
         _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCreateMyChar);
         _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = 100;
      }
      
      public function addNewlyAddedAssetId(param1:String) : void
      {
         if(this._newlyAddedAssetIds == "")
         {
            this._newlyAddedAssetIds += param1;
         }
         else
         {
            this._newlyAddedAssetIds += "," + param1;
         }
      }
      
      public function loadCommonThemeBg() : void
      {
         var _loc1_:anifire.core.Theme = null;
         if(this._themes.containsKey("common"))
         {
            _loc1_ = this.getTheme("common");
         }
         else
         {
            _loc1_ = null;
            trace("Error: theme not found when loading bg zip with themeId:common");
         }
         if(_loc1_.isBgZipLoaded())
         {
            this.thumbTray.loadBackgroundThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeBg = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc1_.loadBg();
      }
      
      public function get timeline() : Timeline
      {
         return this._timeline;
      }
      
      private function closeOverTray(param1:Event) : void
      {
         this.showOverTray(false);
      }
      
      public function showOverTray(param1:Boolean = true) : void
      {
         var _loc2_:PropertyWindowEvent = null;
         if(this.studioType != MESSAGE_STUDIO && !this._boxMode)
         {
            if(param1)
            {
               this.thumbTray.updateThemeButton(-1);
               OverTray(this.pptPanel.parent.parent.parent).open();
               this.pptPanel._close.addEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
            else
            {
               this.thumbTray.updateThemeButton();
               OverTray(this.pptPanel.parent.parent.parent).close();
               this.pptPanel._close.removeEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
         }
         if(this._boxMode)
         {
            _loc2_ = new PropertyWindowEvent(param1 ? PropertyWindowEvent.EVENT_OPEN : PropertyWindowEvent.EVENT_CLOSE);
            _loc2_.view = PropertyWindowEvent.VIEW_PROPERTY_WINDOW;
            Application.application.dispatchEvent(_loc2_);
         }
      }
      
      public function hideInspiration() : void
      {
         this._inspirationLoader.visible = false;
      }
      
      public function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:UtilHashArray = null;
         _loc5_ = new UtilHashArray();
         _loc3_ = 0;
         while(_loc3_ < param1.child(anifire.core.AnimeScene.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(anifire.core.AnimeScene.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,anifire.core.AnimeScene.getThemeTrees(_loc4_,param2,_loc5_));
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.child(AnimeSound.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,AnimeSound.getThemeTrees(_loc4_,param2));
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function showProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
         this.loadProgress = _loc2_;
         if(param1.bytesLoaded >= param1.bytesTotal)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.showProgress);
            anifire.core.Console.getConsole().loadProgressVisible = false;
         }
      }
      
      public function changeTempPropName() : void
      {
         var _loc1_:DisplayObject = DisplayObject(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId)));
         if(_loc1_)
         {
            _loc1_.name = "cellUserProp";
         }
      }
      
      public function get tempPrivateShared() : Boolean
      {
         return this._tempPrivateShared;
      }
      
      private function showTip() : void
      {
         var _loc1_:TipWindow = new TipWindow();
         _loc1_.width = 400;
         _loc1_.height = 200;
         _loc1_.x = (this.mainStage.width - _loc1_.width) / 2;
         _loc1_.y = (this.mainStage.height - _loc1_.height) / 2;
         _loc1_.addEventListener(Event.COMPLETE,this.initTip);
         this.mainStage.addChild(_loc1_);
      }
      
      public function stopAllSounds() : void
      {
         var _loc1_:AnimeSound = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.sounds.length)
         {
            _loc1_ = AnimeSound(this.sounds.getValueByIndex(_loc2_));
            _loc1_.stopSound();
            _loc2_++;
         }
      }
      
      public function get effectTray() : EffectTray
      {
         return this._effectTray;
      }
      
      public function requestLoadStatus(param1:Boolean, param2:Boolean = false, param3:Number = 1) : void
      {
         var _loc4_:Boolean = false;
         if(param1)
         {
            this._loadRequestCounter += param3;
            if(this._loadRequestCounter == 1)
            {
               CursorManager.setBusyCursor();
               _loc4_ = true;
            }
            else
            {
               _loc4_ = false;
            }
         }
         else
         {
            this._loadRequestCounter -= param3;
            if(this._loadRequestCounter < 0)
            {
               this._loadRequestCounter = 0;
            }
            if(this._loadRequestCounter == 0)
            {
               _loc4_ = true;
               CursorManager.removeBusyCursor();
            }
            else
            {
               _loc4_ = false;
            }
         }
         if(_loc4_)
         {
            if(param2)
            {
               this._topButtonBar.setLoadingStatus(param1);
               this._mainStage.setLoadingStatus(param1,true);
               this._timeline.setLoadingStatus(param1);
               this._thumbTray.setLoadingStatus(param1);
            }
            else
            {
               this._topButtonBar.setLoadingStatus(param1);
               this._mainStage.setLoadingStatus(param1,false);
               this._timeline.setLoadingStatus(param1);
            }
         }
      }
      
      private function onFontLoaded(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:FontManager = null;
         _loc2_ = (param1.target.loader as Loader).name;
         _loc3_ = FontManager.getFontManager();
         _loc3_.setFontAsLoaded(_loc2_,param1.target.bytes as ByteArray);
      }
      
      public function loadCcChar() : void
      {
         var _loc1_:URLVariables = null;
         var _loc2_:URLRequest = null;
         var _loc3_:UtilURLStream = null;
         anifire.core.Console.getConsole().requestLoadStatus(true,true);
         if(this._byteArrayReturnFromLoadCcChar == null)
         {
            _loc1_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc1_);
            _loc2_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
            _loc1_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
            _loc1_["count"] = 1000;
            _loc1_["page"] = 0;
            _loc1_["is_cc"] = "Y";
            _loc2_.method = URLRequestMethod.POST;
            _loc2_.data = _loc1_;
            _loc3_ = new UtilURLStream();
            _loc3_.addEventListener(Event.COMPLETE,this.onLoadCcCharCompleted);
            _loc3_.load(_loc2_);
         }
         else
         {
            this.doPrepareLoadCcCharComplete(this._byteArrayReturnFromLoadCcChar);
         }
      }
      
      public function get tempPublished() : Boolean
      {
         return this._tempPublished;
      }
      
      public function copyAsset() : void
      {
         if(this._currentScene != null && this._currentScene.selectedAsset != null)
         {
            this.copyData = this._currentScene.selectedAsset.serialize();
         }
      }
      
      private function onLoadCustomAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:Image = null;
         var _loc4_:Thumb = null;
         var _loc6_:ThumbnailCanvas = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Rectangle = null;
         var _loc13_:DisplayObject = null;
         var _loc14_:Image = null;
         var _loc15_:DisplayObject = null;
         var _loc16_:BitmapData = null;
         var _loc17_:Bitmap = null;
         var _loc18_:SoundThumb = null;
         var _loc5_:String = "cellUserProp";
         if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc2_ = param1.target.loader;
            if(!(_loc2_.content is MovieClip) && !(_loc2_.content is AVM1Movie))
            {
               _loc5_ = String(this._assetId);
               this.thumbTray.popMaskImage(_loc2_.content,this._assetId,this._placeable,this._holdable,this._headable);
            }
         }
         if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
         {
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_ = param1.target.loader;
               _loc15_ = _loc2_.content;
               _loc3_ = Image(_loc2_.parent);
               _loc4_ = this.userTheme.getCharThumbById(this._uploadedAssetXML.@id);
               CharThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
               (_loc4_ as CharThumb).deSerialize(this._uploadedAssetXML,this._userTheme);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc3_ = (_loc15_ = (param1 as EffectEvt).thumbnail).parent as Image;
               ((_loc4_ = new EffectThumb()) as EffectThumb).deSerialize(this._uploadedAssetXML,this._userTheme);
            }
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = anifire.core.Console.getConsole().userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileCharUser.addChild(_loc6_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileEffectUser.addChild(_loc6_);
            }
            _loc6_.name = _loc5_;
            _loc7_ = _loc15_.width;
            _loc8_ = _loc15_.height;
            _loc9_ = 1;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc15_.width = _loc10_;
                  _loc15_.height *= _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc15_.width *= _loc9_;
                  _loc15_.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc15_.width *= _loc9_;
                     _loc15_.height = _loc11_;
                  }
                  else
                  {
                     _loc15_.width = _loc10_;
                     _loc15_.height *= _loc9_;
                  }
               }
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc12_ = _loc2_.getBounds(_loc2_);
               _loc15_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc15_.width) / 2;
               _loc15_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc15_.height) / 2;
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc12_ = _loc15_.getBounds(_loc15_);
               _loc15_.x = (AnimeConstants.TILE_BUBBLE_WIDTH - _loc15_.width) / 2;
               _loc15_.y = (AnimeConstants.TILE_BUBBLE_HEIGHT - _loc15_.height) / 2;
            }
            _loc15_.x -= _loc12_.left;
            _loc15_.y -= _loc12_.top;
            _loc13_ = DisplayObject(_loc15_);
            UtilPlain.stopFamily(_loc13_);
            (_loc14_ = _loc3_).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = param1.target.loader;
            _loc3_ = Image(_loc2_.parent);
            _loc16_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            (_loc17_ = new Bitmap(_loc16_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc17_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            _loc3_.removeChild(_loc3_.getChildByName("imageLoader"));
            _loc3_.addChild(_loc17_);
            _loc4_ = new BackgroundThumb();
            _loc4_.id = _loc4_.thumbId = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = anifire.core.Console.getConsole().userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
            this.thumbTray._uiTileBgUser.addChild(_loc6_);
            _loc17_.x = AnimeConstants.TILE_INSETS;
            _loc17_.y = AnimeConstants.TILE_INSETS;
            _loc3_.graphics.beginFill(0,0);
            _loc3_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc3_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc3_ = Image(_loc2_.parent);
            (_loc4_ = new PropThumb()).id = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = anifire.core.Console.getConsole().userTheme;
            PropThumb(_loc4_).placeable = this._placeable;
            PropThumb(_loc4_).holdable = this._holdable;
            PropThumb(_loc4_).headable = this._headable;
            PropThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            (_loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_PROP_WIDTH,AnimeConstants.TILE_PROP_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled)).name = _loc5_;
            this.thumbTray._uiTilePropUser.addChild(_loc6_);
            _loc7_ = _loc2_.content.width;
            _loc8_ = _loc2_.content.height;
            _loc9_ = 1;
            _loc10_ = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc11_ = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc2_.content.width = _loc10_;
                  _loc2_.content.height *= _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc2_.content.width *= _loc9_;
                  _loc2_.content.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc2_.content.width *= _loc9_;
                     _loc2_.content.height = _loc11_;
                  }
                  else
                  {
                     _loc2_.content.width = _loc10_;
                     _loc2_.content.height *= _loc9_;
                  }
               }
            }
            _loc12_ = _loc2_.getBounds(_loc2_);
            _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
            _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
            _loc2_.x -= _loc12_.left;
            _loc2_.y -= _loc12_.top;
            if(_loc2_.content is MovieClip)
            {
               _loc13_ = DisplayObject(_loc2_.content);
               UtilPlain.stopFamily(_loc13_);
            }
            (_loc14_ = Image(_loc2_.parent)).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            _loc18_ = (param1 as CoreEvent).getEventCreater() as SoundThumb;
            this.thumbTray.addSoundTileCell(_loc18_);
         }
         if(this._importer != null)
         {
            this._importer["success"]();
            if(this._uploadType != AnimeConstants.ASSET_TYPE_UNKNOWN)
            {
               this._thumbTray.showUserGoodies(this._uploadType);
            }
            this._thumbTray.show();
            this.currentScene.playScene();
         }
         else if(_loc18_ != null)
         {
            this.publishW.success(_loc18_);
         }
         this.requestLoadStatus(false,true);
      }
      
      public function set currDragSource(param1:DragSource) : void
      {
         this._currDragSource = param1;
      }
      
      public function loadTheme(param1:String) : void
      {
         var needLoad:Boolean;
         var targetTheme:anifire.core.Theme = null;
         var id:String = param1;
         this.requestLoadStatus(true,true);
         needLoad = true;
         Util.gaTracking("/gostudio/themes/loading/" + id,anifire.core.Console.getConsole().mainStage.stage);
         if(this._themes.containsKey(id))
         {
            targetTheme = this._themes.getValueByKey(id) as anifire.core.Theme;
         }
         else
         {
            targetTheme = new anifire.core.Theme();
            targetTheme.id = id;
            targetTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == id));
         }
         this._isLoaddingCommonTheme = false;
         targetTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         targetTheme.initThemeByLoadThemeFile(this,id);
      }
      
      public function loadMovieByXML(param1:XML) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:URLStream = null;
         this._movieXML = param1;
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_MOVIE_BY_XML);
         _loc2_.method = URLRequestMethod.POST;
         _loc3_ = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc3_[ServerConstants.PARAM_MOVIE_XML] = param1;
         _loc2_.data = _loc3_;
         this._isLoadding = true;
         (_loc4_ = new URLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc4_.load(_loc2_);
      }
      
      public function getImporter() : Application
      {
         return this._importer;
      }
      
      public function set timeline(param1:Timeline) : void
      {
         this._timeline = param1;
      }
      
      public function genDefaultTags() : void
      {
         var _loc1_:UtilHashArray = null;
         var _loc3_:UtilHashArray = null;
         var _loc4_:anifire.core.AnimeScene = null;
         var _loc5_:Thumb = null;
         var _loc6_:Thumb = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc1_ = new UtilHashArray();
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc3_ = new UtilHashArray();
         this.tempMetaData.clearHiddenTags();
         _loc7_ = 0;
         while(_loc7_ < this.scenes.length)
         {
            if((_loc4_ = AnimeScene(this.scenes.getValueByIndex(_loc7_))).characters.length > 0)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.characters.length)
               {
                  _loc6_ = Character(_loc4_.characters.getValueByIndex(_loc8_)).thumb;
                  if(_loc1_.getValueByKey(_loc6_.theme.id) == null)
                  {
                     _loc1_.push(_loc6_.theme.id,_loc6_.theme.id);
                     if(_loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.theme.id);
                     }
                  }
                  if(_loc3_.getValueByKey(_loc6_.id) == null)
                  {
                     _loc3_.push(_loc6_.id,_loc6_.id);
                     if(!_loc6_.isCC && _loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.id);
                     }
                  }
                  _loc8_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function prepareSaveMovieThumbnailScene() : void
      {
         var _loc1_:anifire.core.AnimeScene = null;
         this._isAutoSave = false;
         _loc1_ = AnimeScene(this._scenes.getValueByIndex(this.selectedThumbnailIndex));
         if(_loc1_ != this.currentScene)
         {
            _loc1_.eventDispatcher.addEventListener(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this.onPreparedThumbnailScene);
            _loc1_.loadAllAssets();
         }
         else
         {
            this.saveMovie();
         }
      }
      
      public function addScene(param1:String = "", param2:String = "", param3:Number = 1, param4:Boolean = true) : anifire.core.AnimeScene
      {
         var _loc5_:anifire.core.AnimeScene = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:anifire.core.AnimeScene = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:anifire.core.AnimeScene = null;
         if((_loc5_ = this.getScene(this._currentSceneIndex + param3)) != null)
         {
            _loc6_ = this.timeline.getSceneImageBitmapByIndex(this.getSceneIndex(_loc5_));
         }
         this.capScreenLock = true;
         if(this._currentScene != null && param1 == "")
         {
            _loc7_ = this.timeline.getSceneImageBitmapByIndex(this.getSceneIndex(this._currentScene));
            if(param2 == "")
            {
               _loc8_ = this._currentScene.clone();
               this.currentScene = _loc8_;
            }
            else
            {
               _loc8_ = new anifire.core.AnimeScene();
               this.currentScene = _loc8_;
               _loc8_.console = this;
            }
         }
         else
         {
            (_loc8_ = new anifire.core.AnimeScene(param1)).console = this;
            this.currentScene = _loc8_;
         }
         (_loc9_ = new UtilHashArray()).push(_loc8_.id,_loc8_);
         this._scenes.insert(this._currentSceneIndex + param3,_loc9_);
         this._currentSceneIndex = this.getSceneIndex(this.currentScene);
         this._stageViewStack.addChildAt(this._currentScene.canvas,this._currentSceneIndex);
         this.setCurrentScene(this._currentSceneIndex);
         this._stageViewStack.selectedChild = this._currentScene.canvas;
         this.addSceneCtrl(param1);
         this.setCurrentScene(this._currentSceneIndex);
         this._mainStage.sceneIndexStr = this._currentSceneIndex >= 0 ? "" + (this._currentSceneIndex + param3) : "";
         _loc8_.doUpdateTimelineLength();
         if(param2 != "")
         {
            _loc8_.deSerialize(XML(param2),true,true,false);
         }
         _loc8_.doUpdateTimelineLength();
         if(param4)
         {
            if(this._currentSceneIndex == this._scenes.length - 1)
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._currentSceneIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._currentSceneIndex - 1).startPixel + this.timeline.getSceneInfoByIndex(this._currentSceneIndex - 1).totalPixel);
            }
            else
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._currentSceneIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._currentSceneIndex).startPixel);
            }
         }
         if(_loc7_ != null)
         {
            this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(_loc8_),_loc7_);
         }
         if((_loc10_ = this.getScene(this._currentSceneIndex + 1)) != null)
         {
            _loc10_.doUpdateTimelineLength();
            if(_loc6_ != null)
            {
               this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(_loc10_),_loc6_);
            }
         }
         this.capScreenLock = false;
         if(this.isGoWalkerOn())
         {
            this.dispatchGoWalkerEvent(17);
         }
         return _loc8_;
      }
      
      public function loadConvertedVideo(param1:Array) : void
      {
         var _loc3_:URLRequest = null;
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERVIDEOASSETS);
         _loc2_["count"] = 1000;
         _loc2_["page"] = 0;
         _loc2_["include_ids_only"] = param1.join(",");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onUpdateUserVideoAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      public function get themeListXML() : XML
      {
         return this._themeListXML;
      }
      
      public function playMovie() : void
      {
         trace("c movie");
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).playMovie();
         }
      }
      
      private function doShowPublishWindow(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowPublishWindow);
         setTimeout(this.showPublishWindow,500);
      }
      
      public function showSoundMenu(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:AnimeSound;
         (_loc4_ = this.sounds.getValueByKey(param1) as AnimeSound).showMenu(param2,param3);
      }
      
      public function get newlyAddedAssetIds() : String
      {
         return this._newlyAddedAssetIds;
      }
      
      private function onSceneResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:anifire.core.AnimeScene = null;
         var _loc4_:ICommand = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         if(this._prevSceneLength != _loc2_.totalPixel)
         {
            _loc3_ = this.getScene(param1.index);
            _loc3_.updateEffectTray(_loc2_.totalPixel,this._prevSceneLength);
            _loc3_.userLockedTime = _loc2_.totalPixel;
            (_loc4_ = new ChangeSceneLengthCommand(param1.index,this._prevSceneLength,this._prevAllSoundInfo)).execute();
         }
      }
      
      public function lookIntoAsset() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(this.currentScene.sizingAsset != null)
         {
            this.currentScene.hideEffects(true,true);
            _loc1_ = new Rectangle(this.currentScene.sizingAsset.x,this.currentScene.sizingAsset.y,this.currentScene.sizingAsset.width,this.currentScene.sizingAsset.height);
            _loc2_ = AnimeConstants.SCREEN_WIDTH / _loc1_.width;
            this.stageViewStage.clipContent = false;
            this.stageViewStage.scrollRect = null;
            this.stageViewStage.selectedChild.clipContent = false;
            this.stageViewStage.selectedChild.scaleX = this.stageViewStage.selectedChild.scaleY = _loc2_;
            this.stageViewStage.x = -_loc1_.x * _loc2_ + AnimeConstants.SCREEN_X;
            this.stageViewStage.y = -_loc1_.y * _loc2_ + AnimeConstants.SCREEN_Y;
            this.mainStage._lookInToolBar.visible = true;
            this.mainStage.drawDashBorder();
         }
      }
      
      private function getMovieThumbnail(param1:Boolean = false) : ByteArray
      {
         var _loc2_:anifire.core.AnimeScene = null;
         var _loc3_:Matrix = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc10_:JPGEncoder = null;
         var _loc11_:ByteArray = null;
         var _loc12_:Boolean = false;
         var _loc13_:ColorTransform = null;
         _loc2_ = AnimeScene(this._scenes.getValueByIndex(this.selectedThumbnailIndex));
         _loc3_ = new Matrix();
         if(param1)
         {
            _loc4_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_WIDTH;
            _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_HEIGHT;
         }
         else
         {
            _loc4_ = AnimeConstants.MOVIE_THUMBNAIL_WIDTH;
            _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_HEIGHT;
         }
         if(_loc2_.sizingAsset != null)
         {
            _loc6_ = _loc4_ / _loc2_.sizingAsset.width;
            _loc7_ = _loc5_ / _loc2_.sizingAsset.height;
            _loc8_ = new BitmapData(AnimeConstants.STAGE_WIDTH * _loc6_ > 2880 ? 2880 : int(AnimeConstants.STAGE_WIDTH * _loc6_),AnimeConstants.STAGE_HEIGHT * _loc7_ > 2880 ? 2880 : int(AnimeConstants.STAGE_HEIGHT * _loc7_));
         }
         else
         {
            _loc6_ = _loc4_ / AnimeConstants.PLAYER_WIDTH;
            _loc7_ = _loc5_ / AnimeConstants.PLAYER_HEIGHT;
            _loc8_ = new BitmapData(AnimeConstants.STAGE_WIDTH,AnimeConstants.STAGE_HEIGHT);
         }
         _loc3_.createBox(_loc6_,_loc7_);
         if(_loc2_.sizingAsset != null)
         {
            _loc12_ = EffectAsset(_loc2_.sizingAsset).hideEffect();
            _loc8_.draw(_loc2_.canvas,_loc3_,null,null,null,true);
            if(_loc12_)
            {
               EffectAsset(_loc2_.sizingAsset).showEffect();
            }
         }
         else
         {
            _loc8_.draw(_loc2_.canvas,_loc3_,null,null,null,true);
         }
         _loc9_ = new BitmapData(_loc4_,_loc5_);
         if(_loc2_.sizingAsset != null)
         {
            _loc9_.copyPixels(_loc8_,new Rectangle(_loc2_.sizingAsset.x * _loc6_,_loc2_.sizingAsset.y * _loc7_,_loc4_,_loc5_),new Point(0,0));
         }
         else
         {
            _loc9_.copyPixels(_loc8_,new Rectangle(AnimeConstants.SCREEN_X * _loc6_,AnimeConstants.SCREEN_Y * _loc7_,_loc4_,_loc5_),new Point(0,0));
         }
         if(param1)
         {
            _loc13_ = new ColorTransform(0.5,0.5,0.5);
            _loc9_.colorTransform(new Rectangle(0,0,_loc9_.width,_loc9_.height),_loc13_);
         }
         return (_loc10_ = new JPGEncoder(80)).encode(_loc9_);
      }
      
      public function set thumbTrayActive(param1:Boolean) : void
      {
         this.thumbTray.active = param1;
      }
      
      public function set tempPrivateShared(param1:Boolean) : void
      {
         this._tempPrivateShared = param1;
      }
      
      private function onCommandAddedHandler(param1:CommandEvent) : void
      {
         this.mainStage.enableRedo(false);
      }
      
      public function get userTheme() : anifire.core.Theme
      {
         return this._userTheme;
      }
      
      public function get copyData() : String
      {
         return this._copyData;
      }
      
      public function set copySceneData(param1:String) : void
      {
         this._copySceneData = param1;
      }
      
      public function get mainStage() : MainStage
      {
         return this._mainStage;
      }
      
      private function onGetCcCharCountComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = null;
         var _loc3_:String = null;
         var _loc4_:LoadCcCharCountEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onGetCcCharCountComplete);
         if(param1.type == Event.COMPLETE)
         {
            _loc2_ = param1.target as URLLoader;
            _loc3_ = _loc2_.data as String;
            if(_loc3_.length > 1 && _loc3_.charAt(0) == "0")
            {
               (_loc4_ = new LoadCcCharCountEvent(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this)).ccCharCount = Number(_loc3_.substr(1));
               this.dispatchEvent(_loc4_);
            }
         }
      }
      
      public function get currentLicensorName() : String
      {
         return this._currentLicensorName;
      }
      
      public function deserializeSound(param1:XML) : void
      {
         var indexArray:Array = null;
         var soundXML:XML = null;
         var newSound:AnimeSound = null;
         var tmpVol:Number = NaN;
         var movieXML:XML = param1;
         indexArray = UtilXmlInfo.getAndSortXMLattribute(movieXML,"index",AnimeSound.XML_NODE_NAME);
         var tempTrackNum:int = 0;
         var i:int = 0;
         while(i < indexArray.length)
         {
            soundXML = movieXML.child(AnimeSound.XML_NODE_NAME).(@index == indexArray[i] as int)[0];
            newSound = new AnimeSound();
            newSound.deSerialize(soundXML);
            if(newSound.startFrame < (this.timeline.getTotalTimeInSec() + 300) * AnimeConstants.FRAME_PER_SEC)
            {
               if(newSound.soundThumb != null)
               {
                  tmpVol = 1;
                  if(soundXML.attribute("vol").length() != 0)
                  {
                     tmpVol = Number(soundXML.@vol);
                  }
                  if(soundXML.attribute("track").length() == 0)
                  {
                     this.addSound(newSound,UtilUnitConvert.frameToPixel(Number(soundXML["start"].toString())),UtilUnitConvert.trackToPixel(Number(tempTrackNum)),indexArray[i],false,true,tmpVol);
                     tempTrackNum = tempTrackNum == 3 ? 0 : tempTrackNum + 1;
                  }
                  else
                  {
                     this.addSound(newSound,UtilUnitConvert.frameToPixel(Number(soundXML["start"].toString())),UtilUnitConvert.trackToPixel(Number(soundXML.@track.toString())),indexArray[i],false,true,tmpVol);
                  }
               }
            }
            i++;
         }
      }
      
      private function doPrepareLoadCcCharComplete(param1:ByteArray) : void
      {
         var _loc4_:ZipFile = null;
         var _loc5_:ZipEntry = null;
         var _loc6_:XML = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:Thumb = null;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:CoreEvent = null;
         var _loc12_:ByteArray = null;
         var _loc13_:ZipFile = null;
         var _loc14_:int = 0;
         var _loc15_:ZipEntry = null;
         var _loc16_:ByteArray = null;
         var _loc17_:UtilHashArray = null;
         var _loc18_:Object = null;
         var _loc19_:UtilCrypto = null;
         var _loc20_:ByteArray = null;
         param1.position = 0;
         var _loc2_:int = param1.readByte();
         var _loc3_:Array = new Array();
         trace("returnCode:" + _loc2_);
         if(_loc2_ == 0)
         {
            _loc4_ = new ZipFile(param1);
            _loc6_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            this._userTheme.deSerialize(_loc6_);
            this._lastLoaddedTheme.clearAllThumbs();
            this._lastLoaddedTheme.deSerialize(_loc6_);
            _loc7_ = this._lastLoaddedTheme.charThumbs;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length)
            {
               _loc8_ = CharThumb(_loc7_.getValueByIndex(_loc9_));
               _loc5_ = _loc4_.getEntry(_loc8_.getFileName());
               _loc3_.push(_loc8_.id);
               if(_loc5_ != null)
               {
                  if(!CharThumb(_loc8_).isCC)
                  {
                     _loc8_.imageData = _loc4_.getInput(_loc5_);
                     trace("thumb.getFileName():" + _loc8_.getFileName());
                     CharThumb(this._userTheme.charThumbs.getValueByKey(_loc8_.id)).imageData = _loc4_.getInput(_loc5_);
                  }
                  else if(_loc5_ != null)
                  {
                     _loc12_ = _loc4_.getInput(_loc5_);
                     _loc13_ = new ZipFile(_loc12_);
                     _loc17_ = new UtilHashArray();
                     _loc18_ = new Object();
                     _loc14_ = 0;
                     while(_loc14_ < _loc13_.size)
                     {
                        if((_loc15_ = _loc13_.entries[_loc14_]).name == PlayerConstant.CHAR_XML_FILENAME)
                        {
                           _loc18_["xml"] = new XML(_loc13_.getInput(_loc15_).toString());
                        }
                        else if(_loc15_.name.substr(_loc15_.name.length - 3,3).toLowerCase() == "swf")
                        {
                           _loc16_ = _loc13_.getInput(_loc15_);
                           (_loc19_ = new UtilCrypto()).decrypt(_loc16_);
                           _loc17_.push(_loc15_.name,_loc16_);
                        }
                        _loc14_++;
                     }
                     _loc18_["imageData"] = _loc17_;
                     _loc8_.imageData = _loc18_;
                  }
               }
               _loc9_++;
            }
            this._userTheme.mergeTheme(this._lastLoaddedTheme);
            this.addTheme(this._userTheme.id,this._userTheme);
            this._thumbTray.removeLoadingCanvas(AnimeConstants.ASSET_TYPE_CHAR);
            (_loc10_ = new Object())["newCharIdArray"] = _loc3_;
            _loc10_["lastLoadedTheme"] = this._lastLoaddedTheme;
            _loc11_ = new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this,_loc10_);
            anifire.core.Console.getConsole().requestLoadStatus(false,true);
            this.dispatchEvent(_loc11_);
         }
         else
         {
            _loc20_ = new ByteArray();
            param1.readBytes(_loc20_);
            _logger.error("getUserAssets failed: \n" + _loc20_.toString());
            Alert.show("getUserAssets failed: \n" + _loc20_.toString());
         }
      }
      
      private function onUpdateUserVideoAssetsComplete(param1:Event) : void
      {
         var _loc5_:ZipFile = null;
         var _loc6_:XML = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:Thumb = null;
         var _loc9_:ZipEntry = null;
         var _loc10_:int = 0;
         var _loc11_:CoreEvent = null;
         var _loc12_:ByteArray = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int = _loc3_.readByte();
         trace("returnCode:" + _loc4_);
         if(_loc4_ == 0)
         {
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            _loc5_ = new ZipFile(_loc3_);
            _loc6_ = new XML(_loc5_.getInput(_loc5_.getEntry("desc.xml")));
            this.userTheme.deSerialize(_loc6_);
            this._lastLoaddedTheme.clearAllThumbs();
            this._lastLoaddedTheme.deSerialize(_loc6_);
            _loc7_ = this._lastLoaddedTheme.videoPropThumbs;
            _loc10_ = 0;
            while(_loc10_ < _loc7_.length)
            {
               _loc8_ = PropThumb(_loc7_.getValueByIndex(_loc10_));
               if((_loc9_ = _loc5_.getEntry(_loc8_.getFileName())) != null)
               {
                  _loc8_.imageData = _loc5_.getInput(_loc9_);
                  trace("thumb.id:" + _loc8_.id);
                  PropThumb(this._userTheme.videoPropThumbs.getValueByKey(_loc8_.id)).imageData = _loc5_.getInput(_loc9_);
               }
               _loc10_++;
            }
            this.thumbTray.removeLoadingCanvas(this._loaddingAssetType);
            this.thumbTray.loadThumbs(this._lastLoaddedTheme,false,this.thumbTray._uiTileVideoPropUser);
            _loc11_ = new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this);
            this.onLoadUserThemeComplete(_loc11_);
         }
         else
         {
            _loc12_ = new ByteArray();
            _loc2_.readBytes(_loc12_);
            _logger.error("getUserAssets failed: \n" + _loc12_.toString());
            Alert.show("getUserAssets failed: \n" + _loc12_.toString());
         }
      }
      
      private function doSaveMovieComplete(param1:Event) : void
      {
         var _loc2_:IDataInput = null;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:Date = null;
         var _loc6_:String = null;
         if(param1.type != Event.COMPLETE)
         {
            _logger.error(param1.toString());
         }
         else
         {
            _loc5_ = new Date();
            _loc6_ = UtilUnitConvert.getClockTime(_loc5_.getHours(),_loc5_.getMinutes());
            this.topButtonBar._btnSave.toolTip = UtilDict.toDisplay("go","topbtnbar_savenshare") + " (" + UtilDict.toDisplay("go","topbtnbar_lastsaved") + ": " + _loc6_ + ")";
         }
         this.enableAfterSave();
         _loc2_ = (param1.target as SaveMovieHelper).data;
         _loc3_ = -1;
         if(_loc2_.bytesAvailable >= 1)
         {
            _loc3_ = int(_loc2_.readByte());
         }
         if(String.fromCharCode(_loc3_) == "0" && param1.type == Event.COMPLETE)
         {
            _loc4_ = new ByteArray();
            _loc2_.readBytes(_loc4_);
            this.metaData.movieId = _loc4_.toString();
            this.tempMetaData.movieId = this.metaData.movieId;
            Application.application.parameters["movieId"] = this.metaData.movieId;
            if(this._isAutoSave)
            {
               this.mainStage.showAutoSaveHints();
            }
            this._movieXML = this._filmXML;
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
         }
         else
         {
            _loc4_ = new ByteArray();
            _loc2_.readBytes(_loc4_);
            _logger.error("return code is:" + _loc3_ + "\n error message: \n" + _loc4_.toString());
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,_loc4_.toString()));
         }
         this._isAutoSave = false;
      }
      
      public function bringForward() : void
      {
         var _loc1_:anifire.core.AnimeScene = null;
         var _loc2_:Boolean = false;
         var _loc3_:anifire.core.Asset = null;
         var _loc4_:ICommand = null;
         _loc1_ = _console.currentScene;
         _loc2_ = _loc1_.bringForward();
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new BringForwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function get uploadType() : String
      {
         return this._uploadType;
      }
      
      public function getCurTheme() : anifire.core.Theme
      {
         return this._curTheme;
      }
      
      private function loadMovieById(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         var _loc5_:URLVariables = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:URLLoader = null;
         this._movieXML = null;
         _loc4_ = new URLVariables();
         _loc5_ = new URLVariables();
         _loc6_ = Util.getFlashVar();
         _loc5_[ServerConstants.PARAM_MOVIE_ID] = param1;
         _loc5_[ServerConstants.PARAM_USER_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_ID) as String;
         _loc5_[ServerConstants.PARAM_USER_TOKEN] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_TOKEN) as String;
         if(UtilLicense.isBoxEnvironment())
         {
            _loc5_[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
         }
         Util.addFlashVarsToURLvar(_loc4_);
         _loc2_ = ServerConstants.ACTION_GET_MOVIE + "?" + _loc5_.toString();
         _loc3_ = new URLRequest(_loc2_);
         _loc7_ = String(_loc4_[ServerConstants.PARAM_MOVIE_ID]);
         _loc8_ = String(_loc4_[ServerConstants.PARAM_ORIGINAL_ID]);
         if(_loc7_ != null && Boolean(StringUtil.trim(_loc7_)))
         {
            this.metaData.movieId = _loc7_;
         }
         else if(_loc8_ != null && Boolean(StringUtil.trim(_loc8_)))
         {
            _loc4_[ServerConstants.PARAM_MOVIE_ID] = _loc8_;
            this._originalId = _loc8_;
         }
         _loc4_[ServerConstants.PARAM_IS_EDIT_MODE] = "1";
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc4_;
         (_loc9_ = new URLLoader()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc9_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc9_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc9_.load(_loc3_);
      }
      
      public function premiumEnabled() : Boolean
      {
         return this._purchaseEnabled;
      }
      
      public function get stageScale() : Number
      {
         return anifire.core.Console.getConsole().stageViewStage.selectedChild.scaleX;
      }
      
      public function addSound(param1:AnimeSound, param2:Number, param3:Number, param4:int = -1, param5:Boolean = false, param6:Boolean = false, param7:Number = 1) : void
      {
         this.sounds.push(param1.getID(),param1);
         param2 = UtilUnitConvert.snapToPixelWithTime(param2);
         var _loc8_:Number = UtilUnitConvert.snapToPixelWithTime(UtilUnitConvert.frameToPixel(param1.endFrame - param1.startFrame));
         this.timeline.addSoundAtTime(param1.getID(),param1.getLabel(),param2,param3,_loc8_,param4,param5,param6,param1.soundThumb.duration,param7);
         this.updateSoundById(param1.getID());
         this.stopAllSounds();
      }
      
      private function loadUserThemeIOErrorHandler(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeIOErrorHandler);
         this.loadProgressVisible = false;
         anifire.core.Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      private function onLoadCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCcCharCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         this._byteArrayReturnFromLoadCcChar = new ByteArray();
         _loc2_.readBytes(this._byteArrayReturnFromLoadCcChar);
         this.doPrepareLoadCcCharComplete(this._byteArrayReturnFromLoadCcChar);
      }
      
      public function addPoints(param1:Array) : void
      {
         this._moneyPoints += param1[0];
         this._sharingPoints += param1[1];
      }
      
      public function set tempPublished(param1:Boolean) : void
      {
         this._tempPublished = param1;
      }
      
      private function putFontData(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc6_:ByteArray = null;
         var _loc3_:FontManager = FontManager.getFontManager();
         var _loc4_:UtilHashArray = _loc3_.getFonts().clone();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.getFonts().length)
         {
            _loc2_ = _loc3_.getFonts().getKey(_loc5_);
            if(param1.indexOf(_loc2_) > -1)
            {
               (_loc6_ = new ByteArray()).writeBytes(_loc3_.getFonts().getValueByKey(_loc2_) as ByteArray);
               this.putData(_loc3_.nameToFileName(_loc2_) + ".swf",_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function selectScene(param1:Number) : void
      {
         this._currentSceneIndex = param1;
         this._stageViewStack.selectedIndex = this._currentSceneIndex;
         this.currentScene = this._scenes.getValueByIndex(param1);
         this.currentScene.playScene();
      }
      
      public function get tipsLayer() : Canvas
      {
         return this._tipsLayer;
      }
      
      private function get externalPreviewPlayerController() : ExternalPreviewWindowController
      {
         return this._externalPreviewPlayerController;
      }
      
      public function set screenCapTool(param1:ScreenCapTool) : void
      {
         this._screenCapTool = param1;
      }
      
      public function initializeLoadingBar(param1:ProgressBar) : void
      {
         this._loadProgress = param1;
      }
      
      private function initAutoSave() : void
      {
         var _loc1_:Timer = new Timer(AnimeConstants.AUTOSAVE_INTERVAL);
         _loc1_.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
         _loc1_.start();
      }
      
      public function undo() : void
      {
         var _loc2_:ICommand = null;
         var _loc1_:CommandStack = CommandStack.getInstance();
         if(_loc1_.hasPreviousCommands())
         {
            _loc2_ = _loc1_.previous();
            if(_loc2_ is ICommand)
            {
               ICommand(_loc2_).undo();
               Util.gaTracking("/gostudio/undo/" + _loc2_.toString(),anifire.core.Console.getConsole().mainStage.stage);
            }
            if(!_loc1_.hasPreviousCommands())
            {
               this.enableUndo(false);
            }
            this.enableRedo(true);
         }
      }
      
      public function enableUndo(param1:Boolean) : void
      {
         this.mainStage.enableUndo(param1);
      }
      
      public function checkMyCharNum() : void
      {
         this.addEventListener(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this.onGotCCCount);
         CursorManager.setBusyCursor();
         this.getCcCharCount();
      }
      
      private function onSoundMouseDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
         this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      private function setWhiteTerms(param1:String) : void
      {
         if(param1 != "")
         {
            this._whiteTerms = param1.split(",");
         }
      }
      
      public function get swfloader() : SWFLoader
      {
         return this._swfLoader;
      }
      
      public function set currentScene(param1:anifire.core.AnimeScene) : void
      {
         if(this._currentScene != null && this._currentScene != param1)
         {
            this._currentScene.selectedAsset = null;
            this._currentScene.stopScene();
         }
         this._currentScene = param1;
      }
      
      public function get publishW() : PublishWindow
      {
         return this._publishW;
      }
      
      public function closeImporter() : void
      {
         this._importer["close"]();
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      public function doClearScene(param1:String = "") : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:anifire.core.AnimeScene = null;
         _loc2_ = new ClearSceneCommand();
         _loc2_.execute();
         if(param1 != "")
         {
            _loc3_ = this.getScenebyId(param1);
            _loc3_.deSerialize(,true);
         }
         else
         {
            this._currentScene.deSerialize(,true);
         }
      }
      
      public function get sounds() : UtilHashArray
      {
         return this._sounds;
      }
      
      public function loadCommonThemeProp() : void
      {
         var _loc1_:anifire.core.Theme = null;
         if(this._themes.containsKey("common"))
         {
            _loc1_ = this.getTheme("common");
         }
         else
         {
            _loc1_ = null;
            trace("Error: theme not found when loading bg zip with themeId:common");
         }
         if(_loc1_.isPropZipLoaded())
         {
            this.thumbTray.loadPropThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeProp = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc1_.loadProp();
      }
      
      public function doShowCopyMyCharAlert(param1:Event) : void
      {
         var _loc2_:GoAlert = null;
         _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc2_._lblConfirm.text = "";
         _loc2_._txtDelete.text = UtilDict.toDisplay("go","goalert_createMyChar");
         _loc2_._txtDelete.setStyle("textAlign","left");
         _loc2_._txtDelete.setStyle("fontSize","15");
         _loc2_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCreateMyChar);
         _loc2_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      private function onPreparedThumbnailScene(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onPreparedThumbnailScene);
         this.saveMovie();
      }
      
      public function get currDragObject() : anifire.core.Asset
      {
         return this._currDragObject;
      }
      
      public function get scenes() : UtilHashArray
      {
         return this._scenes;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(param1 && !this._capScreenLock)
         {
            this.doUpdateTimeline(null,true);
            this.updateSceneLength();
         }
      }
      
      private function initTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,5,5,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","gotips_pleaseread");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",13);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).percentWidth = 80;
         _loc5_.setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","center");
         _loc5_.setStyle("horizontalCenter","1");
         _loc5_.setStyle("verticalScrollPolicy","off");
         var _loc6_:StyleSheet;
         (_loc6_ = new StyleSheet()).parseCSS(this.hoverStyles);
         var _loc7_:TextArea;
         (_loc7_ = new TextArea()).styleSheet = _loc6_;
         _loc7_.height = 100;
         _loc7_.selectable = false;
         _loc7_.htmlText = UtilDict.toDisplay("go","gotips_effectupdated");
         _loc7_.setStyle("fontSize",16);
         var _loc8_:TextArea;
         (_loc8_ = new TextArea()).styleSheet = _loc6_;
         _loc8_.selectable = false;
         _loc8_.htmlText = UtilDict.toDisplay("go","gotips_learnmore");
         _loc8_.setStyle("fontSize",16);
         _loc8_.setStyle("textAlign","right");
         _loc7_.verticalScrollPolicy = _loc8_.verticalScrollPolicy = "off";
         _loc7_.percentWidth = _loc8_.percentWidth = 100;
         _loc7_.selectable = _loc8_.selectable = false;
         _loc7_.editable = _loc8_.editable = false;
         _loc7_.setStyle("backgroundAlpha","0");
         _loc8_.setStyle("backgroundAlpha","0");
         _loc7_.setStyle("borderStyle","none");
         _loc8_.setStyle("borderStyle","none");
         _loc5_.addChild(_loc7_);
         _loc5_.addChild(_loc8_);
         _loc2_._content.height = 140;
         _loc2_.setContent(_loc5_);
         var _loc9_:Canvas;
         (_loc9_ = new Canvas()).width = _loc2_.width;
         _loc9_.setStyle("horizontalCenter","1");
         _loc9_.buttonMode = true;
         var _loc10_:Label;
         (_loc10_ = new Label()).text = UtilDict.toDisplay("go","gotips_close");
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = true;
         _loc10_.mouseChildren = false;
         _loc10_.x = (_loc9_.width - 80) / 2;
         _loc10_.setStyle("fontSize",14);
         _loc10_.addEventListener(MouseEvent.CLICK,this.closeTip);
         _loc9_.addChild(_loc10_);
         _loc2_.setClose(_loc9_);
      }
      
      public function alertSceneXml() : void
      {
         var _loc4_:XML = null;
         var _loc1_:XML = this.serialize();
         var _loc2_:XML = _loc1_.child("scene")[0] as XML;
         var _loc3_:String = "";
         for each(_loc4_ in _loc2_.children())
         {
            _loc3_ += _loc4_.toXMLString();
         }
         Alert.show(_loc3_);
      }
      
      public function showShareWindow(param1:Event) : void
      {
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            return;
         }
         CursorManager.setBusyCursor();
         this.requestLoadStatus(true,true);
         if(this._publishW != null)
         {
            this._publishW.setBtnStatus(false);
         }
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = decodeURI(_loc2_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String);
         var _loc4_:RegExp = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc3_ = _loc3_.replace(_loc4_,this.metaData.movieId);
         var _loc5_:URLVariables = new URLVariables();
         var _loc6_:URLRequest = null;
         if(anifire.core.Console.getConsole().boxMode)
         {
            if(this.privateShared || this.published)
            {
               _loc3_ = _loc3_.replace(/#/,"&goemail=goemail#");
            }
            _loc3_ = _loc3_.replace(/v=(\d+)/,"v=" + new Date().time.toString());
            (_loc6_ = new URLRequest(_loc3_)).method = URLRequestMethod.GET;
         }
         else
         {
            if(this.privateShared || this.published)
            {
               _loc5_["goemail"] = "goemail";
            }
            _loc5_["movieId"] = this.metaData.movieId;
            (_loc6_ = new URLRequest(_loc3_)).method = URLRequestMethod.POST;
            _loc6_.data = _loc5_;
         }
         navigateToURL(_loc6_,"_top");
      }
      
      public function addSceneOnDeserialize() : void
      {
         var sceneNode:XML = null;
         var sceneId:String = null;
         var scene:anifire.core.AnimeScene = null;
         var movieXML:XML = this._movieXML;
         var indexArray:Array = UtilXmlInfo.getAndSortXMLattribute(movieXML,"index",anifire.core.AnimeScene.XML_NODE_NAME);
         this.mainStage._labelScene.text = UtilDict.toDisplay("go","mainstage_preparing");
         if(this._sci < indexArray.length)
         {
            this.requestLoadStatus(true,true);
            sceneNode = movieXML.child(anifire.core.AnimeScene.XML_NODE_NAME).(@index == indexArray[_sci] as int)[0];
            if(!(sceneNode.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1 && (this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO) && this.isCopy))
            {
               sceneId = sceneNode.@id;
               scene = this.addScene(sceneId);
               this.capScreenLock = true;
               scene.eventDispatcher.addEventListener(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this.onSceneComplete);
               if(indexArray.length > 1)
               {
                  scene.deSerialize(sceneNode,true,true);
               }
               else
               {
                  scene.deSerialize(sceneNode,true,true,false);
               }
            }
         }
         if(this._sci == indexArray.length)
         {
            this.capScreenLock = false;
            this.requestLoadStatus(false,true,indexArray.length);
            this.mainStage._labelScene.text = UtilDict.toDisplay("go","mainstage_displaying");
            if(indexArray.length > 0 && this.studioType != MESSAGE_STUDIO)
            {
               this.setCurrentScene(0);
               this.currentScene.loadAllAssets();
               this.timeline._timelineScrollbar.scrollPosition = 0;
               this.timeline._timelineScrollbar.dispatchEvent(new Event(ScrollEvent.SCROLL));
            }
            this.deserializeSound(movieXML);
            this._initialized = true;
            if(this.metaData.mver <= 2 && UtilLicense.isEffectChangeTipsShouldBeShown(UtilLicense.getCurrentLicenseId()))
            {
               this.showTip();
            }
         }
         ++this._sci;
      }
      
      private function addSceneCtrl(param1:String) : void
      {
         this._timeline.addScene(param1);
      }
      
      private function loadThemeBgComplete(param1:CoreEvent) : void
      {
         var _loc2_:anifire.core.Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemeBgComplete);
         _loc2_ = param1.getEventCreater() as anifire.core.Theme;
         this.thumbTray.loadBackgroundThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeBg && _loc2_.isBgZipLoaded())
         {
            this.loadCommonThemeBg();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/bg",anifire.core.Console.getConsole().mainStage.stage);
         }
      }
      
      public function changeBubbleMsg(param1:BubbleAsset, param2:String) : void
      {
         param1.text = param2;
         param1.bubble.backupText = param2;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function setCurrentSceneById(param1:String) : void
      {
         var _loc2_:int = this._scenes.getIndex(param1);
         this.setCurrentScene(_loc2_);
      }
      
      public function set selectedThumbnailIndex(param1:int) : void
      {
         this._selectedThumbnailIndex = param1;
      }
      
      public function set copyData(param1:String) : void
      {
         this._copyData = param1;
      }
      
      public function set currentLicensorName(param1:String) : void
      {
         this._currentLicensorName = param1;
      }
      
      private function get isCopyable() : Boolean
      {
         return this._isCopyable;
      }
      
      public function removeGuideBubbles() : void
      {
         this._needGuideBubbles = false;
         if(this._bubbleSceneGuide != null)
         {
            this.hideGuideSceneBub();
         }
         if(this._bubbleThumbGuide != null)
         {
            this.hideGuideThumbBub();
         }
      }
      
      private function doLoadMovie(param1:Event) : void
      {
         var idToLoad:String = null;
         var movieId:String = null;
         var originalId:String = null;
         var shouldLoadExistMovie:Boolean = false;
         var turnOffLoading:Function = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.doLoadMovie);
         idToLoad = "";
         movieId = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String;
         originalId = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         shouldLoadExistMovie = false;
         if(movieId != null && StringUtil.trim(movieId).length > 0)
         {
            shouldLoadExistMovie = true;
            idToLoad = movieId;
         }
         else if(originalId != null && StringUtil.trim(originalId).length > 0)
         {
            shouldLoadExistMovie = true;
            idToLoad = originalId;
         }
         if(shouldLoadExistMovie)
         {
            this.requestLoadStatus(true,true);
            turnOffLoading = function(... rest):void
            {
               var _loc2_:anifire.core.Console = null;
               var _loc3_:ItemClickEvent = null;
               _loc2_ = anifire.core.Console.getConsole();
               _loc2_.requestLoadStatus(false,true);
               if(studioType == MESSAGE_STUDIO)
               {
                  _loc3_ = new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
                  _loc3_.index = 1;
                  thumbTray.onClickThemeButton(_loc3_);
                  thumbTray.VSThumbTray.selectedChild = thumbTray._uiCanvasUser;
               }
            };
            this.addEventListener(CoreEvent.LOAD_MOVIE_COMPLETE,turnOffLoading);
            this.loadMovieById(idToLoad);
         }
         else
         {
            this.newAnimation();
            this._initialized = true;
            Util.gaTracking("/gostudio/themeCompleted",anifire.core.Console.getConsole().mainStage.stage);
         }
      }
      
      private function onUpdateAssetComplete(param1:Event = null) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.UPDATE_ASSET_COMPLETE,this));
      }
      
      public function getCcCharCount() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         _loc1_ = new URLLoader();
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_CC_CHAR_COUNT);
         _loc2_.method = URLRequestMethod.POST;
         _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc3_ = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc2_.data = _loc3_;
         _loc1_.addEventListener(Event.COMPLETE,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCcCharCountComplete);
         _loc1_.load(_loc2_);
      }
      
      private function doUpdateTimeline(param1:Event, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         this._stageViewStack.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.doUpdateTimeline);
         if(!this._capScreenLock)
         {
            if(this._currentScene != null)
            {
               this._stageViewStack.selectedChild = this._currentScene.canvas;
               if(this._defaultUpdateAllTimelineImage)
               {
                  trace("RUN doupdatetimeline... full #######################################");
                  _loc3_ = 0;
                  while(_loc3_ < this._scenes.length)
                  {
                     this.timeline.setSceneTarget(AnimeScene(this._scenes.getValueByIndex(_loc3_)).canvas,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
                     AnimeScene(this._scenes.getValueByIndex(_loc3_)).unloadAllAssets();
                     _loc3_++;
                  }
                  if(this._scenes.length > 1)
                  {
                     this._defaultUpdateAllTimelineImage = false;
                  }
               }
               else
               {
                  _loc3_ = this.currentSceneIndex;
                  this.doUpdateTimelineByScene(this.getScene(_loc3_));
               }
            }
         }
      }
      
      public function addTheme(param1:String, param2:anifire.core.Theme) : void
      {
         var _loc3_:anifire.core.Theme = null;
         if(this._themes.getValueByKey(param1) == null)
         {
            this._themes.push(param1,param2);
         }
         else
         {
            _loc3_ = this._themes.getValueByKey(param1) as anifire.core.Theme;
            _loc3_.mergeTheme(param2);
            this._themes.push(param1,_loc3_);
         }
      }
      
      private function onSoundMoveHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getValueByKey(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel + _loc3_.totalPixel);
         _loc4_.trackNum = UtilUnitConvert.pixelToTrack(_loc3_.y);
         trace("on sound move:" + _loc4_.trackNum);
      }
      
      private function stopScene(param1:Function, param2:Number) : void
      {
         var _loc3_:anifire.core.AnimeScene = null;
         var _loc4_:int = 0;
         if(param2 > 0)
         {
            param2--;
            anifire.core.Console.getConsole().mainStage.callLater(param1,new Array(param1,param2));
         }
         else
         {
            _loc4_ = 1;
            while(_loc4_ < anifire.core.Console.getConsole().scenes.length)
            {
               _loc3_ = anifire.core.Console.getConsole().getScene(_loc4_);
               _loc3_.stopScene();
               _loc4_++;
            }
         }
      }
      
      public function get topButtonBar() : TopButtonBar
      {
         return this._topButtonBar;
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = this._scenes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            AnimeScene(this._scenes.getValueByIndex(_loc3_)).replaceBubbleText(param1,param2);
            _loc3_++;
         }
      }
      
      private function hideGuideThumbBub(param1:Event = null) : void
      {
         this.thumbTray.removeEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
         if(this._bubbleThumbGuide != null)
         {
            this._bubbleThumbGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
            this.hideGuideBubble(this._bubbleThumbGuide);
         }
      }
      
      public function set uploadType(param1:String) : void
      {
         this._uploadType = param1;
      }
      
      public function playScene(param1:Boolean) : void
      {
         if(param1)
         {
            this.currentScene.playScene();
         }
         else
         {
            this.currentScene.stopScene();
         }
      }
      
      public function pasteScene(param1:Number = 1) : void
      {
         var oldSceneId:String = null;
         var oldSoundInfos:Array = null;
         var scene:anifire.core.AnimeScene = null;
         var newSceneId:String = null;
         var setNewScene:Function = null;
         var command:ICommand = null;
         var index:Number = param1;
         if(this._copySceneData != "")
         {
            oldSceneId = this.currentScene.id;
            oldSoundInfos = this.timeline.getAllSoundInfo();
            this.currentScene.unloadAllAssets();
            scene = this.addScene("",this._copySceneData,index);
            newSceneId = scene.id;
            this._copySceneData = "";
            this.setCurrentSceneById(oldSceneId);
            setNewScene = function(param1:String):void
            {
               anifire.core.Console.getConsole().setCurrentSceneById(param1);
            };
            this.currentScene.canvas.callLater(setNewScene,new Array(newSceneId));
            command = new AddSceneCommand(newSceneId,oldSoundInfos);
            command.execute();
         }
      }
      
      private function onLoadFontsDone(param1:LoadMgrEvent = null) : void
      {
         this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
      }
      
      public function get searchedTheme() : anifire.core.Theme
      {
         return this._searchedTheme;
      }
      
      private function newAnimation(param1:Boolean = true) : void
      {
         var _loc3_:Rectangle = null;
         var _loc4_:Object = null;
         if(this.currentScene != null)
         {
            this.currentScene.removeSound();
         }
         this._isMovieNew = true;
         this.stopAllSounds();
         if(this.scenes.length > 0)
         {
            this.clearScenes();
         }
         if(this.sounds.length > 0)
         {
            this.removeAllSounds();
         }
         var _loc2_:anifire.core.AnimeScene = this.addScene();
         this.setCurrentSceneById(_loc2_.id);
         CommandStack.getInstance().reset();
         this._metaData = this._tempMetaData = new anifire.core.MetaData();
         this._published = false;
         this._tempPublished = false;
         this._privateShared = true;
         this._tempPrivateShared = true;
         if(this.siteId == String(Global.BEN10) || UtilLicense.isSchoolEnvironment())
         {
            this._privateShared = false;
            this._tempPrivateShared = false;
         }
         if(this._thumbTray.fullReady())
         {
            if(param1)
            {
               this.addRandomAssetsToScene(this._curTheme,this._currentScene);
            }
         }
         if(this._guideMode == ServerConstants.FLASHVAR_TM_NEW || this._guideMode == ServerConstants.FLASHVAR_TM_SEMI)
         {
            _loc3_ = new Rectangle(this.thumbTray.main_cav.x + this.thumbTray.x,88,this.thumbTray.main_cav.width,380);
            (_loc4_ = new Object())["Rect"] = _loc3_;
            this.goWalker.init(2,true,false,_loc4_);
            this.goWalker.addEventListener(GoWalkerEvent.EVENT_NEXT_STEP,this.freezeCurrentScene);
            this._needGuideBubbles = false;
         }
         if(this._needGuideBubbles && (this.studioType == TINY_STUDIO || this.studioType == FULL_STUDIO))
         {
            this.addGuideBubbles();
         }
      }
      
      public function onGotCCCount(param1:LoadCcCharCountEvent) : void
      {
         CursorManager.removeBusyCursor();
         if(param1.ccCharCount > 0)
         {
            this.thumbTray.switchTheme(ThumbTray.COMMON_THEME);
            this.thumbTray.loadCcTheme();
         }
         else
         {
            this.doShowCreateMyCharAlert(null);
         }
      }
      
      private function doShowNoSaveAlert(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowNoSaveAlert);
         var _loc2_:noSaveAlertWindow = noSaveAlertWindow(PopUpManager.createPopUp(this.mainStage,noSaveAlertWindow,true));
         _loc2_.x = (this.mainStage.stage.width - _loc2_.width) / 2;
         _loc2_.y = this.mainStage.y;
         this._topButtonBar._btnSave.enabled = false;
         this._topButtonBar._btnSave.styleName = "btnSaveFullDisabled";
         this._topButtonBar._btnSave.toolTip = "";
         this._topButtonBar._btnSave.addEventListener(MouseEvent.MOUSE_OVER,this.showNoSaveTips);
      }
      
      public function showPublishWindow() : void
      {
         this.genDefaultTags();
         var _loc1_:PublishWindow = PublishWindow(PopUpManager.createPopUp(this.mainStage,PublishWindow,true));
         _loc1_.initPublishWindow(null,this.tempPublished,this.tempPrivateShared,this.getThumbnailCaptures(),this.tempMetaData.title,this.tempMetaData.getUgcTagString(),this.tempMetaData.description,this.tempMetaData.lang);
         _loc1_.x = (this.mainStage.stage.width - _loc1_.width) / 2;
         _loc1_.y = this.mainStage.y;
         this.publishW = _loc1_;
         if(this.currentScene != null)
         {
            this.currentScene.selectedAsset = null;
         }
      }
      
      public function showCopyMyChar(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = (param1.target as DisplayObject).name;
         navigateToURL(new URLRequest(ServerConstants.CC_PAGE_PATH + "/copy/" + _loc2_),"_top");
      }
      
      private function loadThemePropComplete(param1:CoreEvent) : void
      {
         var _loc2_:anifire.core.Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemePropComplete);
         _loc2_ = param1.getEventCreater() as anifire.core.Theme;
         this.thumbTray.loadPropThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeProp)
         {
            this.loadCommonThemeProp();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/prop",anifire.core.Console.getConsole().mainStage.stage);
         }
      }
      
      public function loadCommonTheme() : void
      {
         var commonTheme:anifire.core.Theme = null;
         Util.gaTracking("/gostudio/themes/loading/common",anifire.core.Console.getConsole().mainStage.stage);
         if(this._themes.containsKey("common"))
         {
            commonTheme = this._themes.getValueByKey("common") as anifire.core.Theme;
         }
         else
         {
            commonTheme = new anifire.core.Theme();
            commonTheme.id = "common";
            if(this._purchasedAssetsXML != null)
            {
               commonTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == "common"));
            }
         }
         this._isLoaddingCommonTheme = true;
         commonTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         commonTheme.initThemeByLoadThemeFile(this,"common");
      }
      
      private function onGetCustomAssetComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:Thumb = null;
         var _loc6_:XML = null;
         var _loc7_:SoundThumb = null;
         var _loc8_:EffectThumb = null;
         var _loc9_:SuperEffect = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:Image = null;
         var _loc12_:Loader = null;
         var _loc13_:Image = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"]();
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc3_ = _loc2_.readByte();
            _loc4_ = new ByteArray();
            _loc2_.readBytes(_loc4_);
            if(!(_loc3_ % 48 == 0 && param1.type == Event.COMPLETE))
            {
               _logger.error("return code is:" + _loc3_ + "\n error message: \n" + _loc4_.toString());
               Alert.show("the return code is: " + _loc3_ + "\n error message: \n" + _loc4_.toString());
               if(this._importer != null)
               {
                  this._importer["error"](null);
               }
               throw new Error("load asset by id failed.");
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._placeable = true;
               _loc5_ = new BackgroundThumb();
               _loc5_.id = _loc5_.thumbId = this._uploadedAssetXML.file;
               _loc5_.name = this._uploadedAssetXML.title;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.theme = anifire.core.Console.getConsole().userTheme;
               _loc5_.imageData = _loc5_.thumbImageData = _loc4_;
               _loc5_.enable = true;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
               this.userTheme.backgroundThumbs.push(_loc5_.id,_loc5_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
            {
               this._holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR ? true : false;
               this._headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD ? true : false;
               this._placeable = true;
               (_loc5_ = new PropThumb()).id = this._uploadedAssetXML.file;
               _loc5_.name = this._uploadedAssetXML.title;
               _loc5_.theme = anifire.core.Console.getConsole().userTheme;
               _loc5_.imageData = _loc4_;
               PropThumb(_loc5_).placeable = true;
               PropThumb(_loc5_).holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR ? true : false;
               PropThumb(_loc5_).headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD ? true : false;
               PropThumb(_loc5_).facing = AnimeConstants.FACING_LEFT;
               _loc5_.enable = true;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
               this.userTheme.propThumbs.push(_loc5_.id,_loc5_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               this._placeable = true;
               _loc6_ = new XML("<theme>" + this._uploadedAssetXML.toString() + "</theme>");
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  ((_loc5_ = new CharThumb()) as CharThumb).deSerialize(this._uploadedAssetXML,anifire.core.Console.getConsole().userTheme);
                  (_loc5_ as CharThumb).imageData = _loc4_;
                  (_loc5_ as CharThumb).name = this._uploadedAssetXML.@name;
                  anifire.core.Console.getConsole().userTheme.mergeThemeXML(_loc6_);
               }
               else
               {
                  (_loc5_ = new EffectThumb()).imageData = _loc4_;
                  _loc5_.deSerialize(this._uploadedAssetXML,anifire.core.Console.getConsole().userTheme);
                  anifire.core.Console.getConsole().userTheme.mergeThemeXML(_loc6_);
               }
               if(Boolean(this._importer["oldChar"]))
               {
                  this._importer["success"]();
                  return;
               }
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this.getTheme("ugc").charThumbs.push(_loc5_.id,_loc5_);
                  this.userTheme.charThumbs.push(_loc5_.id,_loc5_);
               }
               else
               {
                  this.userTheme.effectThumbs.push(_loc5_.id,_loc5_);
               }
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc7_ = new SoundThumb()).deSerializeByUserAssetXML(this._uploadedAssetXML,this.userTheme);
               (_loc5_ = _loc7_).enable = true;
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc5_ as SoundThumb).addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.onLoadCustomAssetImageComplete);
               (_loc5_ as SoundThumb).initSoundByByteArray(_loc4_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               (_loc9_ = (_loc8_ = _loc5_ as EffectThumb).getNewEffect()).addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc10_ = _loc9_.loadThumbnail(_loc8_.imageData as ByteArray);
               (_loc11_ = new Image()).addChild(_loc10_);
               _loc11_.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.doDrag);
            }
            else
            {
               (_loc12_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc12_.loadBytes(_loc4_);
               _loc12_.name = "imageLoader";
               (_loc13_ = new Image()).addChild(_loc12_);
               _loc13_.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.doDrag);
            }
         }
      }
      
      private function setCurTheme(param1:anifire.core.Theme) : void
      {
         this._curTheme = param1;
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         if(_loc2_ != null)
         {
            trace("onSoundResizeStart,soundId:" + _loc2_);
            this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
            trace("onSoundResizeStart:" + this._prevSoundInfo);
         }
      }
      
      public function invisibleImporter() : void
      {
         this._swfLoader.visible = false;
      }
      
      public function doNewAnimation() : void
      {
         Alert.buttonWidth = 100;
         var _loc1_:GoAlert = GoAlert(PopUpManager.createPopUp(this._currentScene.canvas,GoAlert,true));
         _loc1_._lblConfirm.text = "";
         _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_newanimation");
         _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc1_._btnCancel.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = (_loc1_.stage.height - _loc1_.height) / 3;
      }
      
      public function set tipsLayer(param1:Canvas) : void
      {
         this._tipsLayer = param1;
      }
      
      private function set externalPreviewPlayerController(param1:ExternalPreviewWindowController) : void
      {
         this._externalPreviewPlayerController = param1;
      }
      
      public function calculateUsedBytes() : String
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         _loc1_ = Number(System.totalMemory / Math.pow(2,20));
         _loc2_ = 2;
         return _loc1_.toFixed(_loc2_).toString();
      }
      
      public function getBadTerms() : Array
      {
         if(this._badTerms != null)
         {
            return this._badTerms;
         }
         return null;
      }
      
      public function get stageViewStage() : ViewStack
      {
         return this._stageViewStack;
      }
      
      public function redo() : void
      {
         var _loc2_:ICommand = null;
         var _loc1_:CommandStack = CommandStack.getInstance();
         if(_loc1_.hasNextCommands())
         {
            _loc2_ = _loc1_.next();
            if(_loc2_ is ICommand)
            {
               ICommand(_loc2_).redo();
               Util.gaTracking("/gostudio/redo/" + _loc2_.toString(),anifire.core.Console.getConsole().mainStage.stage);
            }
            if(!_loc1_.hasNextCommands())
            {
               this.enableRedo(false);
            }
            this.enableUndo(true);
         }
      }
      
      public function get currentSceneIndex() : Number
      {
         return this._currentSceneIndex;
      }
      
      public function showInspirationWindow() : void
      {
         var app:Application = null;
         if(this._inspirationLoader.content == null)
         {
            this._inspirationLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _inspirationLoader.y = 0;
               _inspirationLoader.visible = true;
               CursorManager.removeBusyCursor();
               _inspirationLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  try
                  {
                     app = Application(SystemManager(_inspirationLoader.content).application);
                     app["init"](Application.application._console);
                     _inspirationLoader.content.removeEventListener(Event.RENDER,f);
                  }
                  catch(err:TypeError)
                  {
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._inspirationLoader.load();
         }
         else
         {
            this._inspirationLoader.visible = true;
            app = Application(SystemManager(this._inspirationLoader.content).application);
            app["switchPanel"](null);
         }
      }
      
      internal function updateSceneLength() : void
      {
         this.currentScene.doUpdateTimelineLength();
      }
      
      public function clearBubbleText(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BubbleAsset = null;
         _loc4_ = this._scenes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < AnimeScene(this._scenes.getValueByIndex(_loc2_)).bubbles.length)
            {
               if((_loc5_ = BubbleAsset(AnimeScene(this._scenes.getValueByIndex(_loc2_)).bubbles.getValueByIndex(_loc3_))).bubble.backupText != "" && param1 == false)
               {
                  _loc5_.bubble.text = _loc5_.bubble.backupText;
               }
               else
               {
                  _loc5_.bubble.backupText = _loc5_.bubble.text;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get boxMode() : Boolean
      {
         return this._boxMode;
      }
      
      public function serializeSound(param1:Boolean = true) : String
      {
         var _loc4_:AnimeSound = null;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < this.sounds.length)
         {
            _loc4_ = this.sounds.getValueByIndex(_loc3_) as AnimeSound;
            _loc2_ += _loc4_.serialize(param1);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function testing(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.testing);
            _loc2_.loaderInfo.loader.parent.parent.removeChild(_loc2_.loaderInfo.loader.parent);
            this.doAddScene();
         }
         else
         {
            trace("Current Frame: " + _loc2_.currentFrame + "         ");
            trace("Total Frame: " + _loc2_.totalFrames + "\n");
         }
      }
      
      private function showNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = new VBox();
         _loc2_.styleName = "vboxNoSave";
         _loc2_.setStyle("paddingTop","12");
         _loc2_.width = 400;
         _loc2_.height = 150;
         _loc2_.x = this._topButtonBar._btnSave.x + this._topButtonBar.x - _loc2_.width + this._topButtonBar._btnSave.width;
         _loc2_.y = this._topButtonBar._btnSave.y + this._topButtonBar.y;
         var _loc3_:TextArea = new TextArea();
         var _loc4_:TextArea = new TextArea();
         var _loc5_:StyleSheet;
         (_loc5_ = new StyleSheet()).parseCSS(this.hoverStyles);
         _loc3_.styleSheet = _loc4_.styleSheet = _loc5_;
         _loc3_.verticalScrollPolicy = _loc4_.verticalScrollPolicy = "off";
         _loc3_.htmlText = UtilDict.toDisplay("go","nstip_title1");
         _loc4_.htmlText = UtilDict.toDisplay("go","nstip_title2");
         _loc3_.percentWidth = _loc4_.percentWidth = 100;
         _loc3_.styleName = _loc4_.styleName = "textNormal";
         _loc3_.selectable = _loc4_.selectable = false;
         _loc3_.editable = _loc4_.editable = false;
         _loc3_.setStyle("textAlign","center");
         _loc4_.setStyle("textAlign","center");
         _loc3_.setStyle("backgroundAlpha","0");
         _loc4_.setStyle("backgroundAlpha","0");
         _loc3_.setStyle("borderStyle","none");
         _loc4_.setStyle("borderStyle","none");
         var _loc6_:Spacer;
         (_loc6_ = new Spacer()).percentHeight = 100;
         var _loc7_:Text;
         (_loc7_ = new Text()).text = UtilDict.toDisplay("go","nstip_title3");
         _loc7_.percentWidth = 100;
         _loc7_.styleName = "textSmall";
         _loc7_.selectable = false;
         _loc7_.setStyle("textAlign","right");
         _loc7_.setStyle("color","#666666");
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc4_);
         _loc2_.addChild(_loc6_);
         _loc2_.addChild(_loc7_);
         _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
         this.tipsLayer.addChild(_loc2_);
      }
      
      public function clearScenes() : void
      {
         this._currentScene = null;
         this._currentSceneIndex = -1;
         if(this._scenes.length > 0)
         {
            this._scenes.remove(0,this._scenes.length);
            this._stageViewStack.removeAllChildren();
            this._timeline.removeAllScenes();
            this._timeline.removeAllSounds();
         }
      }
      
      public function doAddScene() : void
      {
         var _loc1_:Array = null;
         var _loc2_:anifire.core.AnimeScene = null;
         var _loc3_:ICommand = null;
         this.currentScene.unloadAllAssets();
         _loc1_ = this.timeline.getAllSoundInfo();
         _loc2_ = this.addScene();
         this.setCurrentSceneById(_loc2_.id);
         this.currentScene.canvas.callLater(this.sceneChangeEffect);
         _loc3_ = new AddSceneCommand(_loc2_.id,_loc1_);
         _loc3_.execute();
         this.mainStage._btnAddScene.buttonMode = this.mainStage._btnDelScene.buttonMode = true;
      }
      
      public function showImporterWindow(param1:String, param2:String = null) : void
      {
         var type:String = param1;
         var text:String = param2;
         if(text != null)
         {
            this._tempAsset = this._currentScene.selectedAsset;
         }
         if(this._importer == null)
         {
            this._swfLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _swfLoader.y = 0;
               _swfLoader.visible = true;
               CursorManager.removeBusyCursor();
               _swfLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  if(!_importerOpenedBefore)
                  {
                     try
                     {
                        _importer = Application(SystemManager(_swfLoader.content).application);
                        _importer["init"](Application.application._console);
                        _swfLoader.content.removeEventListener(Event.RENDER,f);
                        if(_studioType == TINY_STUDIO)
                        {
                           _importer["isFacebook"]();
                        }
                        if(_studioType == MESSAGE_STUDIO)
                        {
                           _importer["isEmessage"]();
                        }
                        _importer["gotoPanel"](type,text);
                        _importerOpenedBefore = true;
                     }
                     catch(err:TypeError)
                     {
                     }
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._swfLoader.load();
         }
         else
         {
            if(!this._importerOpenedBefore)
            {
               this._importer = Application(SystemManager(this._swfLoader.content).application);
               this._importer["init"](Application.application._console);
               if(this._studioType != FULL_STUDIO)
               {
                  this._importer["isFacebook"]();
               }
               this._importerOpenedBefore = true;
            }
            this._importer["gotoPanel"](type,text);
            this._swfLoader.content.visible = true;
            this._swfLoader.visible = true;
         }
         if(this.currentScene != null)
         {
            this.currentScene.stopScene();
         }
         this.currentScene.selectedAsset = null;
      }
      
      private function loadUserThemeSecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeSecurityErrorHandler);
         this.loadProgressVisible = false;
         anifire.core.Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      public function removeAllSounds() : void
      {
         this.stopAllSounds();
         this.sounds.removeAll();
         this.timeline.removeAllSounds();
      }
      
      public function onGetCustomCharComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:Thumb = null;
         var _loc4_:ZipFile = null;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:CharThumb = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"](null);
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc4_ = new ZipFile(_loc2_);
            _loc5_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            _loc6_ = String(this._importer["charId"]);
            this.userTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            this._lastLoaddedTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            if((_loc7_ = this._lastLoaddedTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,this._lastLoaddedTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if((_loc7_ = this._userTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,this._userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if(this.getTheme("ugc") != null)
            {
               _loc7_ = this.getTheme("ugc").getCharThumbById(_loc6_);
            }
            else
            {
               _loc7_ = null;
            }
            if(_loc7_ != null)
            {
               _loc7_.deSerialize(_loc5_,this._userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            this._importer["success"]();
         }
      }
      
      public function get published() : Boolean
      {
         return this._published;
      }
      
      public function searchAsset(param1:String, param2:String, param3:int, param4:int) : void
      {
         this.requestLoadStatus(true,true);
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["type"] = param2;
         _loc5_["keywords"] = param1;
         _loc5_["page"] = param3;
         _loc5_["count"] = param4;
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_SEARCH_ASSET)).method = URLRequestMethod.POST;
         _loc6_.data = _loc5_;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).addEventListener(Event.COMPLETE,this.onSearchComplete);
         _loc7_.load(_loc6_);
      }
      
      public function get thumbTray() : ThumbTray
      {
         return this._thumbTray;
      }
      
      private function addGuideBubbles() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:XML = null;
         var _loc4_:Bubble = null;
         var _loc5_:Rectangle = null;
         var _loc6_:XML = null;
         var _loc7_:Bubble = null;
         _loc1_ = 106;
         if(this._studioType == TINY_STUDIO)
         {
            if(this._bubbleThumbGuide == null)
            {
               _loc3_ = <bubble x="0" y="0" w="180" h="90" rotate="0" type="ROUNDRECTANGULAR">
											        <body rgb="16777215" alpha="0.9" linergb="0" tailx="25" taily="-34"/>
											        <text rgb="0" font="TrebuchetMS1" size="35" align="center" bold="false" italic="false">
											          Mouse over here to bring out characters
											        </text>
											      </bubble>;
               (_loc4_ = BubbleMgr.getBubbleByXML(_loc3_)).useDeviceFont = true;
               this._bubbleThumbGuide = new Image();
               this._bubbleThumbGuide.addChild(_loc4_);
               _loc5_ = this.thumbTray.getBounds(this.thumbTray);
               this._bubbleThumbGuide.x = 71;
               this._bubbleThumbGuide.y = _loc1_;
               this._bubbleThumbGuide.useHandCursor = true;
               this._bubbleThumbGuide.mouseChildren = false;
               this._bubbleThumbGuide.buttonMode = true;
            }
            this.thumbTray.parent.addChild(this._bubbleThumbGuide);
            this.thumbTray.addEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
            this._bubbleThumbGuide.addEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
         }
         _loc2_ = 361;
         _loc1_ = 381;
         if(this._studioType == FULL_STUDIO)
         {
            _loc2_ += 320;
            _loc1_ -= 50;
         }
         if(this._bubbleSceneGuide == null)
         {
            _loc6_ = <bubble x="0" y="0" w="180" h="100" rotate="0" type="ELLIPSE">
						  <body rgb="16777215" alpha="0.9" linergb="0" tailx="164" taily="107"/>
						    <text rgb="0" font="TrebuchetMS1" size="25" align="center" bold="false" italic="false" embed="false"></text>
						</bubble>;
            (_loc7_ = BubbleMgr.getBubbleByXML(_loc6_)).useDeviceFont = false;
            _loc7_.text = UtilDict.toDisplay("go","guide_bubble_text");
            this._bubbleSceneGuide = new Image();
            this._bubbleSceneGuide.addChild(_loc7_);
            this._bubbleSceneGuide.x = _loc2_;
            this._bubbleSceneGuide.y = _loc1_;
            this._bubbleSceneGuide.useHandCursor = true;
            this._bubbleSceneGuide.mouseChildren = false;
            this._bubbleSceneGuide.buttonMode = true;
         }
         this.thumbTray.parent.addChild(this._bubbleSceneGuide);
         this._mainStage._btnAddScene.addEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
         this._bubbleSceneGuide.addEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
      }
      
      public function copyScene() : void
      {
         this._copySceneData = this.currentScene.serialize(-1,false);
      }
      
      public function get studioType() : String
      {
         return this._studioType;
      }
      
      public function enableRedo(param1:Boolean) : void
      {
         this.mainStage.enableRedo(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function get currDragSource() : DragSource
      {
         return this._currDragSource;
      }
      
      public function getThumbnailCaptures() : UtilHashArray
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:int = 0;
         _loc1_ = new UtilHashArray();
         _loc2_ = 0;
         while(_loc2_ < this._scenes.length)
         {
            _loc1_.push(String(_loc2_),null);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function onSceneComplete(param1:Event) : void
      {
         trace("onSceneComplete:" + param1);
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSceneComplete);
         this.addSceneOnDeserialize();
      }
      
      public function loadSingleCcChar(param1:String) : void
      {
         var _loc3_:URLRequest = null;
         anifire.core.Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
         _loc2_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
         _loc2_["count"] = 100;
         _loc2_["page"] = 0;
         _loc2_["is_cc"] = "Y";
         _loc2_["include_ids_only"] = param1;
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).dataFormat = URLLoaderDataFormat.BINARY;
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadSingleCcCharCompleted);
         _loc4_.load(_loc3_);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set publishW(param1:PublishWindow) : void
      {
         this._publishW = param1;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function get copySceneData() : String
      {
         return this._copySceneData;
      }
      
      public function set loadProgress(param1:Number) : void
      {
         this._loadProgress.visible = true;
         this._loadProgress.setProgress(param1,100);
      }
      
      public function removeScene(param1:anifire.core.AnimeScene) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this._scenes.getIndex(param1.id);
         this._scenes.remove(_loc2_,1);
      }
      
      public function showLogin() : void
      {
         ExternalInterface.call("startLoginProcess");
      }
      
      public function showSignup() : void
      {
         ExternalInterface.call("startSignupProcess");
      }
      
      private function showSaveMovieError(param1:CoreEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:GoAlert = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            _loc2_ = param1.getData() as String;
            _loc4_ = GoAlert(PopUpManager.createPopUp(this._currentScene.canvas,GoAlert,true));
            if(_loc2_ == ServerConstants.ERROR_CODE_SAVE_MOVIE_BLOCKED_BY_VIDEO_RECORDING)
            {
               _loc3_ = UtilDict.toDisplay("go","constant_save_movie_error_due_to_video_record");
               _loc4_.width = 400;
               _loc4_.height = 300;
            }
            else
            {
               _loc3_ = UtilDict.toDisplay("go","constant_connecterr");
            }
            _loc4_.showButton(false,true);
            _loc4_._txtDelete.htmlText = _loc3_;
            _loc4_._btnCancel.label = UtilDict.toDisplay("go","ok");
            _loc4_.x = (_loc4_.stage.width - _loc4_.width) / 2;
            _loc4_.y = 100;
         }
      }
      
      public function getViewStackWindow() : ViewStackWindow
      {
         return this._viewStackWindow;
      }
      
      public function loadUserTheme(param1:String = "prop") : void
      {
         var _loc3_:URLRequest = null;
         anifire.core.Console.getConsole().addEventListener(CoreEvent.LOAD_USER_ASSET_COMPLETE,this.onLoadUserThemeComplete);
         this._loaddingAssetType = param1;
         anifire.core.Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
         {
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_COMMUNITYASSETS);
            _loc2_["type"] = this._loaddingAssetType;
            if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextCommunityCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextCommunityBgPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
            {
               _loc2_["count"] = 24;
               _loc2_["page"] = this._nextCommunityPropPage;
               _loc2_["subtype"] = "";
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextCommunityCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundPage;
               _loc2_["inclde_files"] = 0;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundVoicePage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundEffectPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundMusicPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundTTSPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextCommunityEffectPage;
            }
         }
         else if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
         {
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
            _loc2_["type"] = this._loaddingAssetType;
            if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 20;
               if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) != "1")
               {
                  _loc2_["is_cc"] = "N";
               }
               _loc2_["page"] = this._nextUserCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserBgPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
            {
               _loc2_["count"] = 24;
               _loc2_["page"] = this._nextUserPropPage;
               _loc2_["subtype"] = "";
               _loc2_["excludesubtype"] = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundPage;
               _loc2_["include_files"] = 0;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundEffectPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundMusicPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundVoicePage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundTTSPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextUserEffectPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserVideoPropPage;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_PROP;
            }
            _loc2_["exclude_ids"] = this._newlyAddedAssetIds;
         }
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadUserAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      public function set goWalker(param1:GoWalker) : void
      {
         this._goWalker = param1;
      }
      
      public function get screenCapTool() : ScreenCapTool
      {
         return this._screenCapTool;
      }
      
      public function onGetCustomAssetCompleteByte(param1:ByteArray, param2:XML, param3:Boolean) : void
      {
         var sThumb:SoundThumb = null;
         var byte:ByteArray = param1;
         var my:XML = param2;
         var add:Boolean = param3;
         sThumb = new SoundThumb();
         this._uploadedAssetXML = my;
         sThumb.deSerializeByUserAssetXML(this._uploadedAssetXML,this.userTheme);
         sThumb.enable = true;
         sThumb.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,function():void
         {
            if(thumbTray.userAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               thumbTray.addSoundTileCell(sThumb);
               addNewlyAddedAssetId(_uploadedAssetXML.id);
            }
            if(_importer != null)
            {
               _importer["onLoadAssetCompleteHandler"](null);
            }
            thumbTray.gotoSpecifiedTabInMyGoodies("voiceover");
            if(add)
            {
               _console.createAsset(sThumb);
            }
         });
         sThumb.initSoundByByteArray(byte);
      }
      
      public function flipAsset() : void
      {
         var _loc2_:anifire.core.Asset = null;
         var _loc1_:anifire.core.AnimeScene = _console.currentScene;
         _loc2_ = _console.currentScene.selectedAsset;
         _loc2_.flipIt();
      }
      
      public function loadThemeProp(param1:String) : void
      {
         var _loc2_:anifire.core.Theme = null;
         if(this._themes.containsKey(param1))
         {
            _loc2_ = this.getTheme(param1);
         }
         else
         {
            _loc2_ = null;
            trace("Error: theme not found when loading bg zip with themeId:" + param1);
         }
         if(_loc2_.isPropZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/props",anifire.core.Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/props",anifire.core.Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeProp = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc2_.loadProp();
      }
      
      public function get currentScene() : anifire.core.AnimeScene
      {
         return this._currentScene;
      }
      
      public function onUserLoginCancel() : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_CANCEL,this));
      }
      
      public function setCurrentSceneVisible() : void
      {
         trace("set currentscene visible:" + this.currentScene.id);
         this.timeline.setSceneVisible(this.getSceneIndex(this.currentScene));
      }
      
      public function isGoWalkerOn() : Boolean
      {
         if(this.goWalker != null && this.goWalker.guideMode)
         {
            return true;
         }
         return false;
      }
      
      private function doInitFonts(param1:LoadMgrEvent) : void
      {
         var _loc2_:FontManager = null;
         var _loc3_:UtilLoadMgr = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Loader = null;
         var _loc7_:* = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitFonts);
         _loc2_ = FontManager.getFontManager();
         if(_loc2_.getFonts().length > 0)
         {
            _loc3_ = new UtilLoadMgr();
            _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadFontsDone);
            _loc5_ = 0;
            while(_loc5_ < _loc2_.getFonts().length)
            {
               _loc4_ = _loc2_.getFonts().getKey(_loc5_);
               (_loc6_ = new Loader()).name = _loc4_;
               _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoaded);
               _loc7_ = _loc2_.nameToFileName(_loc4_) + ".swf";
               _loc3_.addEventDispatcher(_loc6_.contentLoaderInfo,Event.COMPLETE);
               _loc6_.loadBytes(_loc2_.getFonts().getValueByKey(_loc4_));
               _loc5_++;
            }
            _loc3_.commit();
         }
         else
         {
            this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
         }
      }
      
      public function getNextScene(param1:anifire.core.AnimeScene) : anifire.core.AnimeScene
      {
         var _loc2_:int = 0;
         _loc2_ = this.getSceneIndex(param1);
         return this.getScene(_loc2_ + 1);
      }
      
      public function isUserAlreadyLogin() : Boolean
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         _loc1_ = Util.getFlashVar();
         _loc2_ = _loc1_.getValueByKey("userId");
         if(_loc2_ == null || _loc2_ == "")
         {
            return false;
         }
         return true;
      }
      
      public function doDeleScene() : void
      {
         var _loc1_:ICommand = null;
         if(this._currentScene.getNumberOfAssests() != 0 || this._scenes.length > 1)
         {
            _loc1_ = new RemoveSceneCommand();
            _loc1_.execute();
            if(this.stageScale > 1)
            {
               this.lookOut();
            }
            this.deleteCurrentScene();
            this._mainStage.callLater(this.setCurrentSceneVisible);
         }
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function updateSoundById(param1:String) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:AnimeSound = null;
         _loc2_ = this.getSoundInfoById(param1);
         _loc3_ = this.sounds.getValueByKey(param1) as AnimeSound;
         _loc3_.startFrame = UtilUnitConvert.pixelToFrame(_loc2_.startPixel);
         _loc3_.endFrame = UtilUnitConvert.pixelToFrame(_loc2_.startPixel + _loc2_.totalPixel);
         _loc3_.trackNum = UtilUnitConvert.pixelToTrack(_loc2_.y);
         _loc3_.inner_volume = _loc2_.inner_volume;
      }
      
      private function doLoadDefaultTheme(param1:CoreEvent) : void
      {
         var trayId:String;
         var xmlList:XMLList;
         var targetThemeCode:String = null;
         var event:CoreEvent = param1;
         this.removeEventListener(CoreEvent.LOAD_THEMELIST_COMPLETE,this.doLoadDefaultTheme);
         this._themeListXML = event.getData() as XML;
         this.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.doUpdateThumbTray);
         if(!anifire.core.Console.getConsole().isUserAlreadyLogin() && anifire.core.Console.getConsole().siteId == String(Global.BEN10))
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doShowNoSaveAlert);
         }
         trayId = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_DEFAULT_TRAYTHEME);
         xmlList = this._themeListXML.theme.(@id == trayId);
         if(trayId != null && xmlList.length() > 0)
         {
            targetThemeCode = trayId;
         }
         else
         {
            targetThemeCode = this._themeListXML.child("theme")[0].attribute("id");
         }
         if(anifire.core.Console.getConsole().isThemeCcRelated(targetThemeCode))
         {
            anifire.core.Console.getConsole().addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadMovie);
         }
         else
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMovie);
         }
         this._thumbTray.initThemeDropdown();
         if(trayId != null && xmlList.length() > 0)
         {
            this._thumbTray.initThemeChosenById(targetThemeCode);
         }
         else
         {
            this.loadTheme(targetThemeCode);
         }
      }
      
      public function checkSoundSpaceAtScene(param1:anifire.core.AnimeScene, param2:SoundThumb, param3:AnimeSound = null, param4:Boolean = false) : void
      {
         var _loc7_:GoAlert = null;
         var _loc5_:int = this.getSceneIndex(param1);
         var _loc6_:Point;
         if((_loc6_ = this.timeline.getEarliestSoundSpace(_loc5_)).x == -999)
         {
            if(!param4)
            {
               (_loc7_ = GoAlert(PopUpManager.createPopUp(this._currentScene.canvas,GoAlert,true)))._lblConfirm.text = "";
               _loc7_._txtDelete.text = UtilDict.toDisplay("go","timeline_soundexceed");
               _loc7_._btnDelete.visible = false;
               _loc7_._btnCancel.label = UtilDict.toDisplay("go","ok");
               _loc7_.x = (_loc7_.stage.width - _loc7_.width) / 2;
               _loc7_.y = 100;
            }
            return;
         }
         this.addSoundAtScene(param1,param2,_loc6_,param3);
      }
      
      private function LoadThemeComplete(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.LoadThemeComplete);
         var _loc2_:anifire.core.Theme = param1.getEventCreater() as anifire.core.Theme;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this,_loc2_));
         Util.gaTracking("/gostudio/themes/complete/" + _loc2_.id,anifire.core.Console.getConsole().mainStage.stage);
      }
      
      private function onSearchComplete(param1:Event) : void
      {
         var _loc4_:ZipFile = null;
         var _loc5_:XML = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:Thumb = null;
         var _loc11_:ZipEntry = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:ByteArray = null;
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:int = _loc2_.readByte();
         if(_loc3_ == 0)
         {
            _loc4_ = new ZipFile(_loc2_);
            _loc5_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            this._thumbTray.hasMoreSearch = _loc5_.@moreBg == "1" ? true : false;
            this._thumbTray.updateSearchCount(_loc5_.@all_asset_count);
            this._searchedTheme.clearAllThumbs();
            this._searchedTheme.deSerialize(_loc5_);
            _loc6_ = this._searchedTheme.backgroundThumbs;
            _loc7_ = this._searchedTheme.propThumbs;
            _loc8_ = this._searchedTheme.charThumbs;
            _loc9_ = this._searchedTheme.effectThumbs;
            _loc12_ = 0;
            while(_loc12_ < _loc6_.length)
            {
               _loc10_ = BackgroundThumb(_loc6_.getValueByIndex(_loc12_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
                  _loc10_.thumbImageData = _loc4_.getInput(_loc11_);
               }
               _loc12_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc7_.length)
            {
               _loc10_ = PropThumb(_loc7_.getValueByIndex(_loc13_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc13_++;
            }
            _loc14_ = 0;
            while(_loc14_ < _loc8_.length)
            {
               _loc10_ = CharThumb(_loc8_.getValueByIndex(_loc14_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc14_++;
            }
            _loc15_ = 0;
            while(_loc15_ < _loc9_.length)
            {
               _loc10_ = EffectThumb(_loc9_.getValueByIndex(_loc15_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc15_++;
            }
            this.addTheme(this._searchedTheme.id,this._searchedTheme);
            this._thumbTray.loadThumbs(this._searchedTheme);
         }
         else
         {
            _loc16_ = new ByteArray();
            _loc2_.readBytes(_loc16_);
            _logger.error("search community assets failed: \n" + _loc16_.toString());
            Alert.show("search community assets failed: \n" + _loc16_.toString());
         }
      }
      
      public function get selectedThumbnailIndex() : int
      {
         return this._selectedThumbnailIndex;
      }
      
      public function get siteId() : String
      {
         return this._siteId;
      }
      
      public function closePublishWindow() : void
      {
         if(this._publishW != null)
         {
            PopUpManager.removePopUp(this._publishW);
            this.publishW = null;
         }
      }
      
      public function set currDragObject(param1:anifire.core.Asset) : void
      {
         this._currDragObject = param1;
      }
      
      private function onLoadUserAssetsComplete(param1:Event) : void
      {
         var _loc5_:ZipFile = null;
         var _loc6_:XML = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:UtilHashArray = null;
         var _loc18_:UtilHashArray = null;
         var _loc19_:UtilHashArray = null;
         var _loc20_:UtilHashArray = null;
         var _loc21_:UtilHashArray = null;
         var _loc22_:Thumb = null;
         var _loc23_:ZipEntry = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:TipWindow = null;
         var _loc34_:GlowFilter = null;
         var _loc35_:Array = null;
         var _loc36_:ByteArray = null;
         var _loc37_:ZipFile = null;
         var _loc38_:int = 0;
         var _loc39_:ZipEntry = null;
         var _loc40_:ByteArray = null;
         var _loc41_:UtilHashArray = null;
         var _loc42_:Object = null;
         var _loc43_:UtilCrypto = null;
         var _loc44_:ByteArray = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int = _loc3_.readByte();
         trace("returnCode:" + _loc4_);
         if(_loc4_ == 0)
         {
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            _loc5_ = new ZipFile(_loc3_);
            _loc6_ = new XML(_loc5_.getInput(_loc5_.getEntry("desc.xml")));
            _loc7_ = Number(_loc6_.@all_asset_count) > 0 ? true : false;
            if(this.tipsLayer.numChildren == 0 && !_loc7_ && this.studioType == FULL_STUDIO && this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               (_loc33_ = new TipWindow()).width = 380;
               _loc33_.height = 296;
               _loc33_.x = 240;
               _loc33_.y = 152;
               _loc34_ = new GlowFilter(3355443,1,6,6);
               (_loc35_ = new Array()).push(_loc34_);
               _loc33_.filters = _loc35_;
               _loc33_.addEventListener(Event.COMPLETE,this.initThemeTip);
               this.tipsLayer.addChild(_loc33_);
            }
            _loc8_ = _loc6_.@moreBg == "1" ? true : false;
            _loc9_ = _loc6_.@moreProp == "1" ? true : false;
            _loc10_ = _loc6_.@moreVideoProp == "1" ? true : false;
            _loc11_ = _loc6_.@moreChar == "1" ? true : false;
            _loc12_ = _loc6_.@moreFx == "1" ? true : false;
            _loc13_ = _loc6_.@moreVoice == "1" ? true : false;
            _loc14_ = _loc6_.@moreEffect == "1" ? true : false;
            _loc15_ = _loc6_.@moreMusic == "1" ? true : false;
            _loc16_ = _loc6_.@moreTTS == "1" ? true : false;
            _loc24_ = 0;
            _loc25_ = 0;
            _loc26_ = 0;
            _loc27_ = 0;
            _loc28_ = 0;
            Util.gaTracking("/gostudio/" + this.thumbTray.assetTheme + "/complete/" + this._loaddingAssetType,anifire.core.Console.getConsole().mainStage.stage);
            if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
            {
               _loc24_ = this._communityTheme.backgroundThumbs.length;
               _loc25_ = this._communityTheme.propThumbs.length;
               _loc26_ = this._communityTheme.charThumbs.length;
               _loc27_ = this._communityTheme.effectThumbs.length;
               this._communityTheme.deSerialize(_loc6_);
               this._lastLoaddedTheme.clearAllThumbs();
               this._lastLoaddedTheme.deSerialize(_loc6_);
               _loc17_ = this._lastLoaddedTheme.backgroundThumbs;
               _loc18_ = this._lastLoaddedTheme.propThumbs;
               _loc19_ = this._lastLoaddedTheme.charThumbs;
               _loc20_ = this._lastLoaddedTheme.effectThumbs;
               _loc21_ = this._lastLoaddedTheme.videoPropThumbs;
            }
            else if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               _loc24_ = this.userTheme.backgroundThumbs.length;
               _loc25_ = this.userTheme.propThumbs.length;
               _loc26_ = this.userTheme.charThumbs.length;
               _loc27_ = this.userTheme.effectThumbs.length;
               _loc28_ = this.userTheme.videoPropThumbs.length;
               this._userTheme.deSerialize(_loc6_);
               this._lastLoaddedTheme.clearAllThumbs();
               this._lastLoaddedTheme.deSerialize(_loc6_);
               _loc17_ = this._lastLoaddedTheme.backgroundThumbs;
               _loc18_ = this._lastLoaddedTheme.propThumbs;
               _loc19_ = this._lastLoaddedTheme.charThumbs;
               _loc20_ = this._lastLoaddedTheme.effectThumbs;
               _loc21_ = this._lastLoaddedTheme.videoPropThumbs;
            }
            _loc29_ = 0;
            while(_loc29_ < _loc17_.length)
            {
               _loc22_ = BackgroundThumb(_loc17_.getValueByIndex(_loc29_));
               if((_loc23_ = _loc5_.getEntry(_loc22_.getFileName())) != null)
               {
                  _loc22_.imageData = _loc5_.getInput(_loc23_);
                  _loc22_.thumbImageData = _loc5_.getInput(_loc23_);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     BackgroundThumb(this._userTheme.backgroundThumbs.getValueByIndex(_loc29_ + _loc24_)).imageData = _loc5_.getInput(_loc23_);
                     BackgroundThumb(this._userTheme.backgroundThumbs.getValueByIndex(_loc29_ + _loc24_)).thumbImageData = _loc5_.getInput(_loc23_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     BackgroundThumb(this._communityTheme.backgroundThumbs.getValueByIndex(_loc29_ + _loc24_)).imageData = _loc5_.getInput(_loc23_);
                     BackgroundThumb(this._communityTheme.backgroundThumbs.getValueByIndex(_loc29_ + _loc24_)).thumbImageData = _loc5_.getInput(_loc23_);
                  }
               }
               _loc29_++;
            }
            _loc30_ = 0;
            while(_loc30_ < _loc18_.length)
            {
               _loc22_ = PropThumb(_loc18_.getValueByIndex(_loc30_));
               _loc23_ = _loc5_.getEntry(_loc22_.getFileName());
               trace("[thumb.id, thumb.getFileName(),entry]:" + [_loc22_.id,_loc22_.getFileName(),_loc23_]);
               if(_loc23_ != null)
               {
                  _loc22_.imageData = _loc5_.getInput(_loc23_);
                  trace("thumb.id:" + _loc22_.id);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     PropThumb(this._userTheme.propThumbs.getValueByKey(_loc22_.id)).imageData = _loc5_.getInput(_loc23_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     PropThumb(this._communityTheme.propThumbs.getValueByIndex(_loc30_ + _loc25_)).imageData = _loc5_.getInput(_loc23_);
                  }
               }
               _loc30_++;
            }
            _loc30_ = 0;
            while(_loc30_ < _loc21_.length)
            {
               _loc22_ = VideoPropThumb(_loc21_.getValueByIndex(_loc30_));
               _loc23_ = _loc5_.getEntry(_loc22_.getFileName());
               trace("[thumb.id, thumb.getFileName(),entry]:" + [_loc22_.id,_loc22_.getFileName(),_loc23_]);
               if(_loc23_ != null)
               {
                  _loc22_.imageData = _loc5_.getInput(_loc23_);
                  trace("thumb.id:" + _loc22_.id);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     PropThumb(this._userTheme.videoPropThumbs.getValueByKey(_loc22_.id)).imageData = _loc5_.getInput(_loc23_);
                  }
               }
               _loc30_++;
            }
            _loc31_ = 0;
            while(_loc31_ < _loc19_.length)
            {
               _loc22_ = CharThumb(_loc19_.getValueByIndex(_loc31_));
               if((_loc23_ = _loc5_.getEntry(_loc22_.getFileName())) != null)
               {
                  if(!CharThumb(_loc22_).isCC)
                  {
                     _loc22_.imageData = _loc5_.getInput(_loc23_);
                     if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                     {
                        trace("thumb.getFileName():" + _loc22_.getFileName());
                        CharThumb(this._userTheme.charThumbs.getValueByKey(_loc22_.id)).imageData = _loc5_.getInput(_loc23_);
                     }
                     else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                     {
                        CharThumb(this._communityTheme.charThumbs.getValueByIndex(_loc31_ + _loc26_)).imageData = _loc5_.getInput(_loc23_);
                     }
                  }
                  else if(_loc23_ != null)
                  {
                     _loc36_ = _loc5_.getInput(_loc23_);
                     _loc37_ = new ZipFile(_loc36_);
                     _loc41_ = new UtilHashArray();
                     _loc42_ = new Object();
                     _loc38_ = 0;
                     while(_loc38_ < _loc37_.size)
                     {
                        if((_loc39_ = _loc37_.entries[_loc38_]).name == PlayerConstant.CHAR_XML_FILENAME)
                        {
                           _loc42_["xml"] = new XML(_loc37_.getInput(_loc39_).toString());
                        }
                        else if(_loc39_.name.substr(_loc39_.name.length - 3,3).toLowerCase() == "swf")
                        {
                           _loc40_ = _loc37_.getInput(_loc39_);
                           (_loc43_ = new UtilCrypto()).decrypt(_loc40_);
                           _loc41_.push(_loc39_.name,_loc40_);
                        }
                        _loc38_++;
                     }
                     _loc42_["imageData"] = _loc41_;
                     _loc22_.imageData = _loc42_;
                  }
               }
               _loc31_++;
            }
            _loc32_ = 0;
            while(_loc32_ < _loc20_.length)
            {
               _loc22_ = EffectThumb(_loc20_.getValueByIndex(_loc32_));
               if((_loc23_ = _loc5_.getEntry(_loc22_.getFileName())) != null)
               {
                  _loc22_.imageData = _loc5_.getInput(_loc23_);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     EffectThumb(this._userTheme.effectThumbs.getValueByIndex(_loc32_ + _loc27_)).imageData = _loc5_.getInput(_loc23_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     EffectThumb(this._communityTheme.effectThumbs.getValueByIndex(_loc32_ + _loc27_)).imageData = _loc5_.getInput(_loc23_);
                  }
               }
               _loc32_++;
            }
            if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               this._userTheme.mergeTheme(this._lastLoaddedTheme);
               this.addTheme(this._userTheme.id,this._userTheme);
               if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
               {
                  this._thumbTray.hasMoreUserBg = _loc8_;
                  ++this._nextUserBgPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
               {
                  this._thumbTray.hasMoreUserProp = _loc9_;
                  ++this._nextUserPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  this._thumbTray.hasMoreUserVideoProp = _loc10_;
                  ++this._nextUserVideoPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this._thumbTray.hasMoreUserChar = _loc11_;
                  ++this._nextUserCharPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
               {
                  this._thumbTray.hasMoreUserSoundEffect = _loc14_;
                  ++this._nextUserSoundEffectPage;
                  this._thumbTray.hasMoreUserSoundMusic = _loc15_;
                  ++this._nextUserSoundMusicPage;
                  this._thumbTray.hasMoreUserSoundVoice = _loc13_;
                  ++this._nextUserSoundVoicePage;
                  this._thumbTray.hasMoreUserSoundTTS = _loc16_;
                  ++this._nextUserSoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  this._thumbTray.hasMoreUserSoundEffect = _loc14_;
                  ++this._nextUserSoundEffectPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  this._thumbTray.hasMoreUserSoundMusic = _loc15_;
                  ++this._nextUserSoundMusicPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  this._thumbTray.hasMoreUserSoundVoice = _loc13_;
                  ++this._nextUserSoundVoicePage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  this._thumbTray.hasMoreUserSoundTTS = _loc16_;
                  ++this._nextUserSoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
               {
                  this._thumbTray.hasMoreUserEffect = _loc12_;
                  ++this._nextUserEffectPage;
               }
               this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
               this._thumbTray.loadThumbs(this._lastLoaddedTheme);
            }
            else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
            {
               this._communityTheme.mergeTheme(this._lastLoaddedTheme);
               this.addTheme(this._communityTheme.id,this._communityTheme);
               if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
               {
                  this._thumbTray.hasMoreCommunityBg = _loc8_;
                  ++this._nextCommunityBgPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
               {
                  this._thumbTray.hasMoreCommunityProp = _loc9_;
                  ++this._nextCommunityPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this._thumbTray.hasMoreCommunityChar = _loc11_;
                  ++this._nextCommunityCharPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
               {
                  this._thumbTray.hasMoreCommunitySoundEffect = _loc14_;
                  ++this._nextCommunitySoundEffectPage;
                  this._thumbTray.hasMoreCommunitySoundMusic = _loc15_;
                  ++this._nextCommunitySoundMusicPage;
                  this._thumbTray.hasMoreCommunitySoundVoice = _loc13_;
                  ++this._nextCommunitySoundVoicePage;
                  this._thumbTray.hasMoreCommunitySoundTTS = _loc16_;
                  ++this._nextCommunitySoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  this._thumbTray.hasMoreCommunitySoundEffect = _loc14_;
                  ++this._nextCommunitySoundEffectPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  this._thumbTray.hasMoreCommunitySoundMusic = _loc15_;
                  ++this._nextCommunitySoundMusicPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  this._thumbTray.hasMoreCommunitySoundVoice = _loc13_;
                  ++this._nextCommunitySoundVoicePage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  this._thumbTray.hasMoreCommunitySoundTTS = _loc16_;
                  ++this._nextCommunitySoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
               {
                  this._thumbTray.hasMoreCommunityEffect = _loc12_;
                  ++this._nextCommunityEffectPage;
               }
               this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
               this._thumbTray.loadThumbs(this._lastLoaddedTheme);
            }
            if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
            }
            else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this));
            }
         }
         else
         {
            _loc44_ = new ByteArray();
            _loc2_.readBytes(_loc44_);
            _logger.error("getUserAssets failed: \n" + _loc44_.toString());
            Alert.show("getUserAssets failed: \n" + _loc44_.toString());
         }
      }
      
      public function customAssetUploadCompleteHandler(param1:String, param2:String) : void
      {
         var idWithExtension:String = null;
         var idWithoutExt:String = null;
         var errorCode:String = null;
         var errorXML:XML = null;
         var returnData:String = param1;
         var ttype:String = param2;
         var checkCode:String = returnData.substr(0,1);
         if(checkCode == "0")
         {
            this._uploadType = ttype;
            this._uploadedAssetXML = new XML(returnData.substr(1));
            trace("_uploadedAssetXML:" + this._uploadedAssetXML);
            if(this._importer == null || !Boolean(this._importer["oldChar"]))
            {
               if(this._uploadedAssetXML.name() == "effect")
               {
                  idWithExtension = this._uploadedAssetXML.@id;
                  idWithoutExt = String(idWithExtension.split(".")[0]);
                  this.addNewlyAddedAssetId(idWithoutExt);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
               else if(this._uploadedAssetXML.child("subtype") == "video")
               {
                  trace("add asset");
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.buildVideoThumb(this._uploadedAssetXML);
                  this.thumbTray.onLoadUserPropComplete();
               }
               else if(this._uploadedAssetXML.child("id").length() > 0)
               {
                  this._assetId = this._uploadedAssetXML.id;
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.getUserAssetById(this._uploadedAssetXML.child("id")[0]);
               }
               else
               {
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.@id);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
            }
            else
            {
               this.getUserCharById(this._importer["charId"]);
            }
         }
         else
         {
            errorCode = "";
            try
            {
               errorXML = new XML(returnData.substr(1));
               errorCode = errorXML.child("code");
            }
            catch(e:Error)
            {
            }
            if(errorCode == ServerConstants.ERROR_CODE_UNSUPPORTED_IMAGE_FORMAT)
            {
               Alert.show("The image format is not supported.");
            }
            else
            {
               Alert.show("Error occur during the upload process. Let\'s try again later.","Checkcode " + checkCode);
            }
            _logger.error("return code is:" + checkCode + "\n error message: \n" + returnData.substr(1));
         }
      }
      
      public function getWhiteTerms() : Array
      {
         if(this._whiteTerms != null)
         {
            return this._whiteTerms;
         }
         return null;
      }
      
      public function freezeCurrentScene(param1:Event) : void
      {
      }
      
      public function showCreateMyChar(param1:Event = null) : void
      {
         trace("showmyChar");
         navigateToURL(new URLRequest(ServerConstants.CC_PAGE_PATH),"_top");
      }
      
      public function getScene(param1:int) : anifire.core.AnimeScene
      {
         if(param1 < 0 || param1 >= this._scenes.length)
         {
            return null;
         }
         return this._scenes.getValueByIndex(param1);
      }
      
      private function removeNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = VBox(param1.currentTarget);
         if(_loc2_ != null && _loc2_.parent != null && Boolean(_loc2_.parent.contains(_loc2_)))
         {
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      public function serialize(param1:Boolean = true) : XML
      {
         var _loc2_:int = 0;
         this._previewData.removeAll();
         var _loc3_:* = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<film copyable=\"" + (this.isCopyable ? "1" : "0") + "\" duration=\"" + Util.roundNum(this.timeline.getTotalTimeInSec()) + "\" published=\"" + (this.published ? "1" : "0") + (!this.published ? "\" pshare=\"" + (this.privateShared ? "1" : "0") : "") + "\">";
         this.metaData.mver = AnimeConstants.MOVIE_VERSION;
         _loc3_ += this.metaData.serialize();
         var _loc4_:int = this._scenes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ += AnimeScene(this._scenes.getValueByIndex(_loc2_)).serialize(_loc2_,param1);
            _loc2_++;
         }
         _loc3_ += this.serializeSound(param1);
         _loc3_ += "</film>";
         return new XML(_loc3_);
      }
      
      public function showBubbleMsgWindow(param1:BubbleThumb, param2:BubbleAsset) : void
      {
         var _loc3_:int = 0;
         var _loc8_:SoundThumb = null;
         var _loc10_:BubbleMsgChooserItem = null;
         var _loc11_:SoundThumb = null;
         var _loc12_:String = null;
         var _loc4_:BubbleMsgChooser = PopUpManager.createPopUp(this.mainStage,BubbleMsgChooser,true) as BubbleMsgChooser;
         var _loc5_:Array = PresetMsg.getInstance().getMsgArray(param1.theme.id);
         var _loc6_:UtilHashArray = anifire.core.Console.getConsole().getTheme(param1.theme.id).soundThumbs;
         var _loc7_:UtilHashArray = new UtilHashArray();
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc8_ = _loc6_.getValueByIndex(_loc3_) as SoundThumb;
            _loc7_.push(_loc8_.name,_loc8_);
            _loc3_++;
         }
         var _loc9_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc12_ = _loc5_[_loc3_] as String;
            _loc11_ = _loc7_.getValueByKey(_loc12_);
            _loc10_ = new BubbleMsgChooserItem(_loc12_,(_loc3_ + 1).toString() + ") " + _loc12_,true,param2,_loc11_ != null,_loc11_);
            _loc9_.push(_loc10_);
            _loc3_++;
         }
         _loc4_.init(_loc9_);
         _loc4_.x = (this.mainStage.stage.width - _loc4_.width) / 2;
         _loc4_.y = this.mainStage.y;
         _loc4_.addEventListener(BubbleMsgEvent.ITEM_CHOOSEN,this.onBubbleMsgChoosen);
      }
      
      public function removeSound(param1:String) : void
      {
         var _loc2_:AnimeSound = AnimeSound(this.sounds.getValueByKey(param1));
         if(_loc2_ != null)
         {
            _loc2_.stopSound();
         }
         this.sounds.remove(this.sounds.getIndex(param1),1);
         this.timeline.removeSoundById(param1);
      }
      
      public function pauseMovie() : void
      {
         trace("c movie");
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).pauseMovie();
         }
      }
      
      public function beforeDoAddScene() : void
      {
         this.mainStage._btnAddScene.buttonMode = this.mainStage._btnDelScene.buttonMode = false;
         if(this.stageScale > 1)
         {
            this.lookOut();
         }
         if(this.myAnimatedMask.isplaying)
         {
            this.myAnimatedMask.stopDrawing();
         }
         this.myAnimatedMask.addEventListener("EventFinished",this.rdyToAddScene);
         this.myAnimatedMask.startDrawing(this.mainStage._addSceneEffContainer);
      }
      
      public function set groupController(param1:anifire.core.GroupController) : void
      {
         this._groupController = param1;
      }
      
      public function get myAnimatedMask() : anifire.core.AnimatedMask
      {
         return this._myAnimatedMask;
      }
      
      private function setBadTerms(param1:String) : void
      {
         this._badTerms = param1.split(",");
      }
      
      public function get isLoaddingCommonThemeChar() : Boolean
      {
         return this._isLoaddingCommonThemeChar;
      }
      
      public function editAsset(param1:MouseEvent = null) : void
      {
         var _loc3_:anifire.core.Asset = null;
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
            }
         }
         var _loc2_:anifire.core.AnimeScene = _console.currentScene;
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ is EffectAsset)
         {
            (_loc3_ as EffectAsset).showInfoWindow();
         }
      }
      
      public function get isLoaddingCommonThemeProp() : Boolean
      {
         return this._isLoaddingCommonThemeProp;
      }
      
      public function updateAssetTime(param1:String, param2:Number, param3:Number, param4:Number = -1, param5:Number = -1) : void
      {
         var _loc6_:anifire.core.Asset;
         if((_loc6_ = anifire.core.Console.getConsole().currentScene.getAssetById(param1)) is BubbleAsset)
         {
            (_loc6_ as BubbleAsset).sttime = param2;
            (_loc6_ as BubbleAsset).edtime = param3;
         }
         else if(_loc6_ is EffectAsset)
         {
            (_loc6_ as EffectAsset).sttime = param2;
            (_loc6_ as EffectAsset).edtime = param3;
            if((_loc6_.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase())
            {
               (_loc6_ as EffectAsset).stzoom = param4;
               (_loc6_ as EffectAsset).edzoom = param5;
            }
         }
         this.onUpdateAssetComplete();
      }
      
      public function get currentSceneId() : String
      {
         if(this._currentScene != null)
         {
            return this._currentScene.id;
         }
         return null;
      }
      
      public function doUpdateTimelineByScene(param1:anifire.core.AnimeScene, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BitmapData = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Matrix = null;
         var _loc9_:Number = NaN;
         var _loc10_:BitmapData = null;
         var _loc11_:Rectangle = null;
         if(param1 != null)
         {
            this.timeline.setSceneTarget(param1.canvas,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            _loc3_ = this.getSceneIndex(param1);
            _loc5_ = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
            if(param1.sizingAsset != null)
            {
               _loc11_ = new Rectangle(param1.sizingAsset.x,param1.sizingAsset.y,param1.sizingAsset.width,param1.sizingAsset.height);
               _loc4_ = Util.capturePicture(param1.canvas,_loc11_);
            }
            else
            {
               _loc4_ = Util.capturePicture(param1.canvas,_loc5_);
            }
            _loc6_ = 220;
            _loc7_ = 141;
            _loc8_ = new Matrix();
            _loc9_ = _loc6_ / _loc4_.width;
            _loc10_ = new BitmapData(_loc6_,_loc7_);
            (_loc8_ = new Matrix()).scale(_loc9_,_loc9_);
            _loc10_.draw(_loc4_,_loc8_,null,null,null,true);
            this.timeline.updateSceneImageByBitmapData(_loc3_,_loc10_);
         }
      }
      
      public function set uploadedAssetXML(param1:XML) : void
      {
         this._uploadedAssetXML = param1;
      }
      
      private function doNavigateToPlayerPage(param1:Event) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:String = null;
         var _loc6_:RegExp = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.doNavigateToPlayerPage);
         _loc2_ = new URLVariables();
         _loc4_ = Util.getFlashVar();
         Util.gaTracking("/gostudio/close",anifire.core.Console.getConsole().mainStage.stage);
         if(_loc4_.containsKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID))
         {
            _loc2_[ServerConstants.SERVER_PLAYER_PARAM_USER_ID] = _loc4_.getValueByKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID) as String;
         }
         _loc5_ = _loc4_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String;
         _loc6_ = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc5_ = _loc5_.replace(_loc6_,this.metaData.movieId);
         _loc3_ = new URLRequest(_loc5_ + _loc2_.toString());
         navigateToURL(_loc3_,"_top");
      }
      
      private function buildVideoThumb(param1:XML) : void
      {
         var _loc5_:ThumbnailCanvas = null;
         this._holdable = false;
         this._headable = false;
         this._placeable = true;
         var _loc2_:VideoPropThumb = new VideoPropThumb();
         _loc2_.id = this._uploadedAssetXML.file;
         _loc2_.name = this._uploadedAssetXML.title;
         _loc2_.theme = anifire.core.Console.getConsole().userTheme;
         VideoPropThumb(_loc2_).subType = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         VideoPropThumb(_loc2_).placeable = true;
         VideoPropThumb(_loc2_).holdable = false;
         VideoPropThumb(_loc2_).headable = false;
         VideoPropThumb(_loc2_).facing = AnimeConstants.FACING_LEFT;
         _loc2_.enable = true;
         _loc2_.tags = this._uploadedAssetXML.tags;
         _loc2_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
         _loc2_.videoHeight = Number(this._uploadedAssetXML.height);
         _loc2_.videoWidth = Number(this._uploadedAssetXML.width);
         this.userTheme.addThumb(_loc2_,UtilXmlInfo.convertUploadedAssetXmlToThumbXml(param1));
         var _loc3_:Image = new Image();
         var _loc4_:DisplayObject = VideoPropThumb(_loc2_).loadThumbnail();
         _loc3_.addChild(_loc4_);
         _loc5_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc2_,true,false,this._purchaseEnabled,"",true,0,false,true);
         _loc5_.name = _loc5_.toolTip = _loc2_.name;
         this.thumbTray._uiTileVideoPropUser.addChild(_loc5_);
         if(this._importer != null)
         {
            this._importer["success"]();
            this.currentScene.playScene();
         }
      }
      
      public function flipCCLookAtCamera() : void
      {
         var _loc2_:anifire.core.Asset = null;
         var _loc3_:Character = null;
         var _loc1_:anifire.core.AnimeScene = _console.currentScene;
         _loc2_ = _console.currentScene.selectedAsset;
         if(_loc2_ is Character)
         {
            _loc3_ = Character(_loc2_);
            if(CharThumb(_loc3_.thumb).isCC)
            {
               trace("Console::flipCCLookAtCamera");
               _loc3_.toggleLookAtCamera();
            }
         }
      }
      
      private function set isCopyable(param1:Boolean) : void
      {
         this._isCopyable = param1;
      }
      
      public function removeSceneByIndex(param1:int) : void
      {
         this._scenes.remove(param1,1);
      }
      
      private function enableAfterSave() : void
      {
         this.requestLoadStatus(false,true);
         if(this._isAutoSave)
         {
            this._topButtonBar._btnSave.enabled = true;
            this._topButtonBar._btnSave.buttonMode = true;
            this._topButtonBar.currentState = "";
         }
         if(!this._isAutoSave)
         {
            if(this._publishW != null)
            {
               this.closePublishWindow();
            }
            if(this._viewStackWindow != null && !this._redirect)
            {
               this.doContinueEdit();
            }
         }
      }
      
      private function onLoadUserThemeComplete(param1:Event) : void
      {
         if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this.thumbTray.onLoadUserPropComplete();
         }
      }
      
      public function hideGuideSceneBub(param1:Event = null) : void
      {
         if(this._bubbleSceneGuide != null)
         {
            this._mainStage._btnAddScene.removeEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
            this._bubbleSceneGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
            this.hideGuideBubble(this._bubbleSceneGuide);
         }
      }
      
      public function get goWalker() : GoWalker
      {
         return this._goWalker;
      }
      
      private function onSoundClickHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:AnimeSound = null;
         var _loc4_:Timeline = null;
         var _loc5_:SoundContainer = null;
         _loc2_ = param1.id;
         _loc3_ = this.sounds.getValueByKey(_loc2_) as AnimeSound;
         _loc4_ = Timeline(param1.currentTarget);
         _loc5_ = param1.soundContainer;
         _loc3_.showMenu(_loc4_.stage.mouseX,_loc4_.stage.mouseY,_loc5_);
      }
      
      private function initThemeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,5,5,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_tipstheme");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",15);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).percentWidth = 85;
         _loc5_.setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","left");
         _loc5_.setStyle("horizontalCenter","1");
         var _loc6_:Text;
         (_loc6_ = new Text()).percentWidth = 100;
         _loc6_.text = UtilDict.toDisplay("go","thumbtray_tipsthemecontent");
         _loc6_.setStyle("fontSize",16);
         var _loc7_:Canvas;
         (_loc7_ = new Canvas()).width = 300;
         _loc7_.height = 110;
         _loc7_.styleName = "imgThemeArrow";
         _loc5_.addChild(_loc6_);
         _loc5_.addChild(_loc7_);
         _loc2_.setContent(_loc5_);
         var _loc8_:Canvas;
         (_loc8_ = new Canvas()).width = _loc2_.width;
         _loc8_.setStyle("horizontalCenter","1");
         _loc8_.buttonMode = true;
         var _loc9_:Label;
         (_loc9_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colorclose");
         _loc9_.buttonMode = true;
         _loc9_.useHandCursor = true;
         _loc9_.mouseChildren = false;
         _loc9_.x = (_loc8_.width - 80) / 2;
         _loc9_.setStyle("fontSize",14);
         _loc9_.addEventListener(MouseEvent.CLICK,this.closeThemeTip);
         _loc8_.addChild(_loc9_);
         _loc2_.setClose(_loc8_);
      }
      
      public function subPoints(param1:Array) : void
      {
         this._moneyPoints -= param1[0];
         this._sharingPoints -= param1[1];
      }
      
      public function get tempMetaData() : anifire.core.MetaData
      {
         return this._tempMetaData;
      }
      
      public function addSoundAtScene(param1:anifire.core.AnimeScene, param2:SoundThumb, param3:Point, param4:AnimeSound = null, param5:Boolean = true) : void
      {
         var _loc8_:ICommand = null;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:UtilLoadMgr = null;
         var _loc12_:AnimeSound = null;
         var _loc13_:Array = null;
         var _loc6_:int = this.getSceneIndex(param1);
         var _loc7_:ElementInfo = this.timeline.getSceneInfoByIndex(_loc6_);
         if(param2.sound != null && param2.sound.getIsReadyToPlay() && param2.lengthFrame != -1)
         {
            if(param4 == null)
            {
               (param4 = new AnimeSound()).init(param2,UtilUnitConvert.pixelToFrame(param3.x),UtilUnitConvert.pixelToFrame(param3.x) + param2.lengthFrame,null,UtilUnitConvert.pixelToTrack(param3.y));
               if(anifire.core.Console.getConsole().publishW != null)
               {
                  this.addSound(param4,param3.x,param3.y,-1,true);
                  this.timeline.setSoundInfoById(param4.getID(),0,this.timeline.getTotalTimeInPixel());
               }
               else
               {
                  this.addSound(param4,param3.x,param3.y,-1,true);
               }
            }
            else
            {
               _loc9_ = this.timeline.getSoundIndexById(param4.getID());
               this.sounds.push(param4.getID(),param4);
               if((_loc10_ = this._timeline.getNextSoundOnSameTrack(param3.y,param3.x)) < UtilUnitConvert.secToPixel(param2.duration / 1000))
               {
                  param4.startFrame = UtilUnitConvert.pixelToFrame(param3.x);
                  param4.endFrame = UtilUnitConvert.pixelToFrame(param3.x) + UtilUnitConvert.pixelToFrame(_loc10_);
               }
               else
               {
                  param4.startFrame = UtilUnitConvert.pixelToFrame(param3.x);
                  param4.endFrame = UtilUnitConvert.pixelToFrame(param3.x) + UtilUnitConvert.secToFrame(param2.duration / 1000);
               }
               param4.trackNum = UtilUnitConvert.pixelToTrack(param3.y);
               this.timeline.setSoundReadyByID(param4.getID());
               if(anifire.core.Console.getConsole().publishW != null)
               {
                  this.timeline.setSoundInfoById(param4.getID(),0,this.timeline.getTotalTimeInPixel());
               }
               else
               {
                  this.timeline.setSoundInfoById(param4.getID(),param3.x,UtilUnitConvert.frameToPixel(param4.endFrame - param4.startFrame),param4.getLabel(),UtilUnitConvert.trackToPixel(param4.trackNum));
               }
               this.stopAllSounds();
            }
            this.requestLoadStatus(false);
            if(param5)
            {
               this._thumbTray.stopAllSounds();
               param4.playSound();
            }
            (_loc8_ = new AddSoundCommand(param4)).execute();
         }
         else
         {
            _loc11_ = new UtilLoadMgr();
            (_loc12_ = new AnimeSound()).init(param2,0,UtilUnitConvert.secToPixel(param2.duration / 1000));
            this.timeline.addSoundAtTime(_loc12_.getID(),"Loading ... " + _loc12_.getLabel(),param3.x,param3.y,UtilUnitConvert.secToPixel(param2.duration / 1000),-1,false,false,param2.duration / 1000);
            (_loc13_ = new Array()).push(param1);
            _loc13_.push(param2);
            _loc13_.push(_loc12_);
            _loc13_.push(param3);
            _loc11_.setExtraData(_loc13_);
            _loc11_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc11_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doAddSoundAtSceneAgain);
            _loc11_.commit();
            this.requestLoadStatus(true);
            param2.initSoundFromNetwork();
         }
         if(this.isGoWalkerOn())
         {
            this.dispatchGoWalkerEvent(10);
         }
      }
      
      public function get metaData() : anifire.core.MetaData
      {
         return this._metaData;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set isCommonThemeLoadded(param1:Boolean) : void
      {
         this._isCommonThemeLoadded = param1;
      }
      
      public function createAsset(param1:Object) : void
      {
         if(this._currentScene != null)
         {
            this._currentScene.createAsset(param1 as Thumb);
         }
      }
      
      private function doUpdateThumbTray(param1:CoreEvent) : void
      {
         var _loc2_:anifire.core.Theme = param1.getData() as anifire.core.Theme;
         this.addTheme(_loc2_.id,_loc2_);
         if(_loc2_.id != "common")
         {
            this.setCurTheme(_loc2_);
            this._thumbTray.themeId = _loc2_.id;
         }
         if(_loc2_.id == "common")
         {
            this._isCommonThemeLoadded = true;
         }
         this._thumbTray.loadThumbs(_loc2_);
      }
      
      public function putData(param1:String, param2:Object) : void
      {
         if(this._previewData == null)
         {
            this._previewData = new UtilHashArray();
         }
         if(!this._previewData.containsKey(param1))
         {
            this._previewData.push(param1,param2,true);
         }
         else
         {
            this._previewData.replaceValueByKey(param1,param2);
         }
      }
      
      private function removeGuideBubbleAfterFade(param1:Event) : void
      {
         var _loc2_:Fade = null;
         var _loc3_:Image = null;
         _loc2_ = param1.target as Fade;
         _loc3_ = _loc2_.target as Image;
         this.thumbTray.parent.removeChild(_loc3_);
         if(_loc3_ == this._bubbleThumbGuide)
         {
            this._bubbleThumbGuide = null;
         }
         if(_loc3_ == this._bubbleSceneGuide)
         {
            this._bubbleSceneGuide = null;
         }
      }
      
      private function deSerialize(param1:XML, param2:String, param3:String = null) : void
      {
         var indexArray:Array = null;
         var metaNode:XML = null;
         var skipEditHead:Boolean = false;
         var i:int = 0;
         var sceneNode:XML = null;
         var sceneId:String = null;
         var scene:anifire.core.AnimeScene = null;
         var movieXML:XML = param1;
         var movieID:String = param2;
         var originalId:String = param3;
         if(movieXML != null)
         {
            this.clearScenes();
            metaNode = movieXML.child(anifire.core.MetaData.XML_NODE_NAME)[0];
            this._metaData = new anifire.core.MetaData();
            this._metaData.deSerialize(metaNode,movieID,originalId);
            this._tempMetaData.deSerialize(metaNode,movieID,originalId);
            this._metaData.lang = this._tempMetaData.lang = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
            this.published = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PUBLISHED) as String == "0" ? false : true;
            this.privateShared = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PRIVATESHARED) as String == "0" ? false : true;
            this.isCopyable = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_COPYABLE) as String == "1" ? true : false;
            if(originalId != null && Boolean(StringUtil.trim(originalId)))
            {
               this._metaData.title = "";
               this._tempMetaData.title = "";
               this.tempPublished = false;
               this.isCopy = true;
            }
            else
            {
               this.tempPublished = this.published;
               this.tempPrivateShared = this.privateShared;
            }
            if(anifire.core.Console.getConsole().studioType == MESSAGE_STUDIO)
            {
               indexArray = UtilXmlInfo.getAndSortXMLattribute(movieXML,"index",anifire.core.AnimeScene.XML_NODE_NAME);
               skipEditHead = true;
               i = 0;
               while(i < indexArray.length)
               {
                  sceneNode = movieXML.child(anifire.core.AnimeScene.XML_NODE_NAME).(@index == indexArray[i] as int)[0];
                  sceneId = sceneNode.@id;
                  scene = this.addScene(sceneId);
                  this.capScreenLock = true;
                  scene.deSerialize(sceneNode,true,false,false);
                  this.capScreenLock = false;
                  if(sceneNode.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1)
                  {
                     skipEditHead = false;
                  }
                  i++;
               }
               this.setCurrentScene(indexArray.length - 1);
               this.currentScene.loadAllAssets();
               this.deserializeSound(movieXML);
               this.stopScene(this.stopScene,6);
               this._initialized = true;
               this.dispatchEvent(new CoreEvent(CoreEvent.PREPARE_MOVIE_COMPLETE,this,skipEditHead));
            }
            else
            {
               this._sci = 0;
               this.addSceneOnDeserialize();
            }
         }
      }
      
      public function get communityTheme() : anifire.core.Theme
      {
         return this._communityTheme;
      }
      
      private function loadUserThemeTimeOutHandler(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeTimeOutHandler);
         this.loadProgressVisible = false;
         anifire.core.Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Operation timeout");
      }
      
      public function getPrevScene(param1:anifire.core.AnimeScene) : anifire.core.AnimeScene
      {
         var _loc2_:int = 0;
         _loc2_ = this.getSceneIndex(param1);
         return this.getScene(_loc2_ - 1);
      }
      
      private function onSoundResizeHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getValueByKey(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel + _loc3_.totalPixel);
      }
      
      public function publishMovie(param1:PublishWindow, param2:Boolean, param3:Boolean, param4:Boolean = false) : void
      {
         this.published = param2;
         this.privateShared = param3;
         this._metaData = this._tempMetaData;
         this._redirect = param4;
         anifire.core.Console.getConsole().groupController.setCurrentGroup(anifire.core.Console.getConsole().groupController.tempCurrentGroup);
         if(this._redirect)
         {
            this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
            this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         }
         this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         this.prepareSaveMovieThumbnailScene();
      }
      
      private function onLoadSingleCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadSingleCcCharCompleted);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.doPrepareLoadCcCharComplete(_loc2_.data as ByteArray);
      }
      
      public function addRandomAssetsToScene(param1:anifire.core.Theme, param2:anifire.core.AnimeScene) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:BackgroundThumb = null;
         var _loc6_:SoundThumb = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:int = 0;
         if(param1 == null || param2 == null)
         {
            _logger.error("Both theme and scene could not be null");
            throw new Error("Both theme and scene could not be null");
         }
         _loc7_ = new UtilHashArray();
         _loc8_ = new UtilHashArray();
         if((_loc5_ = param1.defaultBgThumb) != null && _loc5_.enable)
         {
            _loc7_.push(_loc5_.id,_loc5_);
         }
         _loc9_ = 0;
         while(_loc9_ < param1.soundThumbs.length)
         {
            if((_loc6_ = SoundThumb(param1.soundThumbs.getValueByIndex(_loc9_))).enable && _loc6_.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc8_.push(_loc6_.id,_loc6_);
            }
            _loc9_++;
         }
         if(_loc7_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc7_.length;
            _loc5_ = BackgroundThumb(_loc7_.getValueByIndex(_loc4_));
            param2.createAsset(_loc5_);
         }
         if(_loc8_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc8_.length;
            _loc6_ = SoundThumb(_loc8_.getValueByIndex(_loc4_));
         }
         this._isMovieNew = false;
      }
      
      public function doGoToCopyChar(param1:CopyThumbEvent) : void
      {
         var _loc2_:GoAlert = null;
         _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc2_._lblConfirm.text = UtilDict.toDisplay("go","goalert_copy_char_title");
         _loc2_._txtDelete.text = UtilDict.toDisplay("go","goalert_copy_char_window_alert_text");
         _loc2_._txtDelete.setStyle("textAlign","left");
         _loc2_._txtDelete.setStyle("fontSize","15");
         _loc2_._btnDelete.label = UtilDict.toDisplay("go","goalert_okay");
         _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCopyMyChar);
         _loc2_._btnDelete.name = param1.thumb.encryptId;
         _loc2_._btnCancel.label = UtilDict.toDisplay("go","goalert_cancel");
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      public function doShowCreateMyCharAlert(param1:Event) : void
      {
         var _loc2_:GoAlert = null;
         _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc2_._lblConfirm.text = "";
         _loc2_._txtDelete.text = UtilDict.toDisplay("go","goalert_createMyChar");
         _loc2_._txtDelete.setStyle("textAlign","left");
         _loc2_._txtDelete.setStyle("fontSize","15");
         _loc2_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCreateMyChar);
         _loc2_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      public function get groupController() : anifire.core.GroupController
      {
         return this._groupController;
      }
      
      private function doContinueEdit(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:anifire.core.AnimeScene = null;
         if(this._viewStackWindow != null)
         {
            this._viewStackWindow.removeEventListener(Event.CANCEL,this.doContinueEdit);
            this._viewStackWindow.destory();
         }
         PopUpManager.removePopUp(this._viewStackWindow);
         this._viewStackWindow = null;
         this._publishW = null;
         this._previewData.removeAll();
         if(this._currentScene != null)
         {
            this._currentScene.playScene();
         }
         if(this.isGoWalkerOn())
         {
            this.dispatchGoWalkerEvent(19);
            this.dispatchGoWalkerEvent(20);
            this._guideMode = ServerConstants.FLASHVAR_TM_FIN;
            _loc2_ = 0;
            while(_loc2_ < this._scenes.length)
            {
               _loc3_ = this.getScene(_loc2_);
               _loc3_.meltAllAssets();
               _loc2_++;
            }
         }
      }
      
      private function set isCopy(param1:Boolean) : void
      {
         this._isCopy = param1;
      }
      
      public function thumbTrayCommand(param1:String, param2:String) : void
      {
         this.thumbTray["cmd"](param2);
      }
      
      private function closeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         this.mainStage.removeChild(_loc2_);
      }
      
      public function addStoreCollection(param1:String) : void
      {
         var _loc2_:String = null;
         if(this.storecollection.indexOf(param1) == -1)
         {
            _loc2_ = param1.replace(/\W/g,"_");
            this.storecollection.push(_loc2_);
         }
      }
      
      public function doKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:anifire.core.Asset = null;
         if(param1.ctrlKey)
         {
            _loc2_ = anifire.core.Console.getConsole().currentScene.selectedAsset;
            if(!(_loc2_ is BubbleAsset && Bubble(BubbleAsset(_loc2_).bubble).getLabelType() == TextFieldType.INPUT))
            {
               switch(param1.keyCode)
               {
                  case 67:
                  case 99:
                     this.copyAsset();
                     break;
                  case 86:
                  case 118:
                     this.pasteAsset();
               }
            }
         }
      }
      
      public function set privateShared(param1:Boolean) : void
      {
         this._privateShared = param1;
      }
      
      private function doLoadThemeTreesCompleted(param1:LoadMgrEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         this.deSerialize(this._movieXML,this.metaData.movieId,_loc2_);
         this._isLoadding = false;
         Util.gaTracking("/gostudio/themeCompleted",anifire.core.Console.getConsole().mainStage.stage);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_MOVIE_COMPLETE,this));
      }
      
      public function set loadProgressVisible(param1:Boolean) : void
      {
         this._loadProgress.visible = param1;
      }
      
      public function set soundMute(param1:Boolean) : void
      {
         this._soundMute = param1;
         var _loc2_:int = 0;
         if(this.currentScene != null)
         {
            this.currentScene.muteSound(param1);
         }
      }
      
      public function isMovieNew() : Boolean
      {
         return this._isMovieNew;
      }
      
      public function getSceneIndex(param1:anifire.core.AnimeScene) : int
      {
         return this._scenes.getIndex(param1.id);
      }
      
      public function get isLoaddingCommonTheme() : Boolean
      {
         return this._isLoaddingCommonTheme;
      }
      
      public function getUserAssetById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            this._assetId = Number(param1);
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_ASSET);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomAssetComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function dispatchGoWalkerEvent(param1:Number) : void
      {
         switch(param1)
         {
            case 2:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_CHARACTER_ADDED,this));
               break;
            case 4:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_CHARACTER_ACTION_CHANGED,this));
               break;
            case 6:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_THUMBTRAY_BG_CLICKED,this));
               break;
            case 7:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_BG_ADDED,this));
               break;
            case 9:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_THUMBTRAY_SOUND_CLICKED,this));
               break;
            case 10:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_SOUND_ADDED,this));
               break;
            case 17:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_SCENE_ADDED,this));
               break;
            case 12:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_THUMBTRAY_BUBBLE_CLICKED,this));
               break;
            case 13:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_BUBBLE_ADDED,this));
               break;
            case 15:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_BUBBLE_EDITED,this));
               break;
            case 19:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_PREVIEW_CLICKED,this));
               break;
            case 20:
               this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_PREVIEW_FINISHED,this));
         }
      }
      
      public function updateAsset(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["assetId"] = param1;
         _loc5_["title"] = param2;
         _loc5_["tags"] = param3;
         _loc5_["isPublished"] = param4 ? "1" : "0";
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_UPDATE_ASSET)).data = _loc5_;
         _loc6_.method = URLRequestMethod.POST;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).addEventListener(Event.COMPLETE,this.onUpdateAssetComplete);
         _loc7_.load(_loc6_);
      }
      
      public function getScenebyId(param1:String) : anifire.core.AnimeScene
      {
         return this._scenes.getValueByKey(param1);
      }
      
      public function get isCommonThemeLoadded() : Boolean
      {
         return this._isCommonThemeLoadded;
      }
      
      public function isThemeCcRelated(param1:String) : Boolean
      {
         var list:XMLList = null;
         var themeId:String = param1;
         list = this._themeListXML.child("theme").(attribute("id") == themeId && hasOwnProperty("@cc_theme_id") && attribute("cc_theme_id") != "");
         return list.length() > 0;
      }
      
      public function sendBackward() : void
      {
         var _loc1_:anifire.core.AnimeScene = null;
         var _loc2_:Boolean = false;
         var _loc3_:anifire.core.Asset = null;
         var _loc4_:ICommand = null;
         _loc1_ = _console.currentScene;
         _loc2_ = _loc1_.sendBackward();
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new SendBackwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function getUserCharById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_CHAR);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomCharComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomCharComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomCharComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function saveMovie() : void
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:Boolean = false;
         var _loc5_:SaveMovieHelper = null;
         var _loc6_:Base64Encoder = null;
         var _loc7_:Base64Encoder = null;
         _loc1_ = Util.getFlashVar();
         if(!(this._isAutoSave && this._publishW != null))
         {
            if(!this._isAutoSave)
            {
               this.requestLoadStatus(true,true);
               if(this.published)
               {
                  Util.gaTracking("/gostudio/SaveShare",anifire.core.Console.getConsole().mainStage.stage);
               }
               else if(this._redirect)
               {
                  Util.gaTracking("/gostudio/SaveAndClose",anifire.core.Console.getConsole().mainStage.stage);
               }
               else
               {
                  Util.gaTracking("/gostudio/SaveOnly",anifire.core.Console.getConsole().mainStage.stage);
               }
               if(this._redirect)
               {
                  Util.gaTracking("/gostudio/onExitDiversion",anifire.core.Console.getConsole().mainStage.stage);
               }
            }
            else
            {
               this._topButtonBar._btnSave.buttonMode = false;
               this._topButtonBar._btnSave.enabled = false;
               this._topButtonBar.currentState = "autoSave";
            }
            if(this._publishW != null)
            {
               this._publishW.setBtnStatus(false);
            }
            _loc3_ = new URLVariables();
            this._filmXML = this.serialize(false);
            if(this._isAutoSave)
            {
               if(this.metaData.movieId != null && this._filmXML.children().toXMLString() == this._movieXML.children().toXMLString() && this.siteId != String(Global.BEN10))
               {
                  this.enableAfterSave();
                  this._isAutoSave = false;
                  return;
               }
               if(this.metaData.movieId != null)
               {
                  _loc3_[ServerConstants.PARAM_AUTOSAVE] = 1;
               }
               _loc3_[ServerConstants.PARAM_IS_TRIGGER_BY_AUTOSAVE] = 1;
               Util.gaTracking(AnimeConstants.GA_ACTION__AUTO_SAVE,this.mainStage.stage);
            }
            Util.addFlashVarsToURLvar(_loc3_);
            _loc4_ = true;
            if(this._isAutoSave)
            {
               if(this.metaData.movieId != null)
               {
                  _loc4_ = false;
               }
               else
               {
                  this.selectedThumbnailIndex = this.currentSceneIndex;
               }
            }
            _loc3_[ServerConstants.PARAM_SAVE_THUMBNAIL] = _loc4_ ? "1" : "0";
            if(_loc4_)
            {
               _loc6_ = new Base64Encoder();
               _loc7_ = new Base64Encoder();
               _loc6_.encodeBytes(this.getMovieThumbnail());
               _loc7_.encodeBytes(this.getMovieThumbnail(true));
               _loc3_[ServerConstants.PARAM_THUMBNAIL] = _loc6_.flush();
               _loc3_[ServerConstants.PARAM_THUMBNAIL_LARGE] = _loc7_.flush();
               this.unloadThumbnailScene();
            }
            _loc3_[ServerConstants.PARAM_BODY] = this._filmXML;
            delete _loc3_[ServerConstants.PARAM_MOVIE_ID];
            if(this.metaData.movieId != null)
            {
               _loc3_[ServerConstants.PARAM_MOVIE_ID] = this.metaData.movieId;
            }
            _loc3_[ServerConstants.PARAM_LANG] = this.metaData.lang;
            delete _loc3_[ServerConstants.PARAM_ORIGINAL_ID];
            if(this.metaData.originalId != null && Boolean(StringUtil.trim(this.metaData.originalId)))
            {
               _loc3_[ServerConstants.PARAM_ORIGINAL_ID] = this.metaData.originalId;
            }
            _loc3_[ServerConstants.PARAM_LANG] = this.metaData.lang;
            if(anifire.core.Console.getConsole().studioType == MESSAGE_STUDIO)
            {
               _loc3_[ServerConstants.PARAM_EMESSAGE] = 1;
            }
            if(anifire.core.Console.getConsole().boxMode)
            {
               _loc3_[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = _loc1_.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
            }
            if(anifire.core.Console.getConsole().groupController.isSchoolProject())
            {
               _loc3_[ServerConstants.PARAM_GROUP_ID] = anifire.core.Console.getConsole().groupController.currentGroup.id;
            }
            (_loc5_ = new SaveMovieHelper()).addEventListener(Event.COMPLETE,this.doSaveMovieComplete);
            _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.doSaveMovieComplete);
            _loc5_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doSaveMovieComplete);
            _loc5_.saveMovie(_loc3_);
         }
         else
         {
            this._isAutoSave = false;
         }
      }
      
      public function getThumbnailCaptureBySceneIndex(param1:int) : BitmapData
      {
         return this.timeline.getSceneImageBitmapByIndex(param1);
      }
      
      public function checkMyCharNumAndShowCharImmediately() : void
      {
         this.thumbTray.registerShouldShowCharTabOnCcLoaded(true);
         this.checkMyCharNum();
      }
      
      private function onSoundMouseUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         this._timeline.removeEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
         _loc2_ = param1.id;
         this.updateSoundById(_loc2_);
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         if(_loc3_ != null && this._prevSoundInfo != null)
         {
            if(_loc3_.startPixel != this._prevSoundInfo.startPixel || _loc3_.y != this._prevSoundInfo.y)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
      }
      
      private function get isCopy() : Boolean
      {
         return this._isCopy;
      }
      
      private function loadThemeList(param1:Number = 0) : void
      {
         var urlLoader:URLLoader;
         var request:URLRequest;
         var xclZip:Number = param1;
         this.requestLoadStatus(true,true);
         request = UtilNetwork.getGetThemeListRequest();
         urlLoader = new URLLoader();
         (request.data as URLVariables)["siteId"] = this._siteId;
         (request.data as URLVariables)["xclZip"] = xclZip;
         urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         urlLoader.addEventListener(Event.COMPLETE,this.loadThemeListComplete);
         urlLoader.addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,function():void
         {
            Alert.show("ioerror");
         });
         urlLoader.load(request);
      }
      
      private function onTimerHandler(param1:TimerEvent) : void
      {
         if(this._initialized == true)
         {
            if(this.isUserAlreadyLogin())
            {
               if(this._publishW == null)
               {
                  this._isAutoSave = true;
                  if(this.metaData.movieId == null)
                  {
                     this.genDefaultTags();
                     this._metaData = this._tempMetaData;
                  }
                  this.saveMovie();
               }
            }
            else
            {
               this.mainStage.showAutoSaveHints();
            }
         }
      }
      
      public function get privateShared() : Boolean
      {
         return this._privateShared;
      }
      
      public function get soundMute() : Boolean
      {
         return this._soundMute;
      }
      
      public function userHasTTSRight() : Boolean
      {
         return this._ttsEnabled;
      }
      
      public function getPoints() : Array
      {
         return [this._moneyPoints,this._sharingPoints];
      }
      
      public function deleteCurrentScene() : void
      {
         var _loc1_:GoAlert = null;
         var _loc2_:String = null;
         var _loc3_:Object = null;
         if(this._currentScene != null)
         {
            if(this._timeline.getNumOfSoundStartAtScene(this._currentSceneIndex) > 0)
            {
               _loc1_ = GoAlert(PopUpManager.createPopUp(this._currentScene.canvas,GoAlert,true));
               _loc1_._lblConfirm.text = "";
               _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_removesound");
               _loc1_._btnDelete.visible = false;
               _loc1_._btnCancel.label = UtilDict.toDisplay("go","ok");
               _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
               _loc1_.y = 100;
            }
            else
            {
               this._currentScene.deleteAllAssets();
               this._currentScene.removeAllAssets();
               _loc2_ = this._currentScene.id;
               this.removeSceneByIndex(this._currentSceneIndex);
               _loc3_ = this._stageViewStack.getChildAt(this._currentSceneIndex);
               this._stageViewStack.removeChildAt(this._currentSceneIndex);
               _loc3_ = null;
               this._timeline.removeScene();
               if(this._currentSceneIndex == this._scenes.length)
               {
                  --this._currentSceneIndex;
               }
               if(this._scenes.length == 0)
               {
                  this._currentSceneIndex = -1;
                  this._currentScene = null;
                  this.addScene(_loc2_);
               }
               this.currentScene = this.scenes.getValueByIndex(this._currentSceneIndex);
               this.currentScene.loadAllAssets();
               this.currentScene.playScene();
               this._currentScene.refreshEffectTray(this.effectTray);
               this._mainStage.sceneIndexStr = this._currentSceneIndex >= 0 ? "" + (this._currentSceneIndex + 1) : "";
            }
         }
      }
      
      public function setPoints(param1:Number, param2:Number) : void
      {
         this._moneyPoints = param1;
         this._sharingPoints = param2;
      }
      
      public function set pptPanel(param1:PropertiesWindow) : void
      {
         this._pptPanel = param1;
      }
      
      public function preview(param1:PreviewPlayer = null) : void
      {
         var _loc7_:Boolean = false;
         this.stopAllSounds();
         this._filmXML = this.serialize();
         this.putFontData(this._filmXML.toXMLString());
         _logger.debug("the movie\'s xml: \n " + this._filmXML);
         var _loc2_:UtilHashArray = new UtilHashArray();
         var _loc3_:int = 0;
         while(_loc3_ < this._themes.length)
         {
            _loc2_.push(this._themes.getKey(_loc3_),(this._themes.getValueByIndex(_loc3_) as anifire.core.Theme).getThemeXML());
            _loc3_++;
         }
         var _loc4_:XML = this.userTheme.getThemeXML();
         var _loc5_:anifire.core.Theme = this.getTheme("ugc");
         var _loc6_:XML = null;
         if(_loc4_ == null || _loc5_ == null || _loc5_.getThemeXML() == null)
         {
            _loc6_ = _loc4_;
         }
         else
         {
            _loc6_ = anifire.core.Theme.merge2ThemeXml(_loc4_,_loc5_.getThemeXML(),"ugc","ugc",false);
         }
         _loc6_ = anifire.core.Theme.merge2ThemeXml(_loc5_ != null ? _loc5_.getThemeXML() : null,this.userTheme.getThemeXML(),"ugc","ugc");
         _loc2_.push(this.userTheme.id,_loc6_);
         if(UtilLicense.isExternalPreviewPlayerShouldBeUsed(UtilLicense.getCurrentLicenseId()) && this.studioType == FULL_STUDIO && (this._guideMode == "" || this._guideMode == ServerConstants.FLASHVAR_TM_FIN))
         {
            _loc7_ = true;
         }
         else
         {
            _loc7_ = false;
         }
         if(_loc7_)
         {
            this.externalPreviewPlayerController = new ExternalPreviewWindowController();
            this.externalPreviewPlayerController.removeEventListener(Event.CHANGE,this.showPublishWindow);
            this.externalPreviewPlayerController.removeEventListener(Event.CANCEL,this.doContinueEdit);
            this.externalPreviewPlayerController.addEventListener(Event.CHANGE,this.doShowPublishWindow);
            this.externalPreviewPlayerController.addEventListener(Event.CANCEL,this.doContinueEdit);
            this.externalPreviewPlayerController.initExternalPreviewWindow(this._filmXML,this._previewData,_loc2_);
         }
         else if(param1 == null)
         {
            this._viewStackWindow = ViewStackWindow(PopUpManager.createPopUp(this._currentScene.canvas,ViewStackWindow,true));
            this._viewStackWindow.x = (this._viewStackWindow.stage.width - this._viewStackWindow.width) / 2;
            this._viewStackWindow.y = this._mainStage.y;
            this._viewStackWindow.initAndPreviewMovie(this._filmXML,this._previewData,_loc2_,this._tempMetaData.title);
            this._viewStackWindow.addEventListener(Event.CANCEL,this.doContinueEdit,false,0,true);
         }
         else
         {
            param1.initAndPreview(this._filmXML,this._previewData,_loc2_);
            param1.endScreen.isPreviewMode = false;
            param1.playerControl.fullScreenControl.visible = false;
         }
         if(this._currentScene != null)
         {
            this._currentScene.stopScene();
            this._currentScene.selectedAsset = null;
         }
         this.genDefaultTags();
      }
      
      public function set published(param1:Boolean) : void
      {
         this._published = param1;
      }
      
      private function rdyToAddScene(param1:Event) : void
      {
         this.removeEventListener("EventFinished",this.rdyToAddScene);
         this.doAddScene();
      }
      
      private function unloadThumbnailScene() : void
      {
         var _loc1_:anifire.core.AnimeScene = null;
         _loc1_ = AnimeScene(this._scenes.getValueByIndex(this.selectedThumbnailIndex));
         if(_loc1_ != this.currentScene)
         {
            _loc1_.unloadAllAssets();
         }
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         _loc2_ = param1.id;
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         trace("onSoundResizeComplete:" + this._prevSoundInfo);
         if(this._prevSoundInfo != null)
         {
            if(_loc3_.totalPixel != this._prevSoundInfo.totalPixel)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
         if(_loc3_.totalPixel <= 0)
         {
            this.removeSound(_loc2_);
         }
      }
      
      public function get isLoaddingCommonThemeBg() : Boolean
      {
         return this._isLoaddingCommonThemeBg;
      }
      
      public function set stageViewStage(param1:ViewStack) : void
      {
         this._stageViewStack = param1;
         this._stageViewStack.buttonMode = true;
      }
      
      public function set currentSceneIndex(param1:Number) : void
      {
         this._currentSceneIndex = param1;
      }
      
      public function get pptPanel() : PropertiesWindow
      {
         return this._pptPanel;
      }
   }
}

import anifire.constant.ServerConstants;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLStream;
import flash.net.URLVariables;
import flash.utils.IDataInput;

class SaveMovieHelper extends EventDispatcher
{
   
   public static const SAVE_MOVIE_COMPLETE:String = "save_movie_complete";
   
   public static const SAVE_MOVIE_ERROR:String = "save_movie_error";
    
   
   private var urlRequest:URLRequest;
   
   private var contingency_server_index:int;
   
   public var data:IDataInput;
   
   private var urlStream:URLStream;
   
   public function SaveMovieHelper()
   {
      super();
   }
   
   private function removeListenerFromStream() : void
   {
      this.urlStream.removeEventListener(Event.COMPLETE,this.onComplete);
      this.urlStream.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
      this.urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
   }
   
   private function saveAgain(param1:int) : void
   {
      this.urlRequest.url = ServerConstants.get_ACTION_SAVE_MOVIE(param1);
      this.urlStream.load(this.urlRequest);
   }
   
   private function addEventListenerToStream() : void
   {
      this.urlStream.addEventListener(Event.COMPLETE,this.onComplete);
      this.urlStream.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
      this.urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
   }
   
   private function onError(param1:Event) : void
   {
      ++this.contingency_server_index;
      if(this.contingency_server_index < ServerConstants.get_contingency_web_server_array().length)
      {
         this.saveAgain(this.contingency_server_index);
      }
      else
      {
         this.removeListenerFromStream();
         this.data = this.urlStream;
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         }
         else if(param1.type == SecurityErrorEvent.SECURITY_ERROR)
         {
            this.dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
         }
      }
   }
   
   public function saveMovie(param1:URLVariables) : void
   {
      this.contingency_server_index = -1;
      this.urlRequest = new URLRequest(ServerConstants.get_ACTION_SAVE_MOVIE());
      this.urlRequest.method = URLRequestMethod.POST;
      this.urlRequest.data = param1;
      this.urlStream = new URLStream();
      this.addEventListenerToStream();
      this.urlStream.load(this.urlRequest);
   }
   
   private function onComplete(param1:Event) : void
   {
      this.removeListenerFromStream();
      this.data = this.urlStream;
      this.dispatchEvent(new Event(Event.COMPLETE));
   }
}
