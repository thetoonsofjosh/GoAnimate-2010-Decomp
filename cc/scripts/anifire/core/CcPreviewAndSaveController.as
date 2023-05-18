package anifire.core
{
   import anifire.cc_interface.ICcPreviewAndSaveContainer;
   import anifire.cc_theme_lib.CcCharacter;
   import anifire.cc_theme_lib.CcTheme;
   import anifire.constant.CcLibConstant;
   import anifire.event.CcActionChosenEvent;
   import anifire.event.CcCoreEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import com.adobe.images.JPGEncoder;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   
   public class CcPreviewAndSaveController extends EventDispatcher
   {
       
      
      private var _moneyMode:int;
      
      private var _coupon:int;
      
      private var ui_ps_container:ICcPreviewAndSaveContainer;
      
      private var _ccTheme:CcTheme;
      
      private var _isUserLogined:Boolean;
      
      private var _ccChar:CcCharacter;
      
      public function CcPreviewAndSaveController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function saveSnapShot() : ByteArray
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Matrix = new Matrix();
         var _loc3_:Number = 100;
         var _loc4_:Number = 150;
         _loc1_ = new BitmapData(_loc3_,_loc4_);
         _loc2_.translate(-162,-40);
         _loc2_.scale(1,1);
         _loc1_.draw(this.ui_ps_container.ui_ps_charPreviewer,_loc2_);
         var _loc5_:JPGEncoder;
         return (_loc5_ = new JPGEncoder(85)).encode(_loc1_);
      }
      
      public function goConfirmBox(param1:Number, param2:Number) : void
      {
      }
      
      private function get moneyMode() : int
      {
         return this._moneyMode;
      }
      
      public function initChar(param1:CcCharacter) : void
      {
         this._ccChar = param1;
      }
      
      public function get ccTheme() : CcTheme
      {
         return this._ccTheme;
      }
      
      public function initUi(param1:ICcPreviewAndSaveContainer) : void
      {
         this.ui_ps_container = param1;
         this.ui_ps_container.ui_ps_charPurchaseBox.addEventListener(CcCoreEvent.USER_WANT_TO_BUY_POINT,this.onUserWantToBuyPoint);
         this.ui_ps_container.ui_ps_charPurchaseBox.addEventListener(CcCoreEvent.USER_WANT_TO_CONFIRM,this.onUserWantToConfirm);
         this.ui_ps_container.ui_ps_charPurchaseBox.addEventListener(CcCoreEvent.USER_WANT_TO_REFRESH,this.onUserWantToKnowMoneyStatus);
         this.ui_ps_container.ui_ps_charPurchaseBox.addEventListener(CcCoreEvent.USER_WANT_TO_CANCEL,this.onUserWantToEditAgain);
         this.ui_ps_container.ui_ps_charPreviewOptionBox.addEventListener(CcActionChosenEvent.ACTION_CHOSEN,this.onUserChooseAction);
         this.ui_ps_container.ui_ps_charPreviewOptionBox.addEventListener(CcActionChosenEvent.FACIAL_CHOSEN,this.onUserChooseFacial);
         this.ui_ps_container.ui_ps_purchaseCompleteBox.addEventListener(CcCoreEvent.USER_WANT_TO_GO_TO_CHAR_CREATOR,this.onUserWantToGoToCharCreator);
         this.ui_ps_container.ui_ps_purchaseCompleteBox.addEventListener(CcCoreEvent.USER_WANT_TO_GO_TO_STUDIO,this.onUserWantToGoToStudio);
      }
      
      public function onUserPointUpdate(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc8_:String = null;
         this.ui_ps_container.ui_ps_userPointStatusPanel.setGobuck(param1,this.moneyMode,true);
         this.ui_ps_container.ui_ps_userPointStatusPanel.setGopoint(param2,this.moneyMode,true);
         this.ui_ps_container.ui_ps_statusPanel.updateGoBuckStyle("color","0x00000",this.moneyMode);
         this.ui_ps_container.ui_ps_statusPanel.updateGoPointStyle("color","0x000000",this.moneyMode);
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(this.coupon > 0)
         {
            _loc6_ = Math.max(this.ccChar.calculateGobuck() - this.coupon,0);
         }
         else
         {
            _loc6_ = this.ccChar.calculateGobuck();
         }
         _loc7_ = this.ccChar.calculateGoPoint();
         if(param2 >= _loc7_)
         {
            _loc5_ = true;
         }
         if(param1 >= _loc6_)
         {
            _loc4_ = true;
         }
         if(_loc4_ && _loc5_ || this.moneyMode != CcLibConstant.MONEY_MODE_NORMAL)
         {
            this.ui_ps_container.ui_ps_charPurchaseBox.updateMoneyBg(true);
            if(param3)
            {
               this.onUserWantToSave(new Event(Event.COMPLETE));
            }
         }
         else
         {
            if(!_loc4_)
            {
               this.ui_ps_container.ui_ps_charPurchaseBox.updateMoneyBg(false);
               _loc8_ = UtilDict.toDisplay("cc","<p ><font size=\'16\'><b><font color=\'#FF0000\'>Hey!</font></b><br><font size=\'14\'>You need {0} more GoBucks to get me.</font></p>");
            }
            if(!_loc5_)
            {
               this.ui_ps_container.ui_ps_statusPanel.updateGoPointStyle("color","0xff0000",this.moneyMode);
            }
            if(param3)
            {
               this.proceedToSaveNotEnoughMoney(_loc7_,_loc6_);
               Util.gaTracking("/creator/SaveFail/NeedGB",this.ui_ps_container.ui_ps_interactionViewStack);
            }
         }
      }
      
      public function initMode(param1:int, param2:Boolean, param3:int = 0) : void
      {
         this._isUserLogined = param2;
         this._moneyMode = param1;
         this._coupon = param3;
      }
      
      public function get ccChar() : CcCharacter
      {
         return this._ccChar;
      }
      
      private function onUserChooseAction(param1:CcActionChosenEvent) : void
      {
         trace("CcActionChosenEvent:" + param1.action_id);
         this.ui_ps_container.ui_ps_charPreviewer.initByCcChar(this.ccChar,param1.action_id,param1.facial_id);
      }
      
      private function onUserWantToCancelConfirm(param1:Event) : void
      {
         this.proceedToShow();
      }
      
      public function initTheme(param1:CcTheme) : void
      {
         this._ccTheme = param1;
      }
      
      public function proceedToSaveError() : void
      {
      }
      
      private function onUserWantToGoToCharCreator(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_GO_TO_CHAR_CREATOR,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function onUserWantToBuyPoint(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_BUY_POINT,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function onUserWantToEditAgain(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_CANCEL,this);
         this.dispatchEvent(_loc2_);
      }
      
      public function proceedToSaveNotEnoughMoney(param1:Number, param2:Number) : void
      {
         var _loc3_:String = UtilDict.toDisplay("cc","<p ><font size=\'16\'><b><font color=\'#FF0000\'>Hey!</font></b><br><font size=\'14\'>You need {0} more GoBucks to get me.</font></p>");
      }
      
      private function onUserWantToLearnMore(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_LEARN_MORE,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function get coupon() : int
      {
         return this._coupon;
      }
      
      private function onUserWantToConfirm(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_CONFIRM,this);
         this.dispatchEvent(_loc2_);
      }
      
      public function proceedToShow() : void
      {
         Util.gaTracking("/creator/Preview",this.ui_ps_container.ui_ps_interactionViewStack);
         this.ui_ps_container.ui_ps_charPreviewer.initByCcChar(this.ccChar,this.ccChar.bodyShape.thumbnailActionId,this.ccChar.bodyShape.thumbnailFacialId);
         this.ui_ps_container.ui_ps_statusPanel.setGobuck(this.ccChar.calculateGobuck(),this.moneyMode,true,this.coupon);
         this.ui_ps_container.ui_ps_statusPanel.setGopoint(this.ccChar.calculateGoPoint(),this.moneyMode);
         this.ui_ps_container.ui_ps_interactionViewStack.selectedChild = this.ui_ps_container.ui_ps_charPreviewCanvas;
         this.ui_ps_container.ui_ps_charPreviewOptionBox.init(this.ccChar,this.ccTheme);
         this.ui_ps_container.ui_ps_charPreviewOptionBox.action = this.ccChar.bodyShape.thumbnailActionId;
         this.ui_ps_container.ui_ps_charPreviewOptionBox.facial = this.ccChar.bodyShape.thumbnailFacialId;
         if(this.moneyMode == CcLibConstant.MONEY_MODE_SCHOOL)
         {
            this.ui_ps_container.ui_ps_charPurchaseBox._boxStatusPanel.height = 0;
         }
         if(this.isUserLogined)
         {
            this.ui_ps_container.ui_ps_charPreviewOptionBox.saveEnabled = true;
         }
      }
      
      private function onUserWantToGoToStudio(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_GO_TO_STUDIO,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function onUserWantToSave(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_SAVE,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function get isUserLogined() : Boolean
      {
         return this._isUserLogined;
      }
      
      private function onUserWantToKnowMoneyStatus(param1:Event) : void
      {
         var _loc2_:CcCoreEvent = new CcCoreEvent(CcCoreEvent.USER_WANT_TO_KNOW_HIS_MONEY_STATUS,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function onUserChooseFacial(param1:CcActionChosenEvent) : void
      {
         trace("CcFacialChosenEvent:" + param1.facial_id);
         this.ui_ps_container.ui_ps_charPreviewer.initByCcChar(this.ccChar,param1.action_id,param1.facial_id);
      }
      
      public function proceedToSaveComplete(param1:Number, param2:Number) : void
      {
         this.ui_ps_container.ui_ps_interactionViewStack.selectedChild = this.ui_ps_container.ui_ps_purChaseCompleteContainer;
      }
   }
}
