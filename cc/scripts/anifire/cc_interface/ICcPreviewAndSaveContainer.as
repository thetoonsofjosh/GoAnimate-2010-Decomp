package anifire.cc_interface
{
   import anifire.components.char_editor.CharPreviewer;
   import anifire.components.char_editor.StatusPanel;
   import anifire.components.previewAndSave.CharPreviewOptionBox;
   import anifire.components.previewAndSave.PurchaseBox;
   import anifire.components.previewAndSave.PurchaseCompleteBox;
   import flash.events.IEventDispatcher;
   import mx.containers.ViewStack;
   import mx.core.Container;
   
   public interface ICcPreviewAndSaveContainer extends IEventDispatcher
   {
       
      
      function get ui_ps_purchaseCompleteBox() : PurchaseCompleteBox;
      
      function get ui_ps_statusPanel() : StatusPanel;
      
      function get ui_ps_interactionViewStack() : ViewStack;
      
      function get ui_ps_charPurchaseBox() : PurchaseBox;
      
      function get ui_ps_charPreviewOptionBox() : CharPreviewOptionBox;
      
      function get ui_ps_purChaseCompleteContainer() : Container;
      
      function get ui_ps_charPreviewCanvas() : Container;
      
      function get ui_ps_charPreviewer() : CharPreviewer;
      
      function get ui_ps_userPointStatusPanel() : StatusPanel;
   }
}
