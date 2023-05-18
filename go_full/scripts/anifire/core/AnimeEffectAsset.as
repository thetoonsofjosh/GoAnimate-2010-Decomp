package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.event.EffectEvt;
   import anifire.util.Util;
   import anifire.util.UtilUnitConvert;
   import flash.events.MouseEvent;
   
   public class AnimeEffectAsset extends EffectAsset
   {
       
      
      public function AnimeEffectAsset(param1:String = null)
      {
         super(param1);
         this.bundle.mouseEnabled = false;
         this.bundle.mouseChildren = false;
      }
      
      override public function serialize() : String
      {
         var _loc1_:* = "";
         if(this.sttime > -1 && this.edtime > -1)
         {
            if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
            {
               _loc1_ = "<st>" + UtilUnitConvert.secToFrame(this.sttime) + "</st>" + "<et>" + UtilUnitConvert.secToFrame(this.edtime) + "</et>";
            }
         }
         return "<" + XML_NODE_NAME + " id=\"" + id + "\" index=\"" + this.bundle.parent.getChildIndex(this.bundle) + "\" >" + this.effect.serialize().toXMLString() + "<x>" + Util.roundNum(this.x) + "</x>" + "<y>" + Util.roundNum(this.y) + "</y>" + "<xscale>" + 1 + "</xscale>" + "<yscale>" + 1 + "</yscale>" + _loc1_ + "<file>" + this.thumb.theme.id + "." + this.effect.id + "</file>" + "</" + XML_NODE_NAME + ">";
      }
      
      override internal function initializeDrag(param1:MouseEvent) : void
      {
      }
      
      override internal function doMouseUp(param1:MouseEvent) : void
      {
      }
      
      override public function showControl() : void
      {
      }
      
      override protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         super.loadAssetImageComplete(param1);
         this.x = AnimeConstants.SCREEN_X;
         this.y = AnimeConstants.SCREEN_Y;
         this.addControl();
      }
      
      override internal function clone(param1:Boolean = false) : Asset
      {
         var _loc2_:AnimeEffectAsset = new AnimeEffectAsset();
         _loc2_.id = this.id;
         _loc2_.x = this.x;
         _loc2_.y = this.y;
         _loc2_.sttime = this.sttime;
         _loc2_.edtime = this.edtime;
         if(_loc2_._myEffectXML == null)
         {
            _loc2_._myEffectXML = this.effect.serialize();
         }
         _loc2_._myEffectXML.@w = this.effect.width;
         _loc2_._myEffectXML.@h = this.effect.height;
         _loc2_.scene = this.scene;
         _loc2_.thumb = this.thumb;
         return _loc2_;
      }
      
      override internal function doDrag(param1:MouseEvent) : void
      {
      }
   }
}
