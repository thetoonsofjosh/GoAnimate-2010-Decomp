package anifire.components.studio
{
   import anifire.component.TextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.GoWalkerEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.Container;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class GoWalker extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _actionArray:Array;
      
      private const TITLE_HEIGHT:Number = 28;
      
      private var _1743398429_canvasStep:Canvas;
      
      private var _console:IEventDispatcher;
      
      private var _890356267_mainStageBg:Canvas;
      
      private var _myWalkerGuide:anifire.components.studio.WalkerGuide;
      
      private var _94436_bg:Canvas;
      
      private var _91275179_step:Canvas;
      
      private var _1833197607_tguide:Canvas;
      
      private var _1685604818_thumbTrayBg:Canvas;
      
      private var _1707923963_timelineBg:Canvas;
      
      private var _guideMode:Boolean;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _extraData:Object;
      
      private var GUIDE_ID:String;
      
      private var _99395744_canvasStepSuccess:Canvas;
      
      private var _15222500_canvasBg:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _currAction:String;
      
      private var _currStepNum:int;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _existingUser:Boolean;
      
      private var _1918763312_topButtonBarBg:Canvas;
      
      private var _411415281_ptBubble:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function GoWalker()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":954,
                  "height":629,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_bg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_timelineBg",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":470,
                                    "width":954,
                                    "height":187
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_mainStageBg",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":306,
                                    "y":42,
                                    "width":648,
                                    "height":454,
                                    "clipContent":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_thumbTrayBg",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":0,
                                    "width":314,
                                    "height":513
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_topButtonBarBg",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":598,
                                    "y":0,
                                    "width":348,
                                    "height":66
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_step",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canvasBg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":420,
                           "height":160,
                           "clipContent":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_tguide",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "clipContent":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canvasStepSuccess",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":420,
                           "height":160,
                           "clipContent":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canvasStep",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":420,
                           "height":160,
                           "clipContent":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_ptBubble",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":115,
                           "height":80,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.width = 954;
         this.height = 629;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         GoWalker._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _timelineBg() : Canvas
      {
         return this._1707923963_timelineBg;
      }
      
      public function set _timelineBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._1707923963_timelineBg;
         if(_loc2_ !== param1)
         {
            this._1707923963_timelineBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timelineBg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ptBubble() : Canvas
      {
         return this._411415281_ptBubble;
      }
      
      public function init(param1:int, param2:Boolean, param3:Boolean = false, param4:Object = null) : void
      {
         this.GUIDE_ID = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE_CC);
         this._currStepNum = param1;
         this._guideMode = param2;
         this._existingUser = param3;
         this._extraData = param4;
         this._actionArray = new Array();
         if(this._guideMode)
         {
            this.myWalkerGuide = new anifire.components.studio.WalkerGuide();
            this._tguide.addChild(this.myWalkerGuide);
            this._tguide.visible = false;
            this.preloadAllCC();
         }
      }
      
      public function set _ptBubble(param1:Canvas) : void
      {
         var _loc2_:Object = this._411415281_ptBubble;
         if(_loc2_ !== param1)
         {
            this._411415281_ptBubble = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ptBubble",_loc2_,param1));
         }
      }
      
      private function onGuideWalkComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onShowGuideComplete);
         var _loc2_:Point = new Point(200,430);
         var _loc3_:Point = new Point(850,430);
         if(this._currStepNum == 17)
         {
            this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
            this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc2_,null,2,true);
            this._currAction = "talk";
         }
         else
         {
            this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
            this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
            this._currAction = "talk";
         }
      }
      
      private function get myWalkerGuide() : anifire.components.studio.WalkerGuide
      {
         return this._myWalkerGuide;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canvasBg() : Canvas
      {
         return this._15222500_canvasBg;
      }
      
      private function fillBg(param1:Canvas) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(0,0.7);
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(param1 == this._thumbTrayBg)
         {
            _loc2_ = -8;
            _loc3_ = -43;
         }
         param1.graphics.drawRect(0,0,param1.width + _loc2_,param1.height + _loc3_);
         if(param1 == this._timelineBg && this._currStepNum == 11)
         {
            param1.graphics.drawRect(77,55,873,78);
         }
         else if(param1 == this._timelineBg && this._currStepNum == 18)
         {
            param1.graphics.drawRect(77,3,873,130);
         }
         param1.graphics.endFill();
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainStageBg() : Canvas
      {
         return this._890356267_mainStageBg;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tguide() : Canvas
      {
         return this._1833197607_tguide;
      }
      
      private function set myWalkerGuide(param1:anifire.components.studio.WalkerGuide) : void
      {
         this._myWalkerGuide = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _topButtonBarBg() : Canvas
      {
         return this._1918763312_topButtonBarBg;
      }
      
      private function onShowGuideComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onShowGuideComplete);
         setTimeout(this.stopGuideTalking,3000);
         this.showContent();
      }
      
      private function stopGuideTalking() : void
      {
         this.myWalkerGuide.load(this.GUIDE_ID,this._currAction,"head_happy",null,null,2,this.myWalkerGuide.isFlip());
      }
      
      private function preloadAllCC() : void
      {
         var _loc5_:String = null;
         var _loc6_:URLRequest = null;
         var _loc7_:UtilURLStream = null;
         var _loc1_:UtilLoadMgr = new UtilLoadMgr();
         _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.show);
         var _loc2_:Array = new Array("walk","stand","stand","talk","pt_at","pt_at","excited","talk");
         var _loc3_:Array = new Array("head_happy","head_happy","head_talk_happy","head_talk_happy","head_talk_happy","head_happy","head_happy","head_happy");
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_] + "+" + _loc3_[_loc4_];
            _loc6_ = UtilNetwork.getGetCcActionRequest(this.GUIDE_ID,_loc2_[_loc4_] + ".zip",_loc3_[_loc4_] + ".zip");
            (_loc7_ = new UtilURLStream()).name = _loc5_;
            _loc1_.addEventDispatcher(_loc7_,LoadEmbedMovieEvent.COMPLETE_EVENT);
            _loc7_.addEventListener(Event.COMPLETE,this.doLoadZipComplete);
            _loc7_.load(_loc6_);
            _loc4_++;
         }
         _loc1_.commit();
      }
      
      public function set _canvasStepSuccess(param1:Canvas) : void
      {
         var _loc2_:Object = this._99395744_canvasStepSuccess;
         if(_loc2_ !== param1)
         {
            this._99395744_canvasStepSuccess = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canvasStepSuccess",_loc2_,param1));
         }
      }
      
      public function set _canvasBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._15222500_canvasBg;
         if(_loc2_ !== param1)
         {
            this._15222500_canvasBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canvasBg",_loc2_,param1));
         }
      }
      
      public function set _mainStageBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._890356267_mainStageBg;
         if(_loc2_ !== param1)
         {
            this._890356267_mainStageBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainStageBg",_loc2_,param1));
         }
      }
      
      public function set _step(param1:Canvas) : void
      {
         var _loc2_:Object = this._91275179_step;
         if(_loc2_ !== param1)
         {
            this._91275179_step = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step",_loc2_,param1));
         }
      }
      
      public function set _topButtonBarBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._1918763312_topButtonBarBg;
         if(_loc2_ !== param1)
         {
            this._1918763312_topButtonBarBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_topButtonBarBg",_loc2_,param1));
         }
      }
      
      private function doFinishGuideMode(param1:Event) : void
      {
         ExternalInterface.call("grayOut(false)");
         this.kill();
         this._guideMode = false;
      }
      
      private function kill() : void
      {
         this._canvasStep.removeAllChildren();
         this._tguide.removeAllChildren();
         this._canvasBg.removeAllChildren();
         this._canvasStep.graphics.clear();
         this._bg.graphics.clear();
         this._thumbTrayBg.graphics.clear();
         this._topButtonBarBg.graphics.clear();
         this._timelineBg.graphics.clear();
         this._mainStageBg.graphics.clear();
         this._step.graphics.clear();
         this._canvasBg.graphics.clear();
      }
      
      private function goNextStep(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.goNextStep);
         if(this._currStepNum != 3 && this._currStepNum != 16 && param1 is MouseEvent)
         {
            this.dispatchEvent(new GoWalkerEvent(GoWalkerEvent.EVENT_NEXT_STEP,this));
         }
         this._canvasStep.visible = this._canvasStepSuccess.visible = false;
         ++this._currStepNum;
         this.show();
      }
      
      private function prepareContent(param1:Canvas, param2:Canvas) : void
      {
         var _loc10_:Button = null;
         var _loc11_:TextButton = null;
         var _loc12_:Canvas = null;
         var _loc13_:Label = null;
         var _loc14_:ViewStack = null;
         var _loc15_:Canvas = null;
         param1.graphics.clear();
         param1.removeAllChildren();
         param2.graphics.clear();
         param2.removeAllChildren();
         var _loc3_:Label = new Label();
         _loc3_.y = 17;
         var _loc4_:Text = new Text();
         var _loc5_:TextButton;
         (_loc5_ = new TextButton()).enabled = true;
         _loc5_.visible = true;
         var _loc6_:Canvas = new Canvas();
         var _loc7_:Label;
         (_loc7_ = new Label()).text = UtilDict.toDisplay("go","GREAT JOB!");
         _loc7_.styleName = "guideBold";
         _loc7_.x = 40;
         _loc7_.y = 20;
         _loc6_.addChild(_loc7_);
         this._ptBubble.visible = false;
         switch(this._currStepNum)
         {
            case 0:
               if(this._existingUser)
               {
                  _loc3_.text = UtilDict.toDisplay("go","Tutorial");
                  _loc4_.text = UtilDict.toDisplay("go","Follow our step-by-step animation basics tutorial and earn 30 GoPoints");
                  _loc5_.label = UtilDict.toDisplay("go","Start Tutorial");
                  _loc5_.y = 198;
                  _loc5_.x = 18;
                  _loc5_.clickFunc = this.goNextStep;
               }
               else
               {
                  _loc3_.text = UtilDict.toDisplay("go","Welcome to GoAnimate Animation Studio");
                  _loc4_.text = UtilDict.toDisplay("go","We see it\'s your first time here. We prepared a short 2 minutes tutorial to introduce our animation studio.\n\nFollow it and you will be animating your first masterpiece in no time!");
                  _loc5_.label = UtilDict.toDisplay("go","Start Tutorial");
                  _loc5_.clickFunc = this.goNextStep;
               }
               break;
            case 1:
               _loc3_.text = UtilDict.toDisplay("go","This is the theme selection screen");
               _loc4_.text = UtilDict.toDisplay("go","The theme you select will specify which characters are available for your animation by default. But don\'t worry, most themes can be mixed together.");
               break;
            case 2:
               this._console.addEventListener(GoWalkerEvent.EVENT_CHARACTER_ADDED,this.goNextStep);
            case 3:
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 1: Characters");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Drag your first character to the stage.</b> Each character comes with a set of actions, movements and facial expressions. You can also drag props on them for further customization.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 2 ? false : true;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 4:
               this._console.addEventListener(GoWalkerEvent.EVENT_CHARACTER_ACTION_CHANGED,this.goNextStep);
            case 5:
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 2: Actions");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Click on your character and select an action.</b> Combine actions and facial expressions to create new ones. Use the movement option to make your character move within a scene.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 4 ? false : true;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 6:
            case 7:
            case 8:
               if(this._currStepNum == 6)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_THUMBTRAY_BG_CLICKED,this.goNextStep);
               }
               else if(this._currStepNum == 7)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_BG_ADDED,this.goNextStep);
               }
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 3: Backgrounds");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Select a new background for your scene.</b> Many backgrounds include layers, allowing you to move objects and characters behind one another.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 8 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 9:
            case 10:
            case 11:
               if(this._currStepNum == 9)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_THUMBTRAY_SOUND_CLICKED,this.goNextStep);
               }
               else if(this._currStepNum == 10)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_SOUND_ADDED,this.goNextStep);
               }
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 4: Sound");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Add sound to your animation.</b> See how the sound is added to the timeline. You can click on it to shorten / increase its length and modify its volume.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 11 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 12:
            case 13:
            case 14:
               if(this._currStepNum == 12)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_THUMBTRAY_BUBBLE_CLICKED,this.goNextStep);
               }
               else if(this._currStepNum == 13)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_BUBBLE_ADDED,this.goNextStep);
               }
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 5: Speech Bubbles (1/2)");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Drag a speech bubble to create dialogs.</b> Speech bubbles are the easiest way to build dialogs and narration in your animations.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 14 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 15:
            case 16:
               if(this._currStepNum == 15)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_BUBBLE_EDITED,this.goNextStep);
               }
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 6: Speech Bubbles (2/2)");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Enter text and adjust speech bubble tail.</b> You can type any text in the speech bubble and customize colors, fonts as well as move the tail to fit your character\'s position.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 16 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 17:
            case 18:
               if(this._currStepNum == 17)
               {
                  this._console.addEventListener(GoWalkerEvent.EVENT_SCENE_ADDED,this.goNextStep);
               }
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 7: Scenes");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Add a new scene.</b> See how the new scene appears in the timeline below. You can add as many scenes as you want to");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 18 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 19:
               this._console.addEventListener(GoWalkerEvent.EVENT_PREVIEW_CLICKED,this.goNextStep);
               _loc3_.text = UtilDict.toDisplay("go","Tutorial step 8: Preview");
               _loc4_.htmlText = UtilDict.toDisplay("go","<b>Preview your animation.</b> You can preview your animation at any time while creating your animation.");
               _loc5_.label = UtilDict.toDisplay("go","Next") + " >";
               _loc5_.visible = this._currStepNum == 20 ? true : false;
               _loc5_.clickFunc = this.goNextStep;
               break;
            case 20:
               _loc3_.text = UtilDict.toDisplay("go","That\'s it.");
               _loc4_.text = UtilDict.toDisplay("go","This concludes our introduction tutorial.\n\nMake sure to check our tutorial videos for more tips.");
               _loc4_.setStyle("textAlign","center");
               (_loc10_ = new Button()).enabled = true;
               _loc10_.visible = true;
               _loc10_.buttonMode = true;
               _loc10_.label = UtilDict.toDisplay("go","Start animating!");
               _loc10_.y = 200;
               _loc10_.x = 144;
               _loc10_.addEventListener(MouseEvent.CLICK,this.doFinishGuideMode);
               _loc10_.styleName = "btnWhite";
               _loc10_.setStyle("fontSize",16);
               param1.addChild(_loc10_);
               (_loc11_ = new TextButton()).label = UtilDict.toDisplay("go","Go to visit our tutorial videos page now!");
               _loc11_.clickFunc = this.popTutorialPage;
               _loc11_.percentWidth = 100;
               _loc11_.txtAlign = "center";
               _loc11_.y = 145;
               param1.addChild(_loc11_);
         }
         param1.graphics.beginFill(15658734);
         param1.graphics.drawRoundRect(0,0,param1.width,param1.height,20,20);
         if(this._currStepNum == 17 || this._currStepNum == 18 || this._currStepNum == 19)
         {
            this.addArrow(param1,"tl");
         }
         else if(this._currStepNum != 20)
         {
            this.addArrow(param1,"tr");
         }
         param1.graphics.endFill();
         param2.graphics.beginFill(15658734);
         param2.graphics.drawRoundRect(0,0,param2.width,param2.height,20,20);
         if(this._currStepNum == 17 || this._currStepNum == 18 || this._currStepNum == 19)
         {
            this.addArrow(param2,"tl");
         }
         else if(this._currStepNum != 20)
         {
            this.addArrow(param2,"tr");
         }
         param2.graphics.endFill();
         if(this._existingUser && this._currStepNum == 0 || this._currStepNum == 20)
         {
         }
         if(this._existingUser && this._currStepNum == 0)
         {
            _loc12_ = new Canvas();
            _loc12_.width = _loc12_.height = 60;
            _loc12_.styleName = "imgStickerNew";
            _loc12_.x = param1.width - 30;
            _loc12_.y = -30;
            _loc12_.clipContent = false;
            param1.addChild(_loc12_);
            param1.clipContent = false;
         }
         if(_loc3_.text != "")
         {
            if(this._existingUser && this._currStepNum == 0)
            {
               _loc3_.percentWidth = 100;
               _loc3_.styleName = "guideTitle";
               _loc3_.setStyle("textAlign","left");
               _loc3_.x = 30;
               (_loc13_ = new Label()).percentWidth = 100;
               _loc13_.styleName = "guideRemark";
               _loc13_.x = 30;
               _loc13_.text = UtilDict.toDisplay("go","Just takes 2 minutes");
               _loc13_.y = _loc3_.y + this.TITLE_HEIGHT - 2;
               param1.addChild(_loc13_);
            }
            else
            {
               _loc3_.percentWidth = 100;
               _loc3_.styleName = "guideTitle";
            }
            param1.addChild(_loc3_);
         }
         if(_loc4_.text != "")
         {
            _loc4_.percentWidth = 100;
            _loc4_.selectable = false;
            _loc4_.styleName = "guideContent";
            _loc4_.y = _loc3_.y + this.TITLE_HEIGHT + 20;
            if(this._existingUser && this._currStepNum == 0)
            {
               _loc4_.y += 10;
            }
            param1.addChild(_loc4_);
         }
         if(_loc5_.label != "")
         {
            _loc14_ = new ViewStack();
            _loc14_.percentWidth = _loc14_.percentHeight = 100;
            _loc5_.width = 150;
            _loc5_.txtSize = 22;
            _loc5_.x = 65;
            _loc5_.y = 20;
            _loc15_ = new Canvas();
            _loc15_.percentHeight = _loc15_.percentWidth = 100;
            _loc15_.horizontalScrollPolicy = "off";
            _loc15_.addChild(_loc5_);
            _loc14_.addChild(_loc15_);
            if(Boolean(_loc5_.visible) && (this._currStepNum != 20 && this._currStepNum != 0))
            {
               _loc14_.addChild(_loc6_);
               this._ptBubble.styleName = "";
               this._ptBubble.styleName = "earnGoPoint";
               this._ptBubble.visible = true;
               this.addGoPoint(this._currStepNum);
               _loc14_.selectedChild = _loc6_;
               setTimeout(this.swapVS,3000,_loc14_,_loc15_);
            }
            param2.addChild(_loc14_);
         }
         var _loc8_:GlowFilter = new GlowFilter(3355443,1,8,8);
         var _loc9_:Array;
         (_loc9_ = new Array()).push(_loc8_);
         param1.filters = _loc9_.concat();
         param2.filters = _loc9_.concat();
      }
      
      private function followMouse() : void
      {
         this._ptBubble.x = this.mouseX;
         this._ptBubble.y = this.mouseY;
      }
      
      public function set _tguide(param1:Canvas) : void
      {
         var _loc2_:Object = this._1833197607_tguide;
         if(_loc2_ !== param1)
         {
            this._1833197607_tguide = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tguide",_loc2_,param1));
         }
      }
      
      private function drawHighlightArea(param1:Container, param2:Rectangle) : void
      {
         param1.graphics.clear();
         param1.graphics.lineStyle(4,16742400);
         param1.graphics.drawRect(param2.x,param2.y,param2.width,param2.height);
      }
      
      private function fillMainstageBg(param1:Canvas, param2:Rectangle = null) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(0,0.7);
         param1.graphics.drawRect(0,-44,param1.width,param1.height + 44 - 26);
         if(param2 != null)
         {
            param1.graphics.drawRect(param2.x,param2.y,param2.width,param2.height);
         }
         else
         {
            param1.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         }
         param1.graphics.endFill();
      }
      
      public function get currStepNum() : int
      {
         return this._currStepNum;
      }
      
      private function _GoWalker_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,954,603);
         },function(param1:Rectangle):void
         {
            _tguide.scrollRect = param1;
         },"_tguide.scrollRect");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return _canvasStepSuccess.x - _ptBubble.width / 2;
         },function(param1:Number):void
         {
            _ptBubble.x = param1;
         },"_ptBubble.x");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return _canvasStepSuccess.y - _ptBubble.height / 2;
         },function(param1:Number):void
         {
            _ptBubble.y = param1;
         },"_ptBubble.y");
         result[2] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:GoWalker = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._GoWalker_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_GoWalkerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      private function swapVS(param1:ViewStack, param2:DisplayObject) : void
      {
         param1.selectedChild = param2 as Container;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canvasStepSuccess() : Canvas
      {
         return this._99395744_canvasStepSuccess;
      }
      
      public function set _thumbTrayBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._1685604818_thumbTrayBg;
         if(_loc2_ !== param1)
         {
            this._1685604818_thumbTrayBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_thumbTrayBg",_loc2_,param1));
         }
      }
      
      private function doLoadZipComplete(param1:Event) : void
      {
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         this.myWalkerGuide.addAction(_loc2_.name,_loc3_,_loc2_);
      }
      
      [Bindable(event="propertyChange")]
      public function get _step() : Canvas
      {
         return this._91275179_step;
      }
      
      private function prepareBg() : void
      {
         var _loc1_:Rectangle = null;
         this._bg.graphics.clear();
         this._thumbTrayBg.graphics.clear();
         this._topButtonBarBg.graphics.clear();
         this._timelineBg.graphics.clear();
         this._mainStageBg.graphics.clear();
         switch(this._currStepNum)
         {
            case 0:
            case 20:
               if(!(this._currStepNum == 0 && this._existingUser))
               {
                  this._bg.graphics.beginFill(0,0.7);
                  this._bg.graphics.drawRect(0,0,this.width,this.height);
                  this._bg.graphics.endFill();
               }
               break;
            case 2:
            case 3:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               if(this._extraData != null)
               {
                  _loc1_ = this._extraData["Rect"] as Rectangle;
                  this._thumbTrayBg.graphics.clear();
                  this._thumbTrayBg.graphics.beginFill(0,0.7);
                  this._thumbTrayBg.graphics.drawRect(0,0,this._thumbTrayBg.width - 8,this._thumbTrayBg.height - 43);
                  this._thumbTrayBg.graphics.drawRect(_loc1_.x - 2,_loc1_.y,_loc1_.width,_loc1_.height);
                  this._thumbTrayBg.graphics.endFill();
               }
               this.fillBg(this._timelineBg);
               this.fillMainstageBg(this._mainStageBg);
               break;
            case 4:
            case 5:
            case 15:
            case 16:
               this.fillBg(this._thumbTrayBg);
               this.fillBg(this._timelineBg);
               this.fillMainstageBg(this._mainStageBg);
               break;
            case 17:
            case 18:
               this.fillBg(this._thumbTrayBg);
               _loc1_ = new Rectangle(530,381,48,48);
               this.fillMainstageBg(this._mainStageBg,_loc1_);
               this.fillBg(this._timelineBg);
               break;
            case 19:
               this.fillBg(this._thumbTrayBg);
               _loc1_ = new Rectangle(454,-42,48,45);
               this.fillMainstageBg(this._mainStageBg,_loc1_);
               this.fillBg(this._timelineBg);
               break;
            case 20:
         }
      }
      
      public function set console(param1:IEventDispatcher) : void
      {
         this._console = param1;
      }
      
      public function get guideMode() : Boolean
      {
         return this._guideMode;
      }
      
      private function showContent() : void
      {
         trace("show:" + this._currStepNum);
         this._canvasStep.visible = this._canvasStepSuccess.visible = false;
         switch(this._currStepNum)
         {
            case 0:
               if(this._existingUser)
               {
                  this._canvasStep.width = 165;
                  this._canvasStep.height = 240;
                  this._canvasStep.y = 76;
                  this._canvasStep.x = this.width - this._canvasStep.width - 27;
                  this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               }
               else
               {
                  this._canvasStep.width = 420;
                  this._canvasStep.height = 240;
                  this._canvasStep.x = (this.width - this._canvasStep.width) / 2;
                  this._canvasStep.y = (this.height - this._canvasStep.height) / 2;
                  this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               }
               break;
            case 1:
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 100;
               this._canvasStep.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._extraData != null)
               {
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               break;
            case 2:
            case 3:
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 2)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               if(this._extraData != null)
               {
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               break;
            case 4:
            case 5:
               this._step.graphics.clear();
               this._extraData["Rect"] = new Rectangle(351,67,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 4)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               if(this._extraData != null)
               {
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               break;
            case 6:
            case 7:
            case 8:
               if(this._currStepNum == 6)
               {
                  this._extraData["Rect"] = new Rectangle(104,43,48,45);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               else if(this._currStepNum == 7 || this._currStepNum == 8)
               {
                  this._extraData["Rect"] = new Rectangle(4,88,306,380);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 6 || this._currStepNum == 7)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               break;
            case 9:
            case 10:
            case 11:
               if(this._currStepNum == 9)
               {
                  this._extraData["Rect"] = new Rectangle(204,43,48,45);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               else if(this._currStepNum == 10 || this._currStepNum == 11)
               {
                  this._extraData["Rect"] = new Rectangle(4,88,306,380);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 9 || this._currStepNum == 10)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               break;
            case 17:
            case 18:
               if(this._currStepNum == 17 || this._currStepNum == 18)
               {
                  this._extraData["Rect"] = new Rectangle(836,423,48,48);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this._canvasStep.width / 2 - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this._canvasStep.width / 2 - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 17)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               break;
            case 12:
            case 13:
            case 14:
               if(this._currStepNum == 12)
               {
                  this._extraData["Rect"] = new Rectangle(54,43,48,45);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               else if(this._currStepNum == 13 || this._currStepNum == 14)
               {
                  this._extraData["Rect"] = new Rectangle(4,88,306,380);
                  this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               }
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 12 || this._currStepNum == 13)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               break;
            case 15:
            case 16:
               this._step.graphics.clear();
               this._extraData["Rect"] = new Rectangle(351,67,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
               this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this.width - this._canvasStep.width - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this.width - this._canvasStepSuccess.width - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               if(this._currStepNum == 15)
               {
                  this._canvasStep.visible = true;
               }
               else
               {
                  this._canvasStepSuccess.visible = true;
               }
               break;
            case 19:
               this._extraData["Rect"] = new Rectangle(761,0,48,45);
               this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               this._canvasStep.width = 420;
               this._canvasStep.height = 180;
               this._canvasStep.x = this._canvasStep.width / 2 - 64;
               this._canvasStep.y = 372;
               this._canvasStepSuccess.width = 200;
               this._canvasStepSuccess.height = 80;
               this._canvasStepSuccess.x = this._canvasStep.width / 2 - 64;
               this._canvasStepSuccess.y = 372;
               this.prepareContent(this._canvasStep,this._canvasStepSuccess);
               this._canvasStep.visible = true;
               break;
            case 20:
               this._extraData["Rect"] = new Rectangle(-100,-100,1,1);
               this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               this._canvasBg.width = 420;
               this._canvasBg.height = 240;
               this._canvasBg.x = (this.width - this._canvasBg.width) / 2;
               this._canvasBg.y = (this.height - this._canvasBg.height) / 2;
               this.prepareContent(this._canvasBg,this._canvasStepSuccess);
               this._canvasBg.visible = true;
         }
         this.prepareBg();
      }
      
      public function set _canvasStep(param1:Canvas) : void
      {
         var _loc2_:Object = this._1743398429_canvasStep;
         if(_loc2_ !== param1)
         {
            this._1743398429_canvasStep = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canvasStep",_loc2_,param1));
         }
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _thumbTrayBg() : Canvas
      {
         return this._1685604818_thumbTrayBg;
      }
      
      private function addGoPoint(param1:Number) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         var _loc3_:URLRequest = UtilNetwork.addTutorialGoPoint(param1);
         _loc2_.load(_loc3_);
      }
      
      private function _GoWalker_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = new Rectangle(0,0,954,603);
         _loc1_ = this._canvasStepSuccess.x - this._ptBubble.width / 2;
         _loc1_ = this._canvasStepSuccess.y - this._ptBubble.height / 2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canvasStep() : Canvas
      {
         return this._1743398429_canvasStep;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
      }
      
      private function addArrow(param1:Canvas, param2:String) : void
      {
         var _loc3_:Number = NaN;
         if(param2 == "tr")
         {
            _loc3_ = 2 / 3;
         }
         else if(param2 == "tl")
         {
            _loc3_ = 1 / 3;
         }
         param1.graphics.moveTo(param1.width * _loc3_ - 10,0);
         param1.graphics.lineTo(param1.width * _loc3_,-10);
         param1.graphics.lineTo(param1.width * _loc3_ + 10,0);
         param1.graphics.lineTo(param1.width * _loc3_ - 10,0);
      }
      
      private function drawBubble() : void
      {
         this._ptBubble.graphics.clear();
         this._ptBubble.graphics.lineStyle(1,0);
         this._ptBubble.graphics.beginFill(16777215);
         this._ptBubble.graphics.drawEllipse(0,0,this._ptBubble.width,this._ptBubble.height);
         this._ptBubble.graphics.endFill();
      }
      
      private function show(param1:Event = null) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.show);
         }
         this._canvasStep.graphics.clear();
         this._canvasStep.removeAllChildren();
         var _loc2_:Point = new Point(1100,430);
         var _loc3_:Point = new Point(850,430);
         var _loc4_:Point = new Point(200,430);
         this._tguide.visible = true;
         switch(this._currStepNum)
         {
            case 2:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.MOVIE_FINISH_EVENT,this.onGuideWalkComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"walk","head_happy",_loc2_,_loc3_,2,false);
               this._currAction = "walk";
               break;
            case 3:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 4:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"pt_at","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "pt_at";
               break;
            case 5:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"stand","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "stand";
               break;
            case 6:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"stand","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "stand";
               break;
            case 7:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"stand","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "stand";
               break;
            case 8:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"stand","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "stand";
               break;
            case 9:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 10:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 11:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 12:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"pt_at","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "pt_at";
               break;
            case 13:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 14:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 15:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"pt_at","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "pt_at";
               break;
            case 16:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc3_,null,2,false);
               this._currAction = "talk";
               break;
            case 17:
               this._extraData["Rect"] = new Rectangle(836,423,48,48);
               this.drawHighlightArea(this._step,this._extraData["Rect"] as Rectangle);
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.MOVIE_FINISH_EVENT,this.onGuideWalkComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"walk","head_happy",_loc3_,_loc4_,2,false,0);
               this._currAction = "walk";
               break;
            case 18:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc4_,null,2,true);
               this._currAction = "talk";
               break;
            case 19:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"talk","head_talk_happy",_loc4_,null,2,true);
               this._currAction = "talk";
               break;
            case 20:
               this.myWalkerGuide.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onShowGuideComplete);
               this.myWalkerGuide.load(this.GUIDE_ID,"excited","head_happy",_loc4_,null,2,true);
               this._currAction = "excited";
         }
         this.prepareBg();
      }
      
      private function popTutorialPage(param1:Event) : void
      {
         navigateToURL(new URLRequest(ServerConstants.VIDEO_TUTOR_PATH),"_blank");
      }
   }
}
