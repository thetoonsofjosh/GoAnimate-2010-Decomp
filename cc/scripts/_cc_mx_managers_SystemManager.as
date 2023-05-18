package
{
   import flash.system.ApplicationDomain;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.managers.SystemManager;
   
   public class _cc_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory
   {
       
      
      public function _cc_mx_managers_SystemManager()
      {
         super();
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0 ? "cc" : String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object;
         if((_loc4_ = new _loc3_()) is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         return _loc4_;
      }
      
      override public function info() : Object
      {
         return {
            "applicationComplete":"initialConsole();",
            "backgroundAlpha":"0",
            "backgroundColor":"0xFFFFFF",
            "cdRsls":[{
               "rsls":["http://goanimate.com/static/libs/framework_3.3.0.4852.swz","http://goanimate.com/static/libs/framework_3.3.0.4852.swf"],
               "policyFiles":["",""],
               "digests":["077ba3fd3a24318b67b13f8297375c8df03582d8f6495f1391e74526498e773f","077ba3fd3a24318b67b13f8297375c8df03582d8f6495f1391e74526498e773f"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,false]
            },{
               "rsls":["http://goanimate.com/static/libs/rpc_3.3.0.4852.swz","http://goanimate.com/static/libs/rpc_3.3.0.4852.swf"],
               "policyFiles":["",""],
               "digests":["e507eca26d5bd6e3feff5882f3d93ecc0210452643fc6425c58103d3a67ffa85","e507eca26d5bd6e3feff5882f3d93ecc0210452643fc6425c58103d3a67ffa85"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,false]
            }],
            "compiledLocales":["en_US"],
            "compiledResourceBundleNames":["collections","containers","controls","core","effects","logging","skins","styles"],
            "creationPolicy":"none",
            "currentDomain":ApplicationDomain.currentDomain,
            "frameRate":"24",
            "height":"500",
            "layout":"absolute",
            "mainClassName":"cc",
            "mixins":["_cc_FlexInit","_richTextEditorTextAreaStyleStyle","_ControlBarStyle","_alertButtonStyleStyle","_textAreaVScrollBarStyleStyle","_headerDateTextStyle","_SwatchPanelStyle","_globalStyle","_ListBaseStyle","_todayStyleStyle","_AlertStyle","_TabBarStyle","_windowStylesStyle","_ApplicationStyle","_ToolTipStyle","_ButtonBarButtonStyle","_CursorManagerStyle","_opaquePanelStyle","_TextInputStyle","_errorTipStyle","_dateFieldPopupStyle","_ComboBoxStyle","_dataGridStylesStyle","_TabStyle","_popUpMenuStyle","_headerDragProxyStyleStyle","_activeTabStyleStyle","_PanelStyle","_DragManagerStyle","_ContainerStyle","_windowStatusStyle","_ScrollBarStyle","_swatchPanelTextFieldStyle","_ButtonBarStyle","_textAreaHScrollBarStyleStyle","_plainStyle","_activeButtonStyleStyle","_comboDropdownStyle","_ButtonStyle","_ColorPickerStyle","_weekDayStyleStyle","_linkButtonStyleStyle","_anifire_components_previewAndSave_PurchaseCompleteBoxWatcherSetupUtil","_anifire_components_previewAndSave_CharPreviewOptionBoxWatcherSetupUtil","_anifire_component_TextButtonWatcherSetupUtil","_anifire_components_char_editor_TemplateCCSelectorWatcherSetupUtil","_anifire_components_char_editor_StatusPanelWatcherSetupUtil","_anifire_components_char_editor_ComponentTypeChooserWatcherSetupUtil","_anifire_components_previewAndSave_PurchaseBoxWatcherSetupUtil","_anifire_components_char_editor_CharPreviewerWatcherSetupUtil","_anifire_components_char_editor_ButtonBarWatcherSetupUtil","_anifire_components_char_editor_BodyShapeMegaChooserWatcherSetupUtil","_ccWatcherSetupUtil"],
            "preinitialize":"loadClientLocale();",
            "usePreloader":true,
            "verticalScrollPolicy":"off",
            "width":"954"
         };
      }
   }
}
