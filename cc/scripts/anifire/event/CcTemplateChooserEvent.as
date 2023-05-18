package anifire.event
{
   public class CcTemplateChooserEvent extends ExtraDataEvent
   {
      
      public static const PREVIEW_TAB_CHANGED:String = "event_preview_tab_changed";
      
      public static const PREVIEW_CHARACTER_CHANGED:String = "event_preview_changed";
      
      public static const USER_WANT_TO_PREVIEW:String = "action_preview";
       
      
      public function CcTemplateChooserEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
