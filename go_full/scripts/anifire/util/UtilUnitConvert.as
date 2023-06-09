package anifire.util
{
   import anifire.constant.AnimeConstants;
   
   public class UtilUnitConvert
   {
       
      
      public function UtilUnitConvert()
      {
         super();
      }
      
      public static function trackToPixel(param1:Number) : Number
      {
         return Math.floor(param1 * (AnimeConstants.SOUNDCONTAINER_HEIGHT + AnimeConstants.VERTICAL_GAP));
      }
      
      public static function secToFrame(param1:Number, param2:Boolean = false, param3:Boolean = false) : Number
      {
         var _loc4_:Number = param1 * AnimeConstants.FRAME_PER_SEC;
         if(!param2)
         {
            _loc4_ = Math.round(_loc4_);
         }
         return _loc4_ > 0 ? _loc4_ : (param3 ? 0 : 1);
      }
      
      public static function getClockTime(param1:uint, param2:uint) : String
      {
         var _loc3_:String = "PM";
         var _loc4_:String = doubleDigitFormat(param2);
         if(param1 > 12)
         {
            param1 -= 12;
         }
         else if(param1 == 0)
         {
            _loc3_ = "AM";
            param1 = 12;
         }
         else if(param1 < 12)
         {
            _loc3_ = "AM";
         }
         return doubleDigitFormat(param1) + ":" + _loc4_ + " " + _loc3_;
      }
      
      public static function getTargetPoint(param1:Number, param2:Number, param3:Number, param4:Number) : int
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(param4 == 2)
         {
            return 1;
         }
         _loc5_ = (param2 - param1) / (param4 - 1);
         _loc6_ = 0;
         _loc6_ = 0;
         while(_loc6_ < param4 - 1)
         {
            if(param3 >= param1 + _loc5_ * _loc6_ && param3 <= param1 + _loc5_ * (_loc6_ + 1))
            {
               return _loc6_ + 1;
            }
            _loc6_++;
         }
         return 0;
      }
      
      public static function pixelToTrack(param1:Number) : Number
      {
         return param1 / (AnimeConstants.SOUNDCONTAINER_HEIGHT + AnimeConstants.VERTICAL_GAP);
      }
      
      public static function pixelToFrame(param1:Number, param2:Boolean = false) : Number
      {
         var _loc3_:Number = param1 * AnimeConstants.FRAME_PER_PIXEL;
         if(!param2)
         {
            _loc3_ = Math.round(_loc3_);
         }
         return _loc3_ > 0 ? _loc3_ : 1;
      }
      
      public static function uintToColorHexString(param1:uint) : String
      {
         var _loc2_:String = "";
         _loc2_ += param1.toString(16).toUpperCase();
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "0x" + _loc2_;
      }
      
      public static function pixelToSec(param1:Number) : Number
      {
         return param1 / AnimeConstants.PIXEL_PER_SEC;
      }
      
      public static function doubleDigitFormat(param1:uint) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return String(param1);
      }
      
      public static function snapToPixelWithTime(param1:Number) : Number
      {
         var _loc2_:Number = Math.round(UtilUnitConvert.pixelToSec(param1) * 10) / 10;
         return UtilUnitConvert.secToPixel(_loc2_);
      }
      
      public static function frameToSec(param1:Number, param2:Boolean = true) : Number
      {
         if(param2 && param1 != 0)
         {
            return Util.roundNum(param1 - 1) / AnimeConstants.FRAME_PER_SEC;
         }
         if(param1 >= 0)
         {
            return Util.roundNum(param1 / AnimeConstants.FRAME_PER_SEC);
         }
         return 0;
      }
      
      public static function secToPixel(param1:Number) : Number
      {
         return Math.floor(param1 * AnimeConstants.PIXEL_PER_SEC);
      }
      
      public static function frameToPixel(param1:Number) : Number
      {
         return Math.round(Math.floor(param1 / AnimeConstants.FRAME_PER_PIXEL) / 5) * 5;
      }
   }
}
