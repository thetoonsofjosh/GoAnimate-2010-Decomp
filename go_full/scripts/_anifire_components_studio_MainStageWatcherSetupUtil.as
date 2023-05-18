package
{
   import anifire.components.studio.MainStage;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MainStageWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_MainStageWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MainStage.watcherSetupUtil = new _anifire_components_studio_MainStageWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("_uiCanvasAutoSave",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[3],param3[4]],param2);
         param4[3] = new PropertyWatcher("sceneIndexStr",{"propertyChange":true},[param3[6]],param2);
         param4[0].updateParent(param1);
         param4[3].updateParent(param1);
      }
   }
}
