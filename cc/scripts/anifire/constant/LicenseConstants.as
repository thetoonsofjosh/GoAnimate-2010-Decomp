package anifire.constant
{
   import anifire.util.UtilHashArray;
   
   public class LicenseConstants
   {
      
      public static const PUBLISH_PRIVATE_ON_ONLY:Number = 5;
      
      public static const PUBLISH_PRIVATE_OFF_ONLY:Number = 4;
      
      public static const PUBLISH_SHARING_MUST_ON:Number = 2;
      
      public static const PUBLISH_ALL:Number = 0;
      
      public static const PUBLISH_PUBLIC_ONLY:Number = 6;
      
      public static const PUBLISH_PRIVATE_ONLY:Number = 1;
       
      
      public function LicenseConstants()
      {
         super();
      }
      
      public static function get SHOULD_SHOW_EFFECT_CHANGED_TIP() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0");
         _loc1_.push("1");
         _loc1_.push("2");
         _loc1_.push("3");
         _loc1_.push("4");
         _loc1_.push("5");
         _loc1_.push("6");
         _loc1_.push("9");
         _loc1_.push("10");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_COMMON_PROP_THEME_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("ben10");
         _loc1_.push("chowder");
         _loc1_.push("custom");
         return _loc1_;
      }
      
      public static function get SHOULD_USE_EXTERNAL_PREVIEW_PLAYER() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0");
         _loc1_.push("1");
         _loc1_.push("2");
         _loc1_.push("3");
         _loc1_.push("4");
         _loc1_.push("5");
         _loc1_.push("6");
         _loc1_.push("9");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_THEME_ID() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0pBZ9UF7FrRU");
         return _loc1_;
      }
      
      public static function get PUBLISH_LEVEL() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         _loc1_.push("8",PUBLISH_SHARING_MUST_ON);
         return _loc1_;
      }
      
      public static function get DONT_SHOW_COMMON_SOUND_THEME_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("akon");
         _loc1_.push("sf");
         _loc1_.push("underdog");
         _loc1_.push("willie");
         return _loc1_;
      }
      
      public static function get BAN_SOUND_UPLOAD_LICENSE_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("3");
         _loc1_.push("5");
         return _loc1_;
      }
      
      public static function get DONT_ALLOW_TAKING_SCREENSHOT() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("8");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_HEAD_SECTION_IN_THUMBTRAY() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("7");
         _loc1_.push("8");
         _loc1_.push("10");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_LICENSE_ID() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("10");
         return _loc1_;
      }
   }
}
