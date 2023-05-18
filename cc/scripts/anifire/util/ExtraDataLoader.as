package anifire.util
{
   import anifire.event.ExtraDataEvent;
   import com.senocular.display.CloneUtility;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ExtraDataLoader extends Loader
   {
       
      
      public var extraData;
      
      public function ExtraDataLoader()
      {
         super();
         CloneUtility.registerClass(this);
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         var _loc2_:ExtraDataEvent = new ExtraDataEvent(param1.type,new Object(),this.extraData,param1.bubbles,param1.cancelable);
         return super.dispatchEvent(_loc2_);
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeObject(this.extraData);
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.extraData = param1.readObject();
      }
      
      public function clone() : ExtraDataLoader
      {
         var _loc1_:ByteArray = CloneUtility.writeObjectToByteArray(this);
         return _loc1_.readObject() as ExtraDataLoader;
      }
   }
}
