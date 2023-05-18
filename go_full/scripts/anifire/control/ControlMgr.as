package anifire.control
{
   import flash.display.DisplayObject;
   import mx.logging.ILogger;
   
   public class ControlMgr
   {
      
      public static const NORMAL:String = "NORMAL";
      
      private static var _name:String = "ControlElement";
      
      public static const BUBBLE:String = "BUBBLE";
      
      private static var _logger:ILogger;
      
      public static const FIXED:String = "FIXED";
      
      private static var _control:anifire.control.Control = new anifire.control.Control();
       
      
      public function ControlMgr()
      {
         super();
      }
      
      private static function createControl(param1:DisplayObject, param2:String = "NORMAL") : anifire.control.Control
      {
         switch(param2)
         {
            case NORMAL:
               _control = new anifire.control.Control();
               _control.asset = param1;
               _name += "_" + NORMAL;
               return _control;
            case BUBBLE:
               _control = new BubbleControl();
               _control.asset = param1;
               _name += "_" + BUBBLE;
               return _control;
            case FIXED:
               _control = new FixedControl();
               _control.asset = param1;
               _name += "_" + FIXED;
               return _control;
            default:
               _control = new anifire.control.Control();
               _name += "_" + NORMAL;
               return _control;
         }
      }
      
      public static function get name() : String
      {
         return _name;
      }
      
      public static function getControl(param1:DisplayObject, param2:String = "NORMAL") : anifire.control.Control
      {
         return createControl(param1,param2);
      }
      
      public static function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}
