package
{
   import anifire.components.studio.MyCharButton;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MyCharButtonWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_MyCharButtonWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MyCharButton.watcherSetupUtil = new _anifire_components_studio_MyCharButtonWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("_eng_btn",{"propertyChange":true},[param3[3]],param2);
         param4[1] = new PropertyWatcher("_i18n_btn",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[2].updateParent(param1);
         param4[1].updateParent(param1);
      }
   }
}
