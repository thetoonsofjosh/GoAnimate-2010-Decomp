package
{
   import anifire.components.char_editor.TemplateCCSelector;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_char_editor_TemplateCCSelectorWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_char_editor_TemplateCCSelectorWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TemplateCCSelector.watcherSetupUtil = new _anifire_components_char_editor_TemplateCCSelectorWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("_pager",{"propertyChange":true},[param3[0],param3[1],param3[2]],param2);
         param4[1] = new PropertyWatcher("pageNumber",{"propertyChange":true},[param3[0],param3[1],param3[2]],null);
         param4[2] = new PropertyWatcher("totalPages",null,[param3[1],param3[2]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
         param4[0].addChild(param4[2]);
      }
   }
}
