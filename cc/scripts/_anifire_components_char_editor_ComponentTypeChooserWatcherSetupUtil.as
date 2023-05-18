package
{
   import anifire.components.char_editor.ComponentTypeChooser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_char_editor_ComponentTypeChooserWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_char_editor_ComponentTypeChooserWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ComponentTypeChooser.watcherSetupUtil = new _anifire_components_char_editor_ComponentTypeChooserWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("canQuickBar",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("x",{"xChanged":true},[param3[0]],null);
         param4[2] = new PropertyWatcher("tagSteps",{"propertyChange":true},[param3[0]],param2);
         param4[3] = new PropertyWatcher("width",{"widthChanged":true},[param3[0]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[3]);
      }
   }
}
