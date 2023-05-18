package anifire.constant
{
   import anifire.util.Util;
   
   public class CcServerConstant
   {
      
      private static var _displayThumbnailId:int = 0;
      
      public static const ACTION_SAVE_CC_CHAR:String = ServerConstants.get_server_path() + "saveCCCharacter/";
       
      
      public function CcServerConstant()
      {
         super();
      }
      
      public static function displayThumbnailId() : Boolean
      {
         var permittedHosts:Array;
         var result:Boolean;
         var apiserver:String = null;
         if(_displayThumbnailId != 0)
         {
            return _displayThumbnailId > 0;
         }
         permittedHosts = ["bernard.goanimate.org","alvin.goanimate.org"];
         apiserver = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         result = permittedHosts.some(function(param1:*, param2:int, param3:Array):Boolean
         {
            return apiserver.indexOf(param1 as String) >= 0;
         });
         _displayThumbnailId = result ? 1 : -1;
         return result;
      }
   }
}
