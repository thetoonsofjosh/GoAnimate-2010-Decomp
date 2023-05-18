package anifire.cc_theme_lib
{
   import anifire.event.CcComponentLoadEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class CcState extends EventDispatcher
   {
      
      public static const XML_NODE_NAME:String = "state";
       
      
      public var imageData:ByteArray = null;
      
      public var filename:String;
      
      public var stateId:String;
      
      private var _isLoadingImageData:Boolean = false;
      
      public function CcState()
      {
         super();
      }
      
      private function dispatchLoadCompleteEvent() : void
      {
         this.dispatchEvent(new CcComponentLoadEvent(CcComponentLoadEvent.LOAD_STATE_IMAGE_DATA_COMPLETE,this,this.stateId));
      }
      
      public function deserialize(param1:XML) : void
      {
         this.stateId = param1.@id;
         this.filename = param1.@filename;
      }
      
      private function onLoadImageDataComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadImageDataComplete);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.imageData = _loc2_.data as ByteArray;
         this.dispatchLoadCompleteEvent();
      }
      
      public function loadImageData(param1:URLRequest) : void
      {
         var _loc2_:URLLoader = null;
         if(this.imageData != null)
         {
            this.dispatchLoadCompleteEvent();
         }
         else if(!this._isLoadingImageData)
         {
            _loc2_ = new URLLoader();
            _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadImageDataComplete);
            _loc2_.load(param1);
         }
      }
   }
}
