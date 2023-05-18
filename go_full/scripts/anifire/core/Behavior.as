package anifire.core
{
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Behavior extends EventDispatcher
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Behavior");
       
      
      private var _id:String;
      
      private var _thumb:anifire.core.Thumb;
      
      private var _imageData:Object;
      
      private var _totalFrame:int;
      
      private var _name:String;
      
      private var _behaviorZip:ByteArray;
      
      private var _isEnable:Boolean;
      
      private var _aid:String;
      
      public function Behavior(param1:anifire.core.Thumb, param2:String, param3:String, param4:int, param5:String, param6:String)
      {
         super();
         _logger.debug("Behavior initialized");
         this.thumb = param1;
         this.id = param2;
         this.name = param3;
         this.totalFrame = param4;
         if(param5 == "N")
         {
            this.isEnable = false;
         }
         else
         {
            this.isEnable = true;
         }
         this.aid = param6;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.isEnable = false;
         }
      }
      
      public static function getThemeIdFromBehaviourXML(param1:XML) : String
      {
         return UtilXmlInfo.getThemeIdFromFileName(param1.toString());
      }
      
      public static function getCharIdFromBehaviourXML(param1:XML) : String
      {
         return UtilXmlInfo.getCharIdFromFileName(param1.toString());
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray, param4:Boolean) : UtilHashArray
      {
         var _loc9_:String = null;
         var _loc12_:ByteArray = null;
         var _loc13_:ThemeTree = null;
         var _loc14_:UtilCrypto = null;
         var _loc5_:UtilHashArray = new UtilHashArray();
         var _loc6_:String = UtilXmlInfo.getZipFileNameOfBehaviour(param1.toString(),param4);
         var _loc7_:String = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
         var _loc8_:String = UtilXmlInfo.getThumbIdFromFileName(_loc6_);
         if(param4)
         {
            _loc9_ = UtilXmlInfo.getCharIdFromFileName(_loc6_);
         }
         else
         {
            _loc9_ = UtilXmlInfo.getPropIdFromFileName(_loc6_);
         }
         var _loc10_:ZipEntry = param2.getEntry(_loc6_);
         var _loc11_:Boolean = true;
         if(_loc10_ == null)
         {
            _loc11_ = false;
         }
         else if(param3.containsKey(_loc7_) && (param3.getValueByKey(_loc7_) as ThemeTree).isCharBehaviourExist(_loc9_,_loc8_,param4))
         {
            _loc11_ = false;
         }
         if(_loc11_)
         {
            _loc12_ = param2.getInput(_loc10_);
            if(_loc7_ != "ugc")
            {
               (_loc14_ = new UtilCrypto()).decrypt(_loc12_);
            }
            (_loc13_ = new ThemeTree(_loc7_)).addCharBehaviour(_loc9_,_loc8_,_loc12_,param4);
            _loc5_.push(_loc7_,_loc13_);
         }
         return _loc5_;
      }
      
      public function get totalFrame() : int
      {
         return this._totalFrame;
      }
      
      public function set imageData(param1:Object) : void
      {
         this._imageData = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get isEnable() : Boolean
      {
         return this._isEnable;
      }
      
      public function set totalFrame(param1:int) : void
      {
         this._totalFrame = param1;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set isEnable(param1:Boolean) : void
      {
         this._isEnable = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get thumb() : anifire.core.Thumb
      {
         return this._thumb;
      }
      
      public function set behaviorZip(param1:ByteArray) : void
      {
         this._behaviorZip = param1;
      }
      
      public function loadImageData(param1:String = "char") : void
      {
         Console.getConsole().requestLoadStatus(true);
         var _loc2_:URLRequest = UtilNetwork.getGetThemeAssetRequest(this.thumb.theme.id,this.thumb.id,param1,this.id);
         var _loc3_:UtilURLStream = new UtilURLStream();
         _loc3_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc3_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc3_.load(_loc2_);
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function getKey() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id + "." + this.id;
      }
      
      public function set thumb(param1:anifire.core.Thumb) : void
      {
         this._thumb = param1;
      }
      
      public function get behaviorZip() : ByteArray
      {
         return this._behaviorZip;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function set aid(param1:String) : void
      {
         this._aid = param1;
      }
      
      public function get aid() : String
      {
         return this._aid;
      }
      
      public function loadImageDataComplete(param1:Event) : void
      {
         var _loc4_:UtilCrypto = null;
         var _loc2_:URLStream = URLStream(param1.target);
         Console.getConsole().requestLoadStatus(false);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         this.imageData = _loc3_;
         if(this.thumb.theme.id != "ugc")
         {
            (_loc4_ = new UtilCrypto()).decrypt(this.imageData as ByteArray);
         }
         this.thumb.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_STATE_COMPLETE,this));
      }
   }
}
