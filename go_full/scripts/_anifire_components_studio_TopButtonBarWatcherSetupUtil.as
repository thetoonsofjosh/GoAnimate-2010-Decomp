package
{
   import anifire.components.studio.TopButtonBar;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_TopButtonBarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_TopButtonBarWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TopButtonBar.watcherSetupUtil = new _anifire_components_studio_TopButtonBarWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[12] = new PropertyWatcher("width",{"widthChanged":true},[param3[10]],param2);
         param4[15] = new PropertyWatcher("_txtIdea",{"propertyChange":true},[param3[11]],param2);
         param4[16] = new PropertyWatcher("width",{"widthChanged":true},[param3[11]],null);
         param4[18] = new PropertyWatcher("_btnSave",{"propertyChange":true},[param3[13]],param2);
         param4[13] = new PropertyWatcher("_open",{"propertyChange":true},[param3[10]],param2);
         param4[14] = new PropertyWatcher("width",{"widthChanged":true},[param3[10]],null);
         param4[12].updateParent(param1);
         param4[15].updateParent(param1);
         param4[15].addChild(param4[16]);
         param4[18].updateParent(param1);
         param4[13].updateParent(param1);
         param4[13].addChild(param4[14]);
      }
   }
}
