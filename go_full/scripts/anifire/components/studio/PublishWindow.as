package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.components.containers.SoundTileCell;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.core.CoreEvent;
   import anifire.core.Group;
   import anifire.core.SoundThumb;
   import anifire.core.Theme;
   import anifire.timeline.Timeline;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.Tile;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ComboBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   import mx.utils.StringUtil;
   import template.templateApp.classes.Global;
   
   public class PublishWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _726431551_shareBtnBg:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _2121733154_pubForm:Canvas;
      
      private var _82141533_mainView:ViewStack;
      
      private var _2080614473_pleaseEnterTitle:Label;
      
      private var _1463219121_vbTag:VBox;
      
      private var _993142004_soundForm:VBox;
      
      private var _949564754_pageForm:Canvas;
      
      private var _91048653_lang:String;
      
      private var _filter:FileFilter;
      
      private const SAVE_CLOSE:String = "pubwin_savenclose";
      
      private var _1416620697_txtTutorIntro:TextArea;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private var _83520443_hbSharingModeA:HBox;
      
      private var _143330933_txtDescription:TextArea;
      
      private const TIP_SAVE_SHARE_CLOSE:String = "pubwin_savensharetips";
      
      private var _370236868_canSoundList:Canvas;
      
      private var _1868749467_labelTag:Label;
      
      private var _973409099_popWindowCover:Canvas;
      
      private var _1017351380_hbPublishShareControl:HBox;
      
      public var _PublishWindow_Label1:Label;
      
      public var _PublishWindow_Label2:Label;
      
      public var _PublishWindow_Label3:Label;
      
      public var _PublishWindow_Label4:Label;
      
      public var _PublishWindow_Label5:Label;
      
      public var _PublishWindow_Label6:Label;
      
      public var _PublishWindow_Label7:Label;
      
      public var _PublishWindow_Label8:Label;
      
      public var _PublishWindow_Label9:Label;
      
      private var _1384121864_parentalAlert:Canvas;
      
      private var _45530185_hbPublishShare:HBox;
      
      private var _1391325653_txtAlert:Text;
      
      private var _1375372400_radioPublishPrivate:RadioButton;
      
      private var _826688622_publishShareControl:VBox;
      
      private var _1816075551_vsMoreInfo:ViewStack;
      
      private var _380890527_btnShowVideo:Button;
      
      private var _1383868793_btnBrowse:Button;
      
      private var _1952108612_groupAlert:Canvas;
      
      private var _1188299090_txtGroupAlert:Text;
      
      private var _1081336439_importView:ViewStack;
      
      private var _2944988_tip:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1962716122_lblPage:Label;
      
      private var _1988842562_langBox:ComboBox;
      
      private var _temp_is_redirect:Boolean;
      
      private var _1554648078_pageBtn:Canvas;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1839454473movieTypeA:RadioButtonGroup;
      
      private var _589894064_ckPublic:CheckBox;
      
      private var _1325315106_popWindow:Canvas;
      
      private var _1061294085_radioDraft:RadioButton;
      
      private var _1479694698_txtTags:TextInput;
      
      private var _937704655_pageUploadDone:VBox;
      
      private const SAVE_SIGNUP:String = "pubwin_save_signup";
      
      private var _1097932920_txtAssetTags:TextInput;
      
      private var _12195225_txtMovieTitle:TextInput;
      
      private var _1867156258_publishAddSound:HBox;
      
      private var _1959512361_txtTagsAdd:Text;
      
      private var _1373853913_txtTitle:TextInput;
      
      private var _1948377661_description:String;
      
      private var _file:FileReference;
      
      private var _lang_array:Array = null;
      
      private var _180361540_radioPublishPublic:RadioButton;
      
      private var _1730701776_btnNext:Button;
      
      public var _PublishWindow_Label10:Label;
      
      private var _1958100315_lblWarning:Label;
      
      public var _PublishWindow_Label13:Label;
      
      public var _PublishWindow_Label14:Label;
      
      public var _PublishWindow_Label16:Label;
      
      public var _PublishWindow_Label17:Label;
      
      public var _PublishWindow_Label18:Label;
      
      public var _PublishWindow_Label19:Label;
      
      private var _53440340_btnPopSubmit:Button;
      
      private var _2096658579_labelTag2:Label;
      
      private var _1985600873_vsCaptures:ViewStack;
      
      private var _1126007977_saveProgress:anifire.components.studio.SaveProgress;
      
      public var _PublishWindow_Label11:Label;
      
      private var _284436046_shareBtnBgEffect:Parallel;
      
      public var _PublishWindow_Label20:Label;
      
      public var _PublishWindow_Label21:Label;
      
      public var _PublishWindow_Label22:Label;
      
      private const SAVE_SHARE:String = "pubwin_savenshare";
      
      private var _83520444_hbSharingModeB:HBox;
      
      private var _1479285453_txtFile:TextInput;
      
      private var _1393458143_cbGroup:ComboBox;
      
      private var _301526948_movieName:String;
      
      private const TIP_SAVE:String = "pubwin_saveonlytips";
      
      private const TIP_SAVE_CLOSE:String = "pubwin_savenclosetips";
      
      private var _1114913131_btnSaveNShare:Button;
      
      private var _1113266043_radioPublic:RadioButton;
      
      private var _1839454472movieTypeB:RadioButtonGroup;
      
      private var _709177983_btnShowImport:Button;
      
      private var _23394237_canUploadSound:Canvas;
      
      private var _905402271_uiTileSoundMusicThemes:Tile;
      
      public var _PublishWindow_Text2:Text;
      
      private var _captures:UtilHashArray;
      
      private var _382283995_tempUploadSound:Tile;
      
      private var _1710757388_vbGroup:VBox;
      
      private var _1896006055publishSharingType:RadioButtonGroup;
      
      private var _1597296434_vsSaveOption:ViewStack;
      
      private var _325902852_canSoundTutorial:Canvas;
      
      private var _775146496_vsSaveAdditional:ViewStack;
      
      private var _814129551_popUpAlert:Label;
      
      private var _1730630288_btnPrev:Button;
      
      private var _1358079692_btnCommit:Button;
      
      mx_internal var _watchers:Array;
      
      private var _230640921_radioPrivate:RadioButton;
      
      private var _1472397637_btnSaveNShareSkipMusic:Button;
      
      private var _680181914_userPublishUpload:VBox;
      
      private var _previewWindow:anifire.components.studio.PreviewWindow;
      
      mx_internal var _bindings:Array;
      
      private var _151508365_radioPublish:RadioButton;
      
      private var _91286776_tags:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function PublishWindow()
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 62
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PublishWindow._watcherSetupUtil = param1;
      }
      
      private function prevThumbnail() : void
      {
         if(this._vsCaptures.selectedIndex > 0)
         {
            --this._vsCaptures.selectedIndex;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == 0)
            {
               this.enableButton(this._btnPrev,false);
            }
            if(this._btnNext.enabled == false)
            {
               this.enableButton(this._btnNext,true);
            }
         }
      }
      
      public function success(param1:SoundThumb) : void
      {
         CursorManager.removeBusyCursor();
         this._popWindow.visible = false;
         this._popWindowCover.visible = false;
         this._importView.selectedChild = this._pageUploadDone;
         this.addSoundTileCell(param1,this._tempUploadSound);
         this.deselectAllSoundTileCell();
         var _loc2_:SoundTileCell = SoundTileCell(ThumbnailCanvas(this._tempUploadSound.getChildAt(0)).getChildAt(0));
         ThumbnailCanvas(_loc2_.parent).clickPlay();
         _loc2_.data = "selected";
         _loc2_.dragSensor.graphics.clear();
         _loc2_.dragSensor.graphics.beginFill(16742400,0.5);
         _loc2_.dragSensor.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.dragSensor.graphics.endFill();
         this.updateSaveWithSoundBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioDraft() : RadioButton
      {
         return this._1061294085_radioDraft;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsSaveAdditional() : ViewStack
      {
         return this._775146496_vsSaveAdditional;
      }
      
      private function closeWindow(param1:Event) : void
      {
         this.deselectAllSoundTileCell();
         if(this.parent != null && this.parent is ViewStackWindow)
         {
            ViewStackWindow(this.parent).onCancelHandler(null);
         }
         else
         {
            Console.getConsole().closePublishWindow();
         }
      }
      
      private function _PublishWindow_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this.movieTypeA = _loc1_;
         _loc1_.initialized(this,"movieTypeA");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageBtn() : Canvas
      {
         return this._1554648078_pageBtn;
      }
      
      public function set _vsSaveAdditional(param1:ViewStack) : void
      {
         var _loc2_:Object = this._775146496_vsSaveAdditional;
         if(_loc2_ !== param1)
         {
            this._775146496_vsSaveAdditional = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsSaveAdditional",_loc2_,param1));
         }
      }
      
      public function set _parentalAlert(param1:Canvas) : void
      {
         var _loc2_:Object = this._1384121864_parentalAlert;
         if(_loc2_ !== param1)
         {
            this._1384121864_parentalAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_parentalAlert",_loc2_,param1));
         }
      }
      
      public function set _radioDraft(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1061294085_radioDraft;
         if(_loc2_ !== param1)
         {
            this._1061294085_radioDraft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioDraft",_loc2_,param1));
         }
      }
      
      private function setTempPrivateShared() : void
      {
         if(this._radioPublishPublic.selected)
         {
            Console.getConsole().tempPublished = true;
            Console.getConsole().tempPrivateShared = false;
         }
         else if(Boolean(this._radioPublishPrivate.selected) && Boolean(this._radioPublish.selected))
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = true;
         }
         else
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
         }
         this.enableButton(this._btnSaveNShare,true,Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared);
      }
      
      private function addSelectedSound() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc1_:Number = Number(this._uiTileSoundMusicThemes.numChildren);
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               Console.getConsole().addSoundAtScene(Console.getConsole().currentScene,_loc5_.soundThumb,new Point(0,0),null,false);
               this.deselectAllSoundTileCell();
               return;
            }
            _loc2_++;
         }
         _loc1_ = Number(this._tempUploadSound.numChildren);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               Console.getConsole().addSoundAtScene(Console.getConsole().currentScene,_loc5_.soundThumb,new Point(0,0),null,false);
               this.deselectAllSoundTileCell();
               return;
            }
            _loc2_++;
         }
      }
      
      public function set _pageBtn(param1:Canvas) : void
      {
         var _loc2_:Object = this._1554648078_pageBtn;
         if(_loc2_ !== param1)
         {
            this._1554648078_pageBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbGroup() : ComboBox
      {
         return this._1393458143_cbGroup;
      }
      
      [Bindable(event="propertyChange")]
      public function get _popWindow() : Canvas
      {
         return this._1325315106_popWindow;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pubForm() : Canvas
      {
         return this._2121733154_pubForm;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblPage() : Label
      {
         return this._1962716122_lblPage;
      }
      
      private function initSoundTileCell(param1:FlexEvent) : void
      {
         var _loc2_:SoundTileCell = SoundTileCell(param1.currentTarget);
         _loc2_.getHitArea().addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
      }
      
      public function set tags(param1:String) : void
      {
         this._tags = param1;
      }
      
      public function addSoundTileCell(param1:SoundThumb, param2:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc3_:SoundTileCell = param1.getTileCell().clone();
         _loc3_.buttonMode = true;
         _loc3_.removeEventListener(FlexEvent.CREATION_COMPLETE,param1.initTileCell);
         _loc3_.addEventListener(FlexEvent.CREATION_COMPLETE,this.initSoundTileCell);
         _loc4_ = param2;
         var _loc5_:ThumbnailCanvas = new ThumbnailCanvas(_loc3_.width,_loc3_.height,_loc3_,param1,false,false,false,"",true,1);
         _loc4_.addChild(_loc5_);
         if(_loc4_.numChildren % 2 != 0)
         {
            _loc3_.styleName = ThumbTray.STYLE_SOUND_TILE_1;
         }
         else
         {
            _loc3_.styleName = ThumbTray.STYLE_SOUND_TILE_2;
         }
      }
      
      public function set _popWindow(param1:Canvas) : void
      {
         var _loc2_:Object = this._1325315106_popWindow;
         if(_loc2_ !== param1)
         {
            this._1325315106_popWindow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popWindow",_loc2_,param1));
         }
      }
      
      public function ___txtTags_change(param1:Event) : void
      {
         this.doModifyTags();
      }
      
      public function set _cbGroup(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1393458143_cbGroup;
         if(_loc2_ !== param1)
         {
            this._1393458143_cbGroup = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbGroup",_loc2_,param1));
         }
      }
      
      public function set _pubForm(param1:Canvas) : void
      {
         var _loc2_:Object = this._2121733154_pubForm;
         if(_loc2_ !== param1)
         {
            this._2121733154_pubForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pubForm",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbTag() : VBox
      {
         return this._1463219121_vbTag;
      }
      
      public function set _lblPage(param1:Label) : void
      {
         var _loc2_:Object = this._1962716122_lblPage;
         if(_loc2_ !== param1)
         {
            this._1962716122_lblPage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblPage",_loc2_,param1));
         }
      }
      
      public function ___btnPopSubmit_click(param1:MouseEvent) : void
      {
         this.upload();
      }
      
      public function set _txtAlert(param1:Text) : void
      {
         var _loc2_:Object = this._1391325653_txtAlert;
         if(_loc2_ !== param1)
         {
            this._1391325653_txtAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAlert",_loc2_,param1));
         }
      }
      
      private function doModifyGroup() : void
      {
         if(this._cbGroup.selectedItem.data != "-1")
         {
            Console.getConsole().groupController.tempCurrentGroup = new Group(this._cbGroup.selectedItem.data,this._cbGroup.selectedItem.label);
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _movieName() : String
      {
         return this._301526948_movieName;
      }
      
      public function set _btnNext(param1:Button) : void
      {
         var _loc2_:Object = this._1730701776_btnNext;
         if(_loc2_ !== param1)
         {
            this._1730701776_btnNext = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNext",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _hbPublishShare() : HBox
      {
         return this._45530185_hbPublishShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishShareControl() : VBox
      {
         return this._826688622_publishShareControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundMusicThemes() : Tile
      {
         return this._905402271_uiTileSoundMusicThemes;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pleaseEnterTitle() : Label
      {
         return this._2080614473_pleaseEnterTitle;
      }
      
      public function set _canSoundList(param1:Canvas) : void
      {
         var _loc2_:Object = this._370236868_canSoundList;
         if(_loc2_ !== param1)
         {
            this._370236868_canSoundList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canSoundList",_loc2_,param1));
         }
      }
      
      private function set _description(param1:String) : void
      {
         var _loc2_:Object = this._1948377661_description;
         if(_loc2_ !== param1)
         {
            this._1948377661_description = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_description",_loc2_,param1));
         }
      }
      
      private function onCancelClickHandler(param1:Event = null) : void
      {
         if(this._previewWindow != null)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
         else
         {
            this.hide();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAssetTags() : TextInput
      {
         return this._1097932920_txtAssetTags;
      }
      
      private function doOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
         this.orderConsoleToSaveMovie();
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublic() : RadioButton
      {
         return this._1113266043_radioPublic;
      }
      
      public function set _hbPublishShare(param1:HBox) : void
      {
         var _loc2_:Object = this._45530185_hbPublishShare;
         if(_loc2_ !== param1)
         {
            this._45530185_hbPublishShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hbPublishShare",_loc2_,param1));
         }
      }
      
      public function set _pleaseEnterTitle(param1:Label) : void
      {
         var _loc2_:Object = this._2080614473_pleaseEnterTitle;
         if(_loc2_ !== param1)
         {
            this._2080614473_pleaseEnterTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pleaseEnterTitle",_loc2_,param1));
         }
      }
      
      public function set _vbTag(param1:VBox) : void
      {
         var _loc2_:Object = this._1463219121_vbTag;
         if(_loc2_ !== param1)
         {
            this._1463219121_vbTag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbTag",_loc2_,param1));
         }
      }
      
      public function set _ckPublic(param1:CheckBox) : void
      {
         var _loc2_:Object = this._589894064_ckPublic;
         if(_loc2_ !== param1)
         {
            this._589894064_ckPublic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ckPublic",_loc2_,param1));
         }
      }
      
      private function get LANG_ARRAY() : Array
      {
         var _loc1_:Object = null;
         var _loc2_:UtilHashArray = null;
         var _loc3_:int = 0;
         if(this._lang_array == null)
         {
            this._lang_array = new Array();
            _loc2_ = UtilLicense.getCurrentLicensorSupportedShortLangCodes();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = new Object();
               _loc1_.label = _loc2_.getValueByIndex(_loc3_);
               _loc1_.data = _loc2_.getKey(_loc3_);
               this._lang_array.push(_loc1_);
               _loc3_++;
            }
         }
         return this._lang_array;
      }
      
      [Bindable(event="propertyChange")]
      public function get _saveProgress() : anifire.components.studio.SaveProgress
      {
         return this._1126007977_saveProgress;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPopSubmit() : Button
      {
         return this._53440340_btnPopSubmit;
      }
      
      [Bindable(event="propertyChange")]
      public function get _popWindowCover() : Canvas
      {
         return this._973409099_popWindowCover;
      }
      
      private function set _movieName(param1:String) : void
      {
         var _loc2_:Object = this._301526948_movieName;
         if(_loc2_ !== param1)
         {
            this._301526948_movieName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_movieName",_loc2_,param1));
         }
      }
      
      public function set _btnShowVideo(param1:Button) : void
      {
         var _loc2_:Object = this._380890527_btnShowVideo;
         if(_loc2_ !== param1)
         {
            this._380890527_btnShowVideo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnShowVideo",_loc2_,param1));
         }
      }
      
      public function ___txtDescription_change(param1:Event) : void
      {
         this.doModifyDescription();
      }
      
      [Bindable(event="propertyChange")]
      public function get _shareBtnBg() : Canvas
      {
         return this._726431551_shareBtnBg;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : Button
      {
         return this._1730556742_btnSave;
      }
      
      [Bindable(event="propertyChange")]
      public function get _hbPublishShareControl() : HBox
      {
         return this._1017351380_hbPublishShareControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsSaveOption() : ViewStack
      {
         return this._1597296434_vsSaveOption;
      }
      
      public function ___shareBtnBg_creationComplete(param1:FlexEvent) : void
      {
         this.drawWhiteBorder();
      }
      
      [Bindable(event="propertyChange")]
      public function get _tempUploadSound() : Tile
      {
         return this._382283995_tempUploadSound;
      }
      
      public function ___radioPublish_click(param1:MouseEvent) : void
      {
         this.setTempPublished();
      }
      
      public function set _publishShareControl(param1:VBox) : void
      {
         var _loc2_:Object = this._826688622_publishShareControl;
         if(_loc2_ !== param1)
         {
            this._826688622_publishShareControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishShareControl",_loc2_,param1));
         }
      }
      
      public function set _uiTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = this._905402271_uiTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._905402271_uiTileSoundMusicThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundMusicThemes",_loc2_,param1));
         }
      }
      
      private function enablingAllSoundTileCell(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc2_:Number = Number(this._uiTileSoundMusicThemes.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc3_));
            (_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).dragSensor.enabled = param1;
            if(param1)
            {
               _loc5_.dragSensor.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            else
            {
               _loc5_.dragSensor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            _loc3_++;
         }
         _loc2_ = Number(this._tempUploadSound.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc3_));
            (_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).dragSensor.enabled = param1;
            if(param1)
            {
               _loc5_.dragSensor.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            else
            {
               _loc5_.dragSensor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            _loc3_++;
         }
      }
      
      public function set _radioPublish(param1:RadioButton) : void
      {
         var _loc2_:Object = this._151508365_radioPublish;
         if(_loc2_ !== param1)
         {
            this._151508365_radioPublish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublish",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishAddSound() : HBox
      {
         return this._1867156258_publishAddSound;
      }
      
      public function ___radioDraft_click(param1:MouseEvent) : void
      {
         this.setTempPublished();
      }
      
      public function set _txtAssetTags(param1:TextInput) : void
      {
         var _loc2_:Object = this._1097932920_txtAssetTags;
         if(_loc2_ !== param1)
         {
            this._1097932920_txtAssetTags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAssetTags",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundForm() : VBox
      {
         return this._993142004_soundForm;
      }
      
      private function showVideoTutorial() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("showSoundTutorial");
         }
      }
      
      public function set _btnShowImport(param1:Button) : void
      {
         var _loc2_:Object = this._709177983_btnShowImport;
         if(_loc2_ !== param1)
         {
            this._709177983_btnShowImport = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnShowImport",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _tags() : String
      {
         return this._91286776_tags;
      }
      
      private function doCancelOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _radioPublic(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1113266043_radioPublic;
         if(_loc2_ !== param1)
         {
            this._1113266043_radioPublic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublic",_loc2_,param1));
         }
      }
      
      public function set _btnBrowse(param1:Button) : void
      {
         var _loc2_:Object = this._1383868793_btnBrowse;
         if(_loc2_ !== param1)
         {
            this._1383868793_btnBrowse = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBrowse",_loc2_,param1));
         }
      }
      
      public function ___popWindow_show(param1:FlexEvent) : void
      {
         this._popWindowCover.visible = true;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsMoreInfo() : ViewStack
      {
         return this._1816075551_vsMoreInfo;
      }
      
      private function initWindow() : void
      {
         this._filter = new FileFilter(UtilDict.toDisplay("go","pubwin_soundfile"),"*.mp3;*.wav;*.m4a");
         this._txtTagsAdd.text = UtilDict.toDisplay("go","pubwin_tagsub");
         this._mainView.selectedChild = this._pubForm;
      }
      
      private function fitBitmapIntoCaptures(param1:BitmapData, param2:int) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Image = null;
         var _loc5_:Canvas = null;
         if(param1 != null)
         {
            _loc3_ = new Bitmap(param1);
            _loc3_.width = 220;
            _loc3_.height = 141;
            (_loc4_ = new Image()).addChild(_loc3_);
            (_loc5_ = new Canvas()).width = this._vsCaptures.width;
            _loc5_.height = this._vsCaptures.height;
            _loc5_.addChild(_loc4_);
            this._vsCaptures.addChildAt(_loc5_,param2);
         }
      }
      
      public function ___radioPublic_click(param1:MouseEvent) : void
      {
         this.setTempPublished();
      }
      
      public function ___txtMovieTitle_change(param1:Event) : void
      {
         this.doModifyMovieName();
      }
      
      private function commit() : void
      {
         if(this._txtFile.text != "")
         {
            this._popWindow.visible = true;
            this._popWindowCover.visible = true;
            this._txtAssetTags.text = "";
            this._txtTitle.text = this._file.name.substring(0,this._file.name.lastIndexOf("."));
            this._ckPublic.selected = false;
            this._ckPublic.enabled = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCommit() : Button
      {
         return this._1358079692_btnCommit;
      }
      
      private function _PublishWindow_Glow2_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.startDelay = 1500;
         _loc1_.alphaFrom = 0.5;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1500;
         _loc1_.blurXFrom = 14;
         _loc1_.blurYFrom = 14;
         _loc1_.blurXTo = 14;
         _loc1_.blurYTo = 14;
         _loc1_.color = 3713279;
         _loc1_.strength = 10;
         return _loc1_;
      }
      
      public function hide() : void
      {
         PopUpManager.removePopUp(PublishWindow(this));
         if(Console.getConsole().currentScene != null)
         {
            Console.getConsole().currentScene.playScene();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageForm() : Canvas
      {
         return this._949564754_pageForm;
      }
      
      public function set _btnPopSubmit(param1:Button) : void
      {
         var _loc2_:Object = this._53440340_btnPopSubmit;
         if(_loc2_ !== param1)
         {
            this._53440340_btnPopSubmit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPopSubmit",_loc2_,param1));
         }
      }
      
      public function set _lblWarning(param1:Label) : void
      {
         var _loc2_:Object = this._1958100315_lblWarning;
         if(_loc2_ !== param1)
         {
            this._1958100315_lblWarning = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblWarning",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainView() : ViewStack
      {
         return this._82141533_mainView;
      }
      
      public function set _saveProgress(param1:anifire.components.studio.SaveProgress) : void
      {
         var _loc2_:Object = this._1126007977_saveProgress;
         if(_loc2_ !== param1)
         {
            this._1126007977_saveProgress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_saveProgress",_loc2_,param1));
         }
      }
      
      public function set _txtGroupAlert(param1:Text) : void
      {
         var _loc2_:Object = this._1188299090_txtGroupAlert;
         if(_loc2_ !== param1)
         {
            this._1188299090_txtGroupAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtGroupAlert",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelTag() : Label
      {
         return this._1868749467_labelTag;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTutorIntro() : TextArea
      {
         return this._1416620697_txtTutorIntro;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsCaptures() : ViewStack
      {
         return this._1985600873_vsCaptures;
      }
      
      private function initSharingMode(param1:int = -1) : void
      {
         var _loc2_:int = 0;
         if(param1 == -1)
         {
            _loc2_ = UtilHashArray(LicenseConstants.PUBLISH_LEVEL).getValueByKey(Console.getConsole().siteId);
         }
         else
         {
            _loc2_ = param1;
         }
         switch(_loc2_)
         {
            case 0:
               this._radioPublic.enabled = true;
               this._radioPrivate.enabled = true;
               this._radioDraft.enabled = true;
               this._radioPublish.enabled = true;
               this._radioPublishPublic.enabled = true;
               this._radioPublishPrivate.enabled = true;
               break;
            case 1:
               this._radioPublic.enabled = false;
               this._radioPrivate.enabled = true;
               this._radioDraft.enabled = true;
               this._radioPublish.enabled = true;
               this._radioPublishPublic.enabled = false;
               this._radioPublishPrivate.enabled = true;
               break;
            case 2:
               this._radioPublic.enabled = true;
               this._radioPrivate.enabled = true;
               this._radioDraft.enabled = false;
               this._radioPublish.enabled = true;
               this._radioPublishPublic.enabled = true;
               this._radioPublishPrivate.enabled = true;
               break;
            case 4:
               this._radioPublic.enabled = false;
               this._radioPrivate.enabled = true;
               this._radioDraft.enabled = true;
               this._radioPublish.enabled = false;
               this._radioPublishPublic.enabled = false;
               this._radioPublishPrivate.enabled = false;
               break;
            case 5:
               this._radioPublic.enabled = false;
               this._radioPrivate.enabled = true;
               this._radioDraft.enabled = false;
               this._radioPublish.enabled = true;
               this._radioPublishPublic.enabled = false;
               this._radioPublishPrivate.enabled = true;
               break;
            case 6:
               this._radioPublic.enabled = true;
               this._radioPrivate.enabled = false;
               this._radioDraft.enabled = false;
               this._radioPublish.enabled = true;
               this._radioPublishPublic.enabled = true;
               this._radioPublishPrivate.enabled = false;
         }
         if(Console.getConsole().siteId == String(Global.BEN10))
         {
            this._vsSaveOption.selectedChild = this._hbSharingModeA;
            this._vsSaveAdditional.selectedChild = this._parentalAlert;
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "0")
            {
               this._radioPublic.enabled = false;
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "2")
            {
               this._radioPublic.enabled = false;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_nonactivate");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 121)
            {
               this._radioPublic.enabled = false;
               this._parentalAlert.visible = true;
               this._parentalAlert.alpha = 1;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 25.1 && (Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != null && Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != "0"))
            {
               this._radioPublic.enabled = false;
               this._parentalAlert.visible = true;
               this._parentalAlert.alpha = 1;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert25");
            }
            else
            {
               this._parentalAlert.visible = true;
               this._parentalAlert.alpha = 1;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_moderators");
               this._txtAlert.setStyle("color","0x000000");
               this._parentalAlert.setStyle("backgroundColor","0xBBE0E3");
            }
         }
         else
         {
            this._vsSaveOption.selectedChild = this._hbSharingModeB;
            this._vsSaveAdditional.selectedChild = this._publishShareControl;
         }
         if(Boolean(this._radioPublic.selected) && !this._radioPublic.enabled)
         {
            this._radioPublic.selected = false;
            this._radioPrivate.selected = true;
         }
         else if(Boolean(this._radioPrivate.selected) && !this._radioPrivate.enabled)
         {
            this._radioPrivate.selected = false;
            this._radioPublic.selected = true;
         }
         if(Boolean(this._radioDraft.selected) && !this._radioDraft.enabled)
         {
            this._radioDraft.selected = false;
            this._radioPublish.selected = true;
         }
         else if(Boolean(this._radioPublish.selected) && !this._radioPublish.enabled)
         {
            this._radioPublish.selected = false;
            this._radioDraft.selected = true;
         }
         if(Boolean(this._radioPublishPublic.selected) && !this._radioPublishPublic.enabled)
         {
            this._radioPublishPublic.selected = false;
            this._radioPublishPrivate.selected = true;
         }
         else if(Boolean(this._radioPublishPrivate.selected) && !this._radioPublishPrivate.enabled)
         {
            this._radioPublishPublic.selected = true;
            this._radioPublishPrivate.selected = false;
         }
         if(Console.getConsole().groupController.isSchoolProject())
         {
            this._radioPublishPublic.selected = true;
            this._vsSaveAdditional.selectedChild = this._groupAlert;
         }
         this.setTempPublished();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPrev() : Button
      {
         return this._1730630288_btnPrev;
      }
      
      private function initTip() : void
      {
         var _loc1_:ColorTransform = null;
         _loc1_ = new ColorTransform(0.5,0.5,0.5);
         this._tip.transform.colorTransform = _loc1_;
         this._tip.toolTip = UtilDict.toDisplay("go","pubwin_psharingtips");
      }
      
      public function set _btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._1730556742_btnSave;
         if(_loc2_ !== param1)
         {
            this._1730556742_btnSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSave",_loc2_,param1));
         }
      }
      
      public function set _btnSaveNShareSkipMusic(param1:Button) : void
      {
         var _loc2_:Object = this._1472397637_btnSaveNShareSkipMusic;
         if(_loc2_ !== param1)
         {
            this._1472397637_btnSaveNShareSkipMusic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSaveNShareSkipMusic",_loc2_,param1));
         }
      }
      
      public function set _radioPublishPublic(param1:RadioButton) : void
      {
         var _loc2_:Object = this._180361540_radioPublishPublic;
         if(_loc2_ !== param1)
         {
            this._180361540_radioPublishPublic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublishPublic",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSaveNShare() : Button
      {
         return this._1114913131_btnSaveNShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _importView() : ViewStack
      {
         return this._1081336439_importView;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDescription() : TextArea
      {
         return this._143330933_txtDescription;
      }
      
      public function set _popWindowCover(param1:Canvas) : void
      {
         var _loc2_:Object = this._973409099_popWindowCover;
         if(_loc2_ !== param1)
         {
            this._973409099_popWindowCover = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popWindowCover",_loc2_,param1));
         }
      }
      
      private function orderConsoleToSaveMovie() : void
      {
         Console.getConsole().tempMetaData.lang = this._langBox.selectedItem.data;
         Console.getConsole().publishMovie(this,Console.getConsole().tempPublished,Console.getConsole().tempPrivateShared,this._temp_is_redirect);
      }
      
      private function _PublishWindow_Glow1_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.duration = 1500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0.5;
         _loc1_.blurXFrom = 14;
         _loc1_.blurYFrom = 14;
         _loc1_.blurXTo = 14;
         _loc1_.blurYTo = 14;
         _loc1_.color = 3713279;
         _loc1_.strength = 10;
         return _loc1_;
      }
      
      public function ___btnSaveNShare_click(param1:MouseEvent) : void
      {
         this.doSaveMovie(true);
      }
      
      [Bindable(event="propertyChange")]
      public function get _popUpAlert() : Label
      {
         return this._814129551_popUpAlert;
      }
      
      private function doModifyDescription() : void
      {
         this.description = this._txtDescription.text;
         Console.getConsole().tempMetaData.description = this._txtDescription.text;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMovieTitle() : TextInput
      {
         return this._12195225_txtMovieTitle;
      }
      
      public function set _vsSaveOption(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1597296434_vsSaveOption;
         if(_loc2_ !== param1)
         {
            this._1597296434_vsSaveOption = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsSaveOption",_loc2_,param1));
         }
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.doSaveMovie();
      }
      
      public function set _shareBtnBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._726431551_shareBtnBg;
         if(_loc2_ !== param1)
         {
            this._726431551_shareBtnBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_shareBtnBg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get publishSharingType() : RadioButtonGroup
      {
         return this._1896006055publishSharingType;
      }
      
      public function set _hbPublishShareControl(param1:HBox) : void
      {
         var _loc2_:Object = this._1017351380_hbPublishShareControl;
         if(_loc2_ !== param1)
         {
            this._1017351380_hbPublishShareControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hbPublishShareControl",_loc2_,param1));
         }
      }
      
      public function ___btnBrowse_click(param1:MouseEvent) : void
      {
         this.browse();
      }
      
      [Bindable(event="propertyChange")]
      public function get _shareBtnBgEffect() : Parallel
      {
         return this._284436046_shareBtnBgEffect;
      }
      
      public function ___cbGroup_change(param1:ListEvent) : void
      {
         this.doModifyGroup();
      }
      
      public function set _tempUploadSound(param1:Tile) : void
      {
         var _loc2_:Object = this._382283995_tempUploadSound;
         if(_loc2_ !== param1)
         {
            this._382283995_tempUploadSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tempUploadSound",_loc2_,param1));
         }
      }
      
      public function set _publishAddSound(param1:HBox) : void
      {
         var _loc2_:Object = this._1867156258_publishAddSound;
         if(_loc2_ !== param1)
         {
            this._1867156258_publishAddSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishAddSound",_loc2_,param1));
         }
      }
      
      public function set _txtTagsAdd(param1:Text) : void
      {
         var _loc2_:Object = this._1959512361_txtTagsAdd;
         if(_loc2_ !== param1)
         {
            this._1959512361_txtTagsAdd = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTagsAdd",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTags() : TextInput
      {
         return this._1479694698_txtTags;
      }
      
      public function set _radioPrivate(param1:RadioButton) : void
      {
         var _loc2_:Object = this._230640921_radioPrivate;
         if(_loc2_ !== param1)
         {
            this._230640921_radioPrivate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPrivate",_loc2_,param1));
         }
      }
      
      private function drawWhiteBorder() : void
      {
         this._shareBtnBg.graphics.clear();
         this._shareBtnBg.graphics.beginFill(16777215);
         this._shareBtnBg.graphics.drawRoundRect(-1,-1,this._shareBtnBg.width + 2,34,10,10);
         this._shareBtnBg.graphics.endFill();
      }
      
      public function ___shareBtnBg_resize(param1:ResizeEvent) : void
      {
         this.drawWhiteBorder();
      }
      
      public function set _txtFile(param1:TextInput) : void
      {
         var _loc2_:Object = this._1479285453_txtFile;
         if(_loc2_ !== param1)
         {
            this._1479285453_txtFile = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtFile",_loc2_,param1));
         }
      }
      
      public function ___btnPrev_click(param1:MouseEvent) : void
      {
         this.prevThumbnail();
      }
      
      private function set _lang(param1:String) : void
      {
         var _loc2_:Object = this._91048653_lang;
         if(_loc2_ !== param1)
         {
            this._91048653_lang = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lang",_loc2_,param1));
         }
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      public function set _soundForm(param1:VBox) : void
      {
         var _loc2_:Object = this._993142004_soundForm;
         if(_loc2_ !== param1)
         {
            this._993142004_soundForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundForm",_loc2_,param1));
         }
      }
      
      public function set movieTypeA(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1839454473movieTypeA;
         if(_loc2_ !== param1)
         {
            this._1839454473movieTypeA = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieTypeA",_loc2_,param1));
         }
      }
      
      public function set movieTypeB(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1839454472movieTypeB;
         if(_loc2_ !== param1)
         {
            this._1839454472movieTypeB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieTypeB",_loc2_,param1));
         }
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      private function set _tags(param1:String) : void
      {
         var _loc2_:Object = this._91286776_tags;
         if(_loc2_ !== param1)
         {
            this._91286776_tags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tags",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbGroup() : VBox
      {
         return this._1710757388_vbGroup;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canSoundTutorial() : Canvas
      {
         return this._325902852_canSoundTutorial;
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      public function upload() : void
      {
         var request:URLRequest = null;
         var variables:URLVariables = null;
         if(this._txtFile.text != "")
         {
            this._txtTitle.enabled = this._txtAssetTags.enabled = this._btnPopSubmit.enabled = false;
            CursorManager.setBusyCursor();
            variables = new URLVariables();
            Util.addFlashVarsToURLvar(variables);
            request = new URLRequest(ServerConstants.ACTION_SAVE_SOUND);
            variables["title"] = this._txtTitle.text;
            variables["keywords"] = this._txtAssetTags.text;
            variables["subtype"] = AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
            variables["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            variables["is_published"] = !!this._ckPublic.selected ? "1" : "0";
            request.data = variables;
            request.method = URLRequestMethod.POST;
            try
            {
               this._file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this.onUploadCustomAssetComplete);
            }
            catch(e:Error)
            {
            }
            trace("request:" + request.url);
            trace("file:" + [this._file.name,this._file.size,this._file.type]);
            this._file.upload(request);
         }
      }
      
      private function prepareGroupDropDown() : void
      {
         var _loc1_:int = 0;
         var _loc6_:Boolean = false;
         var _loc2_:Array = Console.getConsole().groupController.getGroups();
         var _loc3_:Group = Console.getConsole().groupController.currentGroup;
         if(_loc3_.id != "0")
         {
            _loc6_ = false;
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(Group(_loc2_[_loc1_]).id == _loc3_.id)
               {
                  _loc6_ = true;
               }
               _loc1_++;
            }
            if(!_loc6_)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("name");
         var _loc4_:ArrayCollection = new ArrayCollection();
         var _loc5_:Number = 0;
         if(_loc2_.length > 0)
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","Please select group"),
               "data":"-1"
            });
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               _loc4_.addItem({
                  "label":Group(_loc2_[_loc1_]).name,
                  "data":Group(_loc2_[_loc1_]).id
               });
               if(_loc3_ != null && _loc3_.id == Group(_loc2_[_loc1_]).id)
               {
                  Console.getConsole().groupController.tempCurrentGroup = _loc3_;
                  _loc5_ = _loc1_ + 1;
               }
               _loc1_++;
            }
            this._vsSaveAdditional.visible = false;
            this.initSharingMode();
         }
         else
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","No existing group"),
               "data":"0"
            });
            Console.getConsole().groupController.tempCurrentGroup = new Group();
            this._vsSaveAdditional.visible = true;
            this.initSharingMode(4);
         }
         this._cbGroup.dataProvider = _loc4_;
         this._cbGroup.selectedIndex = _loc5_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _parentalAlert() : Canvas
      {
         return this._1384121864_parentalAlert;
      }
      
      private function deselectAllSoundTileCell(param1:SoundTileCell = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc2_:Number = Number(this._uiTileSoundMusicThemes.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc3_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))) != param1)
            {
               _loc4_.clickStop();
               _loc5_.data = "";
               _loc5_.dragSensor.graphics.clear();
            }
            _loc3_++;
         }
         _loc2_ = Number(this._tempUploadSound.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc3_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))) != param1)
            {
               _loc4_.clickStop();
               _loc5_.data = "";
               _loc5_.dragSensor.graphics.clear();
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAlert() : Text
      {
         return this._1391325653_txtAlert;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNext() : Button
      {
         return this._1730701776_btnNext;
      }
      
      private function doModifyMovieName() : void
      {
         this.movieName = this._txtMovieTitle.text;
         Console.getConsole().tempMetaData.title = this._txtMovieTitle.text;
         if(this._previewWindow != null)
         {
            this._previewWindow.movieName = this._txtMovieTitle.text;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canSoundList() : Canvas
      {
         return this._370236868_canSoundList;
      }
      
      [Bindable(event="propertyChange")]
      private function get _description() : String
      {
         return this._1948377661_description;
      }
      
      public function set _vsMoreInfo(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1816075551_vsMoreInfo;
         if(_loc2_ !== param1)
         {
            this._1816075551_vsMoreInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsMoreInfo",_loc2_,param1));
         }
      }
      
      public function ___btnShowVideo_click(param1:MouseEvent) : void
      {
         this.showVideoTutorial();
      }
      
      public function set _txtTitle(param1:TextInput) : void
      {
         var _loc2_:Object = this._1373853913_txtTitle;
         if(_loc2_ !== param1)
         {
            this._1373853913_txtTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTitle",_loc2_,param1));
         }
      }
      
      public function ___radioPrivate_click(param1:MouseEvent) : void
      {
         this.setTempPublished();
      }
      
      private function _PublishWindow_Parallel1_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this._shareBtnBgEffect = _loc1_;
         _loc1_.repeatCount = 0;
         _loc1_.children = [this._PublishWindow_Glow1_c(),this._PublishWindow_Glow2_c()];
         return _loc1_;
      }
      
      public function onSoundMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:SoundTileCell = SoundTileCell(HBox(param1.currentTarget).parent);
         var _loc3_:HBox = HBox(param1.currentTarget);
         this.deselectAllSoundTileCell(_loc2_);
         if(_loc2_.data != "selected")
         {
            ThumbnailCanvas(_loc2_.parent).clickPlay(param1);
            _loc2_.data = "selected";
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(16742400,0.5);
            _loc3_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
            _loc3_.graphics.endFill();
         }
         else
         {
            ThumbnailCanvas(_loc2_.parent).clickStop(param1);
            _loc2_.data = "";
            _loc3_.graphics.clear();
         }
         this.updateSaveWithSoundBtn();
      }
      
      private function _PublishWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_title");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label1.text = param1;
         },"_PublishWindow_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_subtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label2.text = param1;
         },"_PublishWindow_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movietitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label3.text = param1;
         },"_PublishWindow_Label3.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label4.text = param1;
         },"_PublishWindow_Label4.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _movieName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtMovieTitle.text = param1;
         },"_txtMovieTitle.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_tags");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label5.text = param1;
         },"_PublishWindow_Label5.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label6.text = param1;
         },"_PublishWindow_Label6.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _tags;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtTags.text = param1;
         },"_txtTags.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Group");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label7.text = param1;
         },"_PublishWindow_Label7.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label8.text = param1;
         },"_PublishWindow_Label8.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_description");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label9.text = param1;
         },"_PublishWindow_Label9.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _description;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtDescription.text = param1;
         },"_txtDescription.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movielang");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label10.text = param1;
         },"_PublishWindow_Label10.text");
         result[12] = binding;
         binding = new Binding(this,function():Object
         {
            return LANG_ARRAY;
         },function(param1:Object):void
         {
            _langBox.dataProvider = param1;
         },"_langBox.dataProvider");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movielangsub");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Text2.text = param1;
         },"_PublishWindow_Text2.text");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_pickthumb");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label11.text = param1;
         },"_PublishWindow_Label11.text");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _vsCaptures.selectedIndex + 1 + "/" + _captures.length;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _lblPage.text = param1;
         },"_lblPage.text");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveas");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label13.text = param1;
         },"_PublishWindow_Label13.text");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioPublic.label = param1;
         },"_radioPublic.label");
         result[18] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Console.getConsole().tempPublished;
         },function(param1:Boolean):void
         {
            _radioPublic.selected = param1;
         },"_radioPublic.selected");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioPrivate.label = param1;
         },"_radioPrivate.label");
         result[20] = binding;
         binding = new Binding(this,function():Boolean
         {
            return !Console.getConsole().tempPublished;
         },function(param1:Boolean):void
         {
            _radioPrivate.selected = param1;
         },"_radioPrivate.selected");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_draft");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioDraft.label = param1;
         },"_radioDraft.label");
         result[22] = binding;
         binding = new Binding(this,function():Boolean
         {
            return !Console.getConsole().tempPrivateShared;
         },function(param1:Boolean):void
         {
            _radioDraft.selected = param1;
         },"_radioDraft.selected");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_publish");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioPublish.label = param1;
         },"_radioPublish.label");
         result[24] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared;
         },function(param1:Boolean):void
         {
            _radioPublish.selected = param1;
         },"_radioPublish.selected");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_psharing");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label14.text = param1;
         },"_PublishWindow_Label14.text");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioPublishPublic.label = param1;
         },"_radioPublishPublic.label");
         result[27] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Console.getConsole().tempPublished;
         },function(param1:Boolean):void
         {
            _radioPublishPublic.selected = param1;
         },"_radioPublishPublic.selected");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _radioPublishPrivate.label = param1;
         },"_radioPublishPrivate.label");
         result[29] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Console.getConsole().tempPrivateShared;
         },function(param1:Boolean):void
         {
            _radioPublishPrivate.selected = param1;
         },"_radioPublishPrivate.selected");
         result[30] = binding;
         binding = new Binding(this,function():Number
         {
            return (_parentalAlert.height - _txtAlert.height) / 2;
         },function(param1:Number):void
         {
            _txtAlert.y = param1;
         },"_txtAlert.y");
         result[31] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_parent");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtAlert.text = param1;
         },"_txtAlert.text");
         result[32] = binding;
         binding = new Binding(this,function():Number
         {
            return (_groupAlert.height - _txtGroupAlert.height) / 2;
         },function(param1:Number):void
         {
            _txtGroupAlert.y = param1;
         },"_txtGroupAlert.y");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Create groups of students to enable publishing your animations.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtGroupAlert.text = param1;
         },"_txtGroupAlert.text");
         result[34] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonly");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.label = param1;
         },"_btnSave.label");
         result[35] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonlytips");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.toolTip = param1;
         },"_btnSave.toolTip");
         result[36] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Console.getConsole().isUserAlreadyLogin();
         },function(param1:Boolean):void
         {
            _btnSave.visible = param1;
         },"_btnSave.visible");
         result[37] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_warningtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _lblWarning.text = param1;
         },"_lblWarning.text");
         result[38] = binding;
         binding = new Binding(this,function():*
         {
            return _shareBtnBgEffect;
         },function(param1:*):void
         {
            _shareBtnBg.setStyle("creationCompleteEffect",param1);
         },"_shareBtnBg.creationCompleteEffect");
         result[39] = binding;
         binding = new Binding(this,function():*
         {
            return _shareBtnBgEffect;
         },function(param1:*):void
         {
            _shareBtnBg.setStyle("resizeEffect",param1);
         },"_shareBtnBg.resizeEffect");
         result[40] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_astitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label16.text = param1;
         },"_PublishWindow_Label16.text");
         result[41] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_assubtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label17.text = param1;
         },"_PublishWindow_Label17.text");
         result[42] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_aslib");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label18.text = param1;
         },"_PublishWindow_Label18.text");
         result[43] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_uploadtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label19.text = param1;
         },"_PublishWindow_Label19.text");
         result[44] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_import");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnShowImport.label = param1;
         },"_btnShowImport.label");
         result[45] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_max");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label20.text = param1;
         },"_PublishWindow_Label20.text");
         result[46] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_browse");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnBrowse.label = param1;
         },"_btnBrowse.label");
         result[47] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCommit.label = param1;
         },"_btnCommit.label");
         result[48] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_importdone");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label21.text = param1;
         },"_PublishWindow_Label21.text");
         result[49] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_learnmore");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label22.text = param1;
         },"_PublishWindow_Label22.text");
         result[50] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_watch");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnShowVideo.label = param1;
         },"_btnShowVideo.label");
         result[51] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_savenosound");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSaveNShareSkipMusic.label = param1;
         },"_btnSaveNShareSkipMusic.label");
         result[52] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_savensharetips");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSaveNShareSkipMusic.toolTip = param1;
         },"_btnSaveNShareSkipMusic.toolTip");
         result[53] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCloseTop.label = param1;
         },"_btnCloseTop.label");
         result[54] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width * 0.5 - 200;
         },function(param1:Number):void
         {
            _popWindow.x = param1;
         },"_popWindow.x");
         result[55] = binding;
         binding = new Binding(this,function():Number
         {
            return this.height * 0.5 - 126;
         },function(param1:Number):void
         {
            _popWindow.y = param1;
         },"_popWindow.y");
         result[56] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnShowVideo() : Button
      {
         return this._380890527_btnShowVideo;
      }
      
      public function set _pageUploadDone(param1:VBox) : void
      {
         var _loc2_:Object = this._937704655_pageUploadDone;
         if(_loc2_ !== param1)
         {
            this._937704655_pageUploadDone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageUploadDone",_loc2_,param1));
         }
      }
      
      public function ___radioPublishPublic_click(param1:MouseEvent) : void
      {
         this.setTempPrivateShared();
      }
      
      [Bindable(event="propertyChange")]
      public function get _ckPublic() : CheckBox
      {
         return this._589894064_ckPublic;
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublish() : RadioButton
      {
         return this._151508365_radioPublish;
      }
      
      private function browse() : void
      {
         if(this._file == null)
         {
            this._file = new FileReference();
            this._file.addEventListener(Event.SELECT,this.onSelect);
         }
         try
         {
            this._file.browse([this._filter]);
         }
         catch(e:IOError)
         {
            throw new Error("IOError:" + e.getStackTrace());
         }
         catch(e:Error)
         {
            throw new Error("error: " + e.getStackTrace());
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBrowse() : Button
      {
         return this._1383868793_btnBrowse;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnShowImport() : Button
      {
         return this._709177983_btnShowImport;
      }
      
      public function ___btnNext_click(param1:MouseEvent) : void
      {
         this.nextThumbnail();
      }
      
      private function enableButton(param1:Button, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 != null)
         {
            param1.enabled = param2;
            param1.buttonMode = param2;
            if(param1 == this._btnSaveNShare)
            {
               if(param3 && !Console.getConsole().groupController.isSchoolProject())
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SHARE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_SHARE_CLOSE);
               }
               else
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_CLOSE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_CLOSE);
               }
               if(!Console.getConsole().isUserAlreadyLogin())
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SIGNUP) + " >";
               }
            }
         }
      }
      
      public function ___btnCommit_click(param1:MouseEvent) : void
      {
         this.commit();
      }
      
      private function loadSoundThumbs(param1:Theme) : void
      {
         var _loc4_:SoundThumb = null;
         var _loc2_:Array = param1.soundThumbs.clone().getArray();
         _loc2_.sortOn("name",Array.CASEINSENSITIVE);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(!(!(_loc4_ = _loc2_[_loc3_] as SoundThumb).enable || _loc4_.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC))
            {
               trace("sThumb.sound:" + _loc4_.sound);
               this.addSoundTileCell(_loc4_,this._uiTileSoundMusicThemes);
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblWarning() : Label
      {
         return this._1958100315_lblWarning;
      }
      
      public function set _pageForm(param1:Canvas) : void
      {
         var _loc2_:Object = this._949564754_pageForm;
         if(_loc2_ !== param1)
         {
            this._949564754_pageForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageForm",_loc2_,param1));
         }
      }
      
      public function set _btnCommit(param1:Button) : void
      {
         var _loc2_:Object = this._1358079692_btnCommit;
         if(_loc2_ !== param1)
         {
            this._1358079692_btnCommit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCommit",_loc2_,param1));
         }
      }
      
      public function initPublishWindow(param1:anifire.components.studio.PreviewWindow, param2:Boolean, param3:Boolean, param4:UtilHashArray, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = "") : void
      {
         var _loc10_:BitmapData = null;
         var _loc11_:int = 0;
         var _loc12_:BitmapData = null;
         trace("[published,pshared]:" + [param2,param3]);
         this._captures = param4;
         if(param4 != null)
         {
            _loc10_ = Console.getConsole().getThumbnailCaptureBySceneIndex(0);
            Console.getConsole().selectedThumbnailIndex = 0;
            this.fitBitmapIntoCaptures(_loc10_,0);
            _loc11_ = 1;
            while(_loc11_ < param4.length)
            {
               _loc12_ = param4.getValueByIndex(_loc11_);
               this.fitBitmapIntoCaptures(_loc12_,_loc11_);
               _loc11_++;
            }
            this._lblPage.text = "1/" + param4.length;
            this.enableButton(this._btnPrev,false);
            if(param4.length == 1)
            {
               this.enableButton(this._btnNext,false);
            }
         }
         this._previewWindow = param1;
         this._movieName = param5;
         this._tags = param6;
         this._description = param7;
         this._lang = param8;
         this.enableButton(this._btnSaveNShare,true,param2 || param3);
         if(this._lang == "")
         {
            this._lang = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
         }
         _loc11_ = 0;
         while(_loc11_ < this.LANG_ARRAY.length)
         {
            if(this._lang == this.LANG_ARRAY[_loc11_].data)
            {
               this._langBox.selectedIndex = _loc11_;
            }
            _loc11_++;
         }
         if(Console.getConsole().groupController.isSchoolProject())
         {
            this._vsMoreInfo.selectedChild = this._vbGroup;
            this._txtTags.text = "school";
            this.prepareGroupDropDown();
         }
         else
         {
            this._vsMoreInfo.selectedChild = this._vbTag;
            this.initSharingMode();
         }
      }
      
      private function updateSaveWithSoundBtn() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc1_:Number = Number(this._uiTileSoundMusicThemes.numChildren);
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               _loc3_++;
            }
            _loc2_++;
         }
         _loc1_ = Number(this._tempUploadSound.numChildren);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ > 0)
         {
            this._btnSaveNShareSkipMusic.label = UtilDict.toDisplay("go","pubwin_addnsave");
         }
         else
         {
            this._btnSaveNShareSkipMusic.label = UtilDict.toDisplay("go","pubwin_savenosound");
         }
      }
      
      public function set _mainView(param1:ViewStack) : void
      {
         var _loc2_:Object = this._82141533_mainView;
         if(_loc2_ !== param1)
         {
            this._82141533_mainView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainView",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSaveNShareSkipMusic() : Button
      {
         return this._1472397637_btnSaveNShareSkipMusic;
      }
      
      public function ___PublishWindow_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initWindow();
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublishPublic() : RadioButton
      {
         return this._180361540_radioPublishPublic;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtGroupAlert() : Text
      {
         return this._1188299090_txtGroupAlert;
      }
      
      public function set _labelTag(param1:Label) : void
      {
         var _loc2_:Object = this._1868749467_labelTag;
         if(_loc2_ !== param1)
         {
            this._1868749467_labelTag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelTag",_loc2_,param1));
         }
      }
      
      public function set _userPublishUpload(param1:VBox) : void
      {
         var _loc2_:Object = this._680181914_userPublishUpload;
         if(_loc2_ !== param1)
         {
            this._680181914_userPublishUpload = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userPublishUpload",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtFile() : TextInput
      {
         return this._1479285453_txtFile;
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      public function set _vsCaptures(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1985600873_vsCaptures;
         if(_loc2_ !== param1)
         {
            this._1985600873_vsCaptures = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsCaptures",_loc2_,param1));
         }
      }
      
      public function set _txtTags(param1:TextInput) : void
      {
         var _loc2_:Object = this._1479694698_txtTags;
         if(_loc2_ !== param1)
         {
            this._1479694698_txtTags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTags",_loc2_,param1));
         }
      }
      
      public function set _txtTutorIntro(param1:TextArea) : void
      {
         var _loc2_:Object = this._1416620697_txtTutorIntro;
         if(_loc2_ !== param1)
         {
            this._1416620697_txtTutorIntro = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTutorIntro",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTagsAdd() : Text
      {
         return this._1959512361_txtTagsAdd;
      }
      
      [Bindable(event="propertyChange")]
      private function get _lang() : String
      {
         return this._91048653_lang;
      }
      
      private function doModifyTags() : void
      {
         this.tags = this._txtTags.text;
         Console.getConsole().tempMetaData.setUgcTagsByString(this._txtTags.text);
      }
      
      public function set _btnPrev(param1:Button) : void
      {
         var _loc2_:Object = this._1730630288_btnPrev;
         if(_loc2_ !== param1)
         {
            this._1730630288_btnPrev = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPrev",_loc2_,param1));
         }
      }
      
      public function set _btnSaveNShare(param1:Button) : void
      {
         var _loc2_:Object = this._1114913131_btnSaveNShare;
         if(_loc2_ !== param1)
         {
            this._1114913131_btnSaveNShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSaveNShare",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPrivate() : RadioButton
      {
         return this._230640921_radioPrivate;
      }
      
      public function set _labelTag2(param1:Label) : void
      {
         var _loc2_:Object = this._2096658579_labelTag2;
         if(_loc2_ !== param1)
         {
            this._2096658579_labelTag2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelTag2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieTypeA() : RadioButtonGroup
      {
         return this._1839454473movieTypeA;
      }
      
      [Bindable(event="propertyChange")]
      public function get movieTypeB() : RadioButtonGroup
      {
         return this._1839454472movieTypeB;
      }
      
      public function set _importView(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1081336439_importView;
         if(_loc2_ !== param1)
         {
            this._1081336439_importView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_importView",_loc2_,param1));
         }
      }
      
      public function set _txtDescription(param1:TextArea) : void
      {
         var _loc2_:Object = this._143330933_txtDescription;
         if(_loc2_ !== param1)
         {
            this._143330933_txtDescription = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDescription",_loc2_,param1));
         }
      }
      
      private function initSoundList() : void
      {
         this.loadSoundThumbs(Console.getConsole().getCurTheme());
         this.loadSoundThumbs(Console.getConsole().getTheme("common"));
      }
      
      public function set _popUpAlert(param1:Label) : void
      {
         var _loc2_:Object = this._814129551_popUpAlert;
         if(_loc2_ !== param1)
         {
            this._814129551_popUpAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popUpAlert",_loc2_,param1));
         }
      }
      
      public function set _radioPublishPrivate(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1375372400_radioPublishPrivate;
         if(_loc2_ !== param1)
         {
            this._1375372400_radioPublishPrivate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublishPrivate",_loc2_,param1));
         }
      }
      
      public function ___btnSaveNShareSkipMusic_click(param1:MouseEvent) : void
      {
         this.doSaveMovie(true,true);
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTitle() : TextInput
      {
         return this._1373853913_txtTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageUploadDone() : VBox
      {
         return this._937704655_pageUploadDone;
      }
      
      public function set _txtMovieTitle(param1:TextInput) : void
      {
         var _loc2_:Object = this._12195225_txtMovieTitle;
         if(_loc2_ !== param1)
         {
            this._12195225_txtMovieTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMovieTitle",_loc2_,param1));
         }
      }
      
      public function setBtnStatus(param1:Boolean) : void
      {
         if(this._mainView.selectedChild == this._pubForm)
         {
            this.enableButton(this._btnSave,param1);
            this.enableButton(this._btnSaveNShare,param1,Console.getConsole().privateShared);
            this._txtMovieTitle.enabled = param1;
            this._txtTags.enabled = param1;
            this._txtDescription.enabled = param1;
            this._langBox.enabled = param1;
            this._radioPublic.enabled = param1;
            this._radioPrivate.enabled = param1;
            this._radioDraft.enabled = param1;
            this._radioPublish.enabled = param1;
            this._radioPublishPublic.enabled = param1;
            this._radioPublishPrivate.enabled = param1;
            if(param1)
            {
               this.initSharingMode();
            }
            this._btnPrev.enabled = param1;
            this._btnNext.enabled = param1;
            this._btnCloseTop.visible = param1;
            if(param1)
            {
               this._saveProgress.visible = false;
               this._saveProgress.stopSavingProgress();
            }
            else
            {
               this._saveProgress.visible = true;
               this._saveProgress.startSavingProgress();
            }
         }
         else if(this._mainView.selectedChild == this._soundForm)
         {
            this.enableButton(this._btnSaveNShareSkipMusic,param1);
            this.enablingAllSoundTileCell(param1);
            if(this._userPublishUpload)
            {
               this._txtFile.enabled = param1;
               this.enableButton(this._btnBrowse,param1);
               this.enableButton(this._btnCommit,param1);
               this.enableButton(this._btnShowImport,param1);
               this.enableButton(this._btnShowVideo,param1);
            }
         }
      }
      
      private function setTempPublished() : void
      {
         if(this._vsSaveOption.selectedChild == this._hbSharingModeA)
         {
            if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               this.enableButton(this._btnSaveNShare,true,true);
            }
            else if(this._radioPrivate.selected)
            {
               Console.getConsole().tempPublished = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            if(this._txtAlert.text === UtilDict.toDisplay("go","pubwin_moderators"))
            {
               this._parentalAlert.visible = this._radioPublic.selected;
            }
         }
         else if(this._vsSaveOption.selectedChild == this._hbSharingModeB)
         {
            if(this._radioDraft.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,Console.getConsole().tempPrivateShared);
            }
            else if(this._radioPublish.selected)
            {
               if(this._radioPublishPublic.selected)
               {
                  Console.getConsole().tempPublished = true;
                  Console.getConsole().tempPrivateShared = false;
               }
               else if(this._radioPublishPrivate.selected)
               {
                  Console.getConsole().tempPublished = false;
                  Console.getConsole().tempPrivateShared = true;
               }
               else
               {
                  this._radioPublishPublic.selected = true;
                  Console.getConsole().tempPublished = true;
                  Console.getConsole().tempPrivateShared = false;
               }
               this.enableButton(this._btnSaveNShare,true,Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared);
            }
         }
         this.initPublishSetting();
      }
      
      private function nextThumbnail() : void
      {
         var _loc1_:BitmapData = null;
         if(this._vsCaptures.selectedIndex < this._captures.length - 1)
         {
            if(this._vsCaptures.selectedIndex + 1 >= this._vsCaptures.numChildren)
            {
               Console.getConsole().requestLoadStatus(true);
               _loc1_ = Console.getConsole().getThumbnailCaptureBySceneIndex(this._vsCaptures.selectedIndex + 1);
               this.fitBitmapIntoCaptures(_loc1_,this._vsCaptures.selectedIndex + 1);
               Console.getConsole().requestLoadStatus(false);
            }
            this._vsCaptures.selectedIndex += 1;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == this._captures.length - 1)
            {
               this.enableButton(this._btnNext,false);
            }
            if(this._btnPrev.enabled == false)
            {
               this.enableButton(this._btnPrev,true);
            }
         }
      }
      
      public function set publishSharingType(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1896006055publishSharingType;
         if(_loc2_ !== param1)
         {
            this._1896006055publishSharingType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publishSharingType",_loc2_,param1));
         }
      }
      
      public function ___tip_creationComplete(param1:FlexEvent) : void
      {
         this.initTip();
      }
      
      public function ___popWindow_hide(param1:FlexEvent) : void
      {
         this._popWindowCover.visible = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get _userPublishUpload() : VBox
      {
         return this._680181914_userPublishUpload;
      }
      
      private function doSaveMovie(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         if(_loc3_.containsBadword(this._txtMovieTitle.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return;
         }
         if(_loc3_.containsBadword(this._txtTags.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtTags.setFocus();
            return;
         }
         if(_loc3_.containsBadword(this._txtDescription.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtDescription.setFocus();
            return;
         }
         if(StringUtil.trim(this._txtMovieTitle.text) == "")
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return;
         }
         if(StringUtil.trim(this._txtTags.text) == "")
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK_TAG);
            this._lblWarning.visible = true;
            this._txtTags.setFocus();
            return;
         }
         if(Console.getConsole().groupController.isSchoolProject())
         {
            if(this._cbGroup.selectedItem.data == "-1")
            {
               this._lblWarning.text = UtilDict.toDisplay("go","Please select a group");
               this._lblWarning.visible = true;
               this._cbGroup.setFocus();
               return;
            }
         }
         if((Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared) && Console.getConsole().sounds.length < 1 && param1 && !param2)
         {
            this._mainView.selectedChild = this._soundForm;
            this.initSoundList();
            return;
         }
         if(param2)
         {
            this.addSelectedSound();
         }
         this._lblWarning.visible = false;
         this._temp_is_redirect = param1;
         if(Console.getConsole().isUserAlreadyLogin())
         {
            this.setTempPrivateShared();
            this.setTempPublished();
            this.orderConsoleToSaveMovie();
         }
         else
         {
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doOrderConsoleToSaveMovie);
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doCancelOrderConsoleToSaveMovie);
            Console.getConsole().showSignup();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelTag2() : Label
      {
         return this._2096658579_labelTag2;
      }
      
      private function initPublishSetting() : void
      {
         if(!Console.getConsole().tempPrivateShared && !Console.getConsole().tempPublished)
         {
            this._hbPublishShare.visible = false;
            this._hbPublishShareControl.visible = false;
         }
         else
         {
            this._hbPublishShare.visible = true;
            this._hbPublishShareControl.visible = true;
         }
      }
      
      public function set _shareBtnBgEffect(param1:Parallel) : void
      {
         var _loc2_:Object = this._284436046_shareBtnBgEffect;
         if(_loc2_ !== param1)
         {
            this._284436046_shareBtnBgEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_shareBtnBgEffect",_loc2_,param1));
         }
      }
      
      public function onUploadCustomAssetComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         if(Console.getConsole() != null)
         {
            if(param1 != null)
            {
               if(param1.type == DataEvent.UPLOAD_COMPLETE_DATA)
               {
                  _loc2_ = (param1 as DataEvent).data;
               }
               else
               {
                  _loc2_ = (param1.target as URLLoader).data;
               }
            }
            Console.getConsole().customAssetUploadCompleteHandler(_loc2_,AnimeConstants.ASSET_TYPE_SOUND);
         }
      }
      
      public function set _hbSharingModeA(param1:HBox) : void
      {
         var _loc2_:Object = this._83520443_hbSharingModeA;
         if(_loc2_ !== param1)
         {
            this._83520443_hbSharingModeA = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hbSharingModeA",_loc2_,param1));
         }
      }
      
      public function set _groupAlert(param1:Canvas) : void
      {
         var _loc2_:Object = this._1952108612_groupAlert;
         if(_loc2_ !== param1)
         {
            this._1952108612_groupAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_groupAlert",_loc2_,param1));
         }
      }
      
      public function set _canUploadSound(param1:Canvas) : void
      {
         var _loc2_:Object = this._23394237_canUploadSound;
         if(_loc2_ !== param1)
         {
            this._23394237_canUploadSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canUploadSound",_loc2_,param1));
         }
      }
      
      public function set _langBox(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1988842562_langBox;
         if(_loc2_ !== param1)
         {
            this._1988842562_langBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_langBox",_loc2_,param1));
         }
      }
      
      public function ___soundForm_show(param1:FlexEvent) : void
      {
         this.initAddingMusic();
      }
      
      private function _PublishWindow_RadioButtonGroup3_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this.publishSharingType = _loc1_;
         _loc1_.initialized(this,"publishSharingType");
         return _loc1_;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:PublishWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._PublishWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PublishWindowWatcherSetupUtil");
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
      
      public function set _hbSharingModeB(param1:HBox) : void
      {
         var _loc2_:Object = this._83520444_hbSharingModeB;
         if(_loc2_ !== param1)
         {
            this._83520444_hbSharingModeB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hbSharingModeB",_loc2_,param1));
         }
      }
      
      public function ___btnShowImport_click(param1:MouseEvent) : void
      {
         this._importView.selectedChild = this._pageForm;
      }
      
      public function set movieName(param1:String) : void
      {
         this._movieName = param1;
      }
      
      private function _PublishWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","pubwin_title");
         _loc1_ = UtilDict.toDisplay("go","pubwin_subtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_movietitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = this._movieName;
         _loc1_ = UtilDict.toDisplay("go","pubwin_tags");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = this._tags;
         _loc1_ = UtilDict.toDisplay("go","Group");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = UtilDict.toDisplay("go","pubwin_description");
         _loc1_ = this._description;
         _loc1_ = UtilDict.toDisplay("go","pubwin_movielang");
         _loc1_ = this.LANG_ARRAY;
         _loc1_ = UtilDict.toDisplay("go","pubwin_movielangsub");
         _loc1_ = UtilDict.toDisplay("go","pubwin_pickthumb");
         _loc1_ = this._vsCaptures.selectedIndex + 1 + "/" + this._captures.length;
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveas");
         _loc1_ = UtilDict.toDisplay("go","pubwin_public");
         _loc1_ = Console.getConsole().tempPublished;
         _loc1_ = UtilDict.toDisplay("go","pubwin_private");
         _loc1_ = !Console.getConsole().tempPublished;
         _loc1_ = UtilDict.toDisplay("go","pubwin_draft");
         _loc1_ = !Console.getConsole().tempPrivateShared;
         _loc1_ = UtilDict.toDisplay("go","pubwin_publish");
         _loc1_ = Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared;
         _loc1_ = UtilDict.toDisplay("go","pubwin_psharing");
         _loc1_ = UtilDict.toDisplay("go","pubwin_public");
         _loc1_ = Console.getConsole().tempPublished;
         _loc1_ = UtilDict.toDisplay("go","pubwin_private");
         _loc1_ = Console.getConsole().tempPrivateShared;
         _loc1_ = (this._parentalAlert.height - this._txtAlert.height) / 2;
         _loc1_ = UtilDict.toDisplay("go","pubwin_parent");
         _loc1_ = (this._groupAlert.height - this._txtGroupAlert.height) / 2;
         _loc1_ = UtilDict.toDisplay("go","Create groups of students to enable publishing your animations.");
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveonly");
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveonlytips");
         _loc1_ = Console.getConsole().isUserAlreadyLogin();
         _loc1_ = UtilDict.toDisplay("go","pubwin_warningtitle");
         _loc1_ = this._shareBtnBgEffect;
         _loc1_ = this._shareBtnBgEffect;
         _loc1_ = UtilDict.toDisplay("go","pubwin_astitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_assubtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_aslib");
         _loc1_ = UtilDict.toDisplay("go","pubwin_uploadtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_import");
         _loc1_ = UtilDict.toDisplay("go","pubwin_max");
         _loc1_ = UtilDict.toDisplay("go","pubwin_browse");
         _loc1_ = UtilDict.toDisplay("go","pubwin_upload");
         _loc1_ = UtilDict.toDisplay("go","pubwin_importdone");
         _loc1_ = UtilDict.toDisplay("go","pubwin_learnmore");
         _loc1_ = UtilDict.toDisplay("go","pubwin_watch");
         _loc1_ = UtilDict.toDisplay("go","pubwin_savenosound");
         _loc1_ = UtilDict.toDisplay("go","pubwin_savensharetips");
         _loc1_ = UtilDict.toDisplay("go","Close");
         _loc1_ = this.width * 0.5 - 200;
         _loc1_ = this.height * 0.5 - 126;
      }
      
      private function onSelect(param1:Event) : void
      {
         this._txtFile.text = this._file.name;
         if(this._file.size > 7900000)
         {
            this.clearFileReference();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canUploadSound() : Canvas
      {
         return this._23394237_canUploadSound;
      }
      
      [Bindable(event="propertyChange")]
      public function get _langBox() : ComboBox
      {
         return this._1988842562_langBox;
      }
      
      public function set _tip(param1:Button) : void
      {
         var _loc2_:Object = this._2944988_tip;
         if(_loc2_ !== param1)
         {
            this._2944988_tip = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tip",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _hbSharingModeA() : HBox
      {
         return this._83520443_hbSharingModeA;
      }
      
      [Bindable(event="propertyChange")]
      public function get _groupAlert() : Canvas
      {
         return this._1952108612_groupAlert;
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublishPrivate() : RadioButton
      {
         return this._1375372400_radioPublishPrivate;
      }
      
      private function _PublishWindow_RadioButtonGroup2_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this.movieTypeB = _loc1_;
         _loc1_.initialized(this,"movieTypeB");
         return _loc1_;
      }
      
      private function initAddingMusic() : void
      {
         var _loc1_:Canvas = null;
         if(UtilLicense.getCurrentLicenseId() == "7")
         {
            if(this._publishAddSound.getChildIndex(this._userPublishUpload) > 0)
            {
               this._publishAddSound.removeChild(this._userPublishUpload);
               _loc1_ = new Canvas();
               _loc1_.styleName = "domoMusic";
               _loc1_.width = 245;
               _loc1_.height = 310;
               this._publishAddSound.addChildAt(_loc1_,0);
            }
         }
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            if(this._publishAddSound.getChildIndex(this._userPublishUpload) > 0)
            {
               this._publishAddSound.removeChild(this._userPublishUpload);
            }
         }
         this._txtTutorIntro.text = UtilDict.toDisplay("go","pubwin_soundtutotialtips");
      }
      
      public function set lang(param1:String) : void
      {
         this._lang = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _hbSharingModeB() : HBox
      {
         return this._83520444_hbSharingModeB;
      }
      
      public function clearFileReference() : void
      {
         if(this._file != null)
         {
            this._txtFile.text = "";
            this._file.cancel();
            this._file = null;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tip() : Button
      {
         return this._2944988_tip;
      }
      
      public function set _vbGroup(param1:VBox) : void
      {
         var _loc2_:Object = this._1710757388_vbGroup;
         if(_loc2_ !== param1)
         {
            this._1710757388_vbGroup = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbGroup",_loc2_,param1));
         }
      }
      
      public function set _canSoundTutorial(param1:Canvas) : void
      {
         var _loc2_:Object = this._325902852_canSoundTutorial;
         if(_loc2_ !== param1)
         {
            this._325902852_canSoundTutorial = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canSoundTutorial",_loc2_,param1));
         }
      }
      
      public function ___radioPublishPrivate_click(param1:MouseEvent) : void
      {
         this.setTempPrivateShared();
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
   }
}
