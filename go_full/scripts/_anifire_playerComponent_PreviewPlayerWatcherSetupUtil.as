package
{
   import anifire.playerComponent.PreviewPlayer;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_PreviewPlayerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_playerComponent_PreviewPlayerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PreviewPlayer.watcherSetupUtil = new _anifire_playerComponent_PreviewPlayerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[6] = new PropertyWatcher("loading",{"propertyChange":true},[param3[3],param3[7]],param2);
         param4[7] = new PropertyWatcher("width",{"widthChanged":true},[param3[3]],null);
         param4[1] = new PropertyWatcher("loadingScreen",{"propertyChange":true},[param3[1],param3[3]],param2);
         param4[2] = new PropertyWatcher("width",{"widthChanged":true},[param3[1],param3[3]],null);
         param4[3] = new PropertyWatcher("createYourOwn",{"propertyChange":true},[param3[1],param3[6]],param2);
         param4[4] = new PropertyWatcher("width",{"widthChanged":true},[param3[1]],null);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[7]);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[4]);
      }
   }
}
