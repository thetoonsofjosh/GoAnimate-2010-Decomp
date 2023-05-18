package anifire.playback
{
   import anifire.event.LoadMgrEvent;
   import anifire.playerEffect.EffectAsset;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class RemoteDataManager extends EventDispatcher
   {
       
      
      private var _assets:Array;
      
      private var _count:Number;
      
      private var _dataStock:anifire.playback.PlayerDataStock;
      
      public function RemoteDataManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function addTask(param1:Object) : void
      {
         this._assets.push(param1);
      }
      
      private function initNextAsset() : void
      {
         var _loc1_:Object = this._assets[this._count];
         if(_loc1_ is AnimeScene || _loc1_ is EmbedSound)
         {
            _loc1_.addEventListener(PlayerEvent.INIT_REMOTE_DATA_COMPLETE,this.onInitDone);
         }
         else
         {
            _loc1_.getEventDispatcher().addEventListener(PlayerEvent.INIT_REMOTE_DATA_COMPLETE,this.onInitDone);
         }
         if(_loc1_ is Character)
         {
            Character(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is Prop)
         {
            Prop(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is Background)
         {
            Background(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is BubbleAsset)
         {
            BubbleAsset(_loc1_).initRemoteData();
         }
         else if(_loc1_ is EffectAsset)
         {
            EffectAsset(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is Segment)
         {
            Segment(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is AnimeScene)
         {
            AnimeScene(_loc1_).initRemoteData(this._dataStock);
         }
         else if(_loc1_ is EmbedSound)
         {
            EmbedSound(_loc1_).initRemoteData(this._dataStock);
         }
      }
      
      private function onInitDone(param1:Event) : void
      {
         trace("_count:" + this._count);
         ++this._count;
         if(this._count < this._assets.length)
         {
            this.initNextAsset();
         }
         else
         {
            this.onComplete();
         }
      }
      
      public function commit() : void
      {
         trace("assets num:" + this._assets.length);
         this._count = 0;
         if(this._assets.length > 0)
         {
            this.initNextAsset();
         }
         else
         {
            this.onComplete();
         }
      }
      
      private function onComplete() : void
      {
         this.dispatchEvent(new LoadMgrEvent(LoadMgrEvent.ALL_COMPLETE));
      }
      
      public function init(param1:anifire.playback.PlayerDataStock) : void
      {
         this._dataStock = param1;
         this._assets = new Array();
      }
   }
}
