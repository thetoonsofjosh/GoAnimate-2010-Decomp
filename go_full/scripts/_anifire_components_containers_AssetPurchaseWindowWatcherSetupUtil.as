package
{
   import anifire.components.containers.AssetPurchaseWindow;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetPurchaseWindow.watcherSetupUtil = new _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[6] = new PropertyWatcher("_textCost",{"propertyChange":true},[param3[6]],param2);
         param4[5] = new PropertyWatcher("_textYou",{"propertyChange":true},[param3[5]],param2);
         param4[4] = new PropertyWatcher("_assetTitle",{"propertyChange":true},[param3[4]],param2);
         param4[8] = new PropertyWatcher("_textDesc",{"propertyChange":true},[param3[8]],param2);
         param4[7] = new PropertyWatcher("_textLink",{"propertyChange":true},[param3[7]],param2);
         param4[6].updateParent(param1);
         param4[5].updateParent(param1);
         param4[4].updateParent(param1);
         param4[8].updateParent(param1);
         param4[7].updateParent(param1);
      }
   }
}
