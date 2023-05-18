package anifire.util
{
   import anifire.constant.ServerConstants;
   
   public class UtilUser
   {
       
      
      public function UtilUser()
      {
         super();
      }
      
      public static function isUserVip() : Boolean
      {
         return Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIP_USER) == "1";
      }
      
      public static function isBeta() : Boolean
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         return _loc1_.getValueByKey("tts_enabled") == "1";
      }
      
      public static function isPremium() : Boolean
      {
         return isBeta();
      }
   }
}
