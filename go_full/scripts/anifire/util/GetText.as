package anifire.util
{
   import com.adobe.webapis.gettext.GetText;
   import flash.net.URLRequest;
   
   public class GetText extends com.adobe.webapis.gettext.GetText
   {
       
      
      public function GetText()
      {
         super();
      }
      
      override protected function composeURLRequest() : URLRequest
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey("v");
         return new URLRequest(this.getUrl() + this.getLocale() + "/" + this.getName() + ".mo?v=" + _loc2_);
      }
   }
}
