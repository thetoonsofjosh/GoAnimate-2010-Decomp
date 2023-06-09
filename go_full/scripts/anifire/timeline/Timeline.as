package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.event.ExtraDataEvent;
   import anifire.skin.TimeLineSceneLabel;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUnitConvert;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ScrollEvent;
   import mx.styles.*;
   
   public class Timeline extends Canvas implements IBindingClient
   {
      
      public static const SCENE:String = "scene";
      
      public static const BITMAP:String = "bitmap";
      
      public static const BBAR:String = "bbar";
      
      public static const BLANK:String = "blank";
      
      public static const SOUND:String = "sound";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _totalSceneCount:Number = 0;
      
      mx_internal var _bindings:Array;
      
      private var _bbarContainer:anifire.timeline.ITimelineContainer = null;
      
      private var _soundNameCount:Number = 0;
      
      private var _2123936921dummy_cs:Canvas;
      
      private var _soundElements:Array;
      
      private const SCENECONTAINER_HEIGHT:int = 52;
      
      private const BBARCONTAINER_HEIGHT:int = 25;
      
      private var _1742658090sound_hb:HBox;
      
      private var _2141670186container_vb:VBox;
      
      private var _soundMoverArray:Array;
      
      private var _targetUI:UIComponent;
      
      private const SCENE_IMAGE_WIDTH:Number = 76.5;
      
      private var _soundContainer:ArrayCollection;
      
      private var numOfCaptureScreen:Number = 0;
      
      private var _1336746749_maskCanvas:Canvas;
      
      private var _currBgStartIndex:Number = 0;
      
      private const MAX_SOUND_TRACK:Number = 4;
      
      private var _totalSoundCount:Number = 0;
      
      private var _sceneContainer:anifire.timeline.ITimelineContainer = null;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _captureRect:Rectangle = null;
      
      private var _362247270_timelineScrollbar:anifire.timeline.TimelineHScrollBar;
      
      private var _1361347256sb_canvas:Canvas;
      
      private var _1742657952sound_cs:Canvas;
      
      private var _currSoundContainer:anifire.timeline.SoundContainer = null;
      
      private const SCENE_IMAGE_HEIGHT:Number = 51;
      
      private var _1454985665_verticalGap:Number = 2;
      
      private var _soundTesterArray:UtilHashArray;
      
      private var _currSoundStartIndex:Number = 0;
      
      private var _onDragSceneInfo:anifire.timeline.ElementInfo;
      
      private const SOUNDCONTAINER_HEIGHT:int = 18;
      
      private var _1893604106background_bg:anifire.timeline.BackgroundGrid;
      
      mx_internal var _watchers:Array;
      
      private const HSCROLLBAR_HEIGHT:int = 22;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _320222918bbar_vb:VBox;
      
      private var _775487681scene_vb:VBox;
      
      private var _currSoundIndex:Number = -1;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function Timeline()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "height":187,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":anifire.timeline.BackgroundGrid,
                     "id":"background_bg",
                     "stylesFactory":function():void
                     {
                        this.left = "72";
                        this.right = "0";
                        this.top = "0";
                        this.bottom = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":548,
                           "height":64
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "id":"container_vb",
                     "stylesFactory":function():void
                     {
                        this.left = "0";
                        this.right = "0";
                        this.top = "0";
                        this.bottom = "0";
                        this.verticalGap = 0;
                        this.cornerRadius = 15;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "styleName":"sceneContainer",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "id":"scene_vb",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "height":52,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "id":"sound_hb",
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off",
                                    "styleName":"soundContainer",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"dummy_cs",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":72,
                                             "percentHeight":100
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"sound_cs",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "clipContent":true,
                                             "horizontalScrollPolicy":"off"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"bbar_vb",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"sb_canvas",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "visible":false,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":anifire.timeline.TimelineHScrollBar,
                                       "id":"_timelineScrollbar",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "y":0,
                                             "x":72,
                                             "percentWidth":100
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.left = "0";
                        this.borderStyle = "solid";
                        this.borderSkin = TimeLineSceneLabel;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":72,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "alpha":0,
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this._soundElements = new Array();
         this._soundContainer = new ArrayCollection(this._soundElements);
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.height = 187;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___Timeline_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Timeline._watcherSetupUtil = param1;
      }
      
      public function onSceneResize(param1:SceneElement, param2:Number) : void
      {
         var _loc10_:int = 0;
         var _loc11_:anifire.timeline.ElementInfo = null;
         var _loc12_:Number = NaN;
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:Number = param2 - this._onDragSceneInfo.totalPixel;
         _loc4_ = Math.round(_loc4_ / 5) * 5;
         param2 = this._onDragSceneInfo.totalPixel + _loc4_;
         var _loc5_:Number = -1;
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         var _loc8_:UtilHashArray = this._soundTesterArray;
         _loc7_ = 0;
         while(_loc7_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc7_) as anifire.timeline.SoundContainer;
            _loc3_.tempSoundInfo2 = this.getSoundInfoByIndex(_loc7_);
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _loc3_ = _loc8_.getValueByIndex(_loc7_) as anifire.timeline.SoundContainer;
            if(_loc3_.tempSoundInfo.startPixel >= this._onDragSceneInfo.startPixel + this._onDragSceneInfo.totalPixel)
            {
               _loc3_.moveStartTime(_loc4_);
               Console.getConsole().updateSoundById(_loc3_.id);
               _loc6_.push({
                  "action":"move",
                  "container":_loc3_,
                  "para":_loc4_
               });
               _loc3_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc3_));
            }
            _loc7_++;
         }
         if(_loc4_ < 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc8_.length)
            {
               _loc3_ = _loc8_.getValueByIndex(_loc7_) as anifire.timeline.SoundContainer;
               if((_loc5_ = this.checkSoundOverlapOnMove(_loc3_,2)) != -1)
               {
                  break;
               }
               _loc7_++;
            }
         }
         var _loc9_:SceneContainer = null;
         if(_loc5_ == -1)
         {
            param1.width = param2;
            (_loc9_ = SceneContainer(this._sceneContainer)).itemList_hb.graphics.clear();
            _loc9_.itemList_hb.graphics.lineStyle(2,16763904);
            _loc9_.itemList_hb.graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
            SceneElement(param1).showIndicator();
            _loc10_ = this._sceneContainer.getCurrIndex();
            _loc11_ = this.getSceneInfoByIndex(_loc10_);
            _loc12_ = param2;
            this.background_bg.setCeilWidth(_loc10_,_loc12_);
            dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE,_loc10_,_loc11_.id));
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_].action == "move")
               {
                  _loc3_ = _loc6_[_loc7_].container;
                  _loc3_.stime = _loc3_.tempSoundInfo2.startPixel;
                  Console.getConsole().updateSoundById(_loc3_.id);
                  _loc3_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc3_));
               }
               _loc7_++;
            }
         }
      }
      
      public function getSceneLocalPositionIndex(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = Number(_loc2_[_loc3_].x);
            if(param1 < _loc4_)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return _loc3_ - 1;
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,param1.index,param1.id));
      }
      
      private function getSpaceInRow(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc8_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc4_:anifire.timeline.SoundContainer = null;
         var _loc5_:Number = 0;
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < this._soundContainer.length)
         {
            if((_loc4_ = this._soundContainer.getItemAt(_loc7_) as anifire.timeline.SoundContainer).y == param1)
            {
               _loc6_.push({
                  "time":_loc4_.time,
                  "length":_loc4_.length
               });
               _loc5_++;
            }
            _loc7_++;
         }
         var _loc9_:Number = 0;
         var _loc10_:Number = -1;
         var _loc11_:Array = new Array();
         _loc8_ = param2;
         while(_loc8_ < param3)
         {
            _loc12_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_].time <= _loc8_ && _loc8_ <= _loc6_[_loc7_].time + _loc6_[_loc7_].length + 5)
               {
                  _loc12_ = true;
               }
               _loc7_++;
            }
            if(!_loc12_)
            {
               if(_loc9_ == 0)
               {
                  _loc10_ = _loc8_;
               }
               _loc9_++;
            }
            else
            {
               if(_loc10_ != -1)
               {
                  _loc11_.push({
                     "x":_loc10_,
                     "width":_loc9_
                  });
               }
               _loc10_ = -1;
               _loc9_ = 0;
            }
            if(_loc8_ == param3 - 1 && !_loc12_ && _loc10_ != -1)
            {
               _loc11_.push({
                  "x":_loc10_,
                  "width":_loc9_
               });
            }
            _loc8_++;
         }
         if(_loc11_.length > 0)
         {
            _loc11_.sortOn("width",Array.NUMERIC | Array.DESCENDING);
            if(_loc11_[0].width >= 21)
            {
               return _loc11_[0].x;
            }
         }
         if(_loc5_ == 0)
         {
            return 0;
         }
         return -1;
      }
      
      public function set _maskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1336746749_maskCanvas;
         if(_loc2_ !== param1)
         {
            this._1336746749_maskCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvas",_loc2_,param1));
         }
      }
      
      public function get currBgStartIndex() : Number
      {
         return this._currBgStartIndex;
      }
      
      public function updateSceneLength(param1:Number = 100, param2:int = -1, param3:Boolean = false) : void
      {
         var _loc4_:anifire.timeline.ElementInfo = null;
         if(param2 < 0)
         {
            param2 = this._sceneContainer.getCurrIndex();
         }
         if(param3)
         {
            if((_loc4_ = this.getSceneInfoByIndex(param2)).totalPixel > param1)
            {
               this.shortTimeline(_loc4_.totalPixel - param1,_loc4_.startPixel + _loc4_.totalPixel);
            }
            else
            {
               this.moveSoundAfterAddScene(param1 - _loc4_.totalPixel,_loc4_.startPixel + _loc4_.totalPixel);
            }
         }
         this._sceneContainer.changeProperty(param2,"width",param1);
         this.background_bg.setCeilWidth(param2,param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvas() : Canvas
      {
         return this._1336746749_maskCanvas;
      }
      
      public function getSceneWidthByIndex(param1:int = -1) : Number
      {
         return this.background_bg.getCeilWidth(param1);
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         if(param1)
         {
            this._maskCanvas.visible = true;
         }
         else
         {
            this._maskCanvas.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get background_bg() : anifire.timeline.BackgroundGrid
      {
         return this._1893604106background_bg;
      }
      
      public function removeSceneMotionTimeByIndex(param1:int = -1) : void
      {
         SceneContainer(this._sceneContainer).removeSceneMotionTimeByIndex(param1);
      }
      
      public function getSoundInfoById(param1:String) : anifire.timeline.ElementInfo
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:anifire.timeline.SoundContainer = null;
         trace("_soundContainer.length:" + this._soundContainer.length);
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as anifire.timeline.SoundContainer;
            trace("container.id:" + _loc2_.id + "," + param1);
            if(_loc2_.id == param1)
            {
               param1 = _loc2_ == null ? "" : _loc2_.id;
               _loc4_ = _loc2_ == null ? -1 : int(_loc2_.time);
               _loc5_ = _loc2_ == null ? -1 : int(_loc2_.length);
               _loc6_ = _loc2_ == null ? 0 : Number(_loc2_.y);
               _loc7_ = _loc2_ == null ? 1 : _loc2_.inner_volume;
               return new anifire.timeline.ElementInfo(anifire.timeline.ElementInfo.SOUND,param1,_loc4_,_loc5_,_loc6_,_loc7_);
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getSoundInfoByIndex(param1:int = -1) : anifire.timeline.ElementInfo
      {
         var _loc2_:anifire.timeline.SoundContainer = null;
         if(param1 < 0)
         {
            param1 = this._currSoundIndex;
         }
         if(param1 >= 0 && param1 < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(param1) as anifire.timeline.SoundContainer;
         }
         var _loc3_:String = _loc2_ == null ? "" : _loc2_.id;
         var _loc4_:int = _loc2_ == null ? -1 : int(_loc2_.time);
         var _loc5_:int = _loc2_ == null ? -1 : int(_loc2_.length);
         var _loc6_:Number = _loc2_ == null ? 0 : Number(_loc2_.y);
         var _loc7_:Number = _loc2_ == null ? 1 : _loc2_.inner_volume;
         return new anifire.timeline.ElementInfo(anifire.timeline.ElementInfo.SOUND,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function prevScene() : void
      {
         --this._currBgStartIndex;
         if(this._currBgStartIndex <= 0)
         {
            this._currBgStartIndex = 0;
         }
         this.gotoSceneAt(this._currBgStartIndex);
      }
      
      public function removeAllSounds() : void
      {
         this._timelineScrollbar.removeSoundBar(null,true);
         this._totalSoundCount = 0;
         this.sound_cs.removeAllChildren();
         this._soundContainer.removeAll();
         this.sound_cs.setStyle("top",0);
         this.removeBottombar();
         this.updateTimelineSize();
      }
      
      [Bindable(event="propertyChange")]
      public function get dummy_cs() : Canvas
      {
         return this._2123936921dummy_cs;
      }
      
      public function set background_bg(param1:anifire.timeline.BackgroundGrid) : void
      {
         var _loc2_:Object = this._1893604106background_bg;
         if(_loc2_ !== param1)
         {
            this._1893604106background_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"background_bg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get container_vb() : VBox
      {
         return this._2141670186container_vb;
      }
      
      private function onSceneResizeHandler(param1:TimelineEvent) : void
      {
      }
      
      public function addSoundAtTime(param1:String, param2:String = null, param3:Number = 0, param4:Number = 0, param5:Number = 100, param6:int = -1, param7:Boolean = false, param8:Boolean = false, param9:Number = -1, param10:Number = 1) : void
      {
         ++this._totalSoundCount;
         ++this._soundNameCount;
         param2 = param2 == null ? param1 : param2;
         var _loc11_:anifire.timeline.SoundContainer;
         (_loc11_ = this.addContainer(SOUND,param6) as anifire.timeline.SoundContainer).soundReady = param7;
         _loc11_.id = param1;
         _loc11_.label = param2;
         _loc11_.stime = param3;
         _loc11_.y = param4;
         _loc11_.inner_volume = param10;
         var _loc12_:Number;
         if((_loc12_ = this.getNextSoundOnSameTrack(param4,param3)) != 99999 && !param8)
         {
            if(param9 == -1 || _loc12_ < UtilUnitConvert.secToPixel(param9 / 1000))
            {
               _loc11_.slength = _loc12_;
            }
            else
            {
               _loc11_.slength = UtilUnitConvert.secToPixel(param9 / 1000);
            }
         }
         else
         {
            _loc11_.slength = param5;
         }
         _loc11_.setTimelineReferer(this);
         this.selectSoundContainer(_loc11_);
         this.gotoLastSound();
      }
      
      public function getAllSceneInfo() : Array
      {
         var _loc2_:SceneElement = null;
         var _loc4_:anifire.timeline.ElementInfo = null;
         var _loc1_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.count)
         {
            _loc2_ = SceneElement(this._sceneContainer.getItemAt(_loc3_));
            _loc4_ = new anifire.timeline.ElementInfo(anifire.timeline.ElementInfo.SCENE,_loc2_.id,_loc2_.startTime,_loc2_.totalTime);
            _loc1_.push(_loc4_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function onSceneResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._sceneContainer.getCurrIndex();
         var _loc3_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:Number = _loc3_.actionPixel;
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START,_loc2_));
         this._onDragSceneInfo = _loc3_;
         var _loc5_:anifire.timeline.SoundContainer = null;
         var _loc6_:int = 0;
         while(_loc6_ < this._soundContainer.length)
         {
            (_loc5_ = this._soundContainer.getItemAt(_loc6_) as anifire.timeline.SoundContainer).tempSoundInfo = this.getSoundInfoByIndex(_loc6_);
            _loc6_++;
         }
         var _loc7_:Object = this.captureTesterAndMover();
         this._soundTesterArray = _loc7_["checker"];
         this._soundMoverArray = _loc7_["mover"];
         _loc6_ = 0;
         while(_loc6_ < this._soundMoverArray.length)
         {
            (_loc5_ = this._soundMoverArray[_loc6_] as anifire.timeline.SoundContainer).alpha = 0.5;
            _loc6_++;
         }
      }
      
      public function getAllSoundInfo() : Array
      {
         var _loc3_:anifire.timeline.ElementInfo = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._soundContainer.length)
         {
            _loc3_ = this.getSoundInfoByIndex(_loc2_);
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function updateSoundContainerSize() : void
      {
         this.sound_cs.height = 20 * 4 - 2;
      }
      
      public function updateSceneImageByBitmapData(param1:int = -1, param2:BitmapData = null) : void
      {
         var update:Boolean = false;
         var index:int = param1;
         var bitmapData:BitmapData = param2;
         try
         {
            if(index < 0)
            {
               index = this._sceneContainer.getCurrIndex();
            }
            update = false;
            if(this.getSceneImageBitmapByIndex(index) != null)
            {
               if(this.getSceneImageBitmapByIndex(index).compare(bitmapData) != 0)
               {
                  update = true;
               }
            }
            else
            {
               update = true;
            }
            if(update)
            {
               this._sceneContainer.changeProperty(index,"source",bitmapData);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function getTotalTimeInSec() : Number
      {
         return UtilUnitConvert.pixelToSec(this.getTotalTimeInPixel());
      }
      
      private function onSoundClickHandler(param1:TimelineEvent) : void
      {
         var _loc2_:anifire.timeline.SoundContainer = param1.currentTarget as anifire.timeline.SoundContainer;
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_CLICK,param1.index,param1.id,_loc2_));
      }
      
      [Bindable(event="propertyChange")]
      public function get bbar_vb() : VBox
      {
         return this._320222918bbar_vb;
      }
      
      public function setAllSoundInfo(param1:Array) : void
      {
         var _loc2_:anifire.timeline.ElementInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = ElementInfo(param1[_loc3_]);
            this.setSoundInfoById(_loc2_.id,_loc2_.startPixel,_loc2_.totalPixel,null,_loc2_.y,_loc2_.inner_volume);
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_vb() : VBox
      {
         return this._775487681scene_vb;
      }
      
      public function set sound_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1742657952sound_cs;
         if(_loc2_ !== param1)
         {
            this._1742657952sound_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sound_cs",_loc2_,param1));
         }
      }
      
      public function checkSoundOverlapByIndex(param1:Number, param2:int = 5) : Number
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:anifire.timeline.SoundContainer = null;
         _loc3_ = this._soundContainer.getItemAt(param1) as anifire.timeline.SoundContainer;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc4_ = this._soundContainer.getItemAt(_loc5_) as anifire.timeline.SoundContainer;
            if(_loc3_.x > _loc4_.x && _loc3_.y == _loc4_.y && _loc4_ != _loc3_)
            {
               if(_loc3_.x - param2 < _loc4_.x + _loc4_.length)
               {
                  return _loc5_;
               }
            }
            _loc5_++;
         }
         return -1;
      }
      
      [Bindable(event="propertyChange")]
      public function get sound_hb() : HBox
      {
         return this._1742658090sound_hb;
      }
      
      private function updateTimelineSize() : void
      {
         var _loc1_:Number = 0;
         if(this._soundContainer.length < this.MAX_SOUND_TRACK + 1)
         {
            this.updateSoundContainerSize();
         }
         _loc1_ = Number(this._sceneContainer.height);
         if(this.sb_canvas.visible)
         {
            _loc1_ += 22;
         }
         _loc1_ += this.sound_cs.height;
         if(this._bbarContainer != null)
         {
            _loc1_ += this._bbarContainer.height + this._verticalGap;
         }
         height = _loc1_ + 6;
      }
      
      public function removeAllScenes() : void
      {
         this._totalSceneCount = 0;
         this._sceneContainer.removeAllItems();
         var _loc1_:Number = Number(this._soundContainer.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._soundContainer[_loc2_].setHorizontalView(0);
            _loc2_++;
         }
         this.background_bg.setWidthCollect(this.getAllSceneWidth());
         this.background_bg.redraw();
      }
      
      private function onSceneMouseUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:Number = this._sceneContainer.getCurrIndex();
         var _loc3_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(_loc2_);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP,_loc2_,_loc3_.id));
      }
      
      public function moveSoundAfterAddScene(param1:Number, param2:Number) : void
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc4_) as anifire.timeline.SoundContainer;
            _loc3_.tempSoundInfo = this.getSoundInfoByIndex(_loc4_);
            if(_loc3_.x >= param2)
            {
               _loc3_.moveStartTime(param1);
               Console.getConsole().updateSoundById(_loc3_.id);
            }
            _loc4_++;
         }
      }
      
      private function nextScene() : void
      {
         ++this._currBgStartIndex;
         this.gotoSceneAt(this._currBgStartIndex);
      }
      
      public function set container_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._2141670186container_vb;
         if(_loc2_ !== param1)
         {
            this._2141670186container_vb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"container_vb",_loc2_,param1));
         }
      }
      
      public function removeSoundById(param1:String) : void
      {
         var _loc2_:anifire.timeline.SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as anifire.timeline.SoundContainer;
            if(_loc2_.id == param1)
            {
               this.removeSound(_loc3_);
               return;
            }
            _loc3_++;
         }
      }
      
      public function doPatchSceneResizeComplete(param1:int) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE,param1));
      }
      
      public function getNextSoundOnSameTrack(param1:Number, param2:Number) : Number
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:Number = 99999 + UtilUnitConvert.secToPixel(0.1);
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc5_) as anifire.timeline.SoundContainer;
            if(_loc3_.y == param1 && _loc3_.x > param2)
            {
               _loc4_ = Math.min(_loc4_,_loc3_.x - param2);
            }
            _loc5_++;
         }
         return _loc4_ - UtilUnitConvert.secToPixel(0.1);
      }
      
      public function getSceneLocalPositionByIndex(param1:Number) : Number
      {
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         return _loc2_[param1].x;
      }
      
      public function getAllSceneWidth() : Array
      {
         var _loc2_:ITimelineElement = null;
         var _loc1_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.count)
         {
            _loc2_ = this._sceneContainer.getItemAt(_loc3_);
            _loc1_.push(_loc2_.width);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function removeScene(param1:int = -1) : void
      {
         var _loc2_:int = 0;
         if(param1 < 0)
         {
            _loc2_ = this._sceneContainer.getCurrIndex();
         }
         else
         {
            _loc2_ = param1;
         }
         var _loc3_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(_loc2_);
         this.shortTimeline(_loc3_.totalPixel,_loc3_.startPixel + _loc3_.totalPixel);
         if(this._sceneContainer.removeItem(param1))
         {
            this.updateAllScenesLabel();
            --this._totalSceneCount;
            this.background_bg.setWidthCollect(this.getAllSceneWidth());
            this.background_bg.redraw();
         }
      }
      
      private function updateBottomBarButtons() : void
      {
         var _loc1_:BottomBarContainer = null;
         if(this._bbarContainer != null)
         {
            _loc1_ = BottomBarContainer(this._bbarContainer);
            if(this._currSoundIndex <= 0)
            {
               _loc1_.toggleButton(0,false);
            }
            else
            {
               _loc1_.toggleButton(0,true);
            }
            if(this._currSoundIndex >= this._soundContainer.length - 1)
            {
               _loc1_.toggleButton(1,false);
            }
            else
            {
               _loc1_.toggleButton(1,true);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sb_canvas() : Canvas
      {
         return this._1361347256sb_canvas;
      }
      
      public function addScene(param1:String, param2:String = "bitmap", param3:Number = 0) : void
      {
         if(param3 == -1)
         {
            AnimeConstants.SCENE_LENGTH_DEFAULT;
         }
         var _loc4_:SceneElement;
         (_loc4_ = new SceneElement()).id = param1;
         _loc4_.label = String(++this._totalSceneCount);
         _loc4_.width = param3;
         var _loc5_:int;
         if((_loc5_ = this._sceneContainer.getCurrIndex()) >= 0)
         {
            this._sceneContainer.addItemAt(_loc4_,_loc5_ + 1);
            this.updateAllScenesLabel();
         }
         else
         {
            this._sceneContainer.addItem(_loc4_);
         }
         this.background_bg.setWidthCollect(this.getAllSceneWidth());
         this.background_bg.redraw();
      }
      
      public function getTotalTimeInPixel() : Number
      {
         var _loc1_:Array = this.getAllSceneInfo();
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ += ElementInfo(_loc1_[_loc3_]).totalPixel;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getSceneImageBitmapByIndex(param1:int) : BitmapData
      {
         return SceneElement(this._sceneContainer.getItemAt(param1)).source;
      }
      
      private function selectSoundContainer(param1:anifire.timeline.SoundContainer) : void
      {
         var _loc2_:Boolean = param1.focus;
         if(!_loc2_)
         {
            this.resetSoundContainerFocus();
            param1.focus = true;
            this._currSoundIndex = this._soundContainer.getItemIndex(param1);
            this._currSoundContainer = param1;
         }
      }
      
      private function onSoundResizeHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,param1.index,param1.id));
      }
      
      public function getSceneInfoByIndex(param1:int = -1) : anifire.timeline.ElementInfo
      {
         if(param1 < 0)
         {
            param1 = this._sceneContainer.getCurrIndex();
         }
         var _loc2_:SceneElement = SceneElement(this._sceneContainer.getItemAt(param1));
         var _loc3_:Number = _loc2_ == null ? -1 : _loc2_.startTime;
         var _loc4_:Number = _loc2_ == null ? -1 : _loc2_.actionTime;
         return new anifire.timeline.ElementInfo(anifire.timeline.ElementInfo.SCENE,"",_loc3_,_loc4_);
      }
      
      public function checkSoundOverlap() : Boolean
      {
         var _loc4_:int = 0;
         var _loc1_:anifire.timeline.SoundContainer = null;
         var _loc2_:anifire.timeline.SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc1_ = this._soundContainer.getItemAt(_loc3_) as anifire.timeline.SoundContainer;
            _loc4_ = _loc3_ + 1;
            while(_loc4_ < this._soundContainer.length)
            {
               _loc2_ = this._soundContainer.getItemAt(_loc4_) as anifire.timeline.SoundContainer;
               if(_loc1_.soundItem._bg.hitTestObject(_loc2_.soundItem._bg))
               {
                  return true;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getSoundIndexById(param1:String) : int
      {
         var _loc2_:anifire.timeline.SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as anifire.timeline.SoundContainer;
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function setSceneTarget(param1:UIComponent, param2:Rectangle = null) : void
      {
         this._captureRect = param2;
         this._targetUI = param1;
      }
      
      public function addSceneMotionTimeByIndex(param1:int = -1) : void
      {
         SceneContainer(this._sceneContainer).addSceneMotionTimeByIndex(param1);
      }
      
      public function ___Timeline_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function getSceneLocalPosition(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = Number(_loc2_[_loc3_].x);
            if(param1 < _loc4_)
            {
               return _loc2_[_loc3_ - 1].x;
            }
            _loc3_++;
         }
         return _loc2_[_loc3_ - 1].x;
      }
      
      public function getNumOfSoundStartAtScene(param1:Number) : int
      {
         var _loc5_:anifire.timeline.SoundContainer = null;
         var _loc2_:Number = this.getSceneInfoByIndex(param1).startPixel;
         var _loc3_:Number = _loc2_ + this.getSceneInfoByIndex(param1).totalPixel - 1;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this._soundContainer.length)
         {
            if((_loc5_ = this._soundContainer.getItemAt(_loc6_) as anifire.timeline.SoundContainer).x >= _loc2_ && _loc5_.x <= _loc3_)
            {
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function set sound_hb(param1:HBox) : void
      {
         var _loc2_:Object = this._1742658090sound_hb;
         if(_loc2_ !== param1)
         {
            this._1742658090sound_hb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sound_hb",_loc2_,param1));
         }
      }
      
      public function set _verticalGap(param1:Number) : void
      {
         var _loc2_:Object = this._1454985665_verticalGap;
         if(_loc2_ !== param1)
         {
            this._1454985665_verticalGap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_verticalGap",_loc2_,param1));
         }
      }
      
      public function set scene_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._775487681scene_vb;
         if(_loc2_ !== param1)
         {
            this._775487681scene_vb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_vb",_loc2_,param1));
         }
      }
      
      public function doPatchSceneResizeStart(param1:int) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START,param1));
      }
      
      private function getBitmapData(param1:UIComponent) : BitmapData
      {
         var bd:BitmapData = null;
         var m:Matrix = null;
         var target:UIComponent = param1;
         try
         {
            bd = new BitmapData(target.width,target.height);
            m = new Matrix();
            bd.draw(target,m);
            return bd;
         }
         catch(exp:Error)
         {
            return null;
         }
      }
      
      private function showScrollBar(param1:Event) : void
      {
         if(this.sb_canvas.visible == false)
         {
            this.height += 22;
            this.sb_canvas.visible = true;
         }
      }
      
      public function setSoundInfoById(param1:String, param2:Number, param3:Number, param4:String = null, param5:Number = 0, param6:Number = 1) : void
      {
         var _loc7_:int = this.getSoundIndexById(param1);
         var _loc8_:anifire.timeline.SoundContainer;
         (_loc8_ = SoundContainer(this._soundContainer.getItemAt(_loc7_))).stime = param2;
         _loc8_.slength = param3;
         _loc8_.y = param5;
         _loc8_.inner_volume = param6;
         if(param4 != null)
         {
            _loc8_.label = param4;
         }
         _loc8_.soundItem.updateLabel(_loc8_.getLabel());
      }
      
      public function getSceneIndexById(param1:String) : int
      {
         var _loc2_:SceneContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.length)
         {
            _loc2_ = this._sceneContainer.getItemAt(_loc3_) as SceneContainer;
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Timeline = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Timeline_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_TimelineWatcherSetupUtil");
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
      
      private function onBBarClickHandler(param1:TimelineEvent) : void
      {
         switch(param1.type)
         {
            case TimelineEvent.PREV_CLICK:
               this.prevSound();
               dispatchEvent(new TimelineEvent(TimelineEvent.PREV_CLICK));
               break;
            case TimelineEvent.NEXT_CLICK:
               this.nextSound();
               dispatchEvent(new TimelineEvent(TimelineEvent.NEXT_CLICK));
         }
         this.updateBottomBarButtons();
      }
      
      [Bindable(event="propertyChange")]
      public function get _timelineScrollbar() : anifire.timeline.TimelineHScrollBar
      {
         return this._362247270_timelineScrollbar;
      }
      
      public function updateAllScenesLabel() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._sceneContainer.length)
         {
            this._sceneContainer.changeProperty(_loc1_,"label",_loc1_ + 1);
            _loc1_++;
         }
      }
      
      private function _Timeline_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,this.width,200);
         },function(param1:Rectangle):void
         {
            container_vb.scrollRect = param1;
         },"container_vb.scrollRect");
         result[0] = binding;
         return result;
      }
      
      private function prevSound() : void
      {
         --this._currSoundIndex;
         if(this._currSoundIndex <= 0)
         {
            this._currSoundIndex = 0;
         }
         this.resetSoundContainerFocus();
         this._currSoundContainer = this._soundContainer.getItemAt(this._currSoundIndex) as anifire.timeline.SoundContainer;
         this._currSoundContainer.focus = true;
         if(this._currSoundIndex <= this._currSoundStartIndex)
         {
            --this._currSoundStartIndex;
            if(this._currSoundStartIndex <= 0)
            {
               this._currSoundStartIndex = 0;
            }
            this.gotoSoundAt(this._currSoundStartIndex);
         }
      }
      
      private function onSceneMouseDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:Number = this._sceneContainer.getCurrIndex();
         var _loc3_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(_loc2_);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_DOWN,_loc2_,_loc3_.id));
      }
      
      public function getPrevSoundOnSameTrack(param1:Number, param2:Number) : Number
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:Number = 99999 + UtilUnitConvert.secToPixel(0.1);
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc5_) as anifire.timeline.SoundContainer;
            if(_loc3_.y == param1 && _loc3_.x < param2)
            {
               _loc4_ = Math.min(_loc4_,param2 - _loc3_.x - _loc3_.width);
            }
            _loc5_++;
         }
         return _loc4_ - UtilUnitConvert.secToPixel(0.1);
      }
      
      private function onSoundUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:anifire.timeline.SoundContainer = param1.currentTarget as anifire.timeline.SoundContainer;
         var _loc3_:int = this._currSoundIndex;
         var _loc4_:String = _loc2_.id;
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_UP,_loc3_,_loc4_));
      }
      
      [Bindable(event="propertyChange")]
      public function get sound_cs() : Canvas
      {
         return this._1742657952sound_cs;
      }
      
      private function onSoundMoveHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOVE,param1.index,param1.id));
      }
      
      private function getCaptureScreen() : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Matrix = null;
         var _loc5_:Number = NaN;
         var _loc6_:BitmapData = null;
         trace("getCaptureScreen:" + this.numOfCaptureScreen++);
         var _loc1_:Boolean = false;
         if(_loc1_)
         {
            _loc3_ = this.getBitmapData(UIComponent(this._targetUI));
            _loc2_ = new BitmapData(this._captureRect.width,this._captureRect.height);
            if(_loc3_ != null)
            {
               _loc2_.copyPixels(_loc3_,new Rectangle(this._captureRect.x,this._captureRect.y,this._captureRect.width,this._captureRect.height),new Point());
               return _loc2_;
            }
            return null;
         }
         if(this._captureRect == null)
         {
            return null;
         }
         _loc2_ = new BitmapData(this._captureRect.width,this._captureRect.height);
         if(this._targetUI != null)
         {
            _loc4_ = new Matrix();
            _loc5_ = this.SCENE_IMAGE_WIDTH / this._captureRect.width;
            _loc4_.translate(-this._captureRect.x,-this._captureRect.y);
            _loc2_.draw(UIComponent(this._targetUI),_loc4_);
            _loc6_ = new BitmapData(this.SCENE_IMAGE_WIDTH,this.SCENE_IMAGE_HEIGHT);
            (_loc4_ = new Matrix()).scale(_loc5_,_loc5_);
            _loc6_.draw(_loc2_,_loc4_,null,null,null,true);
            return _loc6_;
         }
         return null;
      }
      
      private function soundLengthChangeHandler(param1:ExtraDataEvent) : void
      {
      }
      
      public function set bbar_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._320222918bbar_vb;
         if(_loc2_ !== param1)
         {
            this._320222918bbar_vb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bbar_vb",_loc2_,param1));
         }
      }
      
      public function setSoundReadyByID(param1:String) : void
      {
         var _loc2_:int = this.getSoundIndexById(param1);
         var _loc3_:anifire.timeline.SoundContainer = SoundContainer(this._soundContainer.getItemAt(_loc2_));
         _loc3_.soundReady = true;
      }
      
      private function scrollHandler(param1:ScrollEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.scene_vb.numChildren != 0)
         {
            (this.scene_vb.getChildAt(0) as SceneContainer).setHorizontalView(param1.currentTarget.scrollPosition);
            _loc2_ = Number(this._soundContainer.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._soundContainer[_loc3_].setHorizontalView(param1.currentTarget.scrollPosition);
               _loc3_++;
            }
            this.background_bg.setHorizontalView(param1.currentTarget.scrollPosition);
         }
      }
      
      private function gotoSoundAt(param1:Number) : void
      {
         var _loc2_:anifire.timeline.ITimelineContainer = this._soundContainer.getItemAt(param1) as anifire.timeline.ITimelineContainer;
         var _loc3_:Number = Number(_loc2_.y);
         if(_loc2_ != null)
         {
            this._currSoundStartIndex = param1;
            this.sound_cs.setStyle("top",-_loc3_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _verticalGap() : Number
      {
         return this._1454985665_verticalGap;
      }
      
      private function onSoundDownHandler(param1:TimelineEvent) : void
      {
         var container:anifire.timeline.SoundContainer = null;
         var index:int = 0;
         var id:String = null;
         var event:TimelineEvent = param1;
         try
         {
            container = event.currentTarget as anifire.timeline.SoundContainer;
            this.selectSoundContainer(container);
            index = this._currSoundIndex;
            id = container.id;
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_DOWN,index,id));
         }
         catch(e:Error)
         {
         }
      }
      
      private function onSceneResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:anifire.timeline.SoundContainer = null;
         var _loc2_:int = this._sceneContainer.getCurrIndex();
         var _loc3_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:Number = _loc3_.actionPixel;
         this.background_bg.setCeilWidth(_loc2_,_loc4_);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE,_loc2_));
         var _loc5_:Number = _loc3_.totalPixel - this._onDragSceneInfo.totalPixel;
         _loc6_ = 0;
         while(_loc6_ < this._soundMoverArray.length)
         {
            (_loc7_ = this._soundMoverArray[_loc6_] as anifire.timeline.SoundContainer).moveStartTime(_loc5_);
            Console.getConsole().updateSoundById(_loc7_.id);
            _loc7_.alpha = 1;
            _loc7_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc7_));
            _loc6_++;
         }
         this.background_bg.validateNow();
         this._onDragSceneInfo = null;
         this._soundTesterArray = null;
         this._soundMoverArray = null;
      }
      
      public function bringUp(param1:anifire.timeline.SoundContainer) : void
      {
         this.sound_cs.removeChild(param1);
         this.sound_cs.addChild(param1);
         this._soundContainer.removeItemAt(this._soundContainer.getItemIndex(param1));
         this._soundContainer.addItem(param1);
      }
      
      public function set dummy_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._2123936921dummy_cs;
         if(_loc2_ !== param1)
         {
            this._2123936921dummy_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dummy_cs",_loc2_,param1));
         }
      }
      
      public function setSceneVisible(param1:int) : void
      {
      }
      
      private function checkSoundOverlapOnMove(param1:anifire.timeline.SoundContainer, param2:int = 5) : Number
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc4_:anifire.timeline.SoundContainer = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            if((_loc4_ = this._soundContainer.getItemAt(_loc5_) as anifire.timeline.SoundContainer).y == param1.y && _loc4_.x < param1.x)
            {
               if(_loc3_ == null)
               {
                  _loc3_ = _loc4_;
               }
               else if(_loc4_.x > _loc3_.x)
               {
                  _loc3_ = _loc4_;
               }
            }
            _loc5_++;
         }
         if(_loc3_ != null)
         {
            if(param1.x - param2 <= _loc3_.x + _loc3_.length)
            {
               return _loc5_;
            }
         }
         else if(this.checkSoundOverlap())
         {
            return 0;
         }
         return -1;
      }
      
      public function setSoundVolumeById(param1:String, param2:Number) : void
      {
         var _loc3_:int = this.getSoundIndexById(param1);
         var _loc4_:anifire.timeline.SoundContainer;
         (_loc4_ = SoundContainer(this._soundContainer.getItemAt(_loc3_))).inner_volume = param2;
      }
      
      public function set sb_canvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1361347256sb_canvas;
         if(_loc2_ !== param1)
         {
            this._1361347256sb_canvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sb_canvas",_loc2_,param1));
         }
      }
      
      public function updateSceneImage(param1:int = -1) : void
      {
         var bitmapData:BitmapData = null;
         var update:Boolean = false;
         var index:int = param1;
         try
         {
            bitmapData = this.getCaptureScreen();
            if(index < 0)
            {
               index = this._sceneContainer.getCurrIndex();
            }
            update = false;
            if(this.getSceneImageBitmapByIndex(index) != null)
            {
               if(this.getSceneImageBitmapByIndex(index).compare(bitmapData) != 0)
               {
                  update = true;
               }
            }
            else
            {
               update = true;
            }
            if(update)
            {
               this._sceneContainer.changeProperty(index,"source",bitmapData);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function set _timelineScrollbar(param1:anifire.timeline.TimelineHScrollBar) : void
      {
         var _loc2_:Object = this._362247270_timelineScrollbar;
         if(_loc2_ !== param1)
         {
            this._362247270_timelineScrollbar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timelineScrollbar",_loc2_,param1));
         }
      }
      
      private function nextSound() : void
      {
         ++this._currSoundIndex;
         if(this._currSoundIndex >= this._soundContainer.length)
         {
            this._currSoundIndex = this._soundContainer.length - 1;
         }
         this.resetSoundContainerFocus();
         this._currSoundContainer = this._soundContainer.getItemAt(this._currSoundIndex) as anifire.timeline.SoundContainer;
         this._currSoundContainer.focus = true;
         if(this._currSoundIndex >= this._currSoundStartIndex + this.MAX_SOUND_TRACK - 1)
         {
            ++this._currSoundStartIndex;
            if(this._currSoundStartIndex >= this._soundContainer.length - this.MAX_SOUND_TRACK)
            {
               this._currSoundStartIndex = this._soundContainer.length - this.MAX_SOUND_TRACK;
            }
            this.gotoSoundAt(this._currSoundStartIndex);
         }
      }
      
      private function shortTimeline(param1:Number, param2:Number) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         trace("short Timeline:" + param1 + "," + param2);
         var _loc3_:Number = 0;
         var _loc4_:Number = 5;
         _loc8_ = 0;
         while(_loc8_ < this._soundContainer.length)
         {
            (_loc5_ = this._soundContainer.getItemAt(_loc8_) as anifire.timeline.SoundContainer).tempSoundInfo = this.getSoundInfoByIndex(_loc8_);
            _loc8_++;
         }
         do
         {
            _loc3_ += _loc4_;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = new Array();
            _loc8_ = 0;
            _loc8_ = 0;
            while(_loc8_ < this._soundContainer.length)
            {
               (_loc5_ = this._soundContainer.getItemAt(_loc8_) as anifire.timeline.SoundContainer).tempSoundInfo2 = this.getSoundInfoByIndex(_loc8_);
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < this._soundContainer.length)
            {
               _loc5_ = this._soundContainer.getItemAt(_loc8_) as anifire.timeline.SoundContainer;
               _loc10_ = -1;
               if(_loc5_.tempSoundInfo.startPixel >= param2)
               {
                  _loc5_.stime = _loc5_.x - _loc4_;
                  Console.getConsole().updateSoundById(_loc5_.id);
                  _loc7_.push({
                     "action":"move",
                     "container":_loc5_,
                     "para":_loc4_
                  });
                  if((_loc10_ = this.checkSoundOverlapByIndex(_loc8_,2)) != -1)
                  {
                     _loc6_ = this._soundContainer.getItemAt(_loc10_) as anifire.timeline.SoundContainer;
                     _loc7_.push({
                        "action":"resize",
                        "container":_loc6_,
                        "para":_loc5_.x - _loc6_.x - 5
                     });
                  }
               }
               _loc8_++;
            }
            _loc9_ = true;
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               if(_loc7_[_loc8_].action == "resize")
               {
                  if(_loc7_[_loc8_].para < AnimeConstants.SOUND_LENGTH_MINIMUM)
                  {
                     _loc9_ = false;
                  }
               }
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               switch(_loc9_)
               {
                  case true:
                     if(_loc7_[_loc8_].action == "resize")
                     {
                        (_loc5_ = _loc7_[_loc8_].container).slength = _loc7_[_loc8_].para;
                        Console.getConsole().updateSoundById(_loc5_.id);
                     }
                     break;
                  case false:
                     if(_loc7_[_loc8_].action == "move")
                     {
                        _loc5_ = _loc7_[_loc8_].container;
                        _loc5_.stime = _loc5_.tempSoundInfo2.startPixel;
                        Console.getConsole().updateSoundById(_loc5_.id);
                     }
                     break;
               }
               _loc8_++;
            }
            if(_loc3_ + _loc4_ > param1)
            {
               _loc9_ = false;
            }
         }
         while(_loc3_ + _loc4_ <= param1 && _loc9_ == true);
         
      }
      
      private function addContainer(param1:String, param2:int = -1) : anifire.timeline.ITimelineContainer
      {
         var _loc3_:anifire.timeline.ITimelineContainer = null;
         switch(param1)
         {
            case SCENE:
               _loc3_ = new SceneContainer();
               _loc3_.name = SCENE;
               _loc3_.label = "Scene";
               _loc3_.percentWidth = 100;
               _loc3_.scaleX = 1;
               _loc3_.height = this.SCENECONTAINER_HEIGHT;
               this._sceneContainer = _loc3_;
               this.scene_vb.addChild(_loc3_ as DisplayObject);
               break;
            case SOUND:
               _loc3_ = new anifire.timeline.SoundContainer();
               _loc3_.name = "SOUND_" + this._soundNameCount;
               _loc3_.label = "Sound";
               _loc3_.percentWidth = 100;
               _loc3_.height = this.SOUNDCONTAINER_HEIGHT;
               this._soundContainer.addItem(_loc3_);
               this.sound_cs.addChild(_loc3_ as DisplayObject);
               this._timelineScrollbar.addContainerToScrollBar(_loc3_ as anifire.timeline.SoundContainer);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOUSE_DOWN,this.onSoundDownHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundUpHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_CLICK,this.onSoundClickHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE_START,this.onSoundResizeStartHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE,this.onSoundResizeHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE_COMPLETE,this.onSoundResizeCompleteHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOVE,this.onSoundMoveHandler);
               break;
            case BBAR:
               _loc3_ = new BottomBarContainer();
               _loc3_.name = "BottomBar";
               _loc3_.percentWidth = 100;
               _loc3_.height = this.BBARCONTAINER_HEIGHT;
               this._bbarContainer = _loc3_;
               this.bbar_vb.addChild(_loc3_ as DisplayObject);
               _loc3_.addEventListener(TimelineEvent.NEXT_CLICK,this.onBBarClickHandler);
               _loc3_.addEventListener(TimelineEvent.PREV_CLICK,this.onBBarClickHandler);
               this.updateBottomBarButtons();
         }
         this.updateTimelineSize();
         return _loc3_;
      }
      
      private function hideScrollBar(param1:Event) : void
      {
         if(this.sb_canvas.visible == true)
         {
            this.height -= 22;
            this.sb_canvas.visible = false;
         }
      }
      
      private function _Timeline_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = new Rectangle(0,0,this.width,200);
      }
      
      public function setCurrentSceneByIndex(param1:int) : void
      {
         var _loc2_:SceneContainer = this._sceneContainer as SceneContainer;
         if(_loc2_ != null)
         {
            _loc2_.setCurrentItemByIndex(param1);
         }
      }
      
      public function getEarliestSoundSpace(param1:Number) : Point
      {
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Point = null;
         var _loc9_:* = undefined;
         var _loc2_:anifire.timeline.ElementInfo = this.getSceneInfoByIndex(param1);
         var _loc4_:Number = _loc2_.startPixel;
         var _loc5_:Number = _loc2_.startPixel + _loc2_.actionPixel;
         var _loc6_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.MAX_SOUND_TRACK)
         {
            _loc7_ = _loc3_ * (this.SOUNDCONTAINER_HEIGHT + this._verticalGap);
            _loc6_.push({
               "x":this.getSpaceInRow(_loc7_,_loc4_,_loc5_),
               "y":_loc7_
            });
            _loc3_++;
         }
         _loc6_.sortOn(["x","y"],[Array.NUMERIC]);
         do
         {
            if(_loc6_.length >= 1)
            {
               _loc9_ = _loc6_.shift();
               _loc8_ = new Point(_loc9_.x,_loc9_.y);
            }
            else
            {
               _loc8_ = new Point(-999,0);
            }
         }
         while(_loc8_.x == -1);
         
         return _loc8_;
      }
      
      public function removeSound(param1:int = -1) : void
      {
         if(this._currSoundContainer != null)
         {
            if(param1 < 0 || param1 >= this._soundContainer.length)
            {
               param1 = int(this._soundContainer.getItemIndex(this._currSoundContainer));
            }
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_REMOVED,param1,this._currSoundContainer.id));
            this._timelineScrollbar.removeSoundBar(this._currSoundContainer.name);
            this._soundContainer.removeItemAt(param1);
            this.sound_cs.removeChild(this.sound_cs.getChildAt(param1));
            this._totalSoundCount = this._soundContainer.length;
            if(this._soundContainer.length <= 0)
            {
               this._currSoundContainer = null;
            }
         }
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,param1.index,param1.id));
      }
      
      public function getSceneContainerByIndex(param1:int) : SceneContainer
      {
         return this.scene_vb.getChildAt(param1) as SceneContainer;
      }
      
      private function removeBottombar() : void
      {
         this.bbar_vb.removeAllChildren();
         this._bbarContainer = null;
      }
      
      private function resetSoundContainerFocus() : void
      {
         var _loc3_:anifire.timeline.SoundContainer = null;
         var _loc1_:Number = Number(this._soundContainer.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.sound_cs.getChildAt(_loc2_) as anifire.timeline.SoundContainer;
            _loc3_.focus = false;
            _loc2_++;
         }
      }
      
      private function initApp() : void
      {
         this._timelineScrollbar.addEventListener("SCROLL_VISIBLE",this.showScrollBar);
         this._timelineScrollbar.addEventListener("SCROLL_INVISIBLE",this.hideScrollBar);
         this._timelineScrollbar.initBgGrid(this.background_bg);
         this._sceneContainer = this.addContainer(SCENE);
         this._timelineScrollbar.addContainerToScrollBar(this._sceneContainer as SceneContainer);
         this._sceneContainer.disableFocus();
         this._sceneContainer.setTimelineReferer(this);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_MOUSE_DOWN,this.onSceneMouseDownHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_MOUSE_UP,this.onSceneMouseUpHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_RESIZE_START,this.onSceneResizeStartHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_RESIZE_COMPLETE,this.onSceneResizeCompleteHandler);
      }
      
      public function allSoundsSetFocus(param1:Boolean) : void
      {
         var _loc2_:anifire.timeline.SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as anifire.timeline.SoundContainer;
            if(param1)
            {
               _loc2_.enableFocus();
            }
            else
            {
               _loc2_.disableFocus();
            }
            _loc3_++;
         }
      }
      
      private function gotoSceneAt(param1:Number) : void
      {
         var _loc2_:Number = Number(this._soundContainer.length);
         this._sceneContainer.setHorizontalView(this.background_bg.getHorizontalView(param1));
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._soundContainer[_loc3_].setHorizontalView(this.background_bg.getHorizontalView(param1));
            _loc3_++;
         }
         this.background_bg.setHorizontalView(this.background_bg.getHorizontalView(param1));
         this._currBgStartIndex = param1;
      }
      
      private function gotoLastSound() : void
      {
         this._currSoundIndex = this._soundContainer.length - 1;
         if(this._soundContainer.length >= this.MAX_SOUND_TRACK)
         {
            this._currSoundStartIndex = this._soundContainer.length - this.MAX_SOUND_TRACK;
            this.gotoSoundAt(this._currSoundStartIndex);
         }
         this.updateBottomBarButtons();
      }
      
      private function captureTesterAndMover() : Object
      {
         var _loc2_:anifire.timeline.SoundContainer = null;
         var _loc6_:anifire.timeline.SoundContainer = null;
         var _loc1_:int = 0;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:Array = new Array();
         var _loc5_:Number = this._onDragSceneInfo.startPixel + this._onDragSceneInfo.totalPixel;
         _loc1_ = 0;
         while(_loc1_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc1_) as anifire.timeline.SoundContainer;
            if(_loc2_.tempSoundInfo.startPixel >= _loc5_)
            {
               if((_loc6_ = _loc3_.getValueByKey(String(_loc2_.tempSoundInfo.y))) == null || _loc6_.tempSoundInfo.startPixel > _loc2_.tempSoundInfo.startPixel)
               {
                  _loc3_.push(String(_loc2_.tempSoundInfo.y),_loc2_);
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc1_) as anifire.timeline.SoundContainer;
            if(_loc2_.tempSoundInfo.startPixel >= _loc5_)
            {
               if(!_loc3_.containsValue(_loc2_))
               {
                  _loc4_.push(_loc2_);
               }
            }
            _loc1_++;
         }
         return {
            "checker":_loc3_,
            "mover":_loc4_
         };
      }
   }
}
