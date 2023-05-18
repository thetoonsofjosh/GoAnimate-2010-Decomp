package
{
   import anifire.components.containers.GoAlert;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_GoAlertWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_containers_GoAlertWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoAlert.watcherSetupUtil = new _anifire_components_containers_GoAlertWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
      }
   }
}
