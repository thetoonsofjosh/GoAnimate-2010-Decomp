package
{
   import anifire.timeline.SceneElement;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SceneElementWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_timeline_SceneElementWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneElement.watcherSetupUtil = new _anifire_timeline_SceneElementWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("data",{"dataChange":true},[param3[1]],param2);
         param4[2] = new PropertyWatcher("label",null,[param3[1]],null);
         param4[0] = new PropertyWatcher("cce",{"propertyChange":true},[param3[0]],param2);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[0].updateParent(param1);
      }
   }
}
