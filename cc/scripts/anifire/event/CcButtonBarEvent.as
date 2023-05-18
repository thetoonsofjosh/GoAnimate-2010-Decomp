package anifire.event
{
   public class CcButtonBarEvent extends ExtraDataEvent
   {
      
      public static const UNDO_BUTTON_CLICK:String = "undo_button_click";
      
      public static const RANDOMIZE_BUTTON_CLICK:String = "randomize_button_click";
      
      public static const RESET_BUTTON_CLICK:String = "reset_button_click";
      
      public static const REDO_BUTTON_CLICK:String = "redo_button_click";
      
      public static const SAVE_BUTTON_CLICK:String = "save_button_click";
       
      
      public function CcButtonBarEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
