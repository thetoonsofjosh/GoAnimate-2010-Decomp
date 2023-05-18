package anifire.util
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.LanguageConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.LoadMgrEvent;
   import com.google.analytics.AnalyticsTracker;
   import com.google.analytics.GATracker;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import mx.controls.Alert;
   import mx.core.Application;
   import mx.core.UIComponent;
   import mx.events.StyleEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.logging.targets.TraceTarget;
   import mx.resources.ResourceManager;
   import mx.styles.StyleManager;
   
   public class Util
   {
      
      public static var isDebugMode:Boolean = false;
      
      private static var flashVar_index_by_application:Dictionary = new Dictionary();
      
      private static var _logger:ILogger = Log.getLogger("core.Console");
      
      public static var tracker:AnalyticsTracker;
       
      
      public function Util()
      {
         super();
      }
      
      public static function isVideoRecording() : Boolean
      {
         return Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIDEO_RECORD_MODE) == "1";
      }
      
      public static function loadClientLocale(param1:String, param2:Function) : void
      {
         var _loc3_:UtilHashArray = Util.getFlashVar();
         var _loc4_:String = _loc3_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         var _loc5_:String;
         if((_loc5_ = _loc3_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE)) == null)
         {
            _loc5_ = "go";
         }
         if(_loc4_ == null)
         {
            _loc4_ = "en_US";
         }
         UtilGettext.initAggregate(param1,_loc5_,_loc4_,param2);
         ResourceManager.getInstance().localeChain = [_loc4_];
      }
      
      public static function getFlashVar(param1:Application = null) : UtilHashArray
      {
         var _loc2_:UtilHashArray = null;
         var _loc3_:String = null;
         if(param1 == null)
         {
            param1 = Application.application as Application;
         }
         if(flashVar_index_by_application[param1] == null)
         {
            _loc2_ = new UtilHashArray();
            for(_loc3_ in param1.parameters)
            {
               _loc2_.push(_loc3_,param1.parameters[_loc3_]);
            }
            flashVar_index_by_application[param1] = _loc2_;
         }
         else
         {
            _loc2_ = flashVar_index_by_application[param1];
         }
         return _loc2_.clone();
      }
      
      public static function disableFocus(param1:UIComponent) : void
      {
         var _loc2_:UIComponent = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_) as UIComponent;
            if(_loc2_ != null)
            {
               _loc2_.focusEnabled = false;
            }
            if(param1.getChildAt(_loc3_) is UIComponent)
            {
               disableFocus(UIComponent(_loc2_));
            }
            _loc3_++;
         }
      }
      
      public static function initLog() : void
      {
         var _loc1_:TraceTarget = null;
         _loc1_ = new TraceTarget();
         _loc1_.includeDate = true;
         _loc1_.includeTime = true;
         _loc1_.includeLevel = true;
         _loc1_.includeCategory = true;
         Log.addTarget(_loc1_);
      }
      
      public static function goToLoginPage(param1:Boolean, param2:Boolean, param3:Boolean, param4:String, param5:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:URLRequest = null;
         if(param2 && !param3)
         {
            if(param1)
            {
               _loc6_ = "showSignup";
            }
            else
            {
               _loc6_ = "showLogin";
            }
            ExternalInterface.call(_loc6_,250,param5);
         }
         else
         {
            _loc7_ = param1 ? "signup" : "login";
            _loc8_ = param4 + "go/?" + _loc7_ + "=1&" + "returnto=" + escape(param5);
            _loc9_ = new URLRequest(_loc8_);
            navigateToURL(_loc9_,"_top");
         }
      }
      
      public static function capturePicture(param1:DisplayObject, param2:Rectangle = null) : BitmapData
      {
         var retBd:BitmapData = null;
         var bd:BitmapData = null;
         var m:Matrix = null;
         var newBd:BitmapData = null;
         var source:DisplayObject = param1;
         var srcRect:Rectangle = param2;
         try
         {
            bd = source.width == 0 ? new BitmapData(100,100) : new BitmapData(source.width,source.height);
            m = new Matrix();
            bd.draw(source,m);
            if(srcRect == null || bd == null)
            {
               retBd = bd;
            }
            else
            {
               newBd = new BitmapData(srcRect.width,srcRect.height);
               newBd.copyPixels(bd,srcRect,new Point());
               retBd = newBd;
            }
         }
         catch(e:Error)
         {
         }
         return retBd;
      }
      
      public static function setFlashVar(param1:String, param2:String, param3:Application = null) : void
      {
         if(param3 == null)
         {
            param3 = Application.application as Application;
         }
         getFlashVar(param3);
         var _loc4_:UtilHashArray;
         (_loc4_ = flashVar_index_by_application[param3] as UtilHashArray).push(param1,param2);
      }
      
      public static function showAlert(param1:Event) : void
      {
         var _loc2_:* = "";
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            _loc2_ += "Oops, a connection problem occurred";
         }
         _loc2_ += "\n" + "The task could not be completed. Please try again.";
         Alert.show(_loc2_);
      }
      
      public static function preferLanguageShortCode() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         var _loc3_:String = LanguageConstants.MEDIUM_TO_SHORT_LANG_CODES_MAPPING.getValueByKey(_loc2_);
         if(_loc3_ == null)
         {
            _loc3_ = AnimeConstants.LANGUAGE_CODE_ENGLISH;
         }
         return _loc3_;
      }
      
      public static function roundNum(param1:Number, param2:int = 1) : Number
      {
         return Math.round(param1 * Math.pow(10,param2)) / Math.pow(10,param2);
      }
      
      public static function addFlashVarsToURLvar(param1:URLVariables) : void
      {
         UtilPlain.addFlashVarsToURLvar(getFlashVar(),param1);
      }
      
      public static function gaTracking(param1:String, param2:DisplayObject) : void
      {
         var flashVars:UtilHashArray;
         var javascriptFunctionCall:String = null;
         var ga_account_id:String = null;
         var action:String = param1;
         var dsp:DisplayObject = param2;
         var app:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_APPCODE) as String;
         var isHeartBeatAction:Boolean = action == AnimeConstants.GA_ACTION__AUTO_SAVE ? true : false;
         if(app == "go")
         {
            action = "/pageTracker" + action;
            javascriptFunctionCall = "pageTracker._trackPageview(\'" + action + "\')";
         }
         else
         {
            action = "/urchin" + action;
            javascriptFunctionCall = "urchinTracker(\'" + action + "\')";
         }
         flashVars = getFlashVar();
         if(flashVars.getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
         {
            if(flashVars.getValueByKey(ServerConstants.PARAM_ISOFFLINE) != "1")
            {
               ExternalInterface.call(javascriptFunctionCall);
            }
         }
         else if(dsp != null)
         {
            try
            {
               if(UtilLicense.getCurrentLicenseId() != "7")
               {
                  ga_account_id = "UA-2516970-7";
               }
               else if(UtilLicense.isBoxEnvironment())
               {
                  ga_account_id = "UA-2516970-14";
               }
               else
               {
                  ga_account_id = "UA-2516970-11";
               }
               tracker = new GATracker(dsp,ga_account_id,"AS3",false);
               tracker.trackPageview(action);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      public static function getCharacter(param1:MovieClip) : MovieClip
      {
         if(param1 == null)
         {
            _logger.error("theClip is null");
            return null;
         }
         return UtilPlain.getCharacter(param1);
      }
      
      public static function loadClientTheming(param1:Array, param2:Array, param3:Array, param4:Function) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc10_:IEventDispatcher = null;
         var _loc8_:UtilLoadMgr;
         (_loc8_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,param4);
         var _loc9_:int = 0;
         while(_loc9_ < param1.length)
         {
            _loc5_ = param1[_loc9_] as String;
            _loc6_ = param2[_loc9_] as String;
            _loc7_ = param3[_loc9_] as String;
            _loc10_ = StyleManager.loadStyleDeclarations(UtilNetwork.getClientThemeUrl(_loc7_,_loc6_,_loc5_),true);
            _loc8_.addEventDispatcher(_loc10_ as EventDispatcher,StyleEvent.COMPLETE);
            _loc9_++;
         }
         _loc8_.commit();
      }
      
      public static function generateBoxUrl(param1:String, param2:Boolean = true, param3:URLVariables = null) : String
      {
         var siteUrl:String = param1;
         var propagateSession:Boolean = param2;
         var vars:URLVariables = param3;
         var parentUrl:String = null;
         parentUrl = decodeURI(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_BOX_PARENT_URL));
         if(propagateSession)
         {
            parentUrl = parentUrl.split(/([&\?#])/).filter(function(param1:String, param2:int, param3:Array):Boolean
            {
               return !param1.match(/^(PHPSESSID|v)=/);
            }).join("");
         }
         if(vars)
         {
            parentUrl += "&" + vars.toString();
         }
         return parentUrl + "#" + encodeURI(siteUrl);
      }
      
      public static function traceDisplayList(param1:DisplayObjectContainer, param2:String = "") : void
      {
         UtilPlain.traceDisplayList(param1,param2);
      }
      
      public static function getMovieThumbnailUrl() : String
      {
         var _loc1_:String = null;
         var _loc2_:UtilHashArray = Util.getFlashVar();
         _loc1_ = _loc2_.getValueByKey(ServerConstants.FLASHVAR_THUMBNAIL) as String;
         var _loc3_:String = "http://";
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         else if(_loc1_.length <= _loc3_.length || _loc1_.substr(0,_loc3_.length) != _loc3_)
         {
            _loc1_ = (_loc2_.getValueByKey(ServerConstants.FLASHVAR_APISERVER) as String) + _loc1_;
         }
         return _loc1_;
      }
   }
}
