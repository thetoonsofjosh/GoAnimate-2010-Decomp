package
{
   import anifire.components.studio.ThumbTray;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_ThumbTrayWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_ThumbTrayWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ThumbTray.watcherSetupUtil = new _anifire_components_studio_ThumbTrayWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("pnlShadow",{"propertyChange":true},[param3[2]],param2);
         param4[0] = new PropertyWatcher("VSThumbTray",{"propertyChange":true},[param3[1]],param2);
         param4[38] = new PropertyWatcher("main_cav",{"propertyChange":true},[param3[59]],param2);
         param4[39] = new PropertyWatcher("width",{"widthChanged":true},[param3[59]],null);
         param4[40] = new PropertyWatcher("_btnMyChar",{"propertyChange":true},[param3[65],param3[59]],param2);
         param4[41] = new PropertyWatcher("width",{"widthChanged":true},[param3[59]],null);
         param4[43] = new PropertyWatcher("_uiCanvasUser",{"propertyChange":true},[param3[61]],param2);
         param4[45] = new PropertyWatcher("_uiCanvasCommunity",{"propertyChange":true},[param3[63]],param2);
         param4[1].updateParent(param1);
         param4[0].updateParent(param1);
         param4[38].updateParent(param1);
         param4[38].addChild(param4[39]);
         param4[40].updateParent(param1);
         param4[40].addChild(param4[41]);
         param4[43].updateParent(param1);
         param4[45].updateParent(param1);
      }
   }
}
