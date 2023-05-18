package
{
   import anifire.components.studio.GoWalker;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_GoWalkerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_GoWalkerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoWalker.watcherSetupUtil = new _anifire_components_studio_GoWalkerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("_ptBubble",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[5] = new PropertyWatcher("height",{"heightChanged":true},[param3[2]],null);
         param4[3] = new PropertyWatcher("width",{"widthChanged":true},[param3[1]],null);
         param4[0] = new PropertyWatcher("_canvasStepSuccess",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[4] = new PropertyWatcher("y",{"yChanged":true},[param3[2]],null);
         param4[1] = new PropertyWatcher("x",{"xChanged":true},[param3[1]],null);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[5]);
         param4[2].addChild(param4[3]);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[4]);
         param4[0].addChild(param4[1]);
      }
   }
}
