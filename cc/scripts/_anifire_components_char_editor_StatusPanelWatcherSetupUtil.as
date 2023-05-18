package
{
   import anifire.components.char_editor.StatusPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_char_editor_StatusPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_char_editor_StatusPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         StatusPanel.watcherSetupUtil = new _anifire_components_char_editor_StatusPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("panel",{"propertyChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("width",{"widthChanged":true},[param3[0]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
      }
   }
}
