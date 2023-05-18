package anifire.event
{
   public class GoWalkerEvent extends ExtraDataEvent
   {
      
      public static const EVENT_SCENE_ADDED:String = "event_scene_added";
      
      public static const EVENT_BG_ADDED:String = "event_bg_added";
      
      public static const EVENT_PREVIEW_FINISHED:String = "event_preview_finished";
      
      public static const EVENT_BUBBLE_ADDED:String = "event_bubble_added";
      
      public static const EVENT_NEXT_STEP:String = "event_next_step";
      
      public static const EVENT_SOUND_ADDED:String = "event_sound_added";
      
      public static const EVENT_THUMBTRAY_SOUND_CLICKED:String = "event_thumbtray_sound_clicked";
      
      public static const EVENT_THUMBTRAY_BG_CLICKED:String = "event_thumbtray_bg_clicked";
      
      public static const EVENT_CHARACTER_ACTION_CHANGED:String = "event_character_action_changed";
      
      public static const EVENT_PREVIEW_CLICKED:String = "event_preview_clicked";
      
      public static const EVENT_THUMBTRAY_BUBBLE_CLICKED:String = "event_thumbtray_bubble_clicked";
      
      public static const EVENT_CHARACTER_ADDED:String = "event_character_added";
      
      public static const EVENT_BUBBLE_EDITED:String = "event_bubble_edited";
       
      
      public var step:int;
      
      public function GoWalkerEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
