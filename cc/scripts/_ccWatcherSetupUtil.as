package
{
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _ccWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _ccWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         cc.watcherSetupUtil = new _ccWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[8] = new PropertyWatcher("height",{"heightChanged":true},[param3[5],param3[7]],param2);
         param4[5] = new PropertyWatcher("width",{"widthChanged":true},[param3[4],param3[6]],param2);
         param4[0] = new PropertyWatcher("_ce_statusPanel",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[3]],param2);
         param4[4] = new PropertyWatcher("height",{"heightChanged":true},[param3[3]],null);
         param4[3] = new PropertyWatcher("width",{"widthChanged":true},[param3[2]],null);
         param4[2] = new PropertyWatcher("y",{"yChanged":true},[param3[1]],null);
         param4[1] = new PropertyWatcher("x",{"xChanged":true},[param3[0]],null);
         param4[6] = new PropertyWatcher("ps_charPreviewOptionBox",{"propertyChange":true},[param3[4],param3[5]],param2);
         param4[9] = new PropertyWatcher("height",{"heightChanged":true},[param3[5]],null);
         param4[7] = new PropertyWatcher("width",{"widthChanged":true},[param3[4]],null);
         param4[8].updateParent(param1);
         param4[5].updateParent(param1);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[4]);
         param4[0].addChild(param4[3]);
         param4[0].addChild(param4[2]);
         param4[0].addChild(param4[1]);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[9]);
         param4[6].addChild(param4[7]);
      }
   }
}
