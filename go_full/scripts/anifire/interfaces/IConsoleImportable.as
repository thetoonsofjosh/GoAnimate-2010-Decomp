package anifire.interfaces
{
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public interface IConsoleImportable
   {
       
      
      function customAssetUploadCompleteHandler(param1:String, param2:String) : void;
      
      function deleteAsset(param1:MouseEvent = null) : void;
      
      function invisibleImporter() : void;
      
      function playScene(param1:Boolean) : void;
      
      function userHasTTSRight() : Boolean;
      
      function onGetCustomAssetCompleteByte(param1:ByteArray, param2:XML, param3:Boolean) : void;
      
      function get currentLicensorName() : String;
      
      function requestLoadStatus(param1:Boolean, param2:Boolean = false, param3:Number = 1) : void;
      
      function thumbTrayCommand(param1:String, param2:String) : void;
   }
}
