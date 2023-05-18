package anifire.event
{
   import flash.events.Event;
   
   public class CcSaveCharEvent extends ExtraDataEvent
   {
      
      public static const SAVE_CHAR_COMPLETE:String = "save_char_complete";
      
      public static const SAVE_CHAR_NOT_ENOUGH_MONEY_POINT:String = "save_char_not_enough_money_point";
      
      public static const SAVE_CHAR_ERROR_OCCUR:String = "save_char_error_occur";
       
      
      public var gopoint:Number;
      
      public var gobuck:Number;
      
      public function CcSaveCharEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         var _loc1_:CcSaveCharEvent = new CcSaveCharEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
         _loc1_.gopoint = this.gopoint;
         _loc1_.gobuck = this.gobuck;
         return _loc1_;
      }
   }
}
