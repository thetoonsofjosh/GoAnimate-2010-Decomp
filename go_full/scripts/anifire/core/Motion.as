package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Motion extends Behavior
   {
      
      public static const XML_NODE_NAME:String = "motion";
      
      private static var _logger:ILogger = Log.getLogger("core.Motion");
       
      
      public function Motion(param1:CharThumb, param2:String, param3:String, param4:int, param5:String, param6:String)
      {
         super(param1,param2,param3,param4,param5,param6);
         _logger.debug("Motion initialized");
      }
   }
}
