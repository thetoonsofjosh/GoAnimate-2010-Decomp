package anifire.components.studio
{
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPreviewMovie;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class ExternalPreviewWindowController extends EventDispatcher
   {
       
      
      public function ExternalPreviewWindowController()
      {
         super();
      }
      
      private function onPublish() : void
      {
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onCancel() : void
      {
         this.dispatchEvent(new Event(Event.CANCEL));
      }
      
      public function initExternalPreviewWindow(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var _loc4_:String = UtilPreviewMovie.serializePreviewMovieData(param1,param2,param3);
         ExternalInterface.call("initPreviewPlayer",_loc4_);
         ExternalInterface.addCallback("onExternalPreviewPlayerPublish",this.onPublish);
         ExternalInterface.addCallback("onExternalPreviewPlayerCancel",this.onCancel);
      }
   }
}
