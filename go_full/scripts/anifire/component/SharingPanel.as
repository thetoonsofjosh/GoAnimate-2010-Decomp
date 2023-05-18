package anifire.component
{
   import anifire.constant.ServerConstants;
   import anifire.event.SharingEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilPlain;
   import anifire.util.UtilSharing;
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
   import mx.containers.TabNavigator;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.Application;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.styles.*;
   import mx.utils.StringUtil;
   
   public class SharingPanel extends Canvas implements IBindingClient
   {
      
      private static const TYPE_REDDIT:String = "reddit";
      
      public static const STYLE_STUDIO:String = "style_studio";
      
      public static const TAB_CREATE:String = "create";
      
      public static const TAB_GOEMAIL:String = "goemail";
      
      private static const TYPE_DELICIOUS:String = "delicious";
      
      private static const TYPE_DIGG:String = "digg";
      
      public static const STYLE_PLAYER:String = "style_player";
      
      private static const TYPE_STUMBLEUPON:String = "stumbleupon";
      
      private static const TYPE_FARK:String = "fark";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const TYPE_FACEBOOK:String = "facebook";
      
      public static const TAB_EMBED:String = "embed";
      
      public static const TAB_EMAIL:String = "email";
      
      public static const TAB_SHARE:String = "share";
      
      private static const TYPE_MYSPACE:String = "myspace";
       
      
      private var _1360785098_btnClose1:Button;
      
      private var _1213949942_contactListTab:ViewStack;
      
      private var _1317528577_btnNewAnimation:anifire.component.CreateButton;
      
      private var _1730944143_btnFark:Button;
      
      public var _SharingPanel_Label11:Label;
      
      public var _SharingPanel_Label12:Label;
      
      public var _SharingPanel_Label13:Label;
      
      public var _SharingPanel_Label14:Label;
      
      public var _SharingPanel_Label16:Label;
      
      public var _SharingPanel_Label17:Label;
      
      public var _SharingPanel_Label18:Label;
      
      public var _SharingPanel_Label19:Label;
      
      private var _isFB:Boolean = false;
      
      private var _612233759_txtShareURL:TextInput;
      
      private var _561998435_btnDiggShare:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _711322577_lblStep2:Label;
      
      public var _SharingPanel_Label20:Label;
      
      public var _SharingPanel_Label21:Label;
      
      public var _SharingPanel_Label22:Label;
      
      public var _SharingPanel_Label23:Label;
      
      public var _SharingPanel_Label25:Label;
      
      public var _SharingPanel_Label26:Label;
      
      public var _SharingPanel_Label27:Label;
      
      public var _SharingPanel_Label28:Label;
      
      public var _SharingPanel_Label29:Label;
      
      private var _isFb:Boolean = false;
      
      private var _movieDesc:String;
      
      private var _isSlideshow:Boolean = false;
      
      private var _706637379_txtRecEmail:Label;
      
      private var _isPrivateShared:Boolean = false;
      
      private var _1436605790_emailSentText:Text;
      
      private var _apiServer:String;
      
      private var _60132792_canEmbed:Canvas;
      
      private var _isGo:Boolean = true;
      
      private var _382316096_btnStumbleuponShare:Button;
      
      private var _1445459215_txtSenderName:TextInput;
      
      private var _2044384006_btnCloseTop:anifire.component.IconTextButton;
      
      private var _fbAppURL:String;
      
      private var _1869697277_canCreateNotLogIn:Canvas;
      
      private var _883581826_btnMySpaceShare:Button;
      
      private var _1100971674_btnCopyEmail0:Button;
      
      private var _347601646_btnFarkShare:Button;
      
      private var _257634884_canEmailIsEmbed:Canvas;
      
      private var _1269660595_btnCopyShare:Button;
      
      private var _1480051251_btnDeliciousShare:Button;
      
      private var _1282441206_btnCopyEmail:Button;
      
      private var _userEmail:String;
      
      private var _1058421316_btnRedditShare:Button;
      
      private var _client_theme_code:String;
      
      private var _917370023_txtEmbedURL:TextInput;
      
      private var _chainMovieIds:String;
      
      private var _1360785097_btnClose2:Button;
      
      private var _938154405_btnReddit:Button;
      
      private var _1998779820_canEmailNoNewContact:Canvas;
      
      private var _1775652714_canEmailNotLogged:Canvas;
      
      private var _styleMode:String = "style_player";
      
      private var _905113604_vsSharingPanel:ViewStack;
      
      private var _movieUrl:String;
      
      private var _isOnStudio:Boolean = false;
      
      private var _1282440377_btnCopyEmbed:Button;
      
      private var _1654898563_btnFacebook:Button;
      
      private var _2107462590_btnShare:Button;
      
      private var _owner:String;
      
      private var _2120242372_btnEmbed:Button;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _selectedCanvas:Canvas;
      
      private var _1396665949_btnMySpace:Button;
      
      private var _1742329722_hboxEmail:HBox;
      
      private var _60133621_canEmail:Canvas;
      
      private var _1634983407_non_loginContactListTab:Canvas;
      
      private var _isPublished:Boolean = true;
      
      private var _1730553147_btnSend:Button;
      
      private var _1565562193_loginWithNoContact:Canvas;
      
      private var _userName:String;
      
      private var _1548185748_canCreateEmbed:Canvas;
      
      private var _1730996382_btnDigg:Button;
      
      private var _movieLicenserId:String;
      
      private var _1429005686_txtImportContact:Text;
      
      private var _isEmsg:Boolean = false;
      
      private var _1648048075_canEmailNewContact:Canvas;
      
      private var _appCode:String;
      
      private var _448424303_btnBackTop:anifire.component.IconTextButton;
      
      private var _1360785096_btnClose3:Button;
      
      private var _441836172_txtWebURL:TextInput;
      
      private var _isEmbed:Boolean = false;
      
      private var _1867528202_txtSenderEmail:TextInput;
      
      private var _movieTitle:String;
      
      private var _1916671123_canCreate:Canvas;
      
      private var _thumbnailUrl:String;
      
      private var _1037735649_loginContactListTab:Canvas;
      
      private var _34866078_canShareOther:Canvas;
      
      public var _SharingPanel_Text4:Text;
      
      public var _SharingPanel_Text5:Text;
      
      public var _SharingPanel_Text6:Text;
      
      public var _SharingPanel_Text7:Text;
      
      public var _SharingPanel_Text8:Text;
      
      public var _SharingPanel_Text9:Text;
      
      private var _tab:String = null;
      
      public var _SharingPanel_Text10:Text;
      
      public var _SharingPanel_Text12:Text;
      
      public var _SharingPanel_Text13:Text;
      
      private var _892673284_txtEmailURL:TextInput;
      
      private var _2126102749_btnCopyEmbedCreate:Button;
      
      private var _1930826236_lblMsgStep2:Label;
      
      private var _47353010_canShare:Canvas;
      
      private var _originalMovieId:String;
      
      private var _604466695_txtGoanimateURL:TextInput;
      
      private var _1504835083_txtRecipients:TextInput;
      
      private var _isLogin:Boolean = false;
      
      private var _543526166_txtMessage:TextArea;
      
      private var _movieId:String;
      
      private var _theme_language:String;
      
      private var _1355558663_btnCreate:Button;
      
      private var _2120243201_btnEmail:Button;
      
      private var _1050264321_btnstumbleupon:Button;
      
      private var _numContact:Number = 0;
      
      private var _embedTag:String;
      
      private var _userId:String;
      
      private var _635713576_canContent:Canvas;
      
      private var _1271323916_btnDelicious:Button;
      
      private var _294460542_contactFunctionNavigator:TabNavigator;
      
      private var _1370988937_btnCancel:Button;
      
      private var _470402854lblCreateTitle:Label;
      
      mx_internal var _watchers:Array;
      
      private var _copyable:Boolean = false;
      
      private var _movieOwnerId:String;
      
      private var _242669385_canEmailDetails:Canvas;
      
      private var _1360785095_btnClose4:Button;
      
      private var _1658267108_btnFacebookShare:Button;
      
      mx_internal var _bindings:Array;
      
      private var _variables:URLVariables;
      
      private var _1015645688_importContactsStatement:Canvas;
      
      private var _1884695403_txtImportAllContact:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SharingPanel()
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 52
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SharingPanel._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNewAnimation() : anifire.component.CreateButton
      {
         return this._1317528577_btnNewAnimation;
      }
      
      public function set embedTag(param1:String) : void
      {
         this._embedTag = param1;
      }
      
      public function set _contactListTab(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1213949942_contactListTab;
         if(_loc2_ !== param1)
         {
            this._1213949942_contactListTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_contactListTab",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _contactListTab() : ViewStack
      {
         return this._1213949942_contactListTab;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEmail() : Button
      {
         return this._2120243201_btnEmail;
      }
      
      public function set _lblMsgStep2(param1:Label) : void
      {
         var _loc2_:Object = this._1930826236_lblMsgStep2;
         if(_loc2_ !== param1)
         {
            this._1930826236_lblMsgStep2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblMsgStep2",_loc2_,param1));
         }
      }
      
      public function set _vsSharingPanel(param1:ViewStack) : void
      {
         var _loc2_:Object = this._905113604_vsSharingPanel;
         if(_loc2_ !== param1)
         {
            this._905113604_vsSharingPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsSharingPanel",_loc2_,param1));
         }
      }
      
      public function set _btnNewAnimation(param1:anifire.component.CreateButton) : void
      {
         var _loc2_:Object = this._1317528577_btnNewAnimation;
         if(_loc2_ !== param1)
         {
            this._1317528577_btnNewAnimation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNewAnimation",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyEmail() : Button
      {
         return this._1282441206_btnCopyEmail;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsSharingPanel() : ViewStack
      {
         return this._905113604_vsSharingPanel;
      }
      
      public function set _txtGoanimateURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._604466695_txtGoanimateURL;
         if(_loc2_ !== param1)
         {
            this._604466695_txtGoanimateURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtGoanimateURL",_loc2_,param1));
         }
      }
      
      public function set _btnCopyEmail(param1:Button) : void
      {
         var _loc2_:Object = this._1282441206_btnCopyEmail;
         if(_loc2_ !== param1)
         {
            this._1282441206_btnCopyEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyEmail",_loc2_,param1));
         }
      }
      
      public function set _txtRecipients(param1:TextInput) : void
      {
         var _loc2_:Object = this._1504835083_txtRecipients;
         if(_loc2_ !== param1)
         {
            this._1504835083_txtRecipients = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtRecipients",_loc2_,param1));
         }
      }
      
      public function set _txtSenderEmail(param1:TextInput) : void
      {
         var _loc2_:Object = this._1867528202_txtSenderEmail;
         if(_loc2_ !== param1)
         {
            this._1867528202_txtSenderEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtSenderEmail",_loc2_,param1));
         }
      }
      
      public function get movieUrl() : String
      {
         return this._movieUrl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtSenderEmail() : TextInput
      {
         return this._1867528202_txtSenderEmail;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canContent() : Canvas
      {
         return this._635713576_canContent;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblStep2() : Label
      {
         return this._711322577_lblStep2;
      }
      
      public function set _btnFacebookShare(param1:Button) : void
      {
         var _loc2_:Object = this._1658267108_btnFacebookShare;
         if(_loc2_ !== param1)
         {
            this._1658267108_btnFacebookShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFacebookShare",_loc2_,param1));
         }
      }
      
      public function addContact(param1:String, param2:Boolean = false) : void
      {
         this.showEmailDetail();
         this.callLater(this.insertingContact,[param1,param2]);
      }
      
      public function set movieUrl(param1:String) : void
      {
         this._movieUrl = param1;
      }
      
      public function set _canContent(param1:Canvas) : void
      {
         var _loc2_:Object = this._635713576_canContent;
         if(_loc2_ !== param1)
         {
            this._635713576_canContent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canContent",_loc2_,param1));
         }
      }
      
      public function set _lblStep2(param1:Label) : void
      {
         var _loc2_:Object = this._711322577_lblStep2;
         if(_loc2_ !== param1)
         {
            this._711322577_lblStep2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblStep2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnShare() : Button
      {
         return this._2107462590_btnShare;
      }
      
      public function ___btnClose2_click(param1:MouseEvent) : void
      {
         this.closePanel();
      }
      
      private function showEmailInterfaceInHtml() : void
      {
         ExternalInterface.call("showContactOverlay",true);
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function set _btnDeliciousShare(param1:Button) : void
      {
         var _loc2_:Object = this._1480051251_btnDeliciousShare;
         if(_loc2_ !== param1)
         {
            this._1480051251_btnDeliciousShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDeliciousShare",_loc2_,param1));
         }
      }
      
      public function ___SharingPanel_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyShare() : Button
      {
         return this._1269660595_btnCopyShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canShareOther() : Canvas
      {
         return this._34866078_canShareOther;
      }
      
      public function ___btnDeliciousShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DELICIOUS);
      }
      
      public function ___SharingPanel_Text9_click(param1:MouseEvent) : void
      {
         this.createAnimation();
      }
      
      public function set _btnStumbleuponShare(param1:Button) : void
      {
         var _loc2_:Object = this._382316096_btnStumbleuponShare;
         if(_loc2_ !== param1)
         {
            this._382316096_btnStumbleuponShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnStumbleuponShare",_loc2_,param1));
         }
      }
      
      public function set userId(param1:String) : void
      {
         this._userId = param1;
      }
      
      private function showDiv() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(ExternalInterface.available)
         {
            _loc2_ = "showAddressBook";
            _loc1_ = ExternalInterface.call(_loc2_,true);
         }
         else
         {
            _loc1_ = "js not available";
         }
      }
      
      public function ___txtGoanimateURL_creationComplete(param1:FlexEvent) : void
      {
         this.initGoAnimateURL();
      }
      
      public function set _btnShare(param1:Button) : void
      {
         var _loc2_:Object = this._2107462590_btnShare;
         if(_loc2_ !== param1)
         {
            this._2107462590_btnShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnShare",_loc2_,param1));
         }
      }
      
      public function ___btnDiggShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DIGG);
      }
      
      [Bindable(event="propertyChange")]
      public function get _contactFunctionNavigator() : TabNavigator
      {
         return this._294460542_contactFunctionNavigator;
      }
      
      public function set _btnRedditShare(param1:Button) : void
      {
         var _loc2_:Object = this._1058421316_btnRedditShare;
         if(_loc2_ !== param1)
         {
            this._1058421316_btnRedditShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRedditShare",_loc2_,param1));
         }
      }
      
      public function set _btnCopyShare(param1:Button) : void
      {
         var _loc2_:Object = this._1269660595_btnCopyShare;
         if(_loc2_ !== param1)
         {
            this._1269660595_btnCopyShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyShare",_loc2_,param1));
         }
      }
      
      public function set _canEmbed(param1:Canvas) : void
      {
         var _loc2_:Object = this._60132792_canEmbed;
         if(_loc2_ !== param1)
         {
            this._60132792_canEmbed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmbed",_loc2_,param1));
         }
      }
      
      public function set _canEmailIsEmbed(param1:Canvas) : void
      {
         var _loc2_:Object = this._257634884_canEmailIsEmbed;
         if(_loc2_ !== param1)
         {
            this._257634884_canEmailIsEmbed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmailIsEmbed",_loc2_,param1));
         }
      }
      
      private function updateCreateAnimationButtons() : void
      {
         this.lblCreateTitle.text = UtilDict.toDisplay("player","sharing_create") + " ";
         if(this._isSlideshow)
         {
            this.lblCreateTitle.text += UtilDict.toDisplay("player","sharing_slideshow");
         }
         else if(this._isEmsg)
         {
            this.lblCreateTitle.text += UtilDict.toDisplay("player","sharing_emessage");
         }
         else
         {
            this.lblCreateTitle.text += UtilDict.toDisplay("player","sharing_animation");
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtImportAllContact() : Text
      {
         return this._1884695403_txtImportAllContact;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtEmbedURL() : TextInput
      {
         return this._917370023_txtEmbedURL;
      }
      
      private function backToEmailPage() : void
      {
         if(this.selectedCanvas == this._canEmailIsEmbed || this.selectedCanvas == this._canEmailNewContact || this.selectedCanvas == this._canEmailNoNewContact || this.selectedCanvas == this._canEmailNotLogged)
         {
            this.selectedCanvas = this._canEmailDetails;
         }
         else if(this.selectedCanvas == this._canEmailDetails)
         {
            this.closePanel();
         }
      }
      
      public function ___btnDelicious_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DELICIOUS);
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmailDetails() : Canvas
      {
         return this._242669385_canEmailDetails;
      }
      
      public function copyData(param1:TextInput) : void
      {
         if(param1 != null && param1.text != null)
         {
            param1.setSelection(0,param1.text.length);
            param1.setFocus();
            System.setClipboard(param1.text);
         }
      }
      
      public function set _btnReddit(param1:Button) : void
      {
         var _loc2_:Object = this._938154405_btnReddit;
         if(_loc2_ !== param1)
         {
            this._938154405_btnReddit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnReddit",_loc2_,param1));
         }
      }
      
      private function loadAllContact() : void
      {
         CursorManager.setBusyCursor();
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.load(new URLRequest(ServerConstants.ACTION_GET_ALL_CONTACT + this.userId));
         _loc1_.addEventListener(Event.COMPLETE,this.addAllContact);
      }
      
      public function get thumbnailUrl() : String
      {
         return this._thumbnailUrl;
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
      }
      
      public function ___txtSenderName_creationComplete(param1:FlexEvent) : void
      {
         this.initSenderEmail();
      }
      
      public function set _btnMySpace(param1:Button) : void
      {
         var _loc2_:Object = this._1396665949_btnMySpace;
         if(_loc2_ !== param1)
         {
            this._1396665949_btnMySpace = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMySpace",_loc2_,param1));
         }
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
         }
      }
      
      public function set _canShareOther(param1:Canvas) : void
      {
         var _loc2_:Object = this._34866078_canShareOther;
         if(_loc2_ !== param1)
         {
            this._34866078_canShareOther = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canShareOther",_loc2_,param1));
         }
      }
      
      public function get username() : String
      {
         return this._userName;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCreate() : Button
      {
         return this._1355558663_btnCreate;
      }
      
      private function hideStep2Components() : void
      {
         if(this._lblStep2 != null)
         {
            this._lblStep2.visible = false;
         }
         if(this._lblMsgStep2 != null)
         {
            this._lblMsgStep2.visible = false;
         }
         if(this._txtShareURL != null)
         {
            this._txtShareURL.visible = false;
         }
         if(this._btnCopyShare != null)
         {
            this._btnCopyShare.visible = false;
         }
      }
      
      private function sendEmail() : void
      {
         var variables:URLVariables = null;
         var request:URLRequest = null;
         var stream:URLStream = null;
         if(StringUtil.trim(this._txtSenderName.text).length == 0)
         {
            Alert.show(UtilDict.toDisplay("player","sharing_errname"));
         }
         else if(StringUtil.trim(this._txtMessage.text).length == 0)
         {
            Alert.show(UtilDict.toDisplay("player","sharing_errmessage"));
         }
         else if(StringUtil.trim(this._txtRecipients.text).length == 0)
         {
            Alert.show(UtilDict.toDisplay("player","sharing_erremail"));
         }
         else if((this._txtRecipients.text.split(",") as Array).length > 20)
         {
            Alert.show(UtilDict.toDisplay("player","sharing_errmore"));
         }
         else
         {
            try
            {
               Util.gaTracking("/share/email/flash",this.stage);
            }
            catch(error:SecurityError)
            {
            }
            variables = new URLVariables();
            Util.addFlashVarsToURLvar(variables);
            variables[ServerConstants.PARAM_MOVIE_ID] = this._movieId;
            variables[ServerConstants.PARAM_SENDER_NAME] = this._txtSenderName.text;
            variables[ServerConstants.PARAM_SENDER_EMAIL] = this._txtSenderEmail.text;
            variables[ServerConstants.PARAM_RECIPIENT_EMAIL] = this._txtRecipients.text;
            variables["custom_message"] = this._txtMessage.text;
            if(UtilLicense.isBoxEnvironment())
            {
               variables[ServerConstants.PARAM_BOX_PARENT_URL] = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_BOX_PARENT_URL);
               variables[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
            }
            request = new URLRequest(ServerConstants.ACTION_SEND_SHARE_EMAIL);
            request.method = URLRequestMethod.POST;
            request.data = variables;
            stream = new URLStream();
            stream.addEventListener(Event.COMPLETE,this.sendEmailComplete);
            stream.load(request);
            CursorManager.setBusyCursor();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnstumbleupon() : Button
      {
         return this._1050264321_btnstumbleupon;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : anifire.component.IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _contactFunctionNavigator(param1:TabNavigator) : void
      {
         var _loc2_:Object = this._294460542_contactFunctionNavigator;
         if(_loc2_ !== param1)
         {
            this._294460542_contactFunctionNavigator = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_contactFunctionNavigator",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtEmailURL() : TextInput
      {
         return this._892673284_txtEmailURL;
      }
      
      private function initEmbedURL() : void
      {
         if(this.embedTag == null || this.embedTag == "")
         {
            this.embedTag = this.buildEmbedTag();
         }
         this._txtEmbedURL.text = this.embedTag;
      }
      
      public function get movieTitle() : String
      {
         return this._movieTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelicious() : Button
      {
         return this._1271323916_btnDelicious;
      }
      
      public function init() : void
      {
         this._variables = new URLVariables();
         Util.addFlashVarsToURLvar(this._variables);
         this._apiServer = this._variables["apiserver"];
         this._appCode = this._variables["appCode"];
         this._fbAppURL = this._variables["fb_app_url"];
         this._owner = this._variables["movieOwner"];
         this.userId = !!this._variables["userId"] ? String(this._variables["userId"]) : "";
         this.chainMovieIds = !!this._variables[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID] ? String(this._variables[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID]) : "";
         this.username = !!this._variables["username"] ? String(this._variables["username"]) : "";
         this.userEmail = !!this._variables["uemail"] ? String(this._variables["uemail"]) : "";
         this._isEmsg = !!this._variables["is_emessage"] ? this._variables["is_emessage"] == "1" : false;
         this._isSlideshow = !!this._variables["is_slideshow"] ? this._variables["is_slideshow"] == "1" : false;
         this._originalMovieId = !!this._variables["originalId"] ? String(this._variables["originalId"]) : null;
         if(this.isOnStudio == false)
         {
            this.movieId = !!this._variables["movieId"] ? String(this._variables["movieId"]) : "";
            if(this.movieId == "")
            {
               this.movieId = Application.application.parameters["movieId"];
            }
            this.movieTitle = !!this._variables["movieTitle"] ? String(this._variables["movieTitle"]) : "";
            this.movieDesc = !!this._variables["movieDesc"] ? String(this._variables["movieDesc"]) : "";
            this.thumbnailUrl = !!this._variables["thumbnailURL"] ? Util.getMovieThumbnailUrl() : "";
            this._copyable = !!this._variables[ServerConstants.FLASHVAR_IS_COPYABLE] ? (this._variables[ServerConstants.FLASHVAR_IS_COPYABLE] != "0" ? true : false) : false;
            if(!UtilPlain.get_isMoviePublished_by_flashVar(this._variables["isPublished"],this._variables["is_private_shared"]))
            {
               this.isPublished = false;
            }
            this.isPrivateShared = UtilPlain.get_isMoviePrivateShare_by_flashVar(this._variables["is_private_shared"]) ? true : false;
         }
         this.initEmailURL();
         if(!this._variables["isEmbed"] || this._variables["isEmbed"] == "1")
         {
            this._isEmbed = true;
         }
         else
         {
            if(this._appCode == "go")
            {
               this._isGo = true;
               this._isFB = false;
            }
            else if(this._appCode == "fb")
            {
               this._isFB = true;
               this._isGo = false;
            }
            if(this._userId.length > 0)
            {
               this._isLogin = true;
            }
            this._numContact = !!this._variables["numContact"] ? Number(this._variables["numContact"]) : 0;
         }
         if(Boolean(this._variables["movieOwnerId"]) && this._variables["movieOwnerId"] != "")
         {
            this._movieOwnerId = this._variables["movieOwnerId"];
         }
         else
         {
            this._movieOwnerId = null;
         }
         this._client_theme_code = this._variables[ServerConstants.FLASHVAR_CLIENT_THEME_CODE];
         this._theme_language = this._variables[ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE];
         if(Boolean(this._variables[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID]) && this._variables[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID] != "")
         {
            this._movieLicenserId = this._variables[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID];
         }
         else
         {
            this._movieLicenserId = "";
         }
         this.embedTag = this.buildEmbedTag();
         if(!this._variables[ServerConstants.PARAM_APPCODE] == "fb")
         {
            this._isFb = true;
         }
      }
      
      public function set _txtImportContact(param1:Text) : void
      {
         var _loc2_:Object = this._1429005686_txtImportContact;
         if(_loc2_ !== param1)
         {
            this._1429005686_txtImportContact = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtImportContact",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMessage() : TextArea
      {
         return this._543526166_txtMessage;
      }
      
      public function ___btnFarkShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FARK);
      }
      
      public function ___btnClose1_click(param1:MouseEvent) : void
      {
         this.closePanel();
      }
      
      public function set _txtWebURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._441836172_txtWebURL;
         if(_loc2_ !== param1)
         {
            this._441836172_txtWebURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWebURL",_loc2_,param1));
         }
      }
      
      public function set userEmail(param1:String) : void
      {
         this._userEmail = param1;
      }
      
      public function set _txtImportAllContact(param1:Text) : void
      {
         var _loc2_:Object = this._1884695403_txtImportAllContact;
         if(_loc2_ !== param1)
         {
            this._1884695403_txtImportAllContact = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtImportAllContact",_loc2_,param1));
         }
      }
      
      public function set _btnBackTop(param1:anifire.component.IconTextButton) : void
      {
         var _loc2_:Object = this._448424303_btnBackTop;
         if(_loc2_ !== param1)
         {
            this._448424303_btnBackTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBackTop",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose1() : Button
      {
         return this._1360785098_btnClose1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose2() : Button
      {
         return this._1360785097_btnClose2;
      }
      
      public function creationComplete() : void
      {
         this.hideStep2Components();
         if(this.tab != null)
         {
            this.showTab(this.tab);
         }
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
         {
            ExternalInterface.addCallback("addContact",this.addContact);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose4() : Button
      {
         return this._1360785095_btnClose4;
      }
      
      public function ___btnCopyEmail_click(param1:MouseEvent) : void
      {
         this.copyData(this._txtEmailURL);
      }
      
      public function ___txtImportAllContact_click(param1:MouseEvent) : void
      {
         this.loadAllContact();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose3() : Button
      {
         return this._1360785096_btnClose3;
      }
      
      public function set _emailSentText(param1:Text) : void
      {
         var _loc2_:Object = this._1436605790_emailSentText;
         if(_loc2_ !== param1)
         {
            this._1436605790_emailSentText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_emailSentText",_loc2_,param1));
         }
      }
      
      public function ___btnMySpace_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_MYSPACE);
      }
      
      public function ___btnCopyEmail0_click(param1:MouseEvent) : void
      {
         this.copyData(this._txtWebURL);
      }
      
      public function set _txtEmbedURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._917370023_txtEmbedURL;
         if(_loc2_ !== param1)
         {
            this._917370023_txtEmbedURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtEmbedURL",_loc2_,param1));
         }
      }
      
      private function insertingContact(param1:String, param2:Boolean = false) : void
      {
         if(param2)
         {
            this._txtRecipients.text = param1;
         }
         else
         {
            if(this._txtRecipients.text != "")
            {
               param1 = "," + param1;
            }
            this._txtRecipients.text += param1;
         }
      }
      
      public function set _loginWithNoContact(param1:Canvas) : void
      {
         var _loc2_:Object = this._1565562193_loginWithNoContact;
         if(_loc2_ !== param1)
         {
            this._1565562193_loginWithNoContact = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loginWithNoContact",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyEmail0() : Button
      {
         return this._1100971674_btnCopyEmail0;
      }
      
      public function ___btnEmail_click(param1:MouseEvent) : void
      {
         this.changeTab(param1);
      }
      
      private function initEmailURL() : void
      {
         var _loc2_:URLVariables = null;
         var _loc1_:String = null;
         if((this.movieUrl == null || this.movieUrl == "") && this._txtEmailURL.text == "")
         {
            if(UtilLicense.isBoxEnvironment())
            {
               _loc2_ = new URLVariables();
               _loc2_["utm_source"] = "emailshare";
               _loc2_["utm_campaign"] = UtilLicense.boxCustomerID;
               _loc2_["uid"] = this.userId;
               this.movieUrl = UtilSharing.getBoxMovieUrl(this.movieId,_loc2_);
            }
            else
            {
               this.movieUrl = ServerConstants.MOVIE_PATH + this.movieId + "?utm_source=emailshare&uid=" + this.userId;
            }
         }
         this._txtEmailURL.text = this.movieUrl;
      }
      
      public function set _canEmailDetails(param1:Canvas) : void
      {
         var _loc2_:Object = this._242669385_canEmailDetails;
         if(_loc2_ !== param1)
         {
            this._242669385_canEmailDetails = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmailDetails",_loc2_,param1));
         }
      }
      
      private function set isPrivateShared(param1:Boolean) : void
      {
         this._isPrivateShared = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDiggShare() : Button
      {
         return this._561998435_btnDiggShare;
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.backToEmailPage();
      }
      
      public function set _btnSend(param1:Button) : void
      {
         var _loc2_:Object = this._1730553147_btnSend;
         if(_loc2_ !== param1)
         {
            this._1730553147_btnSend = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSend",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtRecEmail() : Label
      {
         return this._706637379_txtRecEmail;
      }
      
      public function set username(param1:String) : void
      {
         this._userName = param1;
      }
      
      private function changeTab(param1:Event) : void
      {
         if(param1.target == this._btnShare)
         {
            this.showTab(TAB_SHARE);
         }
         else if(param1.target == this._btnEmail)
         {
            this.showTab(TAB_EMAIL);
         }
         else if(param1.target == this._btnEmbed)
         {
            this.showTab(TAB_EMBED);
         }
         else if(param1.target == this._btnCreate)
         {
            this.showTab(TAB_CREATE);
         }
      }
      
      public function set thumbnailUrl(param1:String) : void
      {
         this._thumbnailUrl = param1;
      }
      
      public function set _loginContactListTab(param1:Canvas) : void
      {
         var _loc2_:Object = this._1037735649_loginContactListTab;
         if(_loc2_ !== param1)
         {
            this._1037735649_loginContactListTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loginContactListTab",_loc2_,param1));
         }
      }
      
      public function ___btnFacebookShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FACEBOOK);
      }
      
      public function ___btnFacebook_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FACEBOOK);
      }
      
      public function set _btnFarkShare(param1:Button) : void
      {
         var _loc2_:Object = this._347601646_btnFarkShare;
         if(_loc2_ !== param1)
         {
            this._347601646_btnFarkShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFarkShare",_loc2_,param1));
         }
      }
      
      private function showStep2Components() : void
      {
         if(this._lblStep2 != null)
         {
            this._lblStep2.visible = true;
         }
         if(this._lblMsgStep2 != null)
         {
            this._lblMsgStep2.visible = true;
         }
         if(this._txtShareURL != null)
         {
            this._txtShareURL.visible = true;
         }
         if(this._btnCopyShare != null)
         {
            this._btnCopyShare.visible = true;
         }
      }
      
      public function get movieDesc() : String
      {
         return this._movieDesc;
      }
      
      public function set _txtSenderName(param1:TextInput) : void
      {
         var _loc2_:Object = this._1445459215_txtSenderName;
         if(_loc2_ !== param1)
         {
            this._1445459215_txtSenderName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtSenderName",_loc2_,param1));
         }
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closePanel();
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmailNoNewContact() : Canvas
      {
         return this._1998779820_canEmailNoNewContact;
      }
      
      private function createAnimation(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:URLRequest = null;
         var _loc4_:String = null;
         if(this._isSlideshow)
         {
            _loc3_ = "/go/slideshow/";
         }
         else if(this._isEmsg)
         {
            if(param1)
            {
               _loc3_ = "/go/studio/copyemessage/" + this._originalMovieId;
            }
            else
            {
               _loc3_ = "/go/emessage/";
            }
         }
         else
         {
            _loc3_ = "/go/studio/";
            if(UtilLicense.isBoxEnvironment())
            {
               _loc3_ = "/studio/";
               _loc3_ = (_loc4_ = decodeURI(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_BOX_PARENT_URL))).replace(/v=\d+/,"v=" + new Date().time.toString()) + "#" + _loc3_;
            }
            if(param1)
            {
               _loc5_ = this._movieId;
               _loc3_ += "copy/" + _loc5_;
            }
         }
         if(this._isLogin)
         {
            _loc6_ = new URLRequest(_loc3_);
            navigateToURL(_loc6_,"_blank");
         }
         else
         {
            Util.goToLoginPage(param2,this._isGo,this._isEmbed,this._apiServer,_loc3_);
         }
      }
      
      private function goToYmail() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("showAddressBook","ymail");
         }
      }
      
      public function set styleMode(param1:String) : void
      {
         this._styleMode = param1;
         if(param1 == STYLE_STUDIO)
         {
            this._btnCloseTop.visible = false;
            this.styleName = "";
            this._canContent.styleName = "bgSharingContentStudio";
            this._btnCreate.visible = false;
            this._btnShare.styleName = "tabShareSelectedStudio";
            this._btnShare.y -= 2;
            this._btnEmail.x = this._btnShare.x + 168;
            this._btnEmail.styleName = "tabEmailUnselectedStudio";
            this._btnEmail.y -= 2;
            this._btnEmbed.x = this._btnEmail.x + 166;
            this._btnEmbed.styleName = "tabEmbedUnselectedStudio";
            this._btnEmbed.y -= 2;
         }
      }
      
      public function ___txtEmbedURL_creationComplete(param1:FlexEvent) : void
      {
         this.initEmbedURL();
      }
      
      public function set _btnCloseTop(param1:anifire.component.IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _importContactsStatement() : Canvas
      {
         return this._1015645688_importContactsStatement;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblMsgStep2() : Label
      {
         return this._1930826236_lblMsgStep2;
      }
      
      public function set _btnstumbleupon(param1:Button) : void
      {
         var _loc2_:Object = this._1050264321_btnstumbleupon;
         if(_loc2_ !== param1)
         {
            this._1050264321_btnstumbleupon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnstumbleupon",_loc2_,param1));
         }
      }
      
      public function get embedTag() : String
      {
         return this._embedTag;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtShareURL() : TextInput
      {
         return this._612233759_txtShareURL;
      }
      
      public function set _canCreateNotLogIn(param1:Canvas) : void
      {
         var _loc2_:Object = this._1869697277_canCreateNotLogIn;
         if(_loc2_ !== param1)
         {
            this._1869697277_canCreateNotLogIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canCreateNotLogIn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _non_loginContactListTab() : Canvas
      {
         return this._1634983407_non_loginContactListTab;
      }
      
      public function set _txtEmailURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._892673284_txtEmailURL;
         if(_loc2_ !== param1)
         {
            this._892673284_txtEmailURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtEmailURL",_loc2_,param1));
         }
      }
      
      public function set _btnCreate(param1:Button) : void
      {
         var _loc2_:Object = this._1355558663_btnCreate;
         if(_loc2_ !== param1)
         {
            this._1355558663_btnCreate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCreate",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtRecipients() : TextInput
      {
         return this._1504835083_txtRecipients;
      }
      
      public function set movieTitle(param1:String) : void
      {
         this._movieTitle = param1;
      }
      
      public function set _canEmail(param1:Canvas) : void
      {
         var _loc2_:Object = this._60133621_canEmail;
         if(_loc2_ !== param1)
         {
            this._60133621_canEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmail",_loc2_,param1));
         }
      }
      
      public function ___SharingPanel_Text13_click(param1:MouseEvent) : void
      {
         this.createAnimation(false,false);
      }
      
      public function set _btnDelicious(param1:Button) : void
      {
         var _loc2_:Object = this._1271323916_btnDelicious;
         if(_loc2_ !== param1)
         {
            this._1271323916_btnDelicious = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelicious",_loc2_,param1));
         }
      }
      
      public function ___SharingPanel_Button17_click(param1:MouseEvent) : void
      {
         this.showEmailInterfaceInHtml();
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtGoanimateURL() : TextInput
      {
         return this._604466695_txtGoanimateURL;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFacebookShare() : Button
      {
         return this._1658267108_btnFacebookShare;
      }
      
      public function set _txtMessage(param1:TextArea) : void
      {
         var _loc2_:Object = this._543526166_txtMessage;
         if(_loc2_ !== param1)
         {
            this._543526166_txtMessage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMessage",_loc2_,param1));
         }
      }
      
      private function showContactTab() : void
      {
         if(this._isEmbed || this._isFb)
         {
            this._contactFunctionNavigator.visible = false;
            return;
         }
         if(this._isGo)
         {
            if(this._isLogin)
            {
               if(this._numContact > 0)
               {
                  this._contactListTab.selectedChild = this._loginContactListTab;
                  this._txtImportAllContact.text = UtilDict.toDisplay("player","sharing_addall") + " (" + this._numContact + ")";
               }
               else
               {
                  this._contactListTab.selectedChild = this._loginWithNoContact;
               }
            }
            else
            {
               this._contactListTab.selectedChild = this._non_loginContactListTab;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDeliciousShare() : Button
      {
         return this._1480051251_btnDeliciousShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRedditShare() : Button
      {
         return this._1058421316_btnRedditShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmbed() : Canvas
      {
         return this._60132792_canEmbed;
      }
      
      public function ___btnDigg_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DIGG);
      }
      
      public function set lblCreateTitle(param1:Label) : void
      {
         var _loc2_:Object = this._470402854lblCreateTitle;
         if(_loc2_ !== param1)
         {
            this._470402854lblCreateTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblCreateTitle",_loc2_,param1));
         }
      }
      
      public function get userId() : String
      {
         return this._userId;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnStumbleuponShare() : Button
      {
         return this._382316096_btnStumbleuponShare;
      }
      
      private function showImportContactStatement() : void
      {
         if(this._isEmbed || this._isFb)
         {
            this._importContactsStatement.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmailIsEmbed() : Canvas
      {
         return this._257634884_canEmailIsEmbed;
      }
      
      private function sendEmailComplete(param1:Event) : void
      {
         CursorManager.removeBusyCursor();
         var _loc2_:ByteArray = new ByteArray();
         (param1.target as URLStream).readBytes(_loc2_);
         var _loc3_:String = _loc2_.toString();
         if(this._isEmbed)
         {
            this.selectedCanvas = this._canEmailIsEmbed;
         }
         else if(!this._isLogin)
         {
            this.selectedCanvas = this._canEmailNotLogged;
         }
         else if(Number(_loc3_) > 0)
         {
            this.selectedCanvas = this._canEmailNewContact;
         }
         else
         {
            this.selectedCanvas = this._canEmailNoNewContact;
         }
      }
      
      public function set _btnCopyEmbedCreate(param1:Button) : void
      {
         var _loc2_:Object = this._2126102749_btnCopyEmbedCreate;
         if(_loc2_ !== param1)
         {
            this._2126102749_btnCopyEmbedCreate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyEmbedCreate",_loc2_,param1));
         }
      }
      
      private function _SharingPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("player","sharing_commaseparate");
         _loc1_ = this._hboxEmail.x;
         _loc1_ = this._hboxEmail.y + this._txtRecEmail.y + 14;
         _loc1_ = UtilDict.toDisplay("player","sharing_emailout");
         _loc1_ = UtilDict.toDisplay("player","sharing_yourname");
         _loc1_ = UtilDict.toDisplay("player","sharing_youremail");
         _loc1_ = UtilDict.toDisplay("player","sharing_friendemail");
         _loc1_ = UtilDict.toDisplay("player","sharing_contactlist");
         _loc1_ = UtilDict.toDisplay("player","sharing_select");
         _loc1_ = UtilDict.toDisplay("player","sharing_addall") + " ";
         _loc1_ = UtilDict.toDisplay("player","sharing_nocontacts");
         _loc1_ = UtilDict.toDisplay("player","sharing_login_register");
         _loc1_ = UtilDict.toDisplay("player","sharing_modifymessage");
         _loc1_ = UtilDict.toDisplay("player","sharing_cancel");
         _loc1_ = UtilDict.toDisplay("player","sharing_send");
         _loc1_ = UtilDict.toDisplay("player","sharing_emailout");
         _loc1_ = UtilDict.toDisplay("player","sharing_thankyou");
         _loc1_ = UtilDict.toDisplay("player","sharing_close");
         _loc1_ = UtilDict.toDisplay("player","sharing_emailout");
         _loc1_ = UtilDict.toDisplay("player","sharing_autoadd");
         _loc1_ = UtilDict.toDisplay("player","sharing_easylist");
         _loc1_ = UtilDict.toDisplay("player","sharing_close");
         _loc1_ = UtilDict.toDisplay("player","sharing_emailout");
         _loc1_ = "                                         " + UtilDict.toDisplay("player","sharing_ongoanimate");
         _loc1_ = UtilDict.toDisplay("player","sharing_createaccount");
         _loc1_ = UtilDict.toDisplay("player","sharing_withaccount");
         _loc1_ = UtilDict.toDisplay("player","sharing_close");
         _loc1_ = UtilDict.toDisplay("player","sharing_emailout");
         _loc1_ = this._emailSentText.text = UtilDict.toDisplay("player","sharing_checkout") + " " + UtilLicense.getCurrentLicensorDisplayName() + UtilDict.toDisplay("player","sharing_towatch");
         _loc1_ = UtilDict.toDisplay("player","sharing_close");
         _loc1_ = UtilDict.toDisplay("player","sharing_copy");
         _loc1_ = UtilDict.toDisplay("player","sharing_embed");
         _loc1_ = UtilDict.toDisplay("player","sharing_copy");
         _loc1_ = UtilDict.toDisplay("player","sharing_link");
         _loc1_ = UtilDict.toDisplay("player","sharing_copy");
         _loc1_ = (this._canCreate.width - this.lblCreateTitle.width) / 2;
         _loc1_ = (this._canCreate.width - this._btnNewAnimation.width) / 2;
         _loc1_ = UtilDict.toDisplay("player","Create one from scratch");
         _loc1_ = UtilDict.toDisplay("player","sharing_createanimation");
         _loc1_ = UtilDict.toDisplay("player","sharing_ongoanimate");
         _loc1_ = UtilDict.toDisplay("player","sharing_freefun");
         _loc1_ = UtilDict.toDisplay("player","sharing_or");
         _loc1_ = UtilDict.toDisplay("player","sharing_registered");
         _loc1_ = UtilDict.toDisplay("player","sharing_signup");
         _loc1_ = UtilDict.toDisplay("player","sharing_login");
         _loc1_ = UtilDict.toDisplay("player","Back");
         _loc1_ = UtilDict.toDisplay("player","Close");
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMySpace() : Button
      {
         return this._1396665949_btnMySpace;
      }
      
      public function ___btnstumbleupon_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_STUMBLEUPON);
      }
      
      public function ___btnMySpaceShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_MYSPACE);
      }
      
      public function set _btnClose1(param1:Button) : void
      {
         var _loc2_:Object = this._1360785098_btnClose1;
         if(_loc2_ !== param1)
         {
            this._1360785098_btnClose1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose1",_loc2_,param1));
         }
      }
      
      public function set _btnClose2(param1:Button) : void
      {
         var _loc2_:Object = this._1360785097_btnClose2;
         if(_loc2_ !== param1)
         {
            this._1360785097_btnClose2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose2",_loc2_,param1));
         }
      }
      
      public function set _btnClose3(param1:Button) : void
      {
         var _loc2_:Object = this._1360785096_btnClose3;
         if(_loc2_ !== param1)
         {
            this._1360785096_btnClose3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose3",_loc2_,param1));
         }
      }
      
      public function set _btnClose4(param1:Button) : void
      {
         var _loc2_:Object = this._1360785095_btnClose4;
         if(_loc2_ !== param1)
         {
            this._1360785095_btnClose4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose4",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnReddit() : Button
      {
         return this._938154405_btnReddit;
      }
      
      public function shareAnimation(param1:String, param2:Boolean = false) : void
      {
         var request:URLRequest = null;
         var type:String = param1;
         var showStep2:Boolean = param2;
         var url:String = "";
         var modMovieUrl:String = escape(ServerConstants.MOVIE_PATH + this.movieId + "?utm_source=" + type + "&uid=" + this.userId);
         var modifiedMovieTitle:String = escape(UtilLicense.getCurrentLicensorDisplayName() + ": " + this.movieTitle);
         if(type == TYPE_FACEBOOK)
         {
            url = "http://www.facebook.com/sharer.php?u=" + modMovieUrl + "&t=" + modifiedMovieTitle;
         }
         else if(type == TYPE_MYSPACE)
         {
            url = "http://www.myspace.com/Modules/PostTo/Pages/?t=" + modifiedMovieTitle + "&c=" + escape(this.embedTag) + "&u=" + modMovieUrl + "&l=1";
         }
         else if(type == TYPE_DIGG)
         {
            url = "http://digg.com/submit?phase=2&url=" + modMovieUrl + "&title=" + modifiedMovieTitle + "&bodytext=" + escape(this.movieDesc) + "&topic=videos_animation";
         }
         else if(type == TYPE_DELICIOUS)
         {
            url = "http://del.icio.us/post?noui&v=4&jump=close&url=" + modMovieUrl + "&title=" + modifiedMovieTitle + "&partner=GoAnimate";
         }
         else if(type == TYPE_REDDIT)
         {
            url = "http://reddit.com/submit?url=" + modMovieUrl + "&title=" + modifiedMovieTitle;
         }
         else if(type == TYPE_STUMBLEUPON)
         {
            url = "http://www.stumbleupon.com/submit?url=" + modMovieUrl + "&title=" + modifiedMovieTitle;
         }
         else if(type == TYPE_FARK)
         {
            url = "http://cgi.fark.com/cgi/fark/submit.pl?new_url=" + modMovieUrl + "&new_comment=" + escape(this.movieDesc);
         }
         if(this._isGo)
         {
            try
            {
               Util.gaTracking("/share/" + type + "/flash",this.stage);
            }
            catch(error:SecurityError)
            {
            }
            request = new URLRequest(url);
            navigateToURL(request,"_blank");
         }
         else
         {
            this._txtShareURL.text = url;
            this.showStep2Components();
         }
         if(showStep2)
         {
            this.showStep2Components();
         }
      }
      
      public function ___SharingPanel_Text1_click(param1:MouseEvent) : void
      {
         this.showEmailDetail();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      public function ___btnBackTop_click(param1:MouseEvent) : void
      {
         this.backToEmailPage();
      }
      
      public function set _btnEmbed(param1:Button) : void
      {
         var _loc2_:Object = this._2120242372_btnEmbed;
         if(_loc2_ !== param1)
         {
            this._2120242372_btnEmbed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEmbed",_loc2_,param1));
         }
      }
      
      public function ___btnReddit_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_REDDIT);
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtImportContact() : Text
      {
         return this._1429005686_txtImportContact;
      }
      
      public function set _btnCopyEmbed(param1:Button) : void
      {
         var _loc2_:Object = this._1282440377_btnCopyEmbed;
         if(_loc2_ !== param1)
         {
            this._1282440377_btnCopyEmbed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyEmbed",_loc2_,param1));
         }
      }
      
      public function get userEmail() : String
      {
         return this._userEmail;
      }
      
      private function set chainMovieIds(param1:String) : void
      {
         this._chainMovieIds = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtWebURL() : TextInput
      {
         return this._441836172_txtWebURL;
      }
      
      public function set _canShare(param1:Canvas) : void
      {
         var _loc2_:Object = this._47353010_canShare;
         if(_loc2_ !== param1)
         {
            this._47353010_canShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canShare",_loc2_,param1));
         }
      }
      
      public function buildEmbedTag() : String
      {
         var _loc1_:String = null;
         if(UtilLicense.isBoxEnvironment())
         {
            _loc1_ = UtilSharing.buildBoxEmbedTag(this._owner,this._movieId,this.movieTitle,this.movieDesc,this._userId,this._apiServer,this._appCode,this.thumbnailUrl,this._fbAppURL,this._copyable,this._isPublished,this.isPrivateShared,"embed",this._movieOwnerId,this._movieLicenserId,this._client_theme_code,this._theme_language,this.chainMovieIds);
         }
         else
         {
            _loc1_ = UtilSharing.buildEmbedTag(this._owner,this._movieId,this.movieTitle,this.movieDesc,this._userId,this._apiServer,this._appCode,this.thumbnailUrl,this._fbAppURL,this._copyable,this._isPublished,this.isPrivateShared,"embed",this._movieOwnerId,this._movieLicenserId,this._client_theme_code,this._theme_language,this.chainMovieIds);
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBackTop() : anifire.component.IconTextButton
      {
         return this._448424303_btnBackTop;
      }
      
      public function ___btnCreate_click(param1:MouseEvent) : void
      {
         this.changeTab(param1);
      }
      
      public function ___btnStumbleuponShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_STUMBLEUPON);
      }
      
      private function initWebURL() : void
      {
         this._txtWebURL.text = ServerConstants.HOST_PATH;
      }
      
      [Bindable(event="propertyChange")]
      public function get _loginWithNoContact() : Canvas
      {
         return this._1565562193_loginWithNoContact;
      }
      
      public function ___btnCopyEmbed_click(param1:MouseEvent) : void
      {
         this.copyData(this._txtEmbedURL);
      }
      
      [Bindable(event="propertyChange")]
      public function get _emailSentText() : Text
      {
         return this._1436605790_emailSentText;
      }
      
      public function ___txtWebURL_creationComplete(param1:FlexEvent) : void
      {
         this.initWebURL();
      }
      
      private function get isPrivateShared() : Boolean
      {
         return this._isPrivateShared;
      }
      
      public function set _btnDigg(param1:Button) : void
      {
         var _loc2_:Object = this._1730996382_btnDigg;
         if(_loc2_ !== param1)
         {
            this._1730996382_btnDigg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDigg",_loc2_,param1));
         }
      }
      
      private function addAllContact(param1:Event) : void
      {
         var _loc2_:String = null;
         CursorManager.removeBusyCursor();
         var _loc3_:XML = new XML(param1.target.data);
         _loc2_ = _loc3_.addressbook;
         this.addContact(_loc2_,true);
      }
      
      public function set _btnCopyEmail0(param1:Button) : void
      {
         var _loc2_:Object = this._1100971674_btnCopyEmail0;
         if(_loc2_ !== param1)
         {
            this._1100971674_btnCopyEmail0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyEmail0",_loc2_,param1));
         }
      }
      
      private function _SharingPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_commaseparate");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label11.text = param1;
         },"_SharingPanel_Label11.text");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return _hboxEmail.x;
         },function(param1:Number):void
         {
            _SharingPanel_Label11.x = param1;
         },"_SharingPanel_Label11.x");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return _hboxEmail.y + _txtRecEmail.y + 14;
         },function(param1:Number):void
         {
            _SharingPanel_Label11.y = param1;
         },"_SharingPanel_Label11.y");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_emailout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label12.text = param1;
         },"_SharingPanel_Label12.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_yourname");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label13.text = param1;
         },"_SharingPanel_Label13.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_youremail");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label14.text = param1;
         },"_SharingPanel_Label14.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_friendemail");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtRecEmail.text = param1;
         },"_txtRecEmail.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_contactlist");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _contactListTab.label = param1;
         },"_contactListTab.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_select");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtImportContact.text = param1;
         },"_txtImportContact.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_addall") + " ";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtImportAllContact.text = param1;
         },"_txtImportAllContact.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_nocontacts");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text4.text = param1;
         },"_SharingPanel_Text4.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_login_register");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text5.htmlText = param1;
         },"_SharingPanel_Text5.htmlText");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_modifymessage");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label16.text = param1;
         },"_SharingPanel_Label16.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCancel.label = param1;
         },"_btnCancel.label");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_send");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnSend.label = param1;
         },"_btnSend.label");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_emailout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label17.text = param1;
         },"_SharingPanel_Label17.text");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_thankyou");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label18.text = param1;
         },"_SharingPanel_Label18.text");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnClose1.label = param1;
         },"_btnClose1.label");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_emailout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label19.text = param1;
         },"_SharingPanel_Label19.text");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_autoadd");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text6.text = param1;
         },"_SharingPanel_Text6.text");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_easylist");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text7.text = param1;
         },"_SharingPanel_Text7.text");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnClose2.label = param1;
         },"_btnClose2.label");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_emailout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label20.text = param1;
         },"_SharingPanel_Label20.text");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "                                         " + UtilDict.toDisplay("player","sharing_ongoanimate");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text8.text = param1;
         },"_SharingPanel_Text8.text");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_createaccount");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text9.text = param1;
         },"_SharingPanel_Text9.text");
         result[24] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_withaccount");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text10.text = param1;
         },"_SharingPanel_Text10.text");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnClose3.label = param1;
         },"_btnClose3.label");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_emailout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label21.text = param1;
         },"_SharingPanel_Label21.text");
         result[27] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _emailSentText.text = UtilDict.toDisplay("player","sharing_checkout") + " " + UtilLicense.getCurrentLicensorDisplayName() + UtilDict.toDisplay("player","sharing_towatch");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _emailSentText.text = param1;
         },"_emailSentText.text");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnClose4.label = param1;
         },"_btnClose4.label");
         result[29] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCopyEmail0.label = param1;
         },"_btnCopyEmail0.label");
         result[30] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_embed");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label22.text = param1;
         },"_SharingPanel_Label22.text");
         result[31] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCopyEmbed.label = param1;
         },"_btnCopyEmbed.label");
         result[32] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_link");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label23.text = param1;
         },"_SharingPanel_Label23.text");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCopyEmail.label = param1;
         },"_btnCopyEmail.label");
         result[34] = binding;
         binding = new Binding(this,function():Number
         {
            return (_canCreate.width - lblCreateTitle.width) / 2;
         },function(param1:Number):void
         {
            lblCreateTitle.x = param1;
         },"lblCreateTitle.x");
         result[35] = binding;
         binding = new Binding(this,function():Number
         {
            return (_canCreate.width - _btnNewAnimation.width) / 2;
         },function(param1:Number):void
         {
            _btnNewAnimation.x = param1;
         },"_btnNewAnimation.x");
         result[36] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Create one from scratch");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnNewAnimation.label = param1;
         },"_btnNewAnimation.label");
         result[37] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_createanimation");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label25.text = param1;
         },"_SharingPanel_Label25.text");
         result[38] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_ongoanimate");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label26.text = param1;
         },"_SharingPanel_Label26.text");
         result[39] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_freefun");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label27.text = param1;
         },"_SharingPanel_Label27.text");
         result[40] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_or");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label28.text = param1;
         },"_SharingPanel_Label28.text");
         result[41] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_registered");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Label29.text = param1;
         },"_SharingPanel_Label29.text");
         result[42] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_signup");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text12.text = param1;
         },"_SharingPanel_Text12.text");
         result[43] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","sharing_login");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _SharingPanel_Text13.text = param1;
         },"_SharingPanel_Text13.text");
         result[44] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Back");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnBackTop.label = param1;
         },"_btnBackTop.label");
         result[45] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCloseTop.label = param1;
         },"_btnCloseTop.label");
         result[46] = binding;
         return result;
      }
      
      public function ___SharingPanel_Button16_click(param1:MouseEvent) : void
      {
         this.showEmailInterfaceInHtml();
      }
      
      public function set _canCreate(param1:Canvas) : void
      {
         var _loc2_:Object = this._1916671123_canCreate;
         if(_loc2_ !== param1)
         {
            this._1916671123_canCreate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canCreate",_loc2_,param1));
         }
      }
      
      private function goToGmail() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("showAddressBook","gmail");
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSend() : Button
      {
         return this._1730553147_btnSend;
      }
      
      public function ___SharingPanel_Text12_click(param1:MouseEvent) : void
      {
         this.createAnimation(false,true);
      }
      
      public function set _canCreateEmbed(param1:Canvas) : void
      {
         var _loc2_:Object = this._1548185748_canCreateEmbed;
         if(_loc2_ !== param1)
         {
            this._1548185748_canCreateEmbed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canCreateEmbed",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _loginContactListTab() : Canvas
      {
         return this._1037735649_loginContactListTab;
      }
      
      public function ___btnClose4_click(param1:MouseEvent) : void
      {
         this.closePanel();
      }
      
      public function set _canEmailNotLogged(param1:Canvas) : void
      {
         var _loc2_:Object = this._1775652714_canEmailNotLogged;
         if(_loc2_ !== param1)
         {
            this._1775652714_canEmailNotLogged = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmailNotLogged",_loc2_,param1));
         }
      }
      
      public function ___btnEmbed_click(param1:MouseEvent) : void
      {
         this.changeTab(param1);
      }
      
      public function set _btnFark(param1:Button) : void
      {
         var _loc2_:Object = this._1730944143_btnFark;
         if(_loc2_ !== param1)
         {
            this._1730944143_btnFark = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFark",_loc2_,param1));
         }
      }
      
      private function closePanel() : void
      {
         dispatchEvent(new SharingEvent(SharingEvent.CLOSE_EVENT));
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFarkShare() : Button
      {
         return this._347601646_btnFarkShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtSenderName() : TextInput
      {
         return this._1445459215_txtSenderName;
      }
      
      public function get styleMode() : String
      {
         return this._styleMode;
      }
      
      public function set _hboxEmail(param1:HBox) : void
      {
         var _loc2_:Object = this._1742329722_hboxEmail;
         if(_loc2_ !== param1)
         {
            this._1742329722_hboxEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hboxEmail",_loc2_,param1));
         }
      }
      
      public function set _btnMySpaceShare(param1:Button) : void
      {
         var _loc2_:Object = this._883581826_btnMySpaceShare;
         if(_loc2_ !== param1)
         {
            this._883581826_btnMySpaceShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMySpaceShare",_loc2_,param1));
         }
      }
      
      private function initGoAnimateURL() : void
      {
         this._txtGoanimateURL.text = this._apiServer + "go/studio/";
      }
      
      [Bindable(event="propertyChange")]
      public function get _canCreateNotLogIn() : Canvas
      {
         return this._1869697277_canCreateNotLogIn;
      }
      
      public function set _btnFacebook(param1:Button) : void
      {
         var _loc2_:Object = this._1654898563_btnFacebook;
         if(_loc2_ !== param1)
         {
            this._1654898563_btnFacebook = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFacebook",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmail() : Canvas
      {
         return this._60133621_canEmail;
      }
      
      public function ___btnFark_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FARK);
      }
      
      [Bindable(event="propertyChange")]
      public function get lblCreateTitle() : Label
      {
         return this._470402854lblCreateTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyEmbedCreate() : Button
      {
         return this._2126102749_btnCopyEmbedCreate;
      }
      
      public function ___txtEmailURL_creationComplete(param1:FlexEvent) : void
      {
         this.initEmailURL();
      }
      
      public function ___btnCopyShare_click(param1:MouseEvent) : void
      {
         this.copyData(this._txtShareURL);
      }
      
      private function initSenderEmail() : void
      {
         this._txtSenderName.text = this._userName;
         if(!UtilLicense.isBoxEnvironment())
         {
            this._txtSenderEmail.text = this.userEmail;
         }
         this._txtMessage.text = UtilDict.toDisplay("player","sharing_defaultmessage");
      }
      
      public function set tab(param1:String) : void
      {
         this._tab = param1;
         if(this._btnBackTop != null)
         {
            this.showTab(param1);
         }
      }
      
      public function set _btnDiggShare(param1:Button) : void
      {
         var _loc2_:Object = this._561998435_btnDiggShare;
         if(_loc2_ !== param1)
         {
            this._561998435_btnDiggShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDiggShare",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEmbed() : Button
      {
         return this._2120242372_btnEmbed;
      }
      
      private function setButtonStatus(param1:String) : void
      {
         if(this.styleMode == STYLE_PLAYER)
         {
            this._btnShare.visible = false;
            if(param1 == TAB_SHARE)
            {
               if(this._btnEmail.styleName != "tabEmailUnselected")
               {
                  this._btnEmail.styleName = "tabEmailUnselected";
               }
               if(this._btnEmbed.styleName != "tabEmbedUnselected")
               {
                  this._btnEmbed.styleName = "tabEmbedUnselected";
               }
               if(this._btnCreate.styleName != "tabCreateUnselected")
               {
                  this._btnCreate.styleName = "tabCreateUnselected";
               }
            }
            else if(param1 == TAB_EMAIL || param1 == TAB_GOEMAIL)
            {
               if(this._btnEmail.styleName != "tabEmailSelected")
               {
                  this._btnEmail.styleName = "tabEmailSelected";
               }
               if(this._btnEmbed.styleName != "tabEmbedUnselected")
               {
                  this._btnEmbed.styleName = "tabEmbedUnselected";
               }
               if(this._btnCreate.styleName != "tabCreateUnselected")
               {
                  this._btnCreate.styleName = "tabCreateUnselected";
               }
            }
            else if(param1 == TAB_EMBED)
            {
               if(this._btnEmbed.styleName != "tabEmbedSelected")
               {
                  this._btnEmbed.styleName = "tabEmbedSelected";
               }
               if(this._btnEmail.styleName != "tabEmailUnselected")
               {
                  this._btnEmail.styleName = "tabEmailUnselected";
               }
               if(this._btnCreate.styleName != "tabCreateUnselected")
               {
                  this._btnCreate.styleName = "tabCreateUnselected";
               }
            }
            else if(param1 == TAB_CREATE)
            {
               if(this._btnCreate.styleName != "tabCreateSelected")
               {
                  this._btnCreate.styleName = "tabCreateSelected";
               }
               if(this._btnEmail.styleName != "tabEmailUnselected")
               {
                  this._btnEmail.styleName = "tabEmailUnselected";
               }
               if(this._btnEmbed.styleName != "tabEmbedUnselected")
               {
                  this._btnEmbed.styleName = "tabEmbedUnselected";
               }
            }
         }
         else if(this.styleMode == STYLE_STUDIO)
         {
            if(param1 == TAB_SHARE)
            {
               if(this._btnShare.styleName != "tabShareSelectedStudio")
               {
                  this._btnShare.styleName = "tabShareSelectedStudio";
               }
               if(this._btnEmail.styleName != "tabEmailUnselectedStudio")
               {
                  this._btnEmail.styleName = "tabEmailUnselectedStudio";
               }
               if(this._btnEmbed.styleName != "tabEmbedUnselectedStudio")
               {
                  this._btnEmbed.styleName = "tabEmbedUnselectedStudio";
               }
            }
            else if(param1 == TAB_EMAIL || param1 == TAB_GOEMAIL)
            {
               if(this._btnShare.styleName != "tabShareUnselectedStudio")
               {
                  this._btnShare.styleName = "tabShareUnselectedStudio";
               }
               if(this._btnEmail.styleName != "tabEmailSelectedStudio")
               {
                  this._btnEmail.styleName = "tabEmailSelectedStudio";
               }
               if(this._btnEmbed.styleName != "tabEmbedUnselectedStudio")
               {
                  this._btnEmbed.styleName = "tabEmbedUnselectedStudio";
               }
            }
            else if(param1 == TAB_EMBED)
            {
               if(this._btnShare.styleName != "tabShareUnselectedStudio")
               {
                  this._btnShare.styleName = "tabShareUnselectedStudio";
               }
               if(this._btnEmail.styleName != "tabEmailUnselectedStudio")
               {
                  this._btnEmail.styleName = "tabEmailUnselectedStudio";
               }
               if(this._btnEmbed.styleName != "tabEmbedSelectedStudio")
               {
                  this._btnEmbed.styleName = "tabEmbedSelectedStudio";
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyEmbed() : Button
      {
         return this._1282440377_btnCopyEmbed;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canShare() : Canvas
      {
         return this._47353010_canShare;
      }
      
      private function get chainMovieIds() : String
      {
         return this._chainMovieIds;
      }
      
      private function goToLoginPage(param1:Boolean) : void
      {
         var _loc2_:RegExp = /(?P<protocol>[a-zA-Z]+) : \/\/  (?P<host>[^:\/]*) (:(?P<port>\d+))?  ((?P<path>[^?]*))? ((?P<parameters>.*))? /x;
         var _loc3_:Array = _loc2_.exec(ExternalInterface.call("function(){ return document.location.href.toString();}") as String);
         var _loc4_:String = String(_loc3_.path);
         Util.goToLoginPage(param1,this._isGo,this._isEmbed,this._apiServer,_loc4_);
      }
      
      public function showTab(param1:String) : void
      {
         if(param1 == TAB_SHARE)
         {
            if(this.styleMode != STYLE_STUDIO)
            {
               if(this.styleMode == STYLE_PLAYER)
               {
               }
            }
            if(this._isGo)
            {
               this.selectedCanvas = this._canShare;
            }
            else
            {
               this.selectedCanvas = this._canShareOther;
            }
         }
         else if(param1 == TAB_EMAIL)
         {
            this.showEmailDetail();
         }
         else if(param1 == TAB_GOEMAIL)
         {
            this.selectedCanvas = this._canEmail;
         }
         else if(param1 == TAB_EMBED)
         {
            this.selectedCanvas = this._canEmbed;
         }
         else if(param1 == TAB_CREATE)
         {
            if(this._isGo || this._isFB)
            {
               if(this._isLogin)
               {
                  this.selectedCanvas = this._canCreate;
               }
               else
               {
                  this.selectedCanvas = this._canCreateNotLogIn;
               }
            }
            else if(this._isEmbed)
            {
               this.selectedCanvas = this._canCreateEmbed;
            }
         }
         this.setButtonStatus(param1);
      }
      
      public function set _canEmailNoNewContact(param1:Canvas) : void
      {
         var _loc2_:Object = this._1998779820_canEmailNoNewContact;
         if(_loc2_ !== param1)
         {
            this._1998779820_canEmailNoNewContact = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmailNoNewContact",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDigg() : Button
      {
         return this._1730996382_btnDigg;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmailNotLogged() : Canvas
      {
         return this._1775652714_canEmailNotLogged;
      }
      
      public function ___btnShare_click(param1:MouseEvent) : void
      {
         this.changeTab(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _canCreateEmbed() : Canvas
      {
         return this._1548185748_canCreateEmbed;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canCreate() : Canvas
      {
         return this._1916671123_canCreate;
      }
      
      public function ___btnSend_click(param1:MouseEvent) : void
      {
         this.sendEmail();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFark() : Button
      {
         return this._1730944143_btnFark;
      }
      
      [Bindable(event="propertyChange")]
      public function get _hboxEmail() : HBox
      {
         return this._1742329722_hboxEmail;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMySpaceShare() : Button
      {
         return this._883581826_btnMySpaceShare;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFacebook() : Button
      {
         return this._1654898563_btnFacebook;
      }
      
      public function set _txtRecEmail(param1:Label) : void
      {
         var _loc2_:Object = this._706637379_txtRecEmail;
         if(_loc2_ !== param1)
         {
            this._706637379_txtRecEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtRecEmail",_loc2_,param1));
         }
      }
      
      public function ___SharingPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationComplete();
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:SharingPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._SharingPanel_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_SharingPanelWatcherSetupUtil");
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
      
      public function ___btnClose3_click(param1:MouseEvent) : void
      {
         this.closePanel();
      }
      
      public function get tab() : String
      {
         return this._tab;
      }
      
      public function set _canEmailNewContact(param1:Canvas) : void
      {
         var _loc2_:Object = this._1648048075_canEmailNewContact;
         if(_loc2_ !== param1)
         {
            this._1648048075_canEmailNewContact = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEmailNewContact",_loc2_,param1));
         }
      }
      
      private function set selectedCanvas(param1:Canvas) : void
      {
         this._selectedCanvas = param1;
         this._vsSharingPanel.selectedChild = param1;
         if(param1 == this._canEmailDetails || param1 == this._canEmailIsEmbed || param1 == this._canEmailNewContact || param1 == this._canEmailNoNewContact || param1 == this._canEmailNotLogged)
         {
            this._btnBackTop.visible = false;
         }
         else
         {
            this._btnBackTop.visible = false;
         }
      }
      
      public function ___btnNewAnimation_click(param1:MouseEvent) : void
      {
         this.createAnimation();
      }
      
      public function get isGo() : Boolean
      {
         return this._isGo;
      }
      
      public function ___txtImportContact_click(param1:MouseEvent) : void
      {
         this.showDiv();
      }
      
      public function set isOnStudio(param1:Boolean) : void
      {
         this._isOnStudio = param1;
      }
      
      public function set movieDesc(param1:String) : void
      {
         this._movieDesc = param1;
      }
      
      private function set isPublished(param1:Boolean) : void
      {
         this._isPublished = param1;
      }
      
      public function set _txtShareURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._612233759_txtShareURL;
         if(_loc2_ !== param1)
         {
            this._612233759_txtShareURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtShareURL",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEmailNewContact() : Canvas
      {
         return this._1648048075_canEmailNewContact;
      }
      
      private function showEmailDetail() : void
      {
         if(!this._isGo || this._isEmbed || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_RSS_PATH) != null || UtilLicense.useInternalEmailSharingScreen())
         {
            this.selectedCanvas = this._canEmailDetails;
         }
         else
         {
            this.showEmailInterfaceInHtml();
            this.closePanel();
         }
      }
      
      private function get selectedCanvas() : Canvas
      {
         return this._selectedCanvas;
      }
      
      public function ___canEmail_creationComplete(param1:FlexEvent) : void
      {
         this.showImportContactStatement();
      }
      
      public function get isOnStudio() : Boolean
      {
         return this._isOnStudio;
      }
      
      public function ___canEmailDetails_creationComplete(param1:FlexEvent) : void
      {
         this.showContactTab();
      }
      
      private function get isPublished() : Boolean
      {
         return this._isPublished;
      }
      
      public function set _non_loginContactListTab(param1:Canvas) : void
      {
         var _loc2_:Object = this._1634983407_non_loginContactListTab;
         if(_loc2_ !== param1)
         {
            this._1634983407_non_loginContactListTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_non_loginContactListTab",_loc2_,param1));
         }
      }
      
      public function ___canCreate_creationComplete(param1:FlexEvent) : void
      {
         this.updateCreateAnimationButtons();
      }
      
      public function ___btnRedditShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_REDDIT);
      }
      
      public function set _importContactsStatement(param1:Canvas) : void
      {
         var _loc2_:Object = this._1015645688_importContactsStatement;
         if(_loc2_ !== param1)
         {
            this._1015645688_importContactsStatement = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_importContactsStatement",_loc2_,param1));
         }
      }
      
      public function set _btnEmail(param1:Button) : void
      {
         var _loc2_:Object = this._2120243201_btnEmail;
         if(_loc2_ !== param1)
         {
            this._2120243201_btnEmail = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEmail",_loc2_,param1));
         }
      }
   }
}
