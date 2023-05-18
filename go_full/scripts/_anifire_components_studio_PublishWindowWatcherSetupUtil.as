package
{
   import anifire.components.studio.PublishWindow;
   import anifire.core.Console;
   import flash.display.Sprite;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_PublishWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_PublishWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PublishWindow.watcherSetupUtil = new _anifire_components_studio_PublishWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var bindings:Array = param3;
         var watchers:Array = param4;
         watchers[22] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[19]],null);
         watchers[25] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[21]],null);
         watchers[28] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[23]],null);
         watchers[73] = new PropertyWatcher("height",{"heightChanged":true},[bindings[56]],propertyGetter);
         watchers[31] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[25]],null);
         watchers[16] = new PropertyWatcher("_vsCaptures",{"propertyChange":true},[bindings[16]],propertyGetter);
         watchers[17] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "change":true
         },[bindings[16]],null);
         watchers[54] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[37]],null);
         watchers[72] = new PropertyWatcher("width",{"widthChanged":true},[bindings[55]],propertyGetter);
         watchers[44] = new PropertyWatcher("_txtAlert",{"propertyChange":true},[bindings[31]],propertyGetter);
         watchers[45] = new PropertyWatcher("height",{"heightChanged":true},[bindings[31]],null);
         watchers[49] = new PropertyWatcher("_txtGroupAlert",{"propertyChange":true},[bindings[33]],propertyGetter);
         watchers[50] = new PropertyWatcher("height",{"heightChanged":true},[bindings[33]],null);
         watchers[13] = new PropertyWatcher("LANG_ARRAY",null,[bindings[13]],propertyGetter);
         watchers[47] = new PropertyWatcher("_groupAlert",{"propertyChange":true},[bindings[33]],propertyGetter);
         watchers[48] = new PropertyWatcher("height",{"heightChanged":true},[bindings[33]],null);
         watchers[19] = new PropertyWatcher("length",null,[bindings[16]],null);
         watchers[42] = new PropertyWatcher("_parentalAlert",{"propertyChange":true},[bindings[31]],propertyGetter);
         watchers[43] = new PropertyWatcher("height",{"heightChanged":true},[bindings[31]],null);
         watchers[57] = new PropertyWatcher("_shareBtnBgEffect",{"propertyChange":true},[bindings[39],bindings[40]],propertyGetter);
         watchers[11] = new PropertyWatcher("_description",{"propertyChange":true},[bindings[11]],propertyGetter);
         watchers[4] = new PropertyWatcher("_movieName",{"propertyChange":true},[bindings[4]],propertyGetter);
         watchers[37] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[28]],null);
         watchers[7] = new PropertyWatcher("_tags",{"propertyChange":true},[bindings[7]],propertyGetter);
         watchers[33] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[25]],null);
         watchers[40] = new FunctionReturnWatcher("getConsole",target,function():Array
         {
            return [];
         },null,[bindings[30]],null);
         watchers[22].updateParent(Console);
         watchers[25].updateParent(Console);
         watchers[28].updateParent(Console);
         watchers[73].updateParent(target);
         watchers[31].updateParent(Console);
         watchers[16].updateParent(target);
         watchers[16].addChild(watchers[17]);
         watchers[54].updateParent(Console);
         watchers[72].updateParent(target);
         watchers[44].updateParent(target);
         watchers[44].addChild(watchers[45]);
         watchers[49].updateParent(target);
         watchers[49].addChild(watchers[50]);
         watchers[13].updateParent(target);
         watchers[47].updateParent(target);
         watchers[47].addChild(watchers[48]);
         watchers[19].updateParent(propertyGetter.apply(target,["_captures"]));
         watchers[42].updateParent(target);
         watchers[42].addChild(watchers[43]);
         watchers[57].updateParent(target);
         watchers[11].updateParent(target);
         watchers[4].updateParent(target);
         watchers[37].updateParent(Console);
         watchers[7].updateParent(target);
         watchers[33].updateParent(Console);
         watchers[40].updateParent(Console);
      }
   }
}
