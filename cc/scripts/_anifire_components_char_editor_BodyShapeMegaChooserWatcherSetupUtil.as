package
{
   import anifire.components.char_editor.BodyShapeMegaChooser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_char_editor_BodyShapeMegaChooserWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_char_editor_BodyShapeMegaChooserWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         BodyShapeMegaChooser.watcherSetupUtil = new _anifire_components_char_editor_BodyShapeMegaChooserWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("height",{"heightChanged":true},[param3[2]],param2);
         param4[6] = new PropertyWatcher("mc",{"propertyChange":true},[param3[6],param3[7]],param2);
         param4[7] = new PropertyWatcher("height",{"heightChanged":true},[param3[6]],null);
         param4[0] = new PropertyWatcher("TAB_DATAPROVIDER",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("width",{"widthChanged":true},[param3[1]],param2);
         param4[3] = new PropertyWatcher("_selectedCCChar",{"propertyChange":true},[param3[3]],param2);
         param4[9] = new PropertyWatcher("previewer",{"propertyChange":true},[param3[9]],param2);
         param4[8] = new PropertyWatcher("vs",{"propertyChange":true},[param3[8]],param2);
         param4[2].updateParent(param1);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[7]);
         param4[0].updateParent(param1);
         param4[1].updateParent(param1);
         param4[3].updateParent(param1);
         param4[9].updateParent(param1);
         param4[8].updateParent(param1);
      }
   }
}
