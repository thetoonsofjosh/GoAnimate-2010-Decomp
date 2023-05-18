package
{
   import anifire.components.previewAndSave.CharPreviewOptionBox;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_previewAndSave_CharPreviewOptionBoxWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_previewAndSave_CharPreviewOptionBoxWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CharPreviewOptionBox.watcherSetupUtil = new _anifire_components_previewAndSave_CharPreviewOptionBoxWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
      }
   }
}
