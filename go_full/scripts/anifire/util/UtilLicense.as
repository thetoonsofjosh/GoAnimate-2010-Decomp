package anifire.util
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.LanguageConstants;
   import anifire.constant.LicenseConstants;
   import anifire.constant.ServerConstants;
   
   public class UtilLicense
   {
       
      
      public function UtilLicense()
      {
         super();
      }
      
      public static function get isSoundUploadable() : Boolean
      {
         var _loc1_:Array = LicenseConstants.BAN_SOUND_UPLOAD_LICENSE_IDS;
         var _loc2_:String = Util.getFlashVar().getValueByKey("siteId") as String;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] as String == _loc2_)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function get boxParentSiteBaseURL() : String
      {
         if(!UtilLicense.isBoxEnvironment())
         {
            return null;
         }
         var _loc1_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_BOX_PARENT_URL);
         return _loc1_.replace(/^([^?]+)\?.+$/g,"$1");
      }
      
      public static function isCommonPropShouldBeShown(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.DONT_SHOW_COMMON_PROP_THEME_IDS;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function isBubbleI18NPermitted() : Boolean
      {
         return Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE) == "go" || Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE) != "en_US";
      }
      
      public static function isExternalPreviewPlayerShouldBeUsed(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.SHOULD_USE_EXTERNAL_PREVIEW_PLAYER;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function isUploadRelatedButtonShouldBeShown() : Boolean
      {
         if(getCurrentLicenseId() == "7" || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            return false;
         }
         return true;
      }
      
      public static function isHeadSectionShouldBeShownInThumbtray(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.DONT_SHOW_HEAD_SECTION_IN_THUMBTRAY;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function getCurrentLicensorSupportedShortLangCodes() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         if(getCurrentLicenseId() == "8")
         {
            _loc1_.push("en",LanguageConstants.SHORT_LANG_CODES.getValueByKey("en"));
            _loc1_.push("jp",LanguageConstants.SHORT_LANG_CODES.getValueByKey("jp"));
            _loc1_.push("kr",LanguageConstants.SHORT_LANG_CODES.getValueByKey("kr"));
            _loc1_.push("sc",LanguageConstants.SHORT_LANG_CODES.getValueByKey("sc"));
            _loc1_.push("th",LanguageConstants.SHORT_LANG_CODES.getValueByKey("th"));
            _loc1_.push("tc",LanguageConstants.SHORT_LANG_CODES.getValueByKey("tc"));
         }
         else
         {
            _loc1_.push("de",LanguageConstants.SHORT_LANG_CODES.getValueByKey("de"));
            _loc1_.push("en",LanguageConstants.SHORT_LANG_CODES.getValueByKey("en"));
            _loc1_.push("es",LanguageConstants.SHORT_LANG_CODES.getValueByKey("es"));
            _loc1_.push("fr",LanguageConstants.SHORT_LANG_CODES.getValueByKey("fr"));
            _loc1_.push("it",LanguageConstants.SHORT_LANG_CODES.getValueByKey("it"));
            _loc1_.push("pt",LanguageConstants.SHORT_LANG_CODES.getValueByKey("pt"));
            _loc1_.push("sc",LanguageConstants.SHORT_LANG_CODES.getValueByKey("sc"));
            _loc1_.push("tc",LanguageConstants.SHORT_LANG_CODES.getValueByKey("tc"));
         }
         return _loc1_;
      }
      
      public static function isInspirationButtonShouldBeShown() : Boolean
      {
         if(getCurrentLicenseId() == "7" || getCurrentLicenseId() == "8" || isSchoolEnvironment() || isBoxEnvironment() || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            return false;
         }
         return true;
      }
      
      public static function getDefaultUserGoodiesTab(param1:Boolean) : String
      {
         if(param1)
         {
            return AnimeConstants.ASSET_TYPE_CHAR;
         }
         return AnimeConstants.ASSET_TYPE_PROP;
      }
      
      public static function isBoxEnvironment() : Boolean
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         return _loc1_.indexOf(".box.goanimate") >= 0;
      }
      
      public static function isEffectChangeTipsShouldBeShown(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.SHOULD_SHOW_EFFECT_CHANGED_TIP;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function isCommonSoundShouldBeShown(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.DONT_SHOW_COMMON_SOUND_THEME_IDS;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function getCurrentLicensorDisplayName() : String
      {
         return UtilDict.toDisplay("player","sharing_website_displayname");
      }
      
      public static function get boxCustomerID() : String
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey("uemail") as String;
         return _loc1_.replace(/^x(\d+):.*$/,"$1");
      }
      
      public static function isScreenShotAbilityEnabled(param1:String) : Boolean
      {
         var _loc2_:Array = LicenseConstants.DONT_ALLOW_TAKING_SCREENSHOT;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] as String == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function shouldShowToolTipForCurrentLicensor() : Boolean
      {
         if(getCurrentLicenseId() == "7")
         {
            return false;
         }
         if(getCurrentLicenseId() == "8")
         {
            return false;
         }
         return true;
      }
      
      public static function get playerOverlayControlPanelEnabled() : Boolean
      {
         return !useBoxPreviewBackground();
      }
      
      public static function getCurrentLicensorThumbtrayBannerStyleName() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(getCurrentLicenseId() == "8")
         {
            _loc1_ = Util.getFlashVar().getValueByKey("thmid") as String;
            _loc2_ = Util.getFlashVar().getValueByKey("ch") as String;
            if(_loc2_ != null && _loc2_.length > 1 && _loc2_ != "0zEt_fo4L-5k")
            {
               return "clientThemeChainMovieBanner";
            }
            _loc3_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CHAIN_MOVIE_ID);
            if(_loc3_ != null && _loc3_.length > 1)
            {
               return "clientThemeChainMovieBanner";
            }
            if(_loc1_ == "0fVScYM33x14")
            {
               return "clientThemeBannerChowder";
            }
         }
         else if(getCurrentLicenseId() == "10")
         {
            return "clientThemeBannerBox";
         }
         return "clientThemeBanner";
      }
      
      public static function isActionNameNeedLowerCase() : Boolean
      {
         return getCurrentLicenseId() == "7" ? true : false;
      }
      
      public static function useBoxPreviewBackground() : Boolean
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE) as String;
         return isBoxEnvironment() || Boolean(_loc1_) && _loc1_ == "go";
      }
      
      public static function isUploadedAssetsEnabled() : Boolean
      {
         if(Util.getFlashVar().getValueByKey("upl") == "1")
         {
            return true;
         }
         return false;
      }
      
      public static function isSchoolEnvironment() : Boolean
      {
         return Util.getFlashVar().getValueByKey(ServerConstants.PARAM_U_INFO_SCHOOL) != null;
      }
      
      public static function useInternalEmailSharingScreen() : Boolean
      {
         return Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISEMBED_ID) == "1" || isBoxEnvironment();
      }
      
      public static function isHeadGearSectionShouldBeShownInThumbtray(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Array = LicenseConstants.DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_LICENSE_ID;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_] as String == param1)
            {
               return false;
            }
            _loc2_++;
         }
         var _loc4_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_THEME_ID);
         _loc3_ = LicenseConstants.DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_THEME_ID;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_] as String == _loc4_)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public static function getCurrentLicenseId() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE) as String;
         if(_loc2_ != null && _loc2_ == "domo")
         {
            return "7";
         }
         if(_loc2_ != null && _loc2_ == "cn")
         {
            return "8";
         }
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_MOVIE_LICENSE_ID) as String;
         if(_loc3_ != null && _loc3_ != "")
         {
            return _loc3_;
         }
         var _loc4_:String;
         if((_loc4_ = _loc1_.getValueByKey(ServerConstants.FLASHVAR_SITE_ID) as String) != null && _loc4_ != "")
         {
            return _loc4_;
         }
         return "0";
      }
   }
}
