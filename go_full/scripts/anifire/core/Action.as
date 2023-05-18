package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Action extends Behavior
   {
      
      public static const XML_NODE_NAME:String = "action";
       
      
      private var _propXML:XML;
      
      private var _logger:ILogger;
      
      public function Action(param1:CharThumb, param2:String, param3:String, param4:int, param5:String, param6:String, param7:XML = null)
      {
         this._logger = Log.getLogger("core.Action");
         this.propXML = param7;
         super(param1,param2,param3,param4,param5,param6);
         this._logger.debug("Action initialized");
      }
      
      public function get propXML() : XML
      {
         return this._propXML;
      }
      
      public function set propXML(param1:XML) : void
      {
         this._propXML = param1;
      }
   }
}
