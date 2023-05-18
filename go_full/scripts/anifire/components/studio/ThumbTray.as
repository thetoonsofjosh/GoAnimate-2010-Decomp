package anifire.components.studio
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.color.SelectedColor;
   import anifire.component.CCThumb;
   import anifire.components.containers.GoAlert;
   import anifire.components.containers.SoundTileCell;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.BubbleThumb;
   import anifire.core.CharThumb;
   import anifire.core.Console;
   import anifire.core.CoreEvent;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.core.Theme;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.event.LazyHelperEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.AssetPurchasedEvent;
   import anifire.events.CopyThumbEvent;
   import anifire.events.ThemeChosenEvent;
   import anifire.util.Util;
   import anifire.util.UtilColor;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLazyHelper;
   import anifire.util.UtilLicense;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUser;
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
   import flexlib.containers.FlowBox;
   import mx.binding.*;
   import mx.containers.Accordion;
   import mx.containers.Canvas;
   import mx.containers.Panel;
   import mx.containers.TabNavigator;
   import mx.containers.Tile;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.PopUpButton;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.ToggleButtonBar;
   import mx.core.Container;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.effects.Resize;
   import mx.effects.easing.Quartic;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ItemClickEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ScrollEvent;
   import mx.managers.PopUpManager;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   import mx.utils.StringUtil;
   
   public class ThumbTray extends Canvas implements IBindingClient
   {
      
      public static const COMMON_THEME:String = "GoAnimateGoodies";
      
      public static const STYLE_SOUND_TILE_1:String = "bgSoundCell1";
      
      public static const THEME_NAME_CUSTOM_WORLD:String = "Custom World";
      
      public static const DEFAULT_THEME_ID:String = "politic";
      
      public static const THEME_ID_CUSTOM_WORLD:String = "custom";
      
      public static const COMMUNITY_THEME:String = "CommunityGoodies";
      
      public static const USER_THEME:String = "MyGoodies";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const STYLE_SOUND_TILE_2:String = "bgSoundCell2";
       
      
      private var _1950667355_userTileSoundVoiceThemes:Tile;
      
      private var _596357074_userTileSoundEffectThemes:Tile;
      
      private var _71803449_uiCanvasEffectUser:Canvas;
      
      private var _shouldShowCharTabOnCcLoaded:Boolean = false;
      
      private var _3199dc:Canvas;
      
      private var _hasMoreCommunityBg:Boolean = false;
      
      private var _425225002_uiCanvasUser:Canvas;
      
      private var _active:Boolean = true;
      
      private var _currentSearchPage:int;
      
      private var _themeCbLastSelectedIndex:int = 0;
      
      private var _1122273858_uiCanvasCommunity:Canvas;
      
      private var _userBgReady:Boolean = false;
      
      private var _1493528824createOwnCharButtonCanvasForCelebritiesChar:Canvas;
      
      private var _hasMoreCommunitySoundVoice:Boolean = false;
      
      private var _hasMoreUserSoundMusic:Boolean = false;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _767428474_uiSoundThemes:Accordion;
      
      private var _communityCharReady:Boolean = false;
      
      private var _1174842373_uiCanvasBgUser:Canvas;
      
      private var _769621044_uiCanvasCharUser:Canvas;
      
      private var _130169060createOwnCharButtonCanvasForProChar:Canvas;
      
      private var _userAssetType:String = "prop";
      
      private var _isCurrentThemeShouldLoadChar:Boolean = false;
      
      private var _833075766_uiTileCharCelebrities:FlowBox;
      
      private var _hasMoreUserSoundEffect:Boolean = false;
      
      private var _1621423226_uiTilePropMaskThemes:Tile;
      
      private var _847900688_uiTileBgThemes:Tile;
      
      private var _currentSearchType:String;
      
      private var _userAssetsReady:Boolean = false;
      
      private var _soundTileCellArr:Array;
      
      private var _communityPropReady:Boolean = false;
      
      private var _1992358882_themeSelection:anifire.components.studio.ThemeSelection;
      
      private var _984000672_uiPropThemes:Accordion;
      
      private var _hasMoreCommunityEffect:Boolean = false;
      
      private var _hasMoreCommunityChar:Boolean = false;
      
      private var _939660622_uiNavigatorThemes:TabNavigator;
      
      private var _updatable:Boolean = false;
      
      private var _hasMoreCommunityProp:Boolean = false;
      
      private var _1953398322_uiTileCharCommunity:Tile;
      
      private var _hasMoreUserVideoProp:Boolean = false;
      
      private var mouseOverSoundBtn:Boolean = false;
      
      private var _userVideoPropReady:Boolean = false;
      
      public var _ThumbTray_Canvas17:Canvas;
      
      private var _435498181_uiTilePropCommunity:Tile;
      
      private var _258023566_userSoundNotUploadableNoticeText:Text;
      
      private var _740734062_uiTilePropHeadThemes:Tile;
      
      private var _hasMoreCommunitySoundMusic:Boolean = false;
      
      private var _hasMoreUserEffect:Boolean = false;
      
      private var _switchTheme:Boolean = false;
      
      private var _1401274275_uiTileEffectUser:Tile;
      
      private var _283652654_uiTilePropHandHeldThemes:Tile;
      
      private var _18631945_uiMaskCanvas:Canvas;
      
      public var _ThumbTray_SetProperty1:SetProperty;
      
      public var _ThumbTray_SetProperty2:SetProperty;
      
      public var _ThumbTray_SetProperty3:SetProperty;
      
      private var _hasMoreUserBg:Boolean = false;
      
      private var _1785122530_uiLabelCharUser:Label;
      
      public var _ThumbTray_Button1:Button;
      
      public var _ThumbTray_Button2:Button;
      
      public var _ThumbTray_Button3:Button;
      
      private var _725974475_uiThemeButtonBar:ToggleButtonBar;
      
      private var _1629274085_uiNavigatorCommunity:TabNavigator;
      
      private var _uiTileSearch:Tile;
      
      private var _991343744_uiLblResult:Label;
      
      private var _435809310_uiTileCharUser:Tile;
      
      private var _1921952448_uiTileCharYourChar:FlowBox;
      
      private var _121879230_uiCanvasVideoPropUser:Canvas;
      
      private var _hasMoreSearch:Boolean;
      
      private var _298324450_uiCanvasTheme:Canvas;
      
      private var _hasMoreUserChar:Boolean = false;
      
      private var _hasMoreUserProp:Boolean = false;
      
      private var _391719453_uiTileBgCommunity:Tile;
      
      private var _communityEffectReady:Boolean = false;
      
      private var _uiMenuSearchType:Menu;
      
      private var _uiTileCharCelebrities_lazyHelper:UtilLazyHelper;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _gettingAssets:Boolean = false;
      
      private var _1063809249_btnMyChar:anifire.components.studio.MyCharButton;
      
      private var _8114094main_cav:Canvas;
      
      private var _1429951855_uiTilePropUser:Tile;
      
      private var _hasMoreUserSound:Boolean = false;
      
      private var _userSoundReady:Boolean = false;
      
      private var _1957814528_uiTileCharProfessions:FlowBox;
      
      private var _hidable:Boolean = true;
      
      private var _1147366545_uiLabelBgUser:Label;
      
      public var _ThumbTray_Text2:Text;
      
      private var _1939118856_uiCharThemeAccordion:Accordion;
      
      private var _1096140121_uiCanvasPropUser:Canvas;
      
      private var _assetTheme:String = "GoAnimateGoodies";
      
      private var _1809035697_uiNavigatorUser:TabNavigator;
      
      private var _1764850564_effectResize:Resize;
      
      private var _2107238039_uiTileEffectCommunity:Tile;
      
      private var _userCharReady:Boolean = false;
      
      private var _2044905576_uiTileVideoPropUser:Tile;
      
      private var _1956363228_uiTileEffectThemes:Tile;
      
      private var _userPropReady:Boolean = false;
      
      private var _1107253462_uiTilePropOtherThemes:Tile;
      
      private var _1214981750_uiBtnUpload:Button;
      
      private var _communityBgReady:Boolean = false;
      
      private var _10971153VSThumbTray:ViewStack;
      
      private var _682645850_uiPopBtnSearch:PopUpButton;
      
      private var _hasMoreCommunitySound:Boolean = false;
      
      private var _searchType:String = "prop";
      
      private var _2109846365_uiCharThemeViewStack:ViewStack;
      
      private var _2083741102_uiTileSoundVoiceThemes:Tile;
      
      private var _2055258657_uiTileCharThemes:Tile;
      
      private var _1693645137_userSoundThemes:Accordion;
      
      private var _fullReady:Boolean = false;
      
      private var _uiTileCharProfessions_lazyHelper:UtilLazyHelper;
      
      private var _957346193_uiTileBgUser:Tile;
      
      private var _658818924_assetTrayBg:Canvas;
      
      private var _644843432_userTileSoundMusicThemes:Tile;
      
      private var _currentSsearchText:String;
      
      private var _communityAssetsReady:Boolean = false;
      
      private var _showTip:Boolean = false;
      
      private var _uiTileCharYourChar_lazyHelper:UtilLazyHelper;
      
      private var _1491038559_effectMove:Move;
      
      private var _905402271_uiTileSoundMusicThemes:Tile;
      
      private var _586953306_uiLblCommunity:Label;
      
      private var _canDoPremium:Boolean = false;
      
      private var _hasMoreUserSoundTTS:Boolean = false;
      
      private var _1969718778_uiLblTheme:Label;
      
      private var _1737616366_uiLblUser:Label;
      
      private var _644083601_uiLabelPropUser:Label;
      
      private var _searchSoundTileCellArr:Array;
      
      private var _876679832_uiLabelVideoPropUser:Label;
      
      private var _hasMoreCommunitySoundTTS:Boolean = false;
      
      private var _hasMoreUserSoundVoice:Boolean = false;
      
      private var _45803963_uiTxtSearch:TextInput;
      
      private var _themeId:String;
      
      private var _userEffectReady:Boolean = false;
      
      private var _1282723535_uiBtnSearch:Button;
      
      mx_internal var _watchers:Array;
      
      private var _375869079_uiTileBubbleThemes:Tile;
      
      private var _searching:Boolean = false;
      
      private var _87478335_userSoundNotUploadableNotice:Canvas;
      
      private var _hasMoreCommunitySoundEffect:Boolean = false;
      
      private var _1191025918_uiTileSoundEffectsThemes:Tile;
      
      private var _communitySoundReady:Boolean = false;
      
      private var _1700543726pnlShadow:Panel;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _92238088createOwnCharButtonCanvasForYourChar:Canvas;
      
      public function ThumbTray()
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 82
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ThumbTray._watcherSetupUtil = param1;
      }
      
      public function ___uiTileCharUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function set _uiCanvasBgUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1174842373_uiCanvasBgUser;
         if(_loc2_ !== param1)
         {
            this._1174842373_uiCanvasBgUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasBgUser",_loc2_,param1));
         }
      }
      
      public function ___userTileSoundEffectThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
      }
      
      private function addEffectThumbToTheme(param1:int, param2:EffectThumb, param3:UtilLoadMgr) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc8_:UtilLoadMgr = null;
         var _loc9_:Array = null;
         var _loc4_:SuperEffect = param2.getNewEffect();
         var _loc6_:Image = new Image();
         if(param2.imageData != null || param2.getType() != EffectThumb.TYPE_ANIME)
         {
            _loc4_.addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.loadEffectThumbsComplete);
            param3.addEventDispatcher(_loc4_,EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE);
            _loc5_ = _loc4_.loadThumbnail(param2.imageData as ByteArray);
            _loc6_.addChild(_loc5_);
         }
         else if(param2.getType() == EffectThumb.TYPE_ANIME)
         {
            _loc8_ = new UtilLoadMgr();
            (_loc9_ = new Array()).push(_loc6_);
            _loc9_.push(_loc4_);
            _loc9_.push(param2);
            _loc8_.setExtraData(_loc9_);
            _loc8_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedEffectLoaderAgain);
            _loc8_.commit();
            param3.addEventDispatcher(_loc4_,EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE);
            this.callLater(param2.loadImageData);
         }
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            _loc6_.toolTip = param2.name;
         }
         _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         var _loc7_:ThumbnailCanvas = new ThumbnailCanvas(AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT,_loc6_,param2,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium);
         if(this._searching)
         {
            this._uiTileSearch.addChild(_loc7_);
         }
         else if(this._assetTheme == COMMON_THEME)
         {
            this._uiTileEffectThemes.addChild(_loc7_);
         }
         else if(this._assetTheme == USER_THEME)
         {
            this._uiTileEffectUser.addChild(_loc7_);
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this._uiTileEffectCommunity.addChild(_loc7_);
         }
         _loc6_.graphics.beginFill(0,0);
         _loc6_.graphics.drawRect(0,0,AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT);
         _loc6_.graphics.endFill();
      }
      
      public function ___uiTileVideoPropUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharUser() : Tile
      {
         return this._435809310_uiTileCharUser;
      }
      
      public function ___uiLabelVideoPropUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___uiTxtSearch_focusIn(param1:FocusEvent) : void
      {
         this.onSearchFocusIn(param1);
      }
      
      public function set _uiLblTheme(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1969718778_uiLblTheme;
         if(_loc2_ !== param1)
         {
            this._1969718778_uiLblTheme = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblTheme",_loc2_,param1));
         }
      }
      
      private function loadVideoPropThumbsComplete(param1:Event) : void
      {
         var _loc9_:DisplayObject = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height *= _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width *= _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width *= _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height *= _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = (AnimeConstants.TILE_BACKGROUND_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_BACKGROUND_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x -= _loc8_.left;
         _loc2_.y -= _loc8_.top;
         if(_loc2_.content is MovieClip)
         {
            _loc9_ = DisplayObject(_loc2_.content);
            UtilPlain.stopFamily(_loc9_);
         }
         var _loc10_:Image = Image(_loc2_.parent);
         var _loc11_:Canvas;
         if((_loc11_ = Canvas(_loc10_.parent)) != null)
         {
            _loc10_.graphics.beginFill(0,0);
            _loc10_.drawRoundRect(0,0,_loc11_.width,_loc11_.height);
            _loc10_.graphics.endFill();
         }
      }
      
      public function ___ThumbTray_Button1_click(param1:MouseEvent) : void
      {
         Console.getConsole().doShowCreateMyCharAlert(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgThemes() : Tile
      {
         return this._847900688_uiTileBgThemes;
      }
      
      private function _ThumbTray_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = new Rectangle(0,0,310,492);
         _loc1_ = this.VSThumbTray;
         _loc1_ = this.pnlShadow;
         _loc1_ = AnimeConstants.TILE_CHAR_WIDTH;
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Your Characters");
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Make More Characters");
         _loc1_ = UtilDict.toDisplay("go","Professions");
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Make More Characters");
         _loc1_ = UtilDict.toDisplay("go","Celebrities");
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Make More Characters");
         _loc1_ = AnimeConstants.TILE_BUBBLE_WIDTH;
         _loc1_ = AnimeConstants.TILE_BUBBLE_HEIGHT;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","thumbtray_handheld");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_headgear");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_head");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_others");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_mvo");
         _loc1_ = AnimeConstants.TILE_BUBBLE_WIDTH;
         _loc1_ = AnimeConstants.TILE_BUBBLE_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
         _loc1_ = AnimeConstants.TILE_PROP_WIDTH;
         _loc1_ = AnimeConstants.TILE_PROP_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Click here to upload");
         _loc1_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Click here to upload");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_mvo");
         _loc1_ = UtilDict.toDisplay("go",AnimeConstants.SOUND_UPLOADABLE_MSG);
         _loc1_ = AnimeConstants.TILE_CHAR_WIDTH;
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Click here to upload");
         _loc1_ = AnimeConstants.TILE_BUBBLE_WIDTH;
         _loc1_ = AnimeConstants.TILE_BUBBLE_HEIGHT;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","Click here to upload");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_import");
         _loc1_ = AnimeConstants.TILE_PROP_WIDTH;
         _loc1_ = AnimeConstants.TILE_PROP_HEIGHT;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc1_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc1_ = AnimeConstants.TILE_CHAR_WIDTH;
         _loc1_ = AnimeConstants.TILE_CHAR_HEIGHT;
         _loc1_ = AnimeConstants.TILE_BUBBLE_WIDTH;
         _loc1_ = AnimeConstants.TILE_BUBBLE_HEIGHT;
         _loc1_ = UtilDict.toDisplay("go","thumbtray_search");
         _loc1_ = UtilDict.toDisplay("go","Search");
         _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
         _loc1_ = this.main_cav.width - this._btnMyChar.width - 9;
         _loc1_ = UtilLicense.getCurrentLicensorThumbtrayBannerStyleName();
         _loc1_ = this._uiCanvasUser;
         _loc1_ = UtilDict.toDisplay("emessage","Your Heads");
         _loc1_ = this._uiCanvasCommunity;
         _loc1_ = UtilDict.toDisplay("emessage","Community Heads");
         _loc1_ = this._btnMyChar;
      }
      
      private function mouseOutSoundBtnHandler(param1:Event) : void
      {
         this.mouseOverSoundBtn = false;
      }
      
      public function loadPropThumbs(param1:Theme, param2:UtilLoadMgr, param3:Tile = null) : void
      {
         var _loc5_:Thumb = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         if(this._assetTheme == USER_THEME)
         {
            this._uiLabelPropUser.visible = Console.getConsole().userTheme.propThumbs.length < 3;
         }
         else if(this._assetTheme == COMMON_THEME && param1.id != "common")
         {
            this._uiTilePropHandHeldThemes.removeAllChildren();
            this._uiTilePropMaskThemes.removeAllChildren();
            this._uiTilePropHeadThemes.removeAllChildren();
            this._uiTilePropOtherThemes.removeAllChildren();
         }
         var _loc4_:int = 0;
         while(_loc4_ < param1.propThumbs.length)
         {
            if((_loc5_ = param1.propThumbs.getValueByIndex(_loc4_) as Thumb).enable)
            {
               _loc6_ = false;
               _loc7_ = 0;
               while(_loc7_ < _loc5_.colorRef.length)
               {
                  if(_loc5_.colorRef.getValueByIndex(_loc7_).@enable == "Y")
                  {
                     _loc6_ = true;
                     break;
                  }
                  _loc7_++;
               }
               if(_loc6_)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_.colorRef.length)
                  {
                     if(_loc5_.colorRef.getValueByIndex(_loc7_).@enable == "Y")
                     {
                        this.addPropThumbToTheme(_loc4_,_loc5_,param2,param3,_loc5_.colorRef.getKey(_loc7_));
                     }
                     _loc7_++;
                  }
               }
               else
               {
                  this.addPropThumbToTheme(_loc4_,_loc5_,param2,param3);
               }
            }
            _loc4_++;
         }
         this.onShowPropTray();
      }
      
      public function set hasMoreCommunityChar(param1:Boolean) : void
      {
         this._hasMoreCommunityChar = param1;
      }
      
      public function get hasMoreCommunitySoundTTS() : Boolean
      {
         return this._hasMoreCommunitySoundTTS;
      }
      
      public function gotoSpecifiedTabInMyGoodies(param1:String) : void
      {
         if(param1 as String == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._userSoundThemes;
            this._userSoundThemes.selectedChild = this._userTileSoundVoiceThemes;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_BG)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasBgUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasCharUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasPropUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_SOUND)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._userSoundThemes;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_FX)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasEffectUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasVideoPropUser;
         }
      }
      
      public function get communityAssetsReady() : Boolean
      {
         return this._communityAssetsReady;
      }
      
      public function set hasMoreCommunityProp(param1:Boolean) : void
      {
         this._hasMoreCommunityProp = param1;
      }
      
      public function addSoundTileCell(param1:SoundThumb) : void
      {
         var _loc2_:SoundTileCell = param1.getTileCell();
         _loc2_.buttonMode = true;
         var _loc3_:DisplayObjectContainer = this._uiTileSoundVoiceThemes;
         if(this._searching)
         {
            this._searchSoundTileCellArr.push(_loc2_);
            _loc3_ = this._uiTileSearch;
         }
         else
         {
            this._soundTileCellArr.push(_loc2_);
            if(this._assetTheme == COMMON_THEME)
            {
               if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc3_ = this._uiTileSoundMusicThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc3_ = this._uiTileSoundEffectsThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc3_ = this._uiTileSoundVoiceThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc3_ = this._userTileSoundVoiceThemes;
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc3_ = this._userTileSoundMusicThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc3_ = this._userTileSoundEffectThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc3_ = this._userTileSoundVoiceThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc3_ = this._userTileSoundVoiceThemes;
               }
               _loc2_.addEventListener("mouseOverSoundBtnEvent",this.mouseOverSoundBtnHandler);
               _loc2_.addEventListener("mouseOutSoundBtnEvent",this.mouseOutSoundBtnHandler);
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
                  {
                     if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
                     {
                        if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
                        {
                        }
                     }
                  }
               }
            }
         }
         var _loc4_:ThumbnailCanvas = new ThumbnailCanvas(_loc2_.width,_loc2_.height,_loc2_,param1,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium);
         _loc3_.addChild(_loc4_);
         if(_loc3_.numChildren % 2 != 0)
         {
            _loc2_.styleName = STYLE_SOUND_TILE_1;
         }
         else
         {
            _loc2_.styleName = STYLE_SOUND_TILE_2;
         }
      }
      
      public function ___uiLabelBgUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function set hasMoreUserVideoProp(param1:Boolean) : void
      {
         this._hasMoreUserVideoProp = param1;
      }
      
      private function eventStartHandler(param1:EffectEvent) : void
      {
         this._effectResize.removeEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
         dispatchEvent(new Event("TrayOpen"));
      }
      
      public function set _uiTileBgThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._847900688_uiTileBgThemes;
         if(_loc2_ !== param1)
         {
            this._847900688_uiTileBgThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgThemes",_loc2_,param1));
         }
      }
      
      public function ___btnMyChar_click(param1:MouseEvent) : void
      {
         this.onMyCharButtonClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundMusicThemes() : Tile
      {
         return this._644843432_userTileSoundMusicThemes;
      }
      
      private function feedCharLoaderAgain(param1:LoadMgrEvent) : void
      {
         var _loc7_:Object = null;
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:CharThumb = _loc3_[1] as CharThumb;
         var _loc6_:CCThumb = _loc3_[2] as CCThumb;
         if(_loc5_.isCC)
         {
            _loc7_ = _loc5_.imageData as Object;
            _loc6_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.loadCharThumbsComplete);
            _loc6_.init(_loc7_["xml"] as XML,_loc7_["imageData"] as UtilHashArray);
         }
         else
         {
            _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCharThumbsComplete);
            _loc4_.loadBytes(ByteArray(_loc5_.imageData));
         }
      }
      
      public function ___uiTileSoundMusicThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
      }
      
      public function fullReady() : Boolean
      {
         return this._fullReady;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundMusicThemes() : Tile
      {
         return this._905402271_uiTileSoundMusicThemes;
      }
      
      public function stopAllSounds() : void
      {
         var _loc1_:SoundTileCell = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._soundTileCellArr.length)
         {
            _loc1_ = SoundTileCell(this._soundTileCellArr[_loc2_]);
            _loc1_.stopSound();
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._searchSoundTileCellArr.length)
         {
            _loc1_ = SoundTileCell(this._searchSoundTileCellArr[_loc3_]);
            _loc1_.stopSound();
            _loc3_++;
         }
      }
      
      private function _ThumbTray_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,310,492);
         },function(param1:Rectangle):void
         {
            this.scrollRect = param1;
         },"this.scrollRect");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return VSThumbTray;
         },function(param1:Object):void
         {
            _effectMove.target = param1;
         },"_effectMove.target");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return pnlShadow;
         },function(param1:Object):void
         {
            _effectResize.target = param1;
         },"_effectResize.target");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },function(param1:Number):void
         {
            _uiTileCharThemes.tileWidth = param1;
         },"_uiTileCharThemes.tileWidth");
         result[3] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileCharThemes.tileHeight = param1;
         },"_uiTileCharThemes.tileHeight");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Your Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileCharYourChar.label = param1;
         },"_uiTileCharYourChar.label");
         result[5] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            createOwnCharButtonCanvasForYourChar.height = param1;
         },"createOwnCharButtonCanvasForYourChar.height");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Make More Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ThumbTray_Button1.label = param1;
         },"_ThumbTray_Button1.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Professions");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileCharProfessions.label = param1;
         },"_uiTileCharProfessions.label");
         result[8] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            createOwnCharButtonCanvasForProChar.height = param1;
         },"createOwnCharButtonCanvasForProChar.height");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Make More Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ThumbTray_Button2.label = param1;
         },"_ThumbTray_Button2.label");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Celebrities");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileCharCelebrities.label = param1;
         },"_uiTileCharCelebrities.label");
         result[11] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            createOwnCharButtonCanvasForCelebritiesChar.height = param1;
         },"createOwnCharButtonCanvasForCelebritiesChar.height");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Make More Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ThumbTray_Button3.label = param1;
         },"_ThumbTray_Button3.label");
         result[13] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },function(param1:Number):void
         {
            _uiTileBubbleThemes.tileWidth = param1;
         },"_uiTileBubbleThemes.tileWidth");
         result[14] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileBubbleThemes.tileHeight = param1;
         },"_uiTileBubbleThemes.tileHeight");
         result[15] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },function(param1:Number):void
         {
            _uiTileBgThemes.tileWidth = param1;
         },"_uiTileBgThemes.tileWidth");
         result[16] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileBgThemes.tileHeight = param1;
         },"_uiTileBgThemes.tileHeight");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_handheld");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTilePropHandHeldThemes.label = param1;
         },"_uiTilePropHandHeldThemes.label");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_headgear");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTilePropMaskThemes.label = param1;
         },"_uiTilePropMaskThemes.label");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_head");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTilePropHeadThemes.label = param1;
         },"_uiTilePropHeadThemes.label");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_others");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTilePropOtherThemes.label = param1;
         },"_uiTilePropOtherThemes.label");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileSoundMusicThemes.label = param1;
         },"_uiTileSoundMusicThemes.label");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileSoundEffectsThemes.label = param1;
         },"_uiTileSoundEffectsThemes.label");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_mvo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiTileSoundVoiceThemes.label = param1;
         },"_uiTileSoundVoiceThemes.label");
         result[24] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },function(param1:Number):void
         {
            _uiTileEffectThemes.tileWidth = param1;
         },"_uiTileEffectThemes.tileWidth");
         result[25] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileEffectThemes.tileHeight = param1;
         },"_uiTileEffectThemes.tileHeight");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLblTheme.text = param1;
         },"_uiLblTheme.text");
         result[27] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLblUser.text = param1;
         },"_uiLblUser.text");
         result[28] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_WIDTH;
         },function(param1:Number):void
         {
            _uiTilePropUser.tileWidth = param1;
         },"_uiTilePropUser.tileWidth");
         result[29] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_HEIGHT;
         },function(param1:Number):void
         {
            _uiTilePropUser.tileHeight = param1;
         },"_uiTilePropUser.tileHeight");
         result[30] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLabelPropUser.text = param1;
         },"_uiLabelPropUser.text");
         result[31] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },function(param1:Number):void
         {
            _uiTileBgUser.tileWidth = param1;
         },"_uiTileBgUser.tileWidth");
         result[32] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileBgUser.tileHeight = param1;
         },"_uiTileBgUser.tileHeight");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLabelBgUser.text = param1;
         },"_uiLabelBgUser.text");
         result[34] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _userTileSoundMusicThemes.label = param1;
         },"_userTileSoundMusicThemes.label");
         result[35] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _userTileSoundEffectThemes.label = param1;
         },"_userTileSoundEffectThemes.label");
         result[36] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_mvo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _userTileSoundVoiceThemes.label = param1;
         },"_userTileSoundVoiceThemes.label");
         result[37] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go",AnimeConstants.SOUND_UPLOADABLE_MSG);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ThumbTray_Text2.text = param1;
         },"_ThumbTray_Text2.text");
         result[38] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },function(param1:Number):void
         {
            _uiTileCharUser.tileWidth = param1;
         },"_uiTileCharUser.tileWidth");
         result[39] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileCharUser.tileHeight = param1;
         },"_uiTileCharUser.tileHeight");
         result[40] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLabelCharUser.text = param1;
         },"_uiLabelCharUser.text");
         result[41] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },function(param1:Number):void
         {
            _uiTileEffectUser.tileWidth = param1;
         },"_uiTileEffectUser.tileWidth");
         result[42] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileEffectUser.tileHeight = param1;
         },"_uiTileEffectUser.tileHeight");
         result[43] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },function(param1:Number):void
         {
            _uiTileVideoPropUser.tileWidth = param1;
         },"_uiTileVideoPropUser.tileWidth");
         result[44] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileVideoPropUser.tileHeight = param1;
         },"_uiTileVideoPropUser.tileHeight");
         result[45] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLabelVideoPropUser.text = param1;
         },"_uiLabelVideoPropUser.text");
         result[46] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_import");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiBtnUpload.label = param1;
         },"_uiBtnUpload.label");
         result[47] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_WIDTH;
         },function(param1:Number):void
         {
            _uiTilePropCommunity.tileWidth = param1;
         },"_uiTilePropCommunity.tileWidth");
         result[48] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_HEIGHT;
         },function(param1:Number):void
         {
            _uiTilePropCommunity.tileHeight = param1;
         },"_uiTilePropCommunity.tileHeight");
         result[49] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },function(param1:Number):void
         {
            _uiTileBgCommunity.tileWidth = param1;
         },"_uiTileBgCommunity.tileWidth");
         result[50] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileBgCommunity.tileHeight = param1;
         },"_uiTileBgCommunity.tileHeight");
         result[51] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },function(param1:Number):void
         {
            _uiTileCharCommunity.tileWidth = param1;
         },"_uiTileCharCommunity.tileWidth");
         result[52] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileCharCommunity.tileHeight = param1;
         },"_uiTileCharCommunity.tileHeight");
         result[53] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },function(param1:Number):void
         {
            _uiTileEffectCommunity.tileWidth = param1;
         },"_uiTileEffectCommunity.tileWidth");
         result[54] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },function(param1:Number):void
         {
            _uiTileEffectCommunity.tileHeight = param1;
         },"_uiTileEffectCommunity.tileHeight");
         result[55] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_search");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiBtnSearch.label = param1;
         },"_uiBtnSearch.label");
         result[56] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Search");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiPopBtnSearch.label = param1;
         },"_uiPopBtnSearch.label");
         result[57] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            var _loc2_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _uiLblCommunity.text = param1;
         },"_uiLblCommunity.text");
         result[58] = binding;
         binding = new Binding(this,function():Number
         {
            return main_cav.width - _btnMyChar.width - 9;
         },function(param1:Number):void
         {
            _btnMyChar.x = param1;
         },"_btnMyChar.x");
         result[59] = binding;
         binding = new Binding(this,function():Object
         {
            return UtilLicense.getCurrentLicensorThumbtrayBannerStyleName();
         },function(param1:Object):void
         {
            _ThumbTray_Canvas17.styleName = param1;
         },"_ThumbTray_Canvas17.styleName");
         result[60] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasUser;
         },function(param1:Object):void
         {
            _ThumbTray_SetProperty1.target = param1;
         },"_ThumbTray_SetProperty1.target");
         result[61] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("emessage","Your Heads");
         },function(param1:*):void
         {
            _ThumbTray_SetProperty1.value = param1;
         },"_ThumbTray_SetProperty1.value");
         result[62] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasCommunity;
         },function(param1:Object):void
         {
            _ThumbTray_SetProperty2.target = param1;
         },"_ThumbTray_SetProperty2.target");
         result[63] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("emessage","Community Heads");
         },function(param1:*):void
         {
            _ThumbTray_SetProperty2.value = param1;
         },"_ThumbTray_SetProperty2.value");
         result[64] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnMyChar;
         },function(param1:Object):void
         {
            _ThumbTray_SetProperty3.target = param1;
         },"_ThumbTray_SetProperty3.target");
         result[65] = binding;
         return result;
      }
      
      private function showTip() : void
      {
         var _loc1_:TipWindow = null;
         var _loc2_:GlowFilter = null;
         var _loc3_:Array = null;
         if(!this._showTip && this.themeId == "bunny" && Console.getConsole().studioType != Console.MESSAGE_STUDIO)
         {
            _loc1_ = new TipWindow();
            _loc1_.width = 216;
            _loc1_.height = 222;
            _loc1_.x = 46;
            _loc1_.y = 163;
            _loc2_ = new GlowFilter(3355443,1,6,6);
            _loc3_ = new Array();
            _loc3_.push(_loc2_);
            _loc1_.filters = _loc3_;
            _loc1_.addEventListener(Event.COMPLETE,this.initTip);
            this.addChild(_loc1_);
            this._showTip = true;
         }
      }
      
      public function ___ThumbTray_Canvas17_creationComplete(param1:FlexEvent) : void
      {
         this.initClientThemeBanner(param1);
      }
      
      private function onCommunityTileChange(param1:Event = null) : void
      {
         if(this._uiNavigatorCommunity.selectedChild == this._uiTileSearch)
         {
            this._uiLblResult.visible = true;
            this._uiBtnSearch.visible = false;
            this._uiPopBtnSearch.visible = true;
         }
         else
         {
            this._uiLblResult.visible = false;
            this._uiBtnSearch.visible = true;
            this._uiPopBtnSearch.visible = false;
            if(this._uiNavigatorCommunity.selectedChild == this._uiTileBgCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_BG;
               if(!this._communityBgReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  Console.getConsole().loadUserTheme(AnimeConstants.ASSET_TYPE_BG);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTilePropCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_PROP;
               if(!this._communityPropReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  Console.getConsole().loadUserTheme(AnimeConstants.ASSET_TYPE_PROP);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTileCharCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
               if(!this._communityCharReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  Console.getConsole().loadUserTheme(AnimeConstants.ASSET_TYPE_CHAR);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTileEffectCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_FX;
               if(!this._communityEffectReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  Console.getConsole().loadUserTheme(AnimeConstants.ASSET_TYPE_FX);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
         }
      }
      
      public function set hasMoreCommunitySoundTTS(param1:Boolean) : void
      {
         this._hasMoreCommunitySoundTTS = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get main_cav() : Canvas
      {
         return this._8114094main_cav;
      }
      
      public function set _uiTileCharCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1953398322_uiTileCharCommunity;
         if(_loc2_ !== param1)
         {
            this._1953398322_uiTileCharCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharCommunity",_loc2_,param1));
         }
      }
      
      private function startListenToUserTileChange() : void
      {
         this.doNotListenToUserTileChange();
         this._uiNavigatorUser.addEventListener(IndexChangedEvent.CHANGE,this.onUserAssetTileChange);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHeadThemes() : Tile
      {
         return this._740734062_uiTilePropHeadThemes;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelPropUser() : Label
      {
         return this._644083601_uiLabelPropUser;
      }
      
      public function ___userTileSoundMusicThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
      }
      
      public function set _uiCanvasTheme(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._298324450_uiCanvasTheme;
         if(_loc2_ !== param1)
         {
            this._298324450_uiCanvasTheme = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasTheme",_loc2_,param1));
         }
      }
      
      private function onMouseEventHandler(param1:MouseEvent) : void
      {
         if(!this.mouseOverSoundBtn)
         {
            this.showImporterWindow();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropMaskThemes() : Tile
      {
         return this._1621423226_uiTilePropMaskThemes;
      }
      
      public function set _uiTileCharThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2055258657_uiTileCharThemes;
         if(_loc2_ !== param1)
         {
            this._2055258657_uiTileCharThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharThemes",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectUser() : Tile
      {
         return this._1401274275_uiTileEffectUser;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileVideoPropUser() : Tile
      {
         return this._2044905576_uiTileVideoPropUser;
      }
      
      private function clearAllEffectThumbs() : void
      {
         this._uiTileEffectThemes.removeAllChildren();
      }
      
      private function loadTheme() : void
      {
      }
      
      public function ___uiTxtSearch_focusOut(param1:FocusEvent) : void
      {
         this.onSearchFocusOut(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiSoundThemes() : Accordion
      {
         return this._767428474_uiSoundThemes;
      }
      
      public function set _uiTxtSearch(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._45803963_uiTxtSearch;
         if(_loc2_ !== param1)
         {
            this._45803963_uiTxtSearch = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTxtSearch",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundNotUploadableNoticeText() : Text
      {
         return this._258023566_userSoundNotUploadableNoticeText;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelBgUser() : Label
      {
         return this._1147366545_uiLabelBgUser;
      }
      
      [Bindable(event="propertyChange")]
      public function get dc() : Canvas
      {
         return this._3199dc;
      }
      
      private function _ThumbTray_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this._effectMove = _loc1_;
         _loc1_.duration = 500;
         _loc1_.easingFunction = Quartic.easeOut;
         BindingManager.executeBindings(this,"_effectMove",this._effectMove);
         return _loc1_;
      }
      
      public function get hasMoreCommunitySoundVoice() : Boolean
      {
         return this._hasMoreCommunitySoundVoice;
      }
      
      public function set _uiNavigatorUser(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1809035697_uiNavigatorUser;
         if(_loc2_ !== param1)
         {
            this._1809035697_uiNavigatorUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorUser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiPropThemes() : Accordion
      {
         return this._984000672_uiPropThemes;
      }
      
      public function set main_cav(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._8114094main_cav;
         if(_loc2_ !== param1)
         {
            this._8114094main_cav = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"main_cav",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCharThemeViewStack() : ViewStack
      {
         return this._2109846365_uiCharThemeViewStack;
      }
      
      public function ___uiTileBgUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function set _userTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._644843432_userTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._644843432_userTileSoundMusicThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundMusicThemes",_loc2_,param1));
         }
      }
      
      public function get assetTheme() : String
      {
         return this._assetTheme;
      }
      
      public function set _uiTileEffectUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1401274275_uiTileEffectUser;
         if(_loc2_ !== param1)
         {
            this._1401274275_uiTileEffectUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectUser",_loc2_,param1));
         }
      }
      
      public function get themeId() : String
      {
         return this._themeId;
      }
      
      public function ___uiTileBgCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"bg");
      }
      
      private function doLoadThumbForCurrentTab(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbForCurrentTab);
         if(this._uiNavigatorThemes.selectedChild != this._uiCharThemeViewStack)
         {
            this.onCommonAssetTileChange();
         }
      }
      
      public function set _uiTileVideoPropUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2044905576_uiTileVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._2044905576_uiTileVideoPropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileVideoPropUser",_loc2_,param1));
         }
      }
      
      public function set _uiTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._905402271_uiTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._905402271_uiTileSoundMusicThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundMusicThemes",_loc2_,param1));
         }
      }
      
      private function onLoadAllThumbsComplete(param1:LoadMgrEvent = null) : void
      {
         Console.getConsole().requestLoadStatus(false,true);
         if(this._assetTheme == COMMON_THEME)
         {
            this._fullReady = true;
            if(!(!this._switchTheme && Console.getConsole().isCommonThemeLoadded))
            {
               this.show();
               if(this._uiNavigatorThemes.selectedChild != this._uiPropThemes)
               {
                  if(this._uiNavigatorThemes.selectedChild == this._uiTileBgThemes)
                  {
                  }
               }
            }
         }
         else if(this._assetTheme == USER_THEME)
         {
            this._userAssetsReady = true;
            if(this._userAssetType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._userBgReady = true;
            }
            else if(this._userAssetType == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._userPropReady = true;
            }
            else if(this._userAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               this._userCharReady = true;
            }
            else if(this._userAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               this._userSoundReady = true;
            }
            if(this._gettingAssets)
            {
               this._gettingAssets = false;
            }
            if(this.hasMoreUserBg)
            {
               this.addThumbLoadingCanvas("user","bg");
            }
            if(this.hasMoreUserProp)
            {
               this.addThumbLoadingCanvas("user","prop");
            }
            if(this.hasMoreUserChar)
            {
               this.addThumbLoadingCanvas("user","char");
            }
            if(this.hasMoreUserVideoProp)
            {
               this.addThumbLoadingCanvas("user","video");
            }
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this._communityAssetsReady = true;
            if(this.searchType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._communityBgReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._communityPropReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               this._communityCharReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               this._communitySoundReady = true;
            }
            if(this._gettingAssets)
            {
               this._gettingAssets = false;
            }
            if(this.hasMoreCommunityBg)
            {
               this.addThumbLoadingCanvas("community","bg");
            }
            if(this.hasMoreCommunityProp)
            {
               this.addThumbLoadingCanvas("community","prop");
            }
            if(this.hasMoreCommunityChar)
            {
               this.addThumbLoadingCanvas("community","char");
            }
            if(this._searching)
            {
               if(this._uiNavigatorCommunity.getChildByName("searchTile") == null)
               {
                  this._uiNavigatorCommunity.addChild(this._uiTileSearch);
               }
               this._uiNavigatorCommunity.selectedChild = this._uiTileSearch;
               this._searching = false;
            }
         }
         if(!Console.getConsole().isLoaddingCommonTheme)
         {
            Console.getConsole().loadCommonTheme();
         }
         else
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this));
         }
      }
      
      private function onMyCharButtonClick() : void
      {
         var _loc1_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc1_.assetType = AnimeConstants.ASSET_TYPE_CHAR;
         _loc1_.themeId = THEME_ID_CUSTOM_WORLD;
         this.onThemeChosen(_loc1_);
      }
      
      public function ___uiBtnSearch_click(param1:MouseEvent) : void
      {
         this.searchAsset();
      }
      
      public function get uploadType() : String
      {
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasBgUser)
         {
            return AnimeConstants.ASSET_TYPE_BG;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            return AnimeConstants.ASSET_TYPE_PROP_HEAD;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            return AnimeConstants.ASSET_TYPE_CHAR;
         }
         if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            if(this._userSoundThemes.selectedChild == this._userTileSoundMusicThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
            }
            if(this._userSoundThemes.selectedChild == this._userTileSoundEffectThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT;
            }
            if(this._userSoundThemes.selectedChild == this._userTileSoundVoiceThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER;
            }
         }
         return AnimeConstants.ASSET_TYPE_BG;
      }
      
      public function ___uiTileEffectUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"effect");
      }
      
      private function onSearchFocusOut(param1:Event) : void
      {
         this.active = true;
      }
      
      private function updateThumbColor(param1:Image, param2:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:UtilHashArray = null;
         var _loc6_:int = 0;
         var _loc7_:SelectedColor = null;
         if(param1.parent != null && ThumbnailCanvas(param1.parent).colorSetId != "" && !ThumbnailCanvas(param1.parent).thumb.isCC)
         {
            _loc4_ = ThumbnailCanvas(param1.parent).thumb.colorRef.getValueByKey(ThumbnailCanvas(param1.parent).colorSetId);
            _loc5_ = new UtilHashArray();
            _loc6_ = 0;
            while(_loc6_ < _loc4_.color.length())
            {
               _loc7_ = new SelectedColor(_loc4_.color[_loc6_].@r,_loc4_.color[_loc6_].attribute("oc").length() == 0 ? uint.MAX_VALUE : uint(_loc4_.color[_loc6_].@oc),uint(_loc4_.color[_loc6_]));
               _loc5_.push(_loc4_.color[_loc6_].@r,_loc7_);
               _loc6_++;
            }
            if(_loc5_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  UtilColor.setAssetPartColor(param2,_loc5_.getKey(_loc3_),SelectedColor(_loc5_.getValueByIndex(_loc3_)).dstColor);
                  _loc3_++;
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropCommunity() : Tile
      {
         return this._435498181_uiTilePropCommunity;
      }
      
      public function set _uiTilePropHeadThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._740734062_uiTilePropHeadThemes;
         if(_loc2_ !== param1)
         {
            this._740734062_uiTilePropHeadThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHeadThemes",_loc2_,param1));
         }
      }
      
      public function set _uiLabelPropUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._644083601_uiLabelPropUser;
         if(_loc2_ !== param1)
         {
            this._644083601_uiLabelPropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelPropUser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasUser() : Canvas
      {
         return this._425225002_uiCanvasUser;
      }
      
      private function doStartListenToUserTileChange(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartListenToUserTileChange);
         this.startListenToUserTileChange();
      }
      
      private function feedBubbleLoaderAgain(param1:LoadMgrEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.feedBubbleLoaderAgain);
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:BubbleThumb = _loc3_[1] as BubbleThumb;
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.doRePositionBubbleThumb);
         _loc4_.loadBytes(ByteArray(_loc5_.thumbImageData));
      }
      
      private function set updatable(param1:Boolean) : void
      {
         this._updatable = param1;
         this._uiBtnUpload.enabled = param1;
         this._uiBtnUpload.mouseEnabled = param1;
         this._uiBtnUpload.mouseChildren = param1;
         Console.getConsole().mainStage.updatable = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get pnlShadow() : Panel
      {
         return this._1700543726pnlShadow;
      }
      
      private function doCenterMaskImage(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doCenterMaskImage);
         var _loc2_:MaskImage = param1.target as MaskImage;
         var _loc3_:DisplayObject = _loc2_.parent;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(_loc3_.x + _loc3_.width / 2));
         _loc2_.x = _loc2_.globalToLocal(_loc4_).x - _loc2_.width / 2;
      }
      
      public function set hasMoreUserSoundVoice(param1:Boolean) : void
      {
         this._hasMoreUserSoundVoice = param1;
      }
      
      private function doDispatchUserWantToCopyThumbEvent(param1:CopyThumbEvent) : void
      {
         var _loc2_:CopyThumbEvent = new CopyThumbEvent(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this);
         _loc2_.thumb = param1.thumb;
         this.dispatchEvent(_loc2_);
      }
      
      private function set _1349701436themeId(param1:String) : void
      {
         this._themeId = param1;
      }
      
      public function get searchType() : String
      {
         return this._searchType;
      }
      
      private function onCommonAssetTileChange(param1:Event = null, param2:Boolean = true) : void
      {
         trace("onCommonAssetTileChange");
         var _loc3_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_COMMONITEM);
         if(this._uiNavigatorThemes.selectedChild == this._uiCharThemeViewStack)
         {
            this.showTip();
            if(Console.getConsole().isThemeCcRelated(this.getCurrentThemeId()))
            {
               this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
            }
            else
            {
               this._uiCharThemeViewStack.selectedChild = this._uiTileCharThemes;
            }
            if(this.getIsUiTileCharThemesEmpty())
            {
               this.loadCharThumbs(Console.getConsole().getCurTheme(),new UtilLoadMgr());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadCharThumbs(Console.getConsole().getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiTileBubbleThemes)
         {
            if(this._uiTileBubbleThemes.numChildren == 0)
            {
               this.loadBubbleThumbs(Console.getConsole().getCurTheme());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadBubbleThumbs(Console.getConsole().getTheme("common"));
                  }
               }
            }
            if(Console.getConsole().isGoWalkerOn())
            {
               Console.getConsole().dispatchGoWalkerEvent(12);
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiTileBgThemes)
         {
            if(this._uiTileBgThemes.numChildren == 0)
            {
               this.loadBackgroundThumbs(Console.getConsole().getCurTheme(),new UtilLoadMgr());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadBackgroundThumbs(Console.getConsole().getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
            if(Console.getConsole().isGoWalkerOn())
            {
               Console.getConsole().dispatchGoWalkerEvent(6);
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiPropThemes)
         {
            if(this.getIsUiTilePropHandHeldThemesEmpty())
            {
               this.loadPropThumbs(Console.getConsole().getCurTheme(),new UtilLoadMgr());
               if(param2 && UtilLicense.isCommonPropShouldBeShown(Console.getConsole().getCurTheme().id))
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadPropThumbs(Console.getConsole().getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiSoundThemes)
         {
            if(this._uiTileSoundEffectsThemes.numChildren + this._uiTileSoundMusicThemes.numChildren + this._uiTileSoundVoiceThemes.numChildren == 0)
            {
               if(Console.getConsole().getCurTheme().id != "common" || Console.getConsole().getCurTheme().id == "common" && UtilLicense.isCommonSoundShouldBeShown(Console.getConsole().getCurTheme().id))
               {
                  this.loadSoundThumbs(Console.getConsole().getCurTheme());
                  if(param2 && UtilLicense.isCommonSoundShouldBeShown(Console.getConsole().getCurTheme().id))
                  {
                     if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                     {
                        this.loadSoundThumbs(Console.getConsole().getTheme("common"));
                     }
                  }
               }
            }
            if(Console.getConsole().isGoWalkerOn())
            {
               Console.getConsole().dispatchGoWalkerEvent(9);
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiTileEffectThemes)
         {
            if(this._uiTileEffectThemes.numChildren == 0)
            {
               this.loadEffectThumbs(Console.getConsole().getCurTheme(),new UtilLoadMgr());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadEffectThumbs(Console.getConsole().getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
         }
         else
         {
            Util.gaTracking("/gostudio/" + COMMON_THEME + "/loaded/" + this._uiNavigatorThemes.selectedChild.id,this.stage);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundEffectsThemes() : Tile
      {
         return this._1191025918_uiTileSoundEffectsThemes;
      }
      
      [Bindable(event="propertyChange")]
      public function get createOwnCharButtonCanvasForCelebritiesChar() : Canvas
      {
         return this._1493528824createOwnCharButtonCanvasForCelebritiesChar;
      }
      
      [Bindable(event="propertyChange")]
      public function get createOwnCharButtonCanvasForYourChar() : Canvas
      {
         return this._92238088createOwnCharButtonCanvasForYourChar;
      }
      
      public function set _uiSoundThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._767428474_uiSoundThemes;
         if(_loc2_ !== param1)
         {
            this._767428474_uiSoundThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiSoundThemes",_loc2_,param1));
         }
      }
      
      public function set dc(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3199dc;
         if(_loc2_ !== param1)
         {
            this._3199dc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dc",_loc2_,param1));
         }
      }
      
      private function showSoundNonUploadableNotice() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         this._userSoundNotUploadableNotice.visible;
         this._userSoundThemes.selectedChild = this._userSoundNotUploadableNotice;
         _loc1_ = 0;
         while(_loc1_ < this._userSoundThemes.numChildren)
         {
            _loc2_ = this._userSoundThemes.getChildAt(_loc1_);
            if(_loc2_ != this._userSoundNotUploadableNotice)
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._userSoundThemes.numChildren)
         {
            this._userTileSoundMusicThemes.enabled = false;
            this._userTileSoundEffectThemes.enabled = false;
            this._userTileSoundVoiceThemes.enabled = false;
            _loc1_++;
         }
         this._userSoundThemes.styleName = "accordionDestroyed";
         this._userSoundThemes.mouseEnabled = this._userSoundThemes.mouseChildren = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get createOwnCharButtonCanvasForProChar() : Canvas
      {
         return this._130169060createOwnCharButtonCanvasForProChar;
      }
      
      public function ___uiTileSoundEffectsThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
      }
      
      private function loadBubbleThumbs(param1:Theme) : void
      {
         var _loc3_:BubbleThumb = null;
         var _loc4_:Image = null;
         var _loc5_:Canvas = null;
         var _loc6_:UtilLoadMgr = null;
         var _loc7_:Loader = null;
         var _loc8_:Array = null;
         var _loc9_:Bubble = null;
         var _loc10_:Rectangle = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < param1.bubbleThumbs.length)
         {
            _loc3_ = BubbleThumb(param1.bubbleThumbs.getValueByIndex(_loc2_));
            if(_loc3_.enable)
            {
               _loc4_ = new Image();
               if(_loc3_.isShowMsg)
               {
                  _loc6_ = new UtilLoadMgr();
                  _loc7_ = new Loader();
                  (_loc8_ = new Array()).push(_loc7_);
                  _loc8_.push(_loc3_);
                  _loc6_.setExtraData(_loc8_);
                  _loc6_.addEventDispatcher(_loc3_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc6_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedBubbleLoaderAgain);
                  _loc6_.commit();
                  _loc3_.loadImageData();
                  _loc4_.addChild(_loc7_);
               }
               else
               {
                  (_loc9_ = BubbleMgr.getBubbleByXML(XML(_loc3_.imageData))).text = "";
                  _loc4_.addChild(_loc9_);
                  _loc10_ = _loc9_.getSize();
                  _loc11_ = 1;
                  _loc12_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
                  _loc13_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
                  if(!(_loc10_.width <= _loc12_ && _loc10_.height <= _loc13_))
                  {
                     if(_loc10_.width > _loc12_ && _loc10_.height <= _loc13_)
                     {
                        _loc11_ = _loc12_ / _loc10_.width;
                     }
                     else if(_loc10_.width <= _loc12_ && _loc10_.height > _loc13_)
                     {
                        _loc11_ = _loc13_ / _loc10_.height;
                     }
                     else
                     {
                        _loc11_ = _loc12_ / _loc10_.width;
                        if(_loc10_.height * _loc11_ > _loc13_)
                        {
                           _loc11_ = _loc13_ / _loc10_.height;
                        }
                     }
                  }
                  _loc9_.scale = _loc11_;
                  _loc9_.stopAfterRedraw = true;
                  _loc4_.x = (AnimeConstants.TILE_BUBBLE_WIDTH - _loc10_.width * _loc11_) / 2;
                  _loc4_.y = (AnimeConstants.TILE_BUBBLE_HEIGHT - _loc10_.height * _loc11_) / 2;
               }
               _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.doDrag);
               (_loc5_ = new Canvas()).buttonMode = true;
               _loc5_.width = AnimeConstants.TILE_BUBBLE_WIDTH;
               _loc5_.height = AnimeConstants.TILE_BUBBLE_HEIGHT;
               _loc5_.scrollRect = new Rectangle(0,0,_loc5_.width,_loc5_.height);
               _loc5_.styleName = "tileBubble";
               _loc5_.addChild(_loc4_);
               this._uiTileBubbleThemes.addChild(_loc5_);
               _loc4_.graphics.beginFill(0,0);
               _loc4_.graphics.drawRect(0,0,_loc5_.width,_loc5_.height);
               _loc4_.graphics.endFill();
            }
            _loc2_++;
         }
      }
      
      public function ___uiTileBgUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"bg");
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropOtherThemes() : Tile
      {
         return this._1107253462_uiTilePropOtherThemes;
      }
      
      public function set _uiTilePropMaskThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1621423226_uiTilePropMaskThemes;
         if(_loc2_ !== param1)
         {
            this._1621423226_uiTilePropMaskThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropMaskThemes",_loc2_,param1));
         }
      }
      
      public function set _uiLabelBgUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1147366545_uiLabelBgUser;
         if(_loc2_ !== param1)
         {
            this._1147366545_uiLabelBgUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelBgUser",_loc2_,param1));
         }
      }
      
      public function set _userSoundNotUploadableNoticeText(param1:Text) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._258023566_userSoundNotUploadableNoticeText;
         if(_loc2_ !== param1)
         {
            this._258023566_userSoundNotUploadableNoticeText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundNotUploadableNoticeText",_loc2_,param1));
         }
      }
      
      public function set _uiTileBubbleThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._375869079_uiTileBubbleThemes;
         if(_loc2_ !== param1)
         {
            this._375869079_uiTileBubbleThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBubbleThemes",_loc2_,param1));
         }
      }
      
      public function loadBackgroundThumbs(param1:Theme, param2:UtilLoadMgr) : void
      {
         var _loc4_:Thumb = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(this._assetTheme == USER_THEME)
         {
            if(param1.backgroundThumbs.length < 3)
            {
               this._uiLabelBgUser.visible = true;
            }
            else
            {
               this._uiLabelBgUser.visible = false;
            }
         }
         else if(this._assetTheme == COMMON_THEME && param1.id != "common")
         {
            this._uiTileBgThemes.removeAllChildren();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.backgroundThumbs.length)
         {
            if((_loc4_ = param1.backgroundThumbs.getValueByIndex(_loc3_) as Thumb).enable)
            {
               _loc5_ = false;
               _loc6_ = 0;
               while(_loc6_ < _loc4_.colorRef.length)
               {
                  if(_loc4_.colorRef.getValueByIndex(_loc6_).@enable == "Y")
                  {
                     _loc5_ = true;
                     break;
                  }
                  _loc6_++;
               }
               if(_loc5_)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc4_.colorRef.length)
                  {
                     this.addBackgroundThumbToTheme(_loc3_,_loc4_,param2,_loc4_.colorRef.getKey(_loc6_));
                     _loc6_++;
                  }
               }
               else
               {
                  this.addBackgroundThumbToTheme(_loc3_,_loc4_,param2);
               }
            }
            _loc3_++;
         }
      }
      
      public function set _uiTileEffectCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2107238039_uiTileEffectCommunity;
         if(_loc2_ !== param1)
         {
            this._2107238039_uiTileEffectCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectCommunity",_loc2_,param1));
         }
      }
      
      private function scrollToGetAssets(param1:ScrollEvent, param2:String) : void
      {
         var _loc3_:Canvas = null;
         var _loc4_:* = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Tile = null;
         var _loc7_:Boolean = false;
         var _loc8_:Tile = null;
         var _loc9_:Boolean = false;
         var _loc10_:Tile = null;
         var _loc11_:Boolean = false;
         var _loc12_:Tile = null;
         var _loc13_:Boolean = false;
         var _loc14_:Tile = null;
         var _loc15_:Boolean = false;
         var _loc16_:Tile = null;
         var _loc17_:Boolean = false;
         if(param2 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc6_ = this._assetTheme == USER_THEME ? this._uiTileBgUser : this._uiTileBgCommunity;
            if(_loc7_ = this._assetTheme == USER_THEME ? this.hasMoreUserBg : this.hasMoreCommunityBg)
            {
               _loc4_ = (_loc4_ = (_loc6_.numChildren - 1) / 2) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc6_.verticalScrollPosition / _loc6_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc6_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc6_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc8_ = this._uiTileVideoPropUser;
            if(_loc9_ = this.hasMoreUserVideoProp)
            {
               _loc4_ = (_loc4_ = (_loc8_.numChildren - 1) / 2) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc8_.verticalScrollPosition / _loc8_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc8_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc8_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc10_ = this._assetTheme == USER_THEME ? this._uiTilePropUser : this._uiTilePropCommunity;
            if(_loc11_ = this._assetTheme == USER_THEME ? this.hasMoreUserProp : this.hasMoreCommunityProp)
            {
               _loc4_ = (_loc4_ = (_loc10_.numChildren - 1) / 4) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc10_.verticalScrollPosition / _loc10_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc10_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc10_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc12_ = this._assetTheme == USER_THEME ? this._uiTileCharUser : this._uiTileCharCommunity;
            if(_loc13_ = this._assetTheme == USER_THEME ? this.hasMoreUserChar : this.hasMoreCommunityChar)
            {
               _loc4_ = (_loc4_ = (_loc12_.numChildren - 1) / 4) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc12_.verticalScrollPosition / _loc12_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc12_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc12_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc14_ = this._assetTheme == USER_THEME ? this._uiTileEffectUser : this._uiTileEffectCommunity;
            if(_loc15_ = this._assetTheme == USER_THEME ? this.hasMoreUserEffect : this.hasMoreCommunityEffect)
            {
               _loc4_ = (_loc4_ = (_loc14_.numChildren - 1) / 4) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc14_.verticalScrollPosition / _loc14_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc14_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc14_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
         else
         {
            if(this._assetTheme == USER_THEME)
            {
               if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc16_ = this._userTileSoundMusicThemes;
                  _loc17_ = this.hasMoreUserSoundMusic;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc16_ = this._userTileSoundEffectThemes;
                  _loc17_ = this.hasMoreUserSoundEffect;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc16_ = this._userTileSoundVoiceThemes;
                  _loc17_ = this.hasMoreUserSoundTTS;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc16_ = this._userTileSoundVoiceThemes;
                  _loc17_ = this.hasMoreUserSoundVoice;
               }
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc17_ = this.hasMoreCommunitySoundMusic;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc17_ = this.hasMoreCommunitySoundEffect;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc17_ = this.hasMoreCommunitySoundTTS;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc17_ = this.hasMoreCommunitySoundVoice;
               }
            }
            if(_loc17_)
            {
               _loc4_ = (_loc4_ = (_loc16_.numChildren - 1) / 4) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc16_.verticalScrollPosition / _loc16_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc16_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc16_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  Console.getConsole().loadUserTheme(param2);
               }
            }
         }
      }
      
      public function set hasMoreCommunitySoundVoice(param1:Boolean) : void
      {
         this._hasMoreCommunitySoundVoice = param1;
      }
      
      private function _ThumbTray_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "emessage";
         _loc1_.overrides = [this._ThumbTray_SetProperty1_i(),this._ThumbTray_SetProperty2_i(),this._ThumbTray_SetProperty3_i()];
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiBtnSearch() : Button
      {
         return this._1282723535_uiBtnSearch;
      }
      
      private function loadUserAssetBackgroundThumbsComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:BitmapData = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
         var _loc4_:Bitmap;
         (_loc4_ = new Bitmap(_loc3_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         _loc4_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         var _loc5_:Image = Image(_loc2_.parent);
         _loc5_.removeChild(_loc5_.getChildByName("imageLoader"));
         _loc5_.addChild(_loc4_);
         var _loc6_:Canvas;
         (_loc6_ = new Canvas()).width = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc6_.scrollRect = new Rectangle(0,0,_loc6_.width,_loc6_.height);
         _loc6_.styleName = "tileBackground";
         _loc6_.addChild(_loc5_);
         this._uiTileBgUser.addChild(_loc6_);
         _loc4_.x = AnimeConstants.TILE_INSETS;
         _loc4_.y = AnimeConstants.TILE_INSETS;
         _loc5_.graphics.beginFill(0,0);
         _loc5_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
         _loc5_.graphics.endFill();
      }
      
      public function set _uiPropThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984000672_uiPropThemes;
         if(_loc2_ !== param1)
         {
            this._984000672_uiPropThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiPropThemes",_loc2_,param1));
         }
      }
      
      public function hide(param1:MouseEvent, param2:Boolean = false) : void
      {
         if(param2 || !(param1.stageX >= this.x && param1.stageX <= this.x + this.width + 15 && param1.stageY >= this.y && param1.stageY <= this.y + this.height - 3))
         {
            if(this.hidable && this.active)
            {
               if(this._effectMove.isPlaying)
               {
                  return;
               }
               if(this.VSThumbTray.y != -456)
               {
                  dispatchEvent(new Event("TrayClose"));
                  this._effectMove.yFrom = -15;
                  this._effectMove.yTo = -456;
                  this._effectMove.play();
                  this._effectResize.heightFrom = 471;
                  this._effectResize.heightTo = 30;
                  if(this._effectResize.hasEventListener(EffectEvent.EFFECT_START))
                  {
                     this._effectResize.removeEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
                  }
                  this._effectResize.play();
               }
            }
         }
      }
      
      public function ___uiTxtSearch_mouseDown(param1:MouseEvent) : void
      {
         this.onSearchFocusIn(param1);
      }
      
      private function _ThumbTray_Resize1_i() : Resize
      {
         var _loc1_:Resize = new Resize();
         this._effectResize = _loc1_;
         _loc1_.duration = 500;
         _loc1_.easingFunction = Quartic.easeOut;
         BindingManager.executeBindings(this,"_effectResize",this._effectResize);
         return _loc1_;
      }
      
      public function __VSThumbTray_click(param1:MouseEvent) : void
      {
         this.show();
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasPropUser() : Canvas
      {
         return this._1096140121_uiCanvasPropUser;
      }
      
      public function set _effectMove(param1:Move) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1491038559_effectMove;
         if(_loc2_ !== param1)
         {
            this._1491038559_effectMove = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectMove",_loc2_,param1));
         }
      }
      
      public function set _uiPopBtnSearch(param1:PopUpButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._682645850_uiPopBtnSearch;
         if(_loc2_ !== param1)
         {
            this._682645850_uiPopBtnSearch = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiPopBtnSearch",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorThemes() : TabNavigator
      {
         return this._939660622_uiNavigatorThemes;
      }
      
      public function set _uiCharThemeViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2109846365_uiCharThemeViewStack;
         if(_loc2_ !== param1)
         {
            this._2109846365_uiCharThemeViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCharThemeViewStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelVideoPropUser() : Label
      {
         return this._876679832_uiLabelVideoPropUser;
      }
      
      private function initTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,10,10,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colortitle");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",13);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","center");
         _loc5_.setStyle("horizontalCenter","1");
         var _loc6_:Text;
         (_loc6_ = new Text()).maxWidth = _loc2_.width * 0.95;
         _loc6_.text = UtilDict.toDisplay("go","thumbtray_colorsubtitle");
         _loc6_.setStyle("fontSize",15);
         var _loc7_:Canvas;
         (_loc7_ = new Canvas()).width = 207;
         _loc7_.height = 110;
         _loc7_.styleName = "imgBunnyArrow";
         var _loc8_:Label;
         (_loc8_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_coloricon");
         _loc8_.setStyle("fontSize",11);
         _loc8_.x = 96;
         _loc8_.y = 20;
         _loc7_.addChild(_loc8_);
         _loc5_.addChild(_loc6_);
         _loc5_.addChild(_loc7_);
         _loc2_._content.height = 170;
         _loc2_.setContent(_loc5_);
         var _loc9_:Canvas;
         (_loc9_ = new Canvas()).width = _loc2_.width;
         _loc9_.setStyle("horizontalCenter","1");
         _loc9_.buttonMode = true;
         var _loc10_:Label;
         (_loc10_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colorclose");
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = true;
         _loc10_.mouseChildren = false;
         _loc10_.x = (_loc9_.width - 80) / 2;
         _loc10_.setStyle("fontSize",14);
         _loc10_.addEventListener(MouseEvent.CLICK,this.closeTip);
         _loc9_.addChild(_loc10_);
         _loc2_.setClose(_loc9_);
      }
      
      public function set assetTheme(param1:String) : void
      {
         this._assetTheme = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropUser() : Tile
      {
         return this._1429951855_uiTilePropUser;
      }
      
      private function tileChangeHandler(param1:ChildExistenceChangedEvent) : void
      {
         var _loc2_:Tile = Tile(param1.currentTarget);
         var _loc3_:* = _loc2_.numChildren < 3;
         if(_loc2_ == this._uiTilePropUser)
         {
            this._uiLabelPropUser.visible = _loc3_;
         }
         else if(_loc2_ == this._uiTileBgUser)
         {
            this._uiLabelBgUser.visible = _loc3_;
         }
         else if(_loc2_ == this._uiTileBgUser)
         {
            this._uiLabelCharUser.visible = _loc3_;
         }
      }
      
      public function get hasMoreCommunityBg() : Boolean
      {
         return this._hasMoreCommunityBg;
      }
      
      public function loadCcTheme() : void
      {
         this._uiThemeButtonBar.selectedIndex = 0;
         this._themeSelection.setThemeById(THEME_ID_CUSTOM_WORLD);
         this.setIsCurrentThemeShouldLoadChar(false);
         this.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMyChar);
         Console.getConsole().loadTheme(THEME_ID_CUSTOM_WORLD);
      }
      
      public function set _uiTileCharYourChar(param1:FlowBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1921952448_uiTileCharYourChar;
         if(_loc2_ !== param1)
         {
            this._1921952448_uiTileCharYourChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharYourChar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set themeId(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this.themeId;
         if(_loc2_ !== param1)
         {
            this._1349701436themeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeId",_loc2_,param1));
         }
      }
      
      public function set _uiCanvasVideoPropUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._121879230_uiCanvasVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._121879230_uiCanvasVideoPropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasVideoPropUser",_loc2_,param1));
         }
      }
      
      private function loadBackgroundThumbsComplete(param1:Event) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Bitmap = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Image = Image(_loc2_.parent);
         var _loc4_:DisplayObject = DisplayObject(_loc2_.content);
         this.updateThumbColor(_loc3_,_loc4_);
         if(_loc2_.contentLoaderInfo.content is Bitmap)
         {
            _loc5_ = Util.capturePicture(_loc2_,new Rectangle(0,0,_loc2_.width,_loc2_.height));
            (_loc6_ = new Bitmap(_loc5_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         else
         {
            _loc5_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            (_loc6_ = new Bitmap(_loc5_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         if(_loc3_.getChildByName("imageLoader"))
         {
            _loc3_.removeChild(_loc3_.getChildByName("imageLoader"));
         }
         _loc3_.addChild(_loc6_);
         _loc6_.x = AnimeConstants.TILE_INSETS;
         _loc6_.y = AnimeConstants.TILE_INSETS;
         var _loc7_:Canvas = Canvas(_loc3_.parent);
         _loc3_.graphics.beginFill(0,0);
         _loc3_.drawRoundRect(0,0,_loc7_.width,_loc7_.height);
         _loc3_.graphics.endFill();
      }
      
      public function ___uiTileEffectCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"effect");
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiBtnUpload() : Button
      {
         return this._1214981750_uiBtnUpload;
      }
      
      private function onInputFinish(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.searchAsset();
         }
      }
      
      public function ___uiPopBtnSearch_creationComplete(param1:FlexEvent) : void
      {
         this.initSearchTypeMenu();
      }
      
      public function ___uiTileCharCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_CHAR);
      }
      
      public function set _uiTilePropCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._435498181_uiTilePropCommunity;
         if(_loc2_ !== param1)
         {
            this._435498181_uiTilePropCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropCommunity",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundVoiceThemes() : Tile
      {
         return this._1950667355_userTileSoundVoiceThemes;
      }
      
      public function get hasMoreUserSoundEffect() : Boolean
      {
         return this._hasMoreUserSoundEffect;
      }
      
      public function get hasMoreCommunitySoundMusic() : Boolean
      {
         return this._hasMoreCommunitySoundMusic;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgUser() : Tile
      {
         return this._957346193_uiTileBgUser;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblCommunity() : Label
      {
         return this._586953306_uiLblCommunity;
      }
      
      public function __dc_click(param1:MouseEvent) : void
      {
         this.show();
      }
      
      public function initThumbTrayDefaultTab(param1:Boolean) : void
      {
         this.startListenToUserTileChange();
         if(UtilLicense.getDefaultUserGoodiesTab(param1) == AnimeConstants.ASSET_TYPE_CHAR)
         {
         }
      }
      
      public function set _userSoundThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1693645137_userSoundThemes;
         if(_loc2_ !== param1)
         {
            this._1693645137_userSoundThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundThemes",_loc2_,param1));
         }
      }
      
      private function doStartListenToCommunityTileChange(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartListenToCommunityTileChange);
         }
         this.doNotListenToCommunityTileChange();
         this._uiNavigatorCommunity.addEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      private function onSearchFocusIn(param1:Event) : void
      {
         Console.getConsole().currentScene.selectedAsset = null;
         this.active = false;
      }
      
      public function ___uiTileCharUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"char");
      }
      
      public function ___uiLabelPropUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___uiTileCharUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundVoiceThemes() : Tile
      {
         return this._2083741102_uiTileSoundVoiceThemes;
      }
      
      public function set _uiCanvasUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._425225002_uiCanvasUser;
         if(_loc2_ !== param1)
         {
            this._425225002_uiCanvasUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasUser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasCommunity() : Canvas
      {
         return this._1122273858_uiCanvasCommunity;
      }
      
      private function _ThumbTray_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._ThumbTray_SetProperty3 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_ThumbTray_SetProperty3",this._ThumbTray_SetProperty3);
         return _loc1_;
      }
      
      public function initThemeDropdown() : void
      {
         var _loc1_:Number = NaN;
         var _loc6_:XML = null;
         var _loc7_:UtilHashArray = null;
         var _loc2_:XML = Console.getConsole().themeListXML;
         var _loc3_:Array = new Array();
         var _loc4_:UtilHashArray = new UtilHashArray();
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.child("theme").length())
         {
            if(!((_loc6_ = _loc2_.child("theme")[_loc1_]).hasOwnProperty("@cc_theme_id") && _loc6_.@cc_theme_id != "" && !UtilLicense.isUploadedAssetsEnabled()))
            {
               if(_loc6_.attribute("id") != "common")
               {
                  if(_loc6_.hasOwnProperty("@cc_theme_id") && _loc6_.@cc_theme_id != "")
                  {
                     _loc3_.unshift({
                        "label":_loc6_.attribute("name"),
                        "data":_loc6_.attribute("id")
                     });
                     (_loc7_ = new UtilHashArray()).push(_loc6_.attribute("id"),_loc6_.attribute("name"));
                     _loc4_.insert(0,_loc7_);
                     _loc5_++;
                  }
                  else
                  {
                     _loc3_.push({
                        "label":_loc6_.attribute("name"),
                        "data":_loc6_.attribute("id")
                     });
                     _loc4_.push(_loc6_.attribute("id"),_loc6_.attribute("name"));
                  }
               }
            }
            _loc1_++;
         }
         if(Console.getConsole().boxMode && _loc3_.length <= 1)
         {
         }
         if(UtilLicense.getCurrentLicenseId() == "7" || UtilLicense.isBoxEnvironment())
         {
            this._themeSelection.buildMenu(_loc4_,_loc5_,false,false);
         }
         else
         {
            this._themeSelection.buildMenu(_loc4_,_loc5_);
         }
      }
      
      public function get hasMoreCommunityEffect() : Boolean
      {
         return this._hasMoreCommunityEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasEffectUser() : Canvas
      {
         return this._71803449_uiCanvasEffectUser;
      }
      
      public function set createOwnCharButtonCanvasForProChar(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._130169060createOwnCharButtonCanvasForProChar;
         if(_loc2_ !== param1)
         {
            this._130169060createOwnCharButtonCanvasForProChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createOwnCharButtonCanvasForProChar",_loc2_,param1));
         }
      }
      
      private function doNotListenToUserTileChange() : void
      {
         this._uiNavigatorUser.removeEventListener(IndexChangedEvent.CHANGE,this.onUserAssetTileChange);
      }
      
      public function loadCharThumbs(param1:Theme, param2:UtilLoadMgr) : void
      {
         var _loc4_:UtilLazyHelper = null;
         var _loc6_:* = undefined;
         var _loc7_:CharThumb = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:Object = null;
         if(this._assetTheme == USER_THEME)
         {
            this._uiLabelCharUser.visible = Console.getConsole().userTheme.charThumbs.length < 3;
         }
         else if(this._assetTheme == COMMON_THEME && param1.id != "common")
         {
         }
         var _loc3_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         while(_loc5_ < param1.charThumbs.length)
         {
            if((_loc7_ = param1.charThumbs.getValueByIndex(_loc5_) as CharThumb).isCC && (this._assetTheme == COMMON_THEME || this.getIsCurrentThemeShouldLoadChar()))
            {
               _loc4_ = this.getLazyHelperThatCharThumbShouldBelongTo(_loc7_);
               _loc3_[_loc4_] = 1;
               if(_loc4_.getAttachedTempData() == null)
               {
                  _loc8_ = new UtilHashArray();
                  _loc4_.attachTempDataToMe(_loc8_);
               }
               else
               {
                  _loc8_ = _loc4_.getAttachedTempData() as UtilHashArray;
               }
               (_loc9_ = new Object())["i"] = _loc5_;
               _loc9_["currentCharThumb"] = _loc7_;
               _loc8_.push(_loc7_.id,_loc9_);
            }
            else
            {
               this.loadSingleCharThumbs(_loc5_,_loc7_,param2,true);
            }
            _loc5_++;
         }
         for(_loc6_ in _loc3_)
         {
            (_loc4_ = _loc6_ as UtilLazyHelper).start();
         }
      }
      
      public function ___uiLabelCharUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function set _uiLabelCharUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1785122530_uiLabelCharUser;
         if(_loc2_ !== param1)
         {
            this._1785122530_uiLabelCharUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelCharUser",_loc2_,param1));
         }
      }
      
      public function initThemeChosenById(param1:String) : void
      {
         this._uiThemeButtonBar.selectedIndex = 0;
         this._themeSelection.setThemeById(param1);
         var _loc2_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc2_.themeId = param1;
         this.onThemeChosen(_loc2_);
      }
      
      private function loadSoundThumbsComplete(param1:DisplayObject) : void
      {
         param1.width = this._uiSoundThemes.width;
      }
      
      public function updateThemeButton(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            if(this.assetTheme == COMMON_THEME)
            {
               this._uiThemeButtonBar.selectedIndex = 0;
            }
            else if(this.assetTheme == USER_THEME)
            {
               this._uiThemeButtonBar.selectedIndex = 1;
            }
            else if(this.assetTheme == COMMUNITY_THEME)
            {
               this._uiThemeButtonBar.selectedIndex = 2;
            }
         }
         else if(param1 == -1)
         {
            this._uiThemeButtonBar.selectedIndex = -1;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharCelebrities() : FlowBox
      {
         return this._833075766_uiTileCharCelebrities;
      }
      
      public function loadThumbs(param1:Theme, param2:Boolean = false, param3:Tile = null) : void
      {
         this._canDoPremium = Console.getConsole().premiumEnabled();
         var _loc4_:UtilLoadMgr;
         (_loc4_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadAllThumbsComplete);
         if(this._searching)
         {
            if(this._uiTileSearch == null)
            {
               this._uiTileSearch = new Tile();
               this._uiTileSearch.addEventListener(ScrollEvent.SCROLL,this.doSearchAssetPaging);
               this._uiTileSearch.label = UtilDict.toDisplay("go","thumbtray_result");
               this._uiTileSearch.name = "searchTile";
               this._uiTileSearch.buttonMode = true;
               this._uiTileSearch.horizontalScrollPolicy = ScrollPolicy.OFF;
            }
            if(this.searchType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_BACKGROUND_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_BACKGROUND_HEIGHT;
               this.loadBackgroundThumbs(param1,_loc4_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
               this.loadPropThumbs(param1,_loc4_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_CHAR_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_CHAR_HEIGHT;
               this.loadCharThumbs(param1,_loc4_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               this._uiTileSearch.tileWidth = Number.NaN;
               this._uiTileSearch.tileHeight = Number.NaN;
               this.loadSoundThumbs(param1);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_FX)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_BUBBLE_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_BUBBLE_HEIGHT;
               this.loadEffectThumbs(param1,_loc4_);
            }
         }
         else
         {
            if(this._assetTheme == COMMON_THEME && !this.getIsCurrentThemeShouldLoadChar())
            {
               this._fullReady = false;
               if(Console.getConsole().isCommonThemeLoadded)
               {
                  this.onCommonAssetTileChange(null,true);
               }
               else
               {
                  this.onCommonAssetTileChange(null,false);
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               this._userAssetsReady = false;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               this._communityAssetsReady = false;
            }
            if(this._assetTheme == USER_THEME || this._assetTheme == COMMUNITY_THEME || this.getIsCurrentThemeShouldLoadChar())
            {
               this.loadCharThumbs(param1,_loc4_);
               if(!param2)
               {
                  this.loadEffectThumbs(param1,_loc4_);
                  this.loadPropThumbs(param1,_loc4_,param3);
                  this.loadVideoPropThumbs(param1,_loc4_,param3);
                  this.loadBackgroundThumbs(param1,_loc4_);
                  if(param1.id != "common" || UtilLicense.isCommonSoundShouldBeShown(Console.getConsole().getCurTheme().id))
                  {
                     this.loadSoundThumbs(param1);
                  }
               }
            }
         }
         if(this._assetTheme == COMMON_THEME && !this.getIsCurrentThemeShouldLoadChar())
         {
            this.onLoadAllThumbsComplete();
         }
         else
         {
            _loc4_.commit();
         }
      }
      
      public function set _uiTilePropOtherThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1107253462_uiTilePropOtherThemes;
         if(_loc2_ !== param1)
         {
            this._1107253462_uiTilePropOtherThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropOtherThemes",_loc2_,param1));
         }
      }
      
      private function addNavChangeListener() : void
      {
         this._uiNavigatorThemes.addEventListener(Event.CHANGE,this.onCommonAssetTileChange);
         this._uiNavigatorCommunity.addEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      private function doLoadNewPurchasedChar(param1:AssetPurchasedEvent) : void
      {
         Console.getConsole().addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadSingleCcCharThumb);
         Console.getConsole().loadSingleCcChar(param1.assetId);
      }
      
      public function set pnlShadow(param1:Panel) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1700543726pnlShadow;
         if(_loc2_ !== param1)
         {
            this._1700543726pnlShadow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pnlShadow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiThemeButtonBar() : ToggleButtonBar
      {
         return this._725974475_uiThemeButtonBar;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgCommunity() : Tile
      {
         return this._391719453_uiTileBgCommunity;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHandHeldThemes() : Tile
      {
         return this._283652654_uiTilePropHandHeldThemes;
      }
      
      public function set _uiMaskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._18631945_uiMaskCanvas;
         if(_loc2_ !== param1)
         {
            this._18631945_uiMaskCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiMaskCanvas",_loc2_,param1));
         }
      }
      
      public function set _uiTileSoundEffectsThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1191025918_uiTileSoundEffectsThemes;
         if(_loc2_ !== param1)
         {
            this._1191025918_uiTileSoundEffectsThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundEffectsThemes",_loc2_,param1));
         }
      }
      
      public function get hasMoreUserSoundTTS() : Boolean
      {
         return this._hasMoreUserSoundTTS;
      }
      
      private function addThumbLoadingCanvas(param1:String, param2:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Tile = null;
         var _loc7_:int = 0;
         if(param2 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc3_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc4_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc5_ = "tileBackground";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileBgUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileBgCommunity;
            }
            _loc7_ = 18;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc3_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc4_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc5_ = "tileBackground";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileVideoPropUser;
            }
            _loc7_ = 18;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc3_ = AnimeConstants.TILE_PROP_WIDTH;
            _loc4_ = AnimeConstants.TILE_PROP_HEIGHT;
            _loc5_ = "tileProp";
            if(param1 == "user")
            {
               _loc6_ = this._uiTilePropUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTilePropCommunity;
            }
            _loc7_ = 10;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc3_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc4_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc5_ = "tileChar";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileCharUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileCharCommunity;
            }
            _loc7_ = 10;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc3_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc4_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc5_ = "tileEffect";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileEffectUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileEffectCommunity;
            }
            _loc7_ = 10;
         }
         var _loc8_:Canvas;
         (_loc8_ = new Canvas()).buttonMode = true;
         _loc8_.width = _loc3_;
         _loc8_.height = _loc4_;
         _loc8_.styleName = _loc5_;
         _loc8_.scrollRect = new Rectangle(0,0,_loc8_.width,_loc8_.height);
         _loc8_.name = "helperCanvas";
         var _loc9_:Label;
         (_loc9_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_loading");
         _loc9_.setStyle("fontWeight","bold");
         _loc9_.setStyle("fontSize",_loc7_);
         _loc8_.addChild(_loc9_);
         _loc9_.y = _loc8_.height / 2 - 10;
         if(_loc6_ != null && _loc6_.getChildByName("helperCanvas") == null)
         {
            _loc6_.addChild(_loc8_);
         }
      }
      
      public function set _uiTileCharProfessions(param1:FlowBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1957814528_uiTileCharProfessions;
         if(_loc2_ !== param1)
         {
            this._1957814528_uiTileCharProfessions = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharProfessions",_loc2_,param1));
         }
      }
      
      private function feedBackgroundLoaderAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:BackgroundThumb = _loc3_[1] as BackgroundThumb;
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadBackgroundThumbsComplete);
         _loc4_.loadBytes(ByteArray(_loc5_.thumbImageData));
      }
      
      public function getCurrentThemeId() : String
      {
         return this._themeSelection.currentThemeId;
      }
      
      public function set searchType(param1:String) : void
      {
         this._searchType = param1;
         if(this._uiPopBtnSearch != null)
         {
            if(param1 == AnimeConstants.ASSET_TYPE_BG)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check",
                  "toggled":"true"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check"
               }];
            }
            else if(param1 == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check",
                  "toggled":"true"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check"
               }];
            }
            else if(param1 == AnimeConstants.ASSET_TYPE_FX)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check",
                  "toggled":"true"
               }];
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblTheme() : Label
      {
         return this._1969718778_uiLblTheme;
      }
      
      private function showImporterWindow() : void
      {
         var _loc1_:GoAlert = null;
         if(Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            _loc1_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc1_._lblConfirm.text = "";
            _loc1_._txtDelete.text = "To import your own graphics, please use goanimate.com";
            _loc1_._btnDelete.visible = false;
            _loc1_._btnCancel.label = "OK";
            _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
            _loc1_.y = 100;
            return;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasBgUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_BG);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_PROP_HEAD);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_CHAR);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasEffectUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_FX);
         }
         else if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            if(this._userSoundThemes.selectedChild == this._userTileSoundMusicThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
            }
            else if(this._userSoundThemes.selectedChild == this._userTileSoundEffectThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
            }
            else if(this._userSoundThemes.selectedChild == this._userTileSoundVoiceThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER);
            }
            else
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
            }
         }
      }
      
      private function _ThumbTray_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._ThumbTray_SetProperty2 = _loc1_;
         _loc1_.name = "label";
         BindingManager.executeBindings(this,"_ThumbTray_SetProperty2",this._ThumbTray_SetProperty2);
         return _loc1_;
      }
      
      public function get hasMoreCommunityChar() : Boolean
      {
         return this._hasMoreCommunityChar;
      }
      
      public function set createOwnCharButtonCanvasForCelebritiesChar(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1493528824createOwnCharButtonCanvasForCelebritiesChar;
         if(_loc2_ !== param1)
         {
            this._1493528824createOwnCharButtonCanvasForCelebritiesChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createOwnCharButtonCanvasForCelebritiesChar",_loc2_,param1));
         }
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      public function ___uiTilePropUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function get hasMoreCommunityProp() : Boolean
      {
         return this._hasMoreCommunityProp;
      }
      
      public function set _uiCharThemeAccordion(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1939118856_uiCharThemeAccordion;
         if(_loc2_ !== param1)
         {
            this._1939118856_uiCharThemeAccordion = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCharThemeAccordion",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharThemes() : Tile
      {
         return this._2055258657_uiTileCharThemes;
      }
      
      public function get hasMoreUserVideoProp() : Boolean
      {
         return this._hasMoreUserVideoProp;
      }
      
      private function doLoadSingleCcCharThumb(param1:CoreEvent) : void
      {
         var _loc7_:String = null;
         var _loc8_:CharThumb = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadSingleCcCharThumb);
         var _loc2_:Object = param1.getData();
         var _loc3_:Theme = _loc2_["lastLoadedTheme"] as Theme;
         var _loc4_:Array = _loc2_["newCharIdArray"] as Array;
         var _loc5_:UtilLoadMgr = new UtilLoadMgr();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc6_] as String;
            _loc8_ = _loc3_.getCharThumbById(_loc7_);
            this.loadSingleCharThumbs(_loc3_.charThumbs.getIndex(_loc7_),_loc8_,_loc5_,false);
            _loc6_++;
         }
         _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doShowTheNewCharToUser);
         _loc5_.commit();
      }
      
      private function getLazyHelperThatCharThumbShouldBelongTo(param1:CharThumb) : UtilLazyHelper
      {
         if(param1.theme.id == "ugc")
         {
            return this._uiTileCharYourChar_lazyHelper;
         }
         if(param1.tags.search("professions") >= 0)
         {
            return this._uiTileCharProfessions_lazyHelper;
         }
         if(param1.tags.search("celebrities") >= 0)
         {
            return this._uiTileCharCelebrities_lazyHelper;
         }
         return this._uiTileCharCelebrities_lazyHelper;
      }
      
      private function searchAsset() : void
      {
         if(StringUtil.trim(this._uiTxtSearch.text).length > 0)
         {
            this._currentSsearchText = this._uiTxtSearch.text;
            this._currentSearchPage = 0;
            this._currentSearchType = this.searchType;
            this._hasMoreSearch = true;
            this._searching = true;
            this.clearSearchResults();
            Console.getConsole().searchAsset(this._uiTxtSearch.text,this._currentSearchType,this._currentSearchPage,AnimeConstants.SEARCH_ASSET_PAGE_SIZE);
         }
         else
         {
            Alert.show(UtilDict.toDisplay("go","thumbtray_nokey"),UtilDict.toDisplay("go","thumbtray_nokeytitle"));
         }
      }
      
      private function clearThemeSoundThumbs() : void
      {
         this._uiTileSoundMusicThemes.removeAllChildren();
         this._uiTileSoundEffectsThemes.removeAllChildren();
         this._uiTileSoundVoiceThemes.removeAllChildren();
      }
      
      private function loadCharThumbsComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Image = null;
         var _loc11_:Rectangle = null;
         var _loc12_:MovieClip = null;
         if(param1 is LoadEmbedMovieEvent)
         {
            _loc2_ = null;
            _loc3_ = CCThumb(param1.currentTarget) as CCThumb;
            _loc4_ = Image(CCThumb(param1.currentTarget).parent);
         }
         else
         {
            _loc2_ = Loader(param1.target.loader);
            _loc3_ = _loc2_.content;
            _loc4_ = Image(_loc2_.parent);
         }
         var _loc5_:Canvas = Canvas(_loc4_.parent);
         if(_loc2_ != null)
         {
            if((_loc12_ = UtilPlain.getCharacterFlip(MovieClip(_loc3_))) != null)
            {
               _loc12_.visible = false;
            }
         }
         var _loc6_:Number = _loc3_.width;
         var _loc7_:Number = _loc3_.height;
         var _loc8_:Number = 1;
         var _loc9_:Number = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc10_:Number = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(_loc2_ != null)
         {
            if(!(_loc6_ <= _loc9_ && _loc7_ <= _loc10_))
            {
               if(_loc6_ > _loc9_ && _loc7_ <= _loc10_)
               {
                  _loc8_ = _loc9_ / _loc6_;
                  _loc3_.width = _loc9_;
                  _loc3_.height *= _loc8_;
               }
               else if(_loc6_ <= _loc9_ && _loc7_ > _loc10_)
               {
                  _loc8_ = _loc10_ / _loc7_;
                  _loc3_.width *= _loc8_;
                  _loc3_.height = _loc10_;
               }
               else
               {
                  _loc8_ = _loc9_ / _loc6_;
                  if(_loc7_ * _loc8_ > _loc10_)
                  {
                     _loc8_ = _loc10_ / _loc7_;
                     _loc3_.width *= _loc8_;
                     _loc3_.height = _loc10_;
                  }
                  else
                  {
                     _loc3_.width = _loc9_;
                     _loc3_.height *= _loc8_;
                  }
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc11_ = _loc2_.getBounds(_loc2_);
            _loc2_.x = AnimeConstants.TILE_CHAR_WIDTH / 2;
            _loc2_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc3_.height) / 2;
            _loc2_.y -= _loc11_.top;
         }
         else
         {
            _loc3_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc3_.width) / 2;
            _loc3_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc3_.height) / 2;
         }
         UtilPlain.stopFamily(_loc3_);
         _loc4_.graphics.beginFill(0,0);
         _loc4_.drawRoundRect(0,0,_loc5_.width,_loc5_.height);
         _loc4_.graphics.endFill();
         this.updateThumbColor(_loc4_,_loc3_);
      }
      
      private function feedPropLoaderAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadPropThumbsComplete);
         _loc4_.loadBytes(ByteArray(_loc5_.imageData));
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharCommunity() : Tile
      {
         return this._1953398322_uiTileCharCommunity;
      }
      
      private function _ThumbTray_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._ThumbTray_SetProperty1 = _loc1_;
         _loc1_.name = "label";
         BindingManager.executeBindings(this,"_ThumbTray_SetProperty1",this._ThumbTray_SetProperty1);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasTheme() : Canvas
      {
         return this._298324450_uiCanvasTheme;
      }
      
      private function doUpdateSoundNonUploadableNotice(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdateSoundNonUploadableNotice);
         this._userSoundNotUploadableNoticeText.text = UtilDict.toDisplay("go",AnimeConstants.SOUND_NON_UPLOADABLE_MSG) + " " + Console.getConsole().currentLicensorName;
      }
      
      public function set createOwnCharButtonCanvasForYourChar(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._92238088createOwnCharButtonCanvasForYourChar;
         if(_loc2_ !== param1)
         {
            this._92238088createOwnCharButtonCanvasForYourChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createOwnCharButtonCanvasForYourChar",_loc2_,param1));
         }
      }
      
      public function set _btnMyChar(param1:anifire.components.studio.MyCharButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1063809249_btnMyChar;
         if(_loc2_ !== param1)
         {
            this._1063809249_btnMyChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMyChar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorUser() : TabNavigator
      {
         return this._1809035697_uiNavigatorUser;
      }
      
      private function loadEffectThumbs(param1:Theme, param2:UtilLoadMgr) : void
      {
         var _loc4_:EffectThumb = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.effectThumbs.length)
         {
            if((_loc4_ = EffectThumb(param1.effectThumbs.getValueByIndex(_loc3_))).enable)
            {
               this.addEffectThumbToTheme(_loc3_,_loc4_,param2);
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTxtSearch() : TextInput
      {
         return this._45803963_uiTxtSearch;
      }
      
      public function disallowUploadedAssets() : void
      {
      }
      
      private function doCloseImporter(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doCloseImporter);
         Console.getConsole().closeImporter();
      }
      
      private function initClientThemeBanner(param1:Event) : void
      {
      }
      
      private function setIsCurrentThemeShouldLoadChar(param1:Boolean) : void
      {
         this._isCurrentThemeShouldLoadChar = param1;
      }
      
      public function ___uiTileSoundVoiceThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER);
      }
      
      public function set _uiBtnSearch(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1282723535_uiBtnSearch;
         if(_loc2_ !== param1)
         {
            this._1282723535_uiBtnSearch = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiBtnSearch",_loc2_,param1));
         }
      }
      
      private function doLazyLoadCharThumbs(param1:LazyHelperEvent) : void
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:CharThumb = null;
         var _loc2_:UtilLazyHelper = param1.target as UtilLazyHelper;
         var _loc3_:UtilHashArray = _loc2_.getAttachedTempData() as UtilHashArray;
         var _loc4_:Number = 12;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_.length <= 0)
            {
               break;
            }
            _loc6_ = _loc3_.getValueByIndex(0);
            _loc3_.remove(0,1);
            _loc7_ = _loc6_["i"] as int;
            _loc8_ = _loc6_["currentCharThumb"] as CharThumb;
            this.loadSingleCharThumbs(_loc7_,_loc8_,null,true);
            _loc5_++;
         }
      }
      
      public function get hasMoreUserSoundVoice() : Boolean
      {
         return this._hasMoreUserSoundVoice;
      }
      
      public function ___uiBtnUpload_click(param1:MouseEvent) : void
      {
         this.showImporterWindow();
      }
      
      private function loadSoundThumbs(param1:Theme) : void
      {
         var _loc4_:SoundThumb = null;
         var _loc2_:Array = param1.soundThumbs.clone().getArray();
         _loc2_.sortOn("name",Array.CASEINSENSITIVE);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if((_loc4_ = _loc2_[_loc3_] as SoundThumb).enable)
            {
               this.addSoundTileCell(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function ___userTileSoundVoiceThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER);
      }
      
      private function doSearchAssetPaging(param1:Event) : void
      {
         if(this._uiTileSearch.verticalScrollPosition >= this._uiTileSearch.maxVerticalScrollPosition - this._uiTileSearch.tileHeight && this._hasMoreSearch && !this._searching)
         {
            ++this._currentSearchPage;
            this._searching = true;
            Console.getConsole().searchAsset(this._uiTxtSearch.text,this._currentSearchType,this._currentSearchPage,AnimeConstants.SEARCH_ASSET_PAGE_SIZE);
         }
      }
      
      private function get updatable() : Boolean
      {
         return this._updatable;
      }
      
      private function addCharThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr = null, param4:String = "", param5:Boolean = true) : void
      {
         var _loc10_:Object = null;
         var _loc11_:UtilLoadMgr = null;
         var _loc12_:Array = null;
         var _loc13_:DisplayObjectContainer = null;
         var _loc6_:Loader = new Loader();
         var _loc7_:CCThumb = new CCThumb();
         trace("[thumb.id, thumb.imageData]:" + [param2.id,param2.imageData]);
         if(param2.imageData != null)
         {
            if(!CharThumb(param2).isCC)
            {
               _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCharThumbsComplete);
               if(param3 != null)
               {
                  param3.addEventDispatcher(_loc6_.contentLoaderInfo,Event.COMPLETE);
               }
               _loc6_.loadBytes(ByteArray(param2.imageData));
            }
            else
            {
               _loc10_ = param2.imageData as Object;
               _loc7_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.loadCharThumbsComplete);
               _loc7_.init(_loc10_["xml"] as XML,_loc10_["imageData"] as UtilHashArray);
               if(param3 != null)
               {
                  param3.addEventDispatcher(_loc7_,LoadEmbedMovieEvent.COMPLETE_EVENT);
               }
            }
         }
         else
         {
            trace("preparing char thumb:" + param2.id);
            _loc11_ = new UtilLoadMgr();
            (_loc12_ = new Array()).push(_loc6_);
            _loc12_.push(param2);
            _loc12_.push(_loc7_);
            _loc11_.setExtraData(_loc12_);
            _loc11_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc11_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedCharLoaderAgain);
            _loc11_.commit();
            this.callLater(param2.loadImageData);
         }
         var _loc8_:Image;
         (_loc8_ = new Image()).addChild(_loc6_);
         _loc8_.addChild(_loc7_);
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            _loc8_.toolTip = param2.name;
         }
         _loc8_.addEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         var _loc9_:ThumbnailCanvas = new ThumbnailCanvas(AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT,_loc8_,param2,this._assetTheme == USER_THEME ? true : false,param2.isCC,this._canDoPremium,param4);
         if((param2 as CharThumb).isCC)
         {
            _loc9_.addEventListener(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this.doDispatchUserWantToCopyThumbEvent);
            _loc9_.addEventListener(AssetPurchasedEvent.ASSET_PURCHASED,this.doLoadNewPurchasedChar);
         }
         if(this._searching)
         {
            this._uiTileSearch.addChildAt(_loc9_,param5 ? int(this._uiTileSearch.numChildren) : 0);
         }
         else if(this._assetTheme == COMMON_THEME || this.getIsCurrentThemeShouldLoadChar())
         {
            if(param2.theme.id == "ugc" && param2.isCC)
            {
               _loc13_ = this._uiTileCharYourChar;
            }
            else if(Console.getConsole().isThemeCcRelated(param2.theme.id) && param2.isCC)
            {
               _loc13_ = this.getTileThatCharThumbShouldBelongTo(param2 as CharThumb);
            }
            else
            {
               _loc13_ = this._uiTileCharThemes;
            }
            if(_loc13_ != this._uiTileCharThemes)
            {
               _loc13_.addChildAt(_loc9_,param5 ? _loc13_.numChildren - 1 : 0);
            }
            else
            {
               _loc13_.addChildAt(_loc9_,param5 ? _loc13_.numChildren : 0);
            }
         }
         else if(this._assetTheme == USER_THEME)
         {
            this._uiTileCharUser.addChildAt(_loc9_,param5 ? int(this._uiTileCharUser.numChildren) : 0);
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this._uiTileCharCommunity.addChildAt(_loc9_,param5 ? int(this._uiTileCharCommunity.numChildren) : 0);
         }
      }
      
      public function ___ThumbTray_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initThumbTray();
      }
      
      private function doLoadMyChar(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadMyChar);
         setTimeout(this.doFinishLoadingChar,1000);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBubbleThemes() : Tile
      {
         return this._375869079_uiTileBubbleThemes;
      }
      
      public function changeToFullSize(param1:Boolean = true) : void
      {
         this.pnlShadow.visible = false;
         this.dc.visible = false;
         this._uiCanvasTheme.visible = false;
         this._uiCanvasUser.visible = false;
         this._uiCanvasCommunity.visible = false;
         this.main_cav.y = 37;
         this.VSThumbTray.y = -15;
         this._uiCanvasTheme.height += 15;
         this._uiCanvasTheme.setStyle("backgroundAlpha",0);
         this._uiCanvasTheme.setStyle("borderStyle","none");
         if(param1)
         {
         }
         this._uiNavigatorThemes.height += 15;
         this._uiLblTheme.visible = false;
         this._uiCanvasUser.height += 15;
         this._uiCanvasUser.setStyle("backgroundAlpha",0);
         this._uiCanvasUser.setStyle("borderStyle","none");
         if(param1)
         {
         }
         this._uiNavigatorUser.height += 15;
         this._uiLblUser.visible = false;
         this._uiCanvasCommunity.height += 41;
         this._uiCanvasCommunity.setStyle("backgroundAlpha",0);
         this._uiCanvasCommunity.setStyle("borderStyle","none");
         if(param1)
         {
         }
         this._uiNavigatorCommunity.height += 13;
         this._uiLblCommunity.visible = false;
         this._uiTxtSearch.x = 5;
         this._uiTxtSearch.width += 15;
         this._uiTxtSearch.y = 465 - 21 - 20;
         this._uiPopBtnSearch.x += 5;
         this._uiPopBtnSearch.y = 465 - 21 - 20;
         this._uiBtnSearch.x += 5;
         this._uiBtnSearch.y = 465 - 21 - 20;
         this.height += 9 - 16;
         this.main_cav.height += 9 - 16;
         this.VSThumbTray.height += 9 - 16;
         this.scrollRect = new Rectangle(0,0,this.width,this.height);
         this._uiThemeButtonBar.invalidateDisplayList();
         this._uiThemeButtonBar.invalidateSize();
         if(param1)
         {
            this._uiThemeButtonBar.styleName = "themeButtonsFull";
         }
         this._uiThemeButtonBar.x = 0;
         this._uiThemeButtonBar.height = 38;
         this._uiThemeButtonBar.width = 300;
         if(param1)
         {
            this._uiBtnUpload.width = 80;
            this._uiBtnUpload.height = 22.6;
         }
         this._uiThemeButtonBar.visible = false;
      }
      
      public function ___ThumbTray_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().doShowCreateMyCharAlert(param1);
      }
      
      public function popMaskImage(param1:Object, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:MaskImage;
         (_loc6_ = MaskImage(PopUpManager.createPopUp(this,MaskImage,true))).addEventListener(FlexEvent.CREATION_COMPLETE,this.doCenterMaskImage);
         if(Console.getConsole().studioType == Console.MESSAGE_STUDIO)
         {
            _loc6_.addEventListener(Event.REMOVED_FROM_STAGE,this.doCloseImporter);
         }
         _loc6_.x = 5;
         _loc6_.y = 5;
         _loc6_.placeable = param3;
         _loc6_.holdable = param4;
         _loc6_.headable = param5;
         _loc6_.editImage = param1;
         _loc6_.assetId = param2;
         Console.getConsole().currentScene.stopScene();
      }
      
      public function set _uiNavigatorThemes(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939660622_uiNavigatorThemes;
         if(_loc2_ !== param1)
         {
            this._939660622_uiNavigatorThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorThemes",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiPopBtnSearch() : PopUpButton
      {
         return this._682645850_uiPopBtnSearch;
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectMove() : Move
      {
         return this._1491038559_effectMove;
      }
      
      public function onLoadUserPropComplete() : void
      {
         var _loc4_:ThumbnailCanvas = null;
         var _loc1_:Number = Number(this._uiTileVideoPropUser.numChildren);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            if((_loc4_ = this._uiTileVideoPropUser.getChildAt(_loc3_) as ThumbnailCanvas) != null && _loc4_.thumb is VideoPropThumb)
            {
               if(VideoPropThumb(_loc4_.thumb).videoWidth == 0 && VideoPropThumb(_loc4_.thumb).videoHeight == 0)
               {
                  _loc2_.push(VideoPropThumb(_loc4_.thumb).id);
               }
            }
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            setTimeout(this.updateVideoStatus,30000,_loc2_);
         }
      }
      
      public function ___uiTilePropUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectCommunity() : Tile
      {
         return this._2107238039_uiTileEffectCommunity;
      }
      
      private function initSearchTypeMenu() : void
      {
         this._uiMenuSearchType = new Menu();
         var _loc1_:Object = [{
            "label":UtilDict.toDisplay("go","thumbtray_prop"),
            "value":"thumbtray_prop",
            "type":"check"
         },{
            "label":UtilDict.toDisplay("go","thumbtray_background"),
            "value":"thumbtray_background",
            "type":"check",
            "toggled":"true"
         },{
            "label":UtilDict.toDisplay("go","thumbtray_effect"),
            "value":"thumbtray_effect",
            "type":"check"
         }];
         this._uiMenuSearchType.dataProvider = _loc1_;
         this._uiMenuSearchType.addEventListener("itemClick",this.itemClickHandler);
         this._uiPopBtnSearch.popUp = this._uiMenuSearchType;
      }
      
      public function set _uiCanvasPropUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1096140121_uiCanvasPropUser;
         if(_loc2_ !== param1)
         {
            this._1096140121_uiCanvasPropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasPropUser",_loc2_,param1));
         }
      }
      
      public function ___uiTileVideoPropUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"video");
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundThemes() : Accordion
      {
         return this._1693645137_userSoundThemes;
      }
      
      public function set hidable(param1:Boolean) : void
      {
         this._hidable = param1;
      }
      
      public function set hasMoreUserBg(param1:Boolean) : void
      {
         this._hasMoreUserBg = param1;
      }
      
      public function get userAssetType() : String
      {
         return this._userAssetType;
      }
      
      private function doRePositionBubbleThumb(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doRePositionBubbleThumb);
         var _loc2_:Loader = param1.target.loader as Loader;
         var _loc3_:Rectangle = new Rectangle(AnimeConstants.TILE_INSETS,AnimeConstants.TILE_INSETS,AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2,AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2);
         UtilPlain.centerAlignObj(_loc2_,_loc3_,true);
      }
      
      private function feedEffectLoaderAgain(param1:LoadMgrEvent) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Image = _loc3_[0] as Image;
         var _loc5_:SuperEffect = _loc3_[1] as SuperEffect;
         var _loc6_:EffectThumb = _loc3_[2] as EffectThumb;
         _loc5_.addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.loadEffectThumbsComplete);
         _loc7_ = _loc5_.loadThumbnail(_loc6_.imageData as ByteArray);
         _loc4_.addChild(_loc7_);
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharYourChar() : FlowBox
      {
         return this._1921952448_uiTileCharYourChar;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasVideoPropUser() : Canvas
      {
         return this._121879230_uiCanvasVideoPropUser;
      }
      
      private function doLoadCcCharThumb(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadCcCharThumb);
         var _loc2_:Object = param1.getData();
         var _loc3_:Theme = Console.getConsole().userTheme;
         this.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadThumbForCurrentTab);
         this.loadThumbs(_loc3_,true);
      }
      
      public function set _uiLabelVideoPropUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._876679832_uiLabelVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._876679832_uiLabelVideoPropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelVideoPropUser",_loc2_,param1));
         }
      }
      
      private function doFinishLoadingChar() : void
      {
         this.setIsCurrentThemeShouldLoadChar(true);
         if(this._shouldShowCharTabOnCcLoaded)
         {
            this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
            this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
         }
         Console.getConsole().addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadCcCharThumb);
         Console.getConsole().loadCcChar();
      }
      
      public function ___uiPopBtnSearch_click(param1:MouseEvent) : void
      {
         this.searchAsset();
      }
      
      public function set _assetTrayBg(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._658818924_assetTrayBg;
         if(_loc2_ !== param1)
         {
            this._658818924_assetTrayBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTrayBg",_loc2_,param1));
         }
      }
      
      public function set hasMoreUserSoundMusic(param1:Boolean) : void
      {
         this._hasMoreUserSoundMusic = param1;
      }
      
      private function onShowPropTray() : void
      {
         var _loc2_:Text = null;
         var _loc1_:Boolean = true;
         if(Console.getConsole().siteId != "0")
         {
            _loc1_ = false;
         }
         if(Console.getConsole().isThemeCcRelated(this.getCurrentThemeId()))
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            this._uiTilePropHeadThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
            this._uiTilePropHeadThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
            this._uiTilePropHeadThemes.setStyle("paddingTop",0);
            this._uiTilePropHeadThemes.setStyle("paddingLeft",0);
         }
         else
         {
            _loc2_ = new Text();
            _loc2_.text = UtilDict.toDisplay("go","thumbtray_headswapwarn");
            _loc2_.selectable = false;
            _loc2_.width = 288;
            _loc2_.setStyle("textAlign","left");
            _loc2_.setStyle("color","0x333333");
            _loc2_.setStyle("fontSize","13");
            this._uiTilePropHeadThemes.removeAllChildren();
            this._uiTilePropHeadThemes.tileWidth = 306;
            this._uiTilePropHeadThemes.tileHeight = 100;
            this._uiTilePropHeadThemes.setStyle("paddingTop",50);
            this._uiTilePropHeadThemes.setStyle("paddingLeft",5);
            if(this._assetTheme == COMMON_THEME)
            {
               this._uiTilePropHeadThemes.addChild(_loc2_);
            }
         }
      }
      
      public function set _uiTilePropUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1429951855_uiTilePropUser;
         if(_loc2_ !== param1)
         {
            this._1429951855_uiTilePropUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropUser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelCharUser() : Label
      {
         return this._1785122530_uiLabelCharUser;
      }
      
      private function doShowTheNewCharToUser(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowTheNewCharToUser);
         this._uiCharThemeAccordion.selectedChild = this._uiTileCharYourChar;
         this._uiTileCharYourChar.verticalScrollPosition = 0;
      }
      
      public function switchTheme(param1:String, param2:String = "prop") : void
      {
         this.stopAllSounds();
         this.show();
         this._assetTheme = param1;
         if(param1 == COMMON_THEME)
         {
            Util.gaTracking("/gostudio/" + param1 + "/loaded",this.stage);
         }
         else if(param1 == USER_THEME)
         {
            if(!this.userAssetsReady)
            {
               Util.gaTracking("/gostudio/" + param1 + "/loading",this.stage);
               Console.getConsole().addEventListener(CoreEvent.LOAD_USER_ASSET_COMPLETE,this.doDispatchSwitchCompleteEvent);
               Util.gaTracking("/gostudio/" + param1 + "/loading/" + this._userAssetType,this.stage);
               this._userAssetType = param2;
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               this.doDispatchSwitchCompleteEvent(null);
               Util.gaTracking("/gostudio/" + this._assetTheme + "/loaded",this.stage);
            }
         }
         else if(param1 == COMMUNITY_THEME)
         {
            if(!this.communityAssetsReady)
            {
               Util.gaTracking("/gostudio/" + param1 + "/loading",this.stage);
               Console.getConsole().addEventListener(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this.doDispatchSwitchCompleteEvent);
               Util.gaTracking("/gostudio/" + param1 + "/loading/" + this.searchType,this.stage);
               Console.getConsole().loadUserTheme(this.searchType);
            }
            else
            {
               this.doDispatchSwitchCompleteEvent(null);
               Util.gaTracking("/gostudio/" + param1 + "/loaded",this.stage);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiMaskCanvas() : Canvas
      {
         return this._18631945_uiMaskCanvas;
      }
      
      public function show() : void
      {
         if(this.active)
         {
            if(this._effectMove.isPlaying)
            {
               return;
            }
            if(this.VSThumbTray.y != -15)
            {
               this._effectMove.yFrom = -456;
               this._effectMove.yTo = -15;
               this._effectMove.play();
               this._effectResize.heightFrom = 30;
               this._effectResize.heightTo = this.VSThumbTray.height;
               this._effectResize.addEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
               this._effectResize.play();
            }
         }
      }
      
      public function set hasMoreCommunityBg(param1:Boolean) : void
      {
         this._hasMoreCommunityBg = param1;
      }
      
      private function initThumbTray() : void
      {
         var _loc1_:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".thumbTrayIcon");
         var _loc2_:Class = _loc1_.getStyle("iconChar") as Class;
         var _loc3_:Class = _loc1_.getStyle("iconBubble") as Class;
         var _loc4_:Class = _loc1_.getStyle("iconBackground") as Class;
         var _loc5_:Class = _loc1_.getStyle("iconProp") as Class;
         var _loc6_:Class = _loc1_.getStyle("iconSound") as Class;
         var _loc7_:Class = _loc1_.getStyle("iconEffect") as Class;
         var _loc8_:Class = _loc1_.getStyle("iconVideo") as Class;
         this._uiCharThemeViewStack.icon = this._uiCanvasCharUser.icon = this._uiTileCharCommunity.icon = _loc2_;
         this._uiTileBubbleThemes.icon = _loc3_;
         this._uiTileBgCommunity.icon = this._uiTileBgThemes.icon = this._uiCanvasBgUser.icon = _loc4_;
         this._uiTilePropCommunity.icon = this._uiCanvasPropUser.icon = this._uiPropThemes.icon = _loc5_;
         this._uiCanvasVideoPropUser.icon = _loc8_;
         this._uiSoundThemes.icon = this._userSoundThemes.icon = _loc6_;
         this._uiTileEffectCommunity.icon = this._uiTileEffectThemes.icon = this._uiCanvasEffectUser.icon = _loc7_;
         this._uiTileCharThemes.tileWidth = AnimeConstants.TILE_CHAR_WIDTH;
         this._uiTileCharThemes.tileHeight = AnimeConstants.TILE_CHAR_HEIGHT;
         this._uiTileBubbleThemes.tileWidth = AnimeConstants.TILE_BUBBLE_WIDTH;
         this._uiTileBubbleThemes.tileHeight = AnimeConstants.TILE_BUBBLE_HEIGHT;
         this._uiTilePropHandHeldThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropHandHeldThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropMaskThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropMaskThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropHeadThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropHeadThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropOtherThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropOtherThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTileBgThemes.tileWidth = AnimeConstants.TILE_BACKGROUND_WIDTH;
         this._uiTileBgThemes.tileHeight = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         this._uiThemeButtonBar.addEventListener(ItemClickEvent.ITEM_CLICK,this.onClickThemeButton);
         this._uiTileCharProfessions_lazyHelper.registerScrollBarEventDispatcher(this._uiTileCharProfessions,this._uiCharThemeAccordion,this._uiCharThemeViewStack,AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT);
         this._uiTileCharProfessions_lazyHelper.addEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,this.doLazyLoadCharThumbs);
         this._uiTileCharProfessions_lazyHelper.addEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this.doLazyLoadCharThumbs);
         this._uiTileCharCelebrities_lazyHelper.registerScrollBarEventDispatcher(this._uiTileCharCelebrities,this._uiCharThemeAccordion,this._uiCharThemeViewStack,AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT);
         this._uiTileCharCelebrities_lazyHelper.addEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,this.doLazyLoadCharThumbs);
         this._uiTileCharCelebrities_lazyHelper.addEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this.doLazyLoadCharThumbs);
         this._uiTileCharYourChar_lazyHelper.registerScrollBarEventDispatcher(this._uiTileCharYourChar,this._uiCharThemeAccordion,this._uiCharThemeViewStack,AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT);
         this._uiTileCharYourChar_lazyHelper.addEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,this.doLazyLoadCharThumbs);
         this._uiTileCharYourChar_lazyHelper.addEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this.doLazyLoadCharThumbs);
         if(!UtilLicense.isSoundUploadable)
         {
            this.showSoundNonUploadableNotice();
         }
         else
         {
            this.destroySoundNonUploadableNotice();
         }
         if(!UtilLicense.isHeadSectionShouldBeShownInThumbtray(UtilLicense.getCurrentLicenseId()))
         {
            this._uiPropThemes.removeChild(this._uiTilePropHeadThemes);
         }
         if(!UtilLicense.isHeadGearSectionShouldBeShownInThumbtray(UtilLicense.getCurrentLicenseId()))
         {
            this._uiPropThemes.removeChild(this._uiTilePropMaskThemes);
         }
         if(UtilLicense.getCurrentLicenseId() == "8" || UtilLicense.getCurrentLicenseId() == "7" || UtilLicense.isBoxEnvironment())
         {
            this._btnMyChar.buttonMode = false;
            this._btnMyChar.mouseChildren = false;
            this._btnMyChar.mouseEnabled = false;
         }
         if(!UtilUser.isUserVip())
         {
            this._uiLabelCharUser.scaleX = this._uiLabelCharUser.scaleY = this._uiLabelCharUser.alpha = 0;
         }
         if(!UtilUser.isBeta())
         {
            this._uiNavigatorUser.removeChild(this._uiCanvasVideoPropUser);
         }
         this.addNavChangeListener();
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      private function onDropDownChange(param1:Event) : void
      {
      }
      
      public function set _effectResize(param1:Resize) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1764850564_effectResize;
         if(_loc2_ !== param1)
         {
            this._1764850564_effectResize = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectResize",_loc2_,param1));
         }
      }
      
      private function destroySoundNonUploadableNotice() : void
      {
         this._userSoundThemes.removeChild(this._userSoundNotUploadableNotice);
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this.active = !param1;
         this._uiMaskCanvas.visible = param1;
      }
      
      public function gotoSpecifiedTabInCommunityGoodies(param1:Object) : void
      {
         if(param1 as String == AnimeConstants.ASSET_TYPE_BG)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_BG;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileBgCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileCharCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_PROP;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTilePropCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_FX)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_FX;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileEffectCommunity;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCharThemeAccordion() : Accordion
      {
         return this._1939118856_uiCharThemeAccordion;
      }
      
      public function set hasMoreCommunitySoundEffect(param1:Boolean) : void
      {
         this._hasMoreCommunitySoundEffect = param1;
      }
      
      public function get userAssetsReady() : Boolean
      {
         return this._userAssetsReady;
      }
      
      public function changeToMessageMode() : void
      {
         this.changeToFullSize(false);
         currentState = "emessage";
         this._uiThemeButtonBar.visible = true;
         this._uiThemeButtonBar.styleName = "themeButtonsMessage";
         this._uiThemeButtonBar.x = -130;
         this._uiThemeButtonBar.height = 38;
         this._uiThemeButtonBar.width = 380;
         this._uiThemeButtonBar.graphics.lineStyle(0,0,0);
         this._uiThemeButtonBar.graphics.beginFill(16777215);
         this._uiThemeButtonBar.graphics.drawRect(250,this._uiThemeButtonBar.height - 5,10,5);
         this._uiThemeButtonBar.graphics.endFill();
         this._uiCanvasTheme.visible = false;
         this.VSThumbTray.selectedChild = this._uiCanvasUser;
         this.gotoSpecifiedTabInMyGoodies(AnimeConstants.ASSET_TYPE_PROP);
         this._uiNavigatorUser.styleName = "containerBlue";
         this._uiNavigatorUser.width = 250;
         this._uiNavigatorUser.height = 280;
         this._uiNavigatorUser.y -= 39;
         this._uiCanvasUser.setStyle("cornerRadius",0);
         this._uiCanvasUser.setStyle("borderThickness",10);
         this._uiNavigatorCommunity.styleName = "containerBlue";
         this._uiNavigatorCommunity.width = 250;
         this._uiNavigatorCommunity.height = 310;
         this._uiNavigatorCommunity.y -= 39;
         this._uiLabelPropUser.x = 600;
         this._uiLabelPropUser.alpha = 0;
         this._uiBtnSearch.visible = false;
         this._uiTxtSearch.visible = false;
         this._uiBtnUpload.label = UtilDict.toDisplay("go","thumbtray_importhead");
         this._uiBtnUpload.styleName = "btnBlue";
         this._uiBtnUpload.x = 0;
         this._uiBtnUpload.y = 300;
         this._themeSelection.visible = false;
      }
      
      public function set _uiLblResult(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._991343744_uiLblResult;
         if(_loc2_ !== param1)
         {
            this._991343744_uiLblResult = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblResult",_loc2_,param1));
         }
      }
      
      public function set _uiBtnUpload(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1214981750_uiBtnUpload;
         if(_loc2_ !== param1)
         {
            this._1214981750_uiBtnUpload = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiBtnUpload",_loc2_,param1));
         }
      }
      
      private function addPropThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Tile, param5:String = "") : void
      {
         var _loc7_:ThumbnailCanvas = null;
         var _loc8_:Tile = null;
         var _loc12_:Loader = null;
         var _loc13_:Function = null;
         var _loc14_:UtilLoadMgr = null;
         var _loc15_:Array = null;
         var _loc16_:DisplayObject = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:ThumbnailCanvas = null;
         trace("addPropThumbToTheme:" + [param1,param2.id,PropThumb(param2).subType,param5,param2.theme.id]);
         var _loc6_:Boolean = false;
         if(param4 == null)
         {
            if(this._searching)
            {
               _loc8_ = this._uiTileSearch;
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               if(PropThumb(param2).holdable)
               {
                  _loc8_ = this._uiTilePropHandHeldThemes;
               }
               else if(PropThumb(param2).wearable)
               {
                  _loc8_ = this._uiTilePropMaskThemes;
               }
               else if(PropThumb(param2).headable)
               {
                  _loc8_ = this._uiTilePropHeadThemes;
               }
               else
               {
                  _loc8_ = this._uiTilePropOtherThemes;
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               _loc8_ = this._uiTilePropUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               _loc8_ = this._uiTilePropCommunity;
            }
         }
         else
         {
            _loc8_ = param4;
         }
         var _loc9_:Number;
         if((_loc9_ = Number(_loc8_.numChildren)) > 0)
         {
            param1 = 0;
            while(param1 < _loc9_)
            {
               if(_loc8_.getChildAt(param1) is ThumbnailCanvas && ThumbnailCanvas(_loc8_.getChildAt(param1)).thumb.id == param2.id)
               {
                  _loc7_ = ThumbnailCanvas(_loc8_.getChildAt(param1));
                  _loc6_ = true;
                  break;
               }
               param1++;
            }
         }
         var _loc10_:Image = new Image();
         var _loc11_:Boolean = false;
         if(!(param2 is VideoPropThumb) || param2 is VideoPropThumb && VideoPropThumb(param2).videoHeight > 0 && VideoPropThumb(param2).videoWidth > 0)
         {
            (_loc12_ = new Loader()).name = AnimeConstants.LOADER_NAME + param1;
            param3.addEventDispatcher(_loc12_.contentLoaderInfo,Event.COMPLETE);
            if(param2.imageData != null)
            {
               if(param2 is VideoPropThumb)
               {
                  _loc13_ = this.loadVideoPropThumbsComplete;
               }
               else
               {
                  _loc13_ = this.loadPropThumbsComplete;
               }
               _loc12_.contentLoaderInfo.addEventListener(Event.COMPLETE,_loc13_);
               _loc12_.loadBytes(ByteArray(param2.imageData));
            }
            else
            {
               _loc14_ = new UtilLoadMgr();
               (_loc15_ = new Array()).push(_loc12_);
               _loc15_.push(param2);
               _loc14_.setExtraData(_loc15_);
               _loc14_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               _loc14_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedPropLoaderAgain);
               _loc14_.commit();
               this.callLater(param2.loadImageData);
            }
            _loc10_.addChild(_loc12_);
         }
         else
         {
            _loc16_ = VideoPropThumb(param2).loadThumbnail();
            _loc10_.addChild(_loc16_);
            _loc11_ = true;
         }
         _loc10_.addEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            _loc10_.toolTip = param2.name;
         }
         if(_loc6_)
         {
            if(param2 is VideoPropThumb)
            {
               VideoPropThumb(_loc7_.thumb).videoHeight = VideoPropThumb(param2).videoHeight;
               VideoPropThumb(_loc7_.thumb).videoWidth = VideoPropThumb(param2).videoWidth;
            }
            _loc7_.updateDisplayObject(_loc10_,_loc11_);
         }
         else
         {
            if(param2 is VideoPropThumb)
            {
               _loc17_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
               _loc18_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            }
            else
            {
               _loc17_ = AnimeConstants.TILE_PROP_WIDTH;
               _loc18_ = AnimeConstants.TILE_PROP_HEIGHT;
            }
            _loc19_ = new ThumbnailCanvas(_loc17_,_loc18_,_loc10_,param2,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium,param5,true,0,true);
            _loc8_.addChild(_loc19_);
         }
         if(param2 is VideoPropThumb && VideoPropThumb(param2).videoHeight <= 0 && VideoPropThumb(param2).videoWidth <= 0)
         {
            _loc10_.removeEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         }
      }
      
      public function set hasMoreCommunitySoundMusic(param1:Boolean) : void
      {
         this._hasMoreCommunitySoundMusic = param1;
      }
      
      public function set _uiTileBgUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._957346193_uiTileBgUser;
         if(_loc2_ !== param1)
         {
            this._957346193_uiTileBgUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgUser",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMyChar() : anifire.components.studio.MyCharButton
      {
         return this._1063809249_btnMyChar;
      }
      
      public function ___uiPropThemes_show(param1:FlexEvent) : void
      {
         this.onShowPropTray();
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharProfessions() : FlowBox
      {
         return this._1957814528_uiTileCharProfessions;
      }
      
      public function ___uiTileBgUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function set hasMoreSearch(param1:Boolean) : void
      {
         this._hasMoreSearch = param1;
      }
      
      private function clearThemePropThumbs() : void
      {
         this._uiTilePropHandHeldThemes.removeAllChildren();
         this._uiTilePropMaskThemes.removeAllChildren();
         this._uiTilePropHeadThemes.removeAllChildren();
         this._uiTilePropOtherThemes.removeAllChildren();
      }
      
      private function clearAllBubbleThumbs() : void
      {
         this._uiTileBubbleThemes.removeAllChildren();
      }
      
      private function onThemeChosen(param1:ThemeChosenEvent) : void
      {
         var _loc2_:String = null;
         this._switchTheme = true;
         this.setIsCurrentThemeShouldLoadChar(false);
         if(param1.themeId == "User")
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            if(param1.assetType != null)
            {
               this.doNotListenToUserTileChange();
               this.addEventListener(CoreEvent.SWITCH_TO_USER_THEME_COMPLETE,this.doStartListenToUserTileChange);
               this.gotoSpecifiedTabInMyGoodies(param1.assetType);
            }
            _loc2_ = param1.assetType != null ? param1.assetType : AnimeConstants.ASSET_TYPE_PROP;
            this.switchTheme(USER_THEME,_loc2_);
         }
         else if(param1.themeId == "Comm")
         {
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            if(param1.assetType != null)
            {
               this.doNotListenToCommunityTileChange();
               this.addEventListener(CoreEvent.SWITCH_TO_COMMUNITY_THEME_COMPLETE,this.doStartListenToCommunityTileChange);
               this.gotoSpecifiedTabInCommunityGoodies(param1.assetType);
            }
            this.switchTheme(COMMUNITY_THEME);
         }
         else if(Console.getConsole().isThemeCcRelated(param1.themeId))
         {
            this.assetTheme = COMMON_THEME;
            this.VSThumbTray.selectedChild = this._uiCanvasTheme;
            if(param1.assetType != null)
            {
               this._uiNavigatorThemes.removeEventListener(Event.CHANGE,this.onCommonAssetTileChange);
               switch(param1.assetType)
               {
                  case AnimeConstants.ASSET_TYPE_CHAR:
                     this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
                     this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
                     break;
                  case AnimeConstants.ASSET_TYPE_BUBBLE:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBubbleThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BG:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBgThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_PROP:
                     this._uiNavigatorThemes.selectedChild = this._uiPropThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND:
                     this._uiNavigatorThemes.selectedChild = this._uiSoundThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_FX:
                     this._uiNavigatorThemes.selectedChild = this._uiTileEffectThemes;
               }
               callLater(this.addNavChangeListener);
            }
            this.switchTheme(COMMON_THEME);
            this.loadCcTheme();
         }
         else
         {
            this.assetTheme = COMMON_THEME;
            this.VSThumbTray.selectedChild = this._uiCanvasTheme;
            if(param1.assetType != null)
            {
               this._uiNavigatorThemes.removeEventListener(Event.CHANGE,this.onCommonAssetTileChange);
               switch(param1.assetType)
               {
                  case AnimeConstants.ASSET_TYPE_CHAR:
                     this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
                     this._uiCharThemeViewStack.selectedChild = this._uiTileCharThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BUBBLE:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBubbleThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BG:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBgThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_PROP:
                     this._uiNavigatorThemes.selectedChild = this._uiPropThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND:
                     this._uiNavigatorThemes.selectedChild = this._uiSoundThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_FX:
                     this._uiNavigatorThemes.selectedChild = this._uiTileEffectThemes;
               }
               callLater(this.addNavChangeListener);
            }
            Console.getConsole().loadTheme(param1.themeId);
         }
      }
      
      public function ___uiTileVideoPropUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function set _userTileSoundVoiceThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1950667355_userTileSoundVoiceThemes;
         if(_loc2_ !== param1)
         {
            this._1950667355_userTileSoundVoiceThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundVoiceThemes",_loc2_,param1));
         }
      }
      
      public function set hasMoreUserSoundEffect(param1:Boolean) : void
      {
         this._hasMoreUserSoundEffect = param1;
      }
      
      public function set _uiLblCommunity(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._586953306_uiLblCommunity;
         if(_loc2_ !== param1)
         {
            this._586953306_uiLblCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblCommunity",_loc2_,param1));
         }
      }
      
      private function itemClickHandler(param1:MenuEvent) : void
      {
         var _loc2_:String = String(param1.item.value);
         if(_loc2_ == "thumbtray_background")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_BG;
         }
         else if(_loc2_ == "thumbtray_prop")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_PROP;
         }
         else if(_loc2_ == "thumbtray_char")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
         }
         else if(_loc2_ == "thumbtray_effect")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_FX;
         }
         this._uiPopBtnSearch.close();
      }
      
      public function set hasMoreUserEffect(param1:Boolean) : void
      {
         this._hasMoreUserEffect = param1;
      }
      
      public function ___ThumbTray_Button2_click(param1:MouseEvent) : void
      {
         Console.getConsole().doShowCreateMyCharAlert(param1);
      }
      
      private function getIsUiTilePropHandHeldThemesEmpty() : Boolean
      {
         var _loc1_:int = 0;
         if(this._uiTilePropHandHeldThemes.numChildren + this._uiTilePropMaskThemes.numChildren + this._uiTilePropHeadThemes.numChildren + this._uiTilePropOtherThemes.numChildren == 0)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropHandHeldThemes.numChildren)
         {
            if(this._uiTilePropHandHeldThemes.getChildAt(_loc1_) is Image)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropMaskThemes.numChildren)
         {
            if(this._uiTilePropMaskThemes.getChildAt(_loc1_) is Image)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropHeadThemes.numChildren)
         {
            if(this._uiTilePropHeadThemes.getChildAt(_loc1_) is Image)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropOtherThemes.numChildren)
         {
            if(this._uiTilePropOtherThemes.getChildAt(_loc1_) is Image)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function getIsCurrentThemeShouldLoadChar() : Boolean
      {
         if(this._assetTheme == COMMON_THEME)
         {
            return this._isCurrentThemeShouldLoadChar;
         }
         return false;
      }
      
      public function set _uiTileSoundVoiceThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2083741102_uiTileSoundVoiceThemes;
         if(_loc2_ !== param1)
         {
            this._2083741102_uiTileSoundVoiceThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundVoiceThemes",_loc2_,param1));
         }
      }
      
      private function mouseOverSoundBtnHandler(param1:Event) : void
      {
         this.mouseOverSoundBtn = true;
      }
      
      public function get hasMoreUserBg() : Boolean
      {
         return this._hasMoreUserBg;
      }
      
      public function ___uiTileEffectUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      private function getIsUiTileCharThemesEmpty() : Boolean
      {
         var _loc1_:int = 0;
         if(this._uiTileCharThemes.numChildren <= 0 && this._uiTileCharYourChar.numChildren <= 1 && this._uiTileCharProfessions.numChildren <= 1 && this._uiTileCharCelebrities.numChildren <= 1)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTileCharThemes.numChildren)
         {
            if(this._uiTileCharThemes.getChildAt(_loc1_) is ThumbnailCanvas)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTileCharYourChar.numChildren)
         {
            if(this._uiTileCharYourChar.getChildAt(_loc1_) is ThumbnailCanvas)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTileCharProfessions.numChildren)
         {
            if(this._uiTileCharProfessions.getChildAt(_loc1_) is ThumbnailCanvas)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTileCharCelebrities.numChildren)
         {
            if(this._uiTileCharCelebrities.getChildAt(_loc1_) is ThumbnailCanvas)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get hidable() : Boolean
      {
         return this._hidable;
      }
      
      public function get hasMoreUserSoundMusic() : Boolean
      {
         return this._hasMoreUserSoundMusic;
      }
      
      public function showUserGoodies(param1:String) : void
      {
         this._themeSelection._themeId.text = "Your Stuff";
         this._uiThemeButtonBar.selectedIndex = 1;
         if(param1 == AnimeConstants.ASSET_TYPE_BG)
         {
            this._uiNavigatorUser.selectedChild = this._uiCanvasBgUser;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP || param1 == AnimeConstants.ASSET_TYPE_PROP_HEAD || param1 == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || param1 == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasPropUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasPropUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasCharUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasCharUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_SOUND || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            if(this._uiNavigatorUser.selectedChild != this._userSoundThemes)
            {
               this._uiNavigatorUser.selectedChild = this._userSoundThemes;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasVideoPropUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasVideoPropUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
      }
      
      private function onUserAssetTileChange(param1:Event) : void
      {
         this._assetTheme = ThumbTray.USER_THEME;
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_CHAR;
            if(!this._userCharReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasBgUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_BG;
            if(!this._userBgReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               this._uiLabelBgUser.visible = this._uiTileBgUser.numChildren < 3;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_PROP;
            if(!this._userPropReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               this._uiLabelPropUser.visible = this._uiTilePropUser.numChildren < 3;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_CHAR;
            if(!this._userCharReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(AnimeConstants.ASSET_TYPE_CHAR);
            }
            else
            {
               this._uiLabelCharUser.visible = this._uiTileCharUser.numChildren < 3;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_SOUND;
            if(!this._userSoundReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasEffectUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_FX;
            if(!this._userEffectReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasVideoPropUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
            if(!this._userVideoPropReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               Console.getConsole().loadUserTheme(this._userAssetType);
            }
            else
            {
               this._uiLabelVideoPropUser.visible = this._uiTileVideoPropUser.numChildren < 3;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
      }
      
      private function doNotListenToCommunityTileChange() : void
      {
         this._uiNavigatorCommunity.removeEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      [Bindable(event="propertyChange")]
      public function get _assetTrayBg() : Canvas
      {
         return this._658818924_assetTrayBg;
      }
      
      private function loadPropThumbsComplete(param1:Event) : void
      {
         var _loc9_:DisplayObject = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height *= _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width *= _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width *= _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height *= _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x -= _loc8_.left;
         _loc2_.y -= _loc8_.top;
         if(_loc2_.content is MovieClip)
         {
            _loc9_ = DisplayObject(_loc2_.content);
            UtilPlain.stopFamily(_loc9_);
         }
         var _loc10_:Image = Image(_loc2_.parent);
         var _loc11_:Canvas;
         if((_loc11_ = Canvas(_loc10_.parent)) != null)
         {
            _loc10_.graphics.beginFill(0,0);
            _loc10_.drawRoundRect(0,0,_loc11_.width,_loc11_.height);
            _loc10_.graphics.endFill();
         }
         this.updateThumbColor(_loc10_,_loc9_);
      }
      
      public function set _userSoundNotUploadableNotice(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._87478335_userSoundNotUploadableNotice;
         if(_loc2_ !== param1)
         {
            this._87478335_userSoundNotUploadableNotice = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundNotUploadableNotice",_loc2_,param1));
         }
      }
      
      public function clearTheme() : void
      {
         this.clearAllBubbleThumbs();
         this.clearAllCharThumbs();
         this.clearAllEffectThumbs();
         this.clearThemeBackgroundThumbs();
         this.clearThemePropThumbs();
         this.clearThemeSoundThumbs();
      }
      
      private function clearAllCharThumbs() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         this._uiTileCharThemes.removeAllChildren();
         _loc2_ = this._uiTileCharYourChar.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._uiTileCharYourChar.getChildAt(_loc2_);
            if(_loc1_ is ThumbnailCanvas)
            {
               this._uiTileCharYourChar.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         _loc2_ = this._uiTileCharProfessions.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._uiTileCharProfessions.getChildAt(_loc2_);
            if(_loc1_ is ThumbnailCanvas)
            {
               this._uiTileCharProfessions.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         _loc2_ = this._uiTileCharCelebrities.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._uiTileCharCelebrities.getChildAt(_loc2_);
            if(_loc1_ is ThumbnailCanvas)
            {
               this._uiTileCharCelebrities.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         this._uiTileCharCelebrities_lazyHelper.clear();
         this._uiTileCharProfessions_lazyHelper.clear();
         this._uiTileCharYourChar_lazyHelper.clear();
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectResize() : Resize
      {
         return this._1764850564_effectResize;
      }
      
      public function ___uiTilePropUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"prop");
      }
      
      public function get hasMoreCommunitySoundEffect() : Boolean
      {
         return this._hasMoreCommunitySoundEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblResult() : Label
      {
         return this._991343744_uiLblResult;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ThumbTray = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ThumbTray_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ThumbTrayWatcherSetupUtil");
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
      
      private function closeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         this.removeChild(_loc2_);
      }
      
      public function registerShouldShowCharTabOnCcLoaded(param1:Boolean) : void
      {
         this._shouldShowCharTabOnCcLoaded = param1;
      }
      
      public function set _uiCanvasCommunity(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1122273858_uiCanvasCommunity;
         if(_loc2_ !== param1)
         {
            this._1122273858_uiCanvasCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasCommunity",_loc2_,param1));
         }
      }
      
      public function set _uiCanvasEffectUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._71803449_uiCanvasEffectUser;
         if(_loc2_ !== param1)
         {
            this._71803449_uiCanvasEffectUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasEffectUser",_loc2_,param1));
         }
      }
      
      public function set hasMoreCommunityEffect(param1:Boolean) : void
      {
         this._hasMoreCommunityEffect = param1;
      }
      
      public function set _uiTileCharCelebrities(param1:FlowBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._833075766_uiTileCharCelebrities;
         if(_loc2_ !== param1)
         {
            this._833075766_uiTileCharCelebrities = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharCelebrities",_loc2_,param1));
         }
      }
      
      public function set _uiTilePropHandHeldThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._283652654_uiTilePropHandHeldThemes;
         if(_loc2_ !== param1)
         {
            this._283652654_uiTilePropHandHeldThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHandHeldThemes",_loc2_,param1));
         }
      }
      
      public function set _uiThemeButtonBar(param1:ToggleButtonBar) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._725974475_uiThemeButtonBar;
         if(_loc2_ !== param1)
         {
            this._725974475_uiThemeButtonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiThemeButtonBar",_loc2_,param1));
         }
      }
      
      private function addBackgroundThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:String = "") : void
      {
         var _loc8_:UtilLoadMgr = null;
         var _loc9_:Array = null;
         var _loc5_:Loader;
         (_loc5_ = new Loader()).name = AnimeConstants.LOADER_NAME;
         param3.addEventDispatcher(_loc5_.contentLoaderInfo,Event.COMPLETE);
         if(param2.thumbImageData != null)
         {
            _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadBackgroundThumbsComplete);
            _loc5_.loadBytes(ByteArray(param2.thumbImageData));
         }
         else
         {
            _loc8_ = new UtilLoadMgr();
            (_loc9_ = new Array()).push(_loc5_);
            _loc9_.push(param2);
            _loc8_.setExtraData(_loc9_);
            _loc8_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedBackgroundLoaderAgain);
            _loc8_.commit();
            this.callLater(param2.loadImageData);
         }
         var _loc6_:Image;
         (_loc6_ = new Image()).addChild(_loc5_);
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            _loc6_.toolTip = param2.name;
         }
         _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         var _loc7_:ThumbnailCanvas = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc6_,param2,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium,param4);
         if(this._searching)
         {
            this._uiTileSearch.addChild(_loc7_);
         }
         else if(this._assetTheme == COMMON_THEME)
         {
            this._uiTileBgThemes.addChild(_loc7_);
         }
         else if(this._assetTheme == USER_THEME)
         {
            this._uiTileBgUser.addChild(_loc7_);
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this._uiTileBgCommunity.addChild(_loc7_);
         }
      }
      
      public function ___uiTxtSearch_keyDown(param1:KeyboardEvent) : void
      {
         this.onInputFinish(param1);
      }
      
      public function get hasMoreUserEffect() : Boolean
      {
         return this._hasMoreUserEffect;
      }
      
      private function loadEffectThumbsComplete(param1:EffectEvt) : void
      {
         var _loc2_:DisplayObject = param1.thumbnail;
         trace("on preparing effect thumb complete:" + _loc2_);
         var _loc3_:Image = _loc2_.parent as Image;
         var _loc4_:Rectangle = _loc2_.getBounds(_loc2_);
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc4_.width <= _loc6_ && _loc4_.height <= _loc7_))
         {
            if(_loc4_.width > _loc6_ && _loc4_.height <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc4_.width;
            }
            else if(_loc4_.width <= _loc6_ && _loc4_.height > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_.height;
            }
            else
            {
               _loc5_ = _loc6_ / _loc4_.width;
               if(_loc4_.height * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_.height;
               }
            }
         }
         _loc2_.scaleX = _loc5_;
         _loc2_.scaleY = _loc5_;
         _loc2_.x = -1 * (_loc4_.left + _loc4_.right) / 2 * _loc5_ + AnimeConstants.TILE_BUBBLE_WIDTH / 2;
         _loc2_.y = -1 * (_loc4_.top + _loc4_.bottom) / 2 * _loc5_ + AnimeConstants.TILE_BUBBLE_HEIGHT / 2;
      }
      
      private function doDispatchSwitchCompleteEvent(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDispatchSwitchCompleteEvent);
            Util.gaTracking("/gostudio/" + this._assetTheme + "/complete",this.stage);
         }
         if(this._assetTheme == USER_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SWITCH_TO_USER_THEME_COMPLETE,this));
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SWITCH_TO_COMMUNITY_THEME_COMPLETE,this));
         }
      }
      
      public function set _uiCanvasCharUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._769621044_uiCanvasCharUser;
         if(_loc2_ !== param1)
         {
            this._769621044_uiCanvasCharUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasCharUser",_loc2_,param1));
         }
      }
      
      public function onClickThemeButton(param1:ItemClickEvent) : void
      {
         if(param1.index == 0)
         {
            this.switchTheme(COMMON_THEME);
         }
         else if(param1.index == 1)
         {
            this.switchTheme(USER_THEME);
         }
         else if(param1.index == 2)
         {
            this.switchTheme(COMMUNITY_THEME);
         }
         Console.getConsole().showOverTray(false);
      }
      
      public function set _userTileSoundEffectThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._596357074_userTileSoundEffectThemes;
         if(_loc2_ !== param1)
         {
            this._596357074_userTileSoundEffectThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundEffectThemes",_loc2_,param1));
         }
      }
      
      public function ___uiTilePropCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"prop");
      }
      
      public function set _uiTileEffectThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1956363228_uiTileEffectThemes;
         if(_loc2_ !== param1)
         {
            this._1956363228_uiTileEffectThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectThemes",_loc2_,param1));
         }
      }
      
      public function removeLoadingCanvas(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = this._uiTileBgCommunity.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTileBgCommunity.removeChild(_loc2_);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc2_ = this._uiTilePropCommunity.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTilePropCommunity.removeChild(_loc2_);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc2_ = this._uiTileVideoPropUser.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTileVideoPropUser.removeChild(_loc2_);
            }
         }
      }
      
      public function updateSearchCount(param1:int) : void
      {
         this._uiLblResult.text = StringUtil.substitute(UtilDict.toDisplay("go","{0} asset(s) found."),param1.toString());
      }
      
      private function loadSingleCharThumbs(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Boolean) : void
      {
         var _loc6_:int = 0;
         if(!param2.enable)
         {
            return;
         }
         var _loc5_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < param2.colorRef.length)
         {
            if(param2.colorRef.getValueByIndex(_loc6_).@enable == "Y")
            {
               _loc5_ = true;
               trace("shouldAddColorSet:" + _loc5_);
               break;
            }
            _loc6_++;
         }
         if(_loc5_)
         {
            trace("thumb.colorRef.length:" + param2.colorRef.length);
            _loc6_ = 0;
            while(_loc6_ < param2.colorRef.length)
            {
               this.addCharThumbToTheme(param1,param2,param3,param2.colorRef.getKey(_loc6_),param4);
               _loc6_++;
            }
         }
         else
         {
            this.addCharThumbToTheme(param1,param2,param3,"",param4);
         }
      }
      
      private function getTileThatCharThumbShouldBelongTo(param1:CharThumb) : Container
      {
         if(param1.theme.id == "ugc")
         {
            return this._uiTileCharYourChar;
         }
         if(param1.tags.search("_category_professions") >= 0)
         {
            return this._uiTileCharProfessions;
         }
         if(param1.tags.search("_category_celebrities") >= 0)
         {
            return this._uiTileCharCelebrities;
         }
         return this._uiTileCharCelebrities;
      }
      
      public function ___themeSelection_theme_chosen(param1:ThemeChosenEvent) : void
      {
         this.onThemeChosen(param1);
      }
      
      public function set _uiTileBgCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._391719453_uiTileBgCommunity;
         if(_loc2_ !== param1)
         {
            this._391719453_uiTileBgCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgCommunity",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundNotUploadableNotice() : Canvas
      {
         return this._87478335_userSoundNotUploadableNotice;
      }
      
      public function set _uiNavigatorCommunity(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1629274085_uiNavigatorCommunity;
         if(_loc2_ !== param1)
         {
            this._1629274085_uiNavigatorCommunity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorCommunity",_loc2_,param1));
         }
      }
      
      private function updateVideoStatus(param1:Array) : void
      {
         Console.getConsole().loadConvertedVideo(param1);
      }
      
      public function ___userSoundNotUploadableNotice_render(param1:Event) : void
      {
         this.doUpdateSoundNonUploadableNotice(param1);
      }
      
      public function loadVideoPropThumbs(param1:Theme, param2:UtilLoadMgr, param3:Tile = null) : void
      {
         var _loc5_:Thumb = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.videoPropThumbs.length)
         {
            if((_loc5_ = param1.videoPropThumbs.getValueByIndex(_loc4_) as Thumb).enable)
            {
               this.addPropThumbToTheme(_loc4_,_loc5_,param2,this._uiTileVideoPropUser);
            }
            _loc4_++;
         }
         this.onShowPropTray();
      }
      
      private function clearThemeBackgroundThumbs() : void
      {
         this._uiTileBgThemes.removeAllChildren();
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundEffectThemes() : Tile
      {
         return this._596357074_userTileSoundEffectThemes;
      }
      
      public function set _themeSelection(param1:anifire.components.studio.ThemeSelection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1992358882_themeSelection;
         if(_loc2_ !== param1)
         {
            this._1992358882_themeSelection = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_themeSelection",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasCharUser() : Canvas
      {
         return this._769621044_uiCanvasCharUser;
      }
      
      public function set _uiLblUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1737616366_uiLblUser;
         if(_loc2_ !== param1)
         {
            this._1737616366_uiLblUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblUser",_loc2_,param1));
         }
      }
      
      public function clearSearchResults() : void
      {
         if(this._uiTileSearch != null)
         {
            this._uiTileSearch.removeAllChildren();
            this._searchSoundTileCellArr.splice(0,this._searchSoundTileCellArr.length);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectThemes() : Tile
      {
         return this._1956363228_uiTileEffectThemes;
      }
      
      public function set VSThumbTray(param1:ViewStack) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._10971153VSThumbTray;
         if(_loc2_ !== param1)
         {
            this._10971153VSThumbTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"VSThumbTray",_loc2_,param1));
         }
      }
      
      public function set _uiTileCharUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._435809310_uiTileCharUser;
         if(_loc2_ !== param1)
         {
            this._435809310_uiTileCharUser = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharUser",_loc2_,param1));
         }
      }
      
      public function set hasMoreUserChar(param1:Boolean) : void
      {
         this._hasMoreUserChar = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblUser() : Label
      {
         return this._1737616366_uiLblUser;
      }
      
      [Bindable(event="propertyChange")]
      public function get VSThumbTray() : ViewStack
      {
         return this._10971153VSThumbTray;
      }
      
      public function get hasMoreUserChar() : Boolean
      {
         return this._hasMoreUserChar;
      }
      
      [Bindable(event="propertyChange")]
      public function get _themeSelection() : anifire.components.studio.ThemeSelection
      {
         return this._1992358882_themeSelection;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorCommunity() : TabNavigator
      {
         return this._1629274085_uiNavigatorCommunity;
      }
      
      public function set hasMoreUserProp(param1:Boolean) : void
      {
         this._hasMoreUserProp = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasBgUser() : Canvas
      {
         return this._1174842373_uiCanvasBgUser;
      }
      
      public function set hasMoreUserSoundTTS(param1:Boolean) : void
      {
         this._hasMoreUserSoundTTS = param1;
      }
      
      public function get hasMoreUserProp() : Boolean
      {
         return this._hasMoreUserProp;
      }
      
      public function ___uiTileEffectUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
   }
}
