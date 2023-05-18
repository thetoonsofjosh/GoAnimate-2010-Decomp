package anifire.component
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import mx.preloaders.DownloadProgressBar;
   
   public class MochiAdPreloader extends DownloadProgressBar
   {
       
      
      private var _mochi:anifire.component.MochiAdDisplay;
      
      public function MochiAdPreloader()
      {
         var _loc1_:MovieClip = null;
         super();
         this._mochi = new anifire.component.MochiAdDisplay();
         addChild(_loc1_ = this._mochi.movieClip);
      }
      
      public function isMochiEnabled() : Boolean
      {
         return this.loaderInfo.parameters["ad"] == 1;
      }
      
      override public function set preloader(param1:Sprite) : void
      {
         var preloader:Sprite = param1;
         if(this.isMochiEnabled())
         {
            this._mochi.showPreloader(function():void
            {
               dispatchEvent(new Event(Event.COMPLETE));
            });
         }
         else
         {
            super.preloader = preloader;
         }
      }
   }
}
