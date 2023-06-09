package anifire.effect
{
   import com.gskinner.geom.ColorMatrix;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Timer;
   
   public class GrayScaleEffect extends ProgramEffect
   {
       
      
      private const RGB:Number = 13421772;
      
      private const LINESIZE:Number = 5;
      
      private var _myThumbnailSymbol:Class;
      
      private const ALPHA:Number = 0.6;
      
      public function GrayScaleEffect()
      {
         this._myThumbnailSymbol = GrayScaleEffect__myThumbnailSymbol;
         super();
         type = EffectMgr.TYPE_GRAYSCALE;
         thumbnailSymbol = this._myThumbnailSymbol;
         this.redraw();
      }
      
      override public function serialize() : XML
      {
         return <effect x={x} y={y} w={width} h={height} rotate='0' id={id} type={type}>
											 </effect>;
      }
      
      override public function hideEffect(param1:DisplayObject) : void
      {
         var _loc2_:ColorMatrix = new ColorMatrix();
         _loc2_.adjustColor(0,0,0,0);
         param1.filters = [new ColorMatrixFilter(_loc2_)];
      }
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "body";
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override public function showEffect(param1:DisplayObject) : void
      {
         var timer:Timer;
         var displayObject:DisplayObject = param1;
         var matrix:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];
         var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         displayObject.filters = [grayscaleFilter];
         timer = new Timer(1000,1);
         timer.addEventListener(TimerEvent.TIMER,function():void
         {
            hideEffect(displayObject);
         });
         timer.start();
      }
      
      override protected function drawLabel() : void
      {
      }
      
      override public function redraw() : void
      {
         this.drawBody();
         this.drawLabel();
      }
   }
}
