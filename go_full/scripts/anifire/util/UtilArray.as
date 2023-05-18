package anifire.util
{
   public class UtilArray
   {
      
      private static var keys:Object = new Object();
       
      
      public function UtilArray()
      {
         super();
      }
      
      public static function removeDuplicates(param1:Array, param2:Boolean = false) : Array
      {
         keys = new Object();
         var _loc3_:Array = param1.filter(scanDuplicates);
         if(param2)
         {
            _loc3_.sort();
         }
         return _loc3_;
      }
      
      private static function scanDuplicates(param1:Object, param2:uint, param3:Array) : Boolean
      {
         if(keys.hasOwnProperty(param1))
         {
            return false;
         }
         keys[param1] = param1;
         return true;
      }
   }
}
