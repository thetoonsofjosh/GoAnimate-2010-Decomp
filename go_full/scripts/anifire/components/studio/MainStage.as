package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.components.containers.GoAlert;
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUser;
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
   import mx.containers.HBox;
   import mx.containers.Panel;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.VRule;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.Pause;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class MainStage extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1282133823fadeIn:Fade;
      
      private var _1960351742_btnDelScene:Button;
      
      public var _MainStage_Button1:Button;
      
      public var _MainStage_Button2:Button;
      
      public var _MainStage_Button3:Button;
      
      private var _1253879787_vrFirst:VRule;
      
      private var _1068264244moveId:Move;
      
      public var _MainStage_Label3:Label;
      
      private var _2046797976_lookInToolBar:Canvas;
      
      private var _1091436750fadeOut:Fade;
      
      private var _11548545buttonBar:HBox;
      
      private var _1731020110_btnCopy:IconTextButton;
      
      private var _1570224285_txtAutoSave:Label;
      
      private var _784383908_stageViewStack:ViewStack;
      
      private var _607259319_maskCanvasScene:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1243553213moveOut:Move;
      
      private var _targetUploadType_in_importer:String;
      
      private var _106440182pause:Pause;
      
      private var _2048733181_dashBorder:Canvas;
      
      private var _2110424330_btnPaste:IconTextButton;
      
      private var _1819944037_cnvOffStage:Canvas;
      
      private var _1730485215_btnUndo:IconTextButton;
      
      mx_internal var _watchers:Array;
      
      private var _572770409_labelScene:Label;
      
      private var _518700219_cnvTheaterShadow:Panel;
      
      private var _89648856_btnAddScene:Button;
      
      private var _1730971321_btnEdit:Button;
      
      private var _sceneIndexStr:String;
      
      private var _246888748_efAutoSave:Sequence;
      
      private var _1478358778_addSceneEffContainer:Canvas;
      
      private var _501891183_labelSceneNum:Label;
      
      private var _1730583237_btnRedo:IconTextButton;
      
      private var _1664615877_cnvTheater:Canvas;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1730334960_btnZoom:Button;
      
      private var _895512220_uiLblUpload:Canvas;
      
      private var _1146462423_maskCanvasSceneButtton:Canvas;
      
      private var _766521513_uiCanvasAutoSave:Canvas;
      
      private var _344164871_btnImportVideo:Button;
      
      mx_internal var _bindings:Array;
      
      private var _1338722904_btnDelete:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function MainStage()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":646,
                  "height":454,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Panel,
                     "id":"_cnvTheaterShadow",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":643,
                           "height":454,
                           "layout":"absolute",
                           "styleName":"pnlTheaterShadow"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_cnvTheater",
                     "events":{"creationComplete":"___cnvTheater_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":643,
                           "height":454,
                           "styleName":"canvasTheater",
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "clipContent":true,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":ViewStack,
                              "id":"_stageViewStack",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":0,
                                    "width":643,
                                    "height":402
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_cnvOffStage",
                     "events":{"creationComplete":"___cnvOffStage_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"canvasTheater",
                           "x":0,
                           "y":0,
                           "width":646,
                           "height":454,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "mouseChildren":false,
                           "mouseEnabled":false,
                           "mouseFocusEnabled":true,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_dashBorder"
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"canvasTheater",
                           "x":0,
                           "y":0,
                           "width":646,
                           "height":454,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"_labelScene",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":342,
                                    "y":418,
                                    "styleName":"textColoring"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_labelSceneNum",
                              "stylesFactory":function():void
                              {
                                 this.textDecoration = "underline";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":440,
                                    "y":418,
                                    "styleName":"textColoring"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_uiLblUpload",
                              "events":{"creationComplete":"___uiLblUpload_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":21,
                                    "y":420,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off",
                                    "width":313,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":HBox,
                                       "stylesFactory":function():void
                                       {
                                          this.verticalAlign = "bottom";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":0,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_MainStage_Label3",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 14;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"mouseChildren":false};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_MainStage_Button1",
                                                "events":{"click":"___MainStage_Button1_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "height":22,
                                                      "width":29,
                                                      "styleName":"btnImportImage",
                                                      "focusEnabled":false,
                                                      "useHandCursor":true,
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_MainStage_Button2",
                                                "events":{"click":"___MainStage_Button2_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "height":24,
                                                      "width":22,
                                                      "styleName":"btnImportSound",
                                                      "focusEnabled":false,
                                                      "useHandCursor":true,
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_MainStage_Button3",
                                                "events":{"click":"___MainStage_Button3_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"btnImportChar",
                                                      "focusEnabled":false,
                                                      "useHandCursor":true,
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnImportVideo",
                                                "events":{"click":"___btnImportVideo_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "height":26,
                                                      "width":35,
                                                      "styleName":"btnImportMovie",
                                                      "focusEnabled":false,
                                                      "useHandCursor":true,
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]
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
                     "id":"_lookInToolBar",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":47,
                           "y":5,
                           "width":116,
                           "height":37,
                           "styleName":"controlButtonBar",
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnDelete",
                              "events":{"click":"___btnDelete_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":80,
                                    "y":5,
                                    "width":28,
                                    "height":28,
                                    "styleName":"btnDelete",
                                    "focusEnabled":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnEdit",
                              "events":{"click":"___btnEdit_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":8,
                                    "y":5,
                                    "width":28,
                                    "height":28,
                                    "styleName":"btnEdit",
                                    "focusEnabled":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnZoom",
                              "events":{"click":"___btnZoom_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":44,
                                    "y":5,
                                    "width":28,
                                    "height":28,
                                    "styleName":"btnZoomOut",
                                    "focusEnabled":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_addSceneEffContainer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":643,
                           "height":402,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnAddScene",
                     "events":{"click":"___btnAddScene_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnAddScene",
                           "x":527,
                           "y":404,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnDelScene",
                     "events":{"click":"___btnDelScene_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnDelScene",
                           "x":577,
                           "y":404,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "id":"buttonBar",
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 7;
                        this.horizontalAlign = "center";
                        this.verticalAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":-40,
                           "width":298,
                           "scaleX":0.85,
                           "scaleY":0.85,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":IconTextButton,
                              "id":"_btnCopy",
                              "events":{"mouseUp":"___btnCopy_mouseUp"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnCopy",
                                    "buttonMode":true,
                                    "labelPlacement":"bottom"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":IconTextButton,
                              "id":"_btnPaste",
                              "events":{"mouseUp":"___btnPaste_mouseUp"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnPaste",
                                    "buttonMode":true,
                                    "labelPlacement":"bottom"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VRule,
                                       "id":"_vrFirst",
                                       "stylesFactory":function():void
                                       {
                                          this.top = "10";
                                          this.bottom = "10";
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":IconTextButton,
                              "id":"_btnUndo",
                              "events":{"click":"___btnUndo_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnUndo",
                                    "buttonMode":true,
                                    "labelPlacement":"bottom"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":IconTextButton,
                              "id":"_btnRedo",
                              "events":{"click":"___btnRedo_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnRedo",
                                    "buttonMode":true,
                                    "labelPlacement":"bottom"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvasSceneButtton",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":543,
                           "y":417,
                           "width":200,
                           "height":200,
                           "alpha":0,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvasScene",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":646,
                           "height":454,
                           "alpha":0,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_uiCanvasAutoSave",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16306601;
                        this.cornerRadius = 4;
                        this.borderStyle = "solid";
                        this.borderColor = 16306601;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":127,
                           "height":20,
                           "x":423,
                           "y":-20,
                           "alpha":0,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"_txtAutoSave",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.color = 10920608;
                                 this.textAlign = "center";
                                 this.fontSize = 12;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":3,
                                    "y":0
                                 };
                              }
                           })]
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
         this.width = 646;
         this.height = 454;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this._MainStage_Sequence1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MainStage._watcherSetupUtil = param1;
      }
      
      public function set _btnImportVideo(param1:Button) : void
      {
         var _loc2_:Object = this._344164871_btnImportVideo;
         if(_loc2_ !== param1)
         {
            this._344164871_btnImportVideo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnImportVideo",_loc2_,param1));
         }
      }
      
      private function refreshUploadShortCut(param1:Event) : void
      {
         var _loc2_:UIComponent = UIComponent(param1.currentTarget);
         if(!UtilLicense.isUploadRelatedButtonShouldBeShown())
         {
            _loc2_.visible = false;
         }
         if(!UtilUser.isBeta())
         {
            this._btnImportVideo.visible = false;
         }
      }
      
      public function set _btnPaste(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2110424330_btnPaste;
         if(_loc2_ !== param1)
         {
            this._2110424330_btnPaste = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPaste",_loc2_,param1));
         }
      }
      
      public function set buttonBar(param1:HBox) : void
      {
         var _loc2_:Object = this._11548545buttonBar;
         if(_loc2_ !== param1)
         {
            this._11548545buttonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lookInToolBar() : Canvas
      {
         return this._2046797976_lookInToolBar;
      }
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         Console.getConsole().deleteAsset(param1);
      }
      
      private function _MainStage_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = UtilDict.toDisplay("go","mainstage_displaying");
         _loc1_ = UtilDict.toDisplay("go","mainstage_scene") + " " + this.sceneIndexStr;
         _loc1_ = UtilDict.toDisplay("go","mainstage_import");
         _loc1_ = UtilDict.toDisplay("go","mainstage_images");
         _loc1_ = UtilDict.toDisplay("go","mainstage_sound");
         _loc1_ = UtilDict.toDisplay("go","mainstage_char");
         _loc1_ = UtilDict.toDisplay("go","mainstage_video");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_delete");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_edit");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
         _loc1_ = UtilDict.toDisplay("go","mainstage_addscene");
         _loc1_ = UtilDict.toDisplay("go","mainstage_delscene");
         _loc1_ = AnimeConstants.SCREEN_X;
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_copy");
         _loc1_ = UtilDict.toDisplay("go","Copy");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_paste");
         _loc1_ = UtilDict.toDisplay("go","Paste");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_undo");
         _loc1_ = UtilDict.toDisplay("go","Undo");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_redo");
         _loc1_ = UtilDict.toDisplay("go","Redo");
         _loc1_ = UtilDict.toDisplay("go","mainstage_autosavedone");
      }
      
      public function setLoadingStatus(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1)
            {
               this._maskCanvasScene.visible = true;
            }
            else
            {
               this._maskCanvasScene.visible = false;
            }
         }
         else if(param1)
         {
            this._maskCanvasSceneButtton.visible = true;
         }
         else
         {
            this._maskCanvasSceneButtton.visible = false;
         }
      }
      
      public function enableUndo(param1:Boolean) : void
      {
         this._btnUndo.enabled = param1;
      }
      
      public function set pause(param1:Pause) : void
      {
         var _loc2_:Object = this._106440182pause;
         if(_loc2_ !== param1)
         {
            this._106440182pause = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pause",_loc2_,param1));
         }
      }
      
      public function set _addSceneEffContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1478358778_addSceneEffContainer;
         if(_loc2_ !== param1)
         {
            this._1478358778_addSceneEffContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_addSceneEffContainer",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnZoom() : Button
      {
         return this._1730334960_btnZoom;
      }
      
      [Bindable(event="propertyChange")]
      public function get pause() : Pause
      {
         return this._106440182pause;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vrFirst() : VRule
      {
         return this._1253879787_vrFirst;
      }
      
      public function set _btnZoom(param1:Button) : void
      {
         var _loc2_:Object = this._1730334960_btnZoom;
         if(_loc2_ !== param1)
         {
            this._1730334960_btnZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnZoom",_loc2_,param1));
         }
      }
      
      public function enableRedo(param1:Boolean) : void
      {
         this._btnRedo.enabled = param1;
      }
      
      private function initialStage() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _dashBorder() : Canvas
      {
         return this._2048733181_dashBorder;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelScene() : Button
      {
         return this._1960351742_btnDelScene;
      }
      
      public function set _labelScene(param1:Label) : void
      {
         var _loc2_:Object = this._572770409_labelScene;
         if(_loc2_ !== param1)
         {
            this._572770409_labelScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelScene",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddScene() : Button
      {
         return this._89648856_btnAddScene;
      }
      
      private function _MainStage_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this.moveId = _loc1_;
         _loc1_.yFrom = -20;
         _loc1_.yTo = 2;
         _loc1_.duration = 500;
         BindingManager.executeBindings(this,"moveId",this.moveId);
         return _loc1_;
      }
      
      private function _MainStage_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            moveId.target = param1;
         },"moveId.target");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            fadeIn.target = param1;
         },"fadeIn.target");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            pause.target = param1;
         },"pause.target");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            fadeOut.target = param1;
         },"fadeOut.target");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            moveOut.target = param1;
         },"moveOut.target");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_displaying");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _labelScene.text = param1;
         },"_labelScene.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_scene") + " " + this.sceneIndexStr;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _labelSceneNum.text = param1;
         },"_labelSceneNum.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_import");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Label3.text = param1;
         },"_MainStage_Label3.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_images");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button1.toolTip = param1;
         },"_MainStage_Button1.toolTip");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_sound");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button2.toolTip = param1;
         },"_MainStage_Button2.toolTip");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_char");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button3.toolTip = param1;
         },"_MainStage_Button3.toolTip");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_video");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnImportVideo.toolTip = param1;
         },"_btnImportVideo.toolTip");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_delete");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnDelete.toolTip = param1;
         },"_btnDelete.toolTip");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_edit");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnEdit.toolTip = param1;
         },"_btnEdit.toolTip");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnZoom.toolTip = param1;
         },"_btnZoom.toolTip");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_addscene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnAddScene.toolTip = param1;
         },"_btnAddScene.toolTip");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_delscene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnDelScene.toolTip = param1;
         },"_btnDelScene.toolTip");
         result[16] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.SCREEN_X;
         },function(param1:Number):void
         {
            buttonBar.x = param1;
         },"buttonBar.x");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCopy.toolTip = param1;
         },"_btnCopy.toolTip");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnCopy.label = param1;
         },"_btnCopy.label");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_paste");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnPaste.toolTip = param1;
         },"_btnPaste.toolTip");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Paste");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnPaste.label = param1;
         },"_btnPaste.label");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_undo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnUndo.toolTip = param1;
         },"_btnUndo.toolTip");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Undo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnUndo.label = param1;
         },"_btnUndo.label");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_redo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnRedo.toolTip = param1;
         },"_btnRedo.toolTip");
         result[24] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Redo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _btnRedo.label = param1;
         },"_btnRedo.label");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_autosavedone");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _txtAutoSave.text = param1;
         },"_txtAutoSave.text");
         result[26] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnUndo() : IconTextButton
      {
         return this._1730485215_btnUndo;
      }
      
      private function drawOffStage(param1:Number = 51) : void
      {
         this._lookInToolBar.visible = false;
         this._cnvOffStage.graphics.clear();
         this._cnvOffStage.graphics.lineStyle(StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("borderLineThickness"),StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("borderLineColor"),StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("borderLineAlpha"));
         this._cnvOffStage.graphics.drawRoundRect(0,0,this._cnvOffStage.width,this._cnvOffStage.height,10,10);
         this._cnvOffStage.graphics.lineStyle(0,0,0);
         this._cnvOffStage.graphics.beginFill(StyleManager.getStyleDeclaration(".offStageCanvasMask").getStyle("toolBarColor"),1);
         this._cnvOffStage.graphics.drawRoundRectComplex(0,-42,AnimeConstants.SCREEN_X - 5,42,0,0,0,0);
         this._cnvOffStage.graphics.drawRoundRectComplex(AnimeConstants.SCREEN_X - 5,-42,this.buttonBar.width + 10,42,10,10,0,0);
         this._cnvOffStage.graphics.drawRoundRectComplex(AnimeConstants.SCREEN_X + this.buttonBar.width + 5,-42,20,42,0,0,0,0);
         this._cnvOffStage.graphics.beginFill(StyleManager.getStyleDeclaration(".offStageCanvasMask").getStyle("color"),0.5);
         this._cnvOffStage.graphics.drawRoundRectComplex(0,0,this._cnvOffStage.width,AnimeConstants.SCREEN_Y,10,10,0,0);
         this._cnvOffStage.graphics.drawRect(0,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_X,this._cnvOffStage.height - AnimeConstants.SCREEN_Y - param1);
         this._cnvOffStage.graphics.drawRect(AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_X + 2,this._cnvOffStage.height - AnimeConstants.SCREEN_Y - param1);
         this._cnvOffStage.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT,AnimeConstants.SCREEN_WIDTH,this._cnvOffStage.height - AnimeConstants.SCREEN_Y - AnimeConstants.SCREEN_HEIGHT - param1);
         this._cnvOffStage.graphics.endFill();
         this._cnvOffStage.graphics.beginFill(StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("backdropColor"));
         this._cnvOffStage.graphics.drawRect(0,this._cnvOffStage.height - 55,this._cnvOffStage.width,param1 * 1.1);
         var _loc2_:Matrix = new Matrix();
         _loc2_.createGradientBox(this._cnvOffStage.width,param1,Math.PI / 2,0,this._cnvOffStage.height - param1);
         this._cnvOffStage.graphics.beginGradientFill(GradientType.LINEAR,StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("backgroundGradientColors"),[1,1],[0,255],_loc2_);
         this._cnvOffStage.graphics.drawRoundRectComplex(0,this._cnvOffStage.height - 55,this._cnvOffStage.width,param1,0,0,10,10);
         this._cnvOffStage.graphics.endFill();
         this._cnvOffStage.graphics.lineStyle(0,0,0);
         this._cnvOffStage.graphics.beginFill(StyleManager.getStyleDeclaration(".bottomCanvasTheater").getStyle("bgColor"));
         this._cnvOffStage.graphics.drawRoundRectComplex(0,-42,AnimeConstants.SCREEN_X - 5,42,0,0,0,10);
         this._cnvOffStage.graphics.drawRoundRectComplex(AnimeConstants.SCREEN_X + this.buttonBar.width + 5,-42,20,42,0,0,10,0);
         this._cnvOffStage.graphics.endFill();
      }
      
      private function _MainStage_Pause1_i() : Pause
      {
         var _loc1_:Pause = new Pause();
         this.pause = _loc1_;
         _loc1_.duration = 1000;
         BindingManager.executeBindings(this,"pause",this.pause);
         return _loc1_;
      }
      
      public function ___MainStage_Button2_click(param1:MouseEvent) : void
      {
         this.onLinkClick(AnimeConstants.ASSET_TYPE_SOUND);
      }
      
      public function set _txtAutoSave(param1:Label) : void
      {
         var _loc2_:Object = this._1570224285_txtAutoSave;
         if(_loc2_ !== param1)
         {
            this._1570224285_txtAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAutoSave",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _efAutoSave() : Sequence
      {
         return this._246888748_efAutoSave;
      }
      
      public function set _cnvOffStage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1819944037_cnvOffStage;
         if(_loc2_ !== param1)
         {
            this._1819944037_cnvOffStage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cnvOffStage",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEdit() : Button
      {
         return this._1730971321_btnEdit;
      }
      
      public function set _lookInToolBar(param1:Canvas) : void
      {
         var _loc2_:Object = this._2046797976_lookInToolBar;
         if(_loc2_ !== param1)
         {
            this._2046797976_lookInToolBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lookInToolBar",_loc2_,param1));
         }
      }
      
      public function set _btnUndo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730485215_btnUndo;
         if(_loc2_ !== param1)
         {
            this._1730485215_btnUndo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnUndo",_loc2_,param1));
         }
      }
      
      public function set _stageViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._784383908_stageViewStack;
         if(_loc2_ !== param1)
         {
            this._784383908_stageViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stageViewStack",_loc2_,param1));
         }
      }
      
      public function ___cnvTheater_creationComplete(param1:FlexEvent) : void
      {
         this.drawBg();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRedo() : IconTextButton
      {
         return this._1730583237_btnRedo;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cnvTheaterShadow() : Panel
      {
         return this._518700219_cnvTheaterShadow;
      }
      
      private function set _1575404715sceneIndexStr(param1:String) : void
      {
         this._sceneIndexStr = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set sceneIndexStr(param1:String) : void
      {
         var _loc2_:Object = this.sceneIndexStr;
         if(_loc2_ !== param1)
         {
            this._1575404715sceneIndexStr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneIndexStr",_loc2_,param1));
         }
      }
      
      public function set _btnAddScene(param1:Button) : void
      {
         var _loc2_:Object = this._89648856_btnAddScene;
         if(_loc2_ !== param1)
         {
            this._89648856_btnAddScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddScene",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _addSceneEffContainer() : Canvas
      {
         return this._1478358778_addSceneEffContainer;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasAutoSave() : Canvas
      {
         return this._766521513_uiCanvasAutoSave;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasScene() : Canvas
      {
         return this._607259319_maskCanvasScene;
      }
      
      public function ___btnRedo_click(param1:MouseEvent) : void
      {
         Console.getConsole().redo();
      }
      
      private function _MainStage_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeOut = _loc1_;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.duration = 1500;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      public function showAutoSaveHints() : void
      {
         if(Console.getConsole().isUserAlreadyLogin())
         {
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_autosavedone");
         }
         else
         {
            this._uiCanvasAutoSave.width = 250;
            this.pause.duration = 5000;
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_remind_to_save");
         }
         this._efAutoSave.play();
      }
      
      public function set _btnCopy(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1731020110_btnCopy;
         if(_loc2_ !== param1)
         {
            this._1731020110_btnCopy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopy",_loc2_,param1));
         }
      }
      
      public function ___btnEdit_click(param1:MouseEvent) : void
      {
         Console.getConsole().editAsset(param1);
      }
      
      public function ___MainStage_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().askUserToGoToCcCreator();
      }
      
      public function set _btnDelete(param1:Button) : void
      {
         var _loc2_:Object = this._1338722904_btnDelete;
         if(_loc2_ !== param1)
         {
            this._1338722904_btnDelete = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelete",_loc2_,param1));
         }
      }
      
      public function ___btnCopy_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().copyAsset();
      }
      
      public function get updatable() : Boolean
      {
         return this._uiLblUpload.enabled;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function ___btnZoom_click(param1:MouseEvent) : void
      {
         Console.getConsole().lookOut();
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
         }
      }
      
      public function ___cnvOffStage_creationComplete(param1:FlexEvent) : void
      {
         this.drawOffStage();
      }
      
      public function set _btnRedo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730583237_btnRedo;
         if(_loc2_ !== param1)
         {
            this._1730583237_btnRedo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRedo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelSceneNum() : Label
      {
         return this._501891183_labelSceneNum;
      }
      
      public function set moveId(param1:Move) : void
      {
         var _loc2_:Object = this._1068264244moveId;
         if(_loc2_ !== param1)
         {
            this._1068264244moveId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moveId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBar() : HBox
      {
         return this._11548545buttonBar;
      }
      
      public function get stageViewStack() : ViewStack
      {
         return this._stageViewStack;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
         }
      }
      
      public function set _vrFirst(param1:VRule) : void
      {
         var _loc2_:Object = this._1253879787_vrFirst;
         if(_loc2_ !== param1)
         {
            this._1253879787_vrFirst = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vrFirst",_loc2_,param1));
         }
      }
      
      public function set _btnEdit(param1:Button) : void
      {
         var _loc2_:Object = this._1730971321_btnEdit;
         if(_loc2_ !== param1)
         {
            this._1730971321_btnEdit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEdit",_loc2_,param1));
         }
      }
      
      private function onLinkClick(param1:String) : void
      {
         var _loc2_:GoAlert = null;
         if(Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            _loc2_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc2_._lblConfirm.text = "";
            _loc2_._txtDelete.text = "To import your own graphics, please use goanimate.com";
            _loc2_._btnDelete.visible = false;
            _loc2_._btnCancel.label = "OK";
            _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
            _loc2_.y = 100;
            return;
         }
         this._targetUploadType_in_importer = param1;
         Console.getConsole().thumbTray.showUserGoodies(param1);
         this.doShowImporterWindow();
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MainStage = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MainStage_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MainStageWatcherSetupUtil");
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
      
      public function ___btnAddScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().beforeDoAddScene();
      }
      
      public function set _maskCanvasScene(param1:Canvas) : void
      {
         var _loc2_:Object = this._607259319_maskCanvasScene;
         if(_loc2_ !== param1)
         {
            this._607259319_maskCanvasScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasScene",_loc2_,param1));
         }
      }
      
      public function changeToFullSize() : void
      {
         var _loc1_:Number = 20;
         this._uiLblUpload.y -= _loc1_;
         this._labelScene.y -= _loc1_;
         this._labelSceneNum.y -= _loc1_;
         this._btnAddScene.y -= _loc1_;
         this._btnDelScene.y -= _loc1_;
         this._cnvTheater.height -= _loc1_ + 11;
         this._cnvTheaterShadow.height -= _loc1_ + 11;
         this.height -= _loc1_ + 6;
         this._stageViewStack.scrollRect = new Rectangle(0,0,643,398);
         this._btnCopy.styleName = "btnCopyFull";
         this._btnPaste.styleName = "btnPasteFull";
         this._btnUndo.styleName = "btnUndoFull";
         this._btnRedo.styleName = "btnRedoFull";
         this.drawBg(25);
         this.drawOffStage(25);
      }
      
      public function set moveOut(param1:Move) : void
      {
         var _loc2_:Object = this._1243553213moveOut;
         if(_loc2_ !== param1)
         {
            this._1243553213moveOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moveOut",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAutoSave() : Label
      {
         return this._1570224285_txtAutoSave;
      }
      
      public function set _efAutoSave(param1:Sequence) : void
      {
         var _loc2_:Object = this._246888748_efAutoSave;
         if(_loc2_ !== param1)
         {
            this._246888748_efAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_efAutoSave",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _stageViewStack() : ViewStack
      {
         return this._784383908_stageViewStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cnvOffStage() : Canvas
      {
         return this._1819944037_cnvOffStage;
      }
      
      public function get sceneIndexStr() : String
      {
         if(this._sceneIndexStr == null)
         {
            this._sceneIndexStr = "";
         }
         return this._sceneIndexStr;
      }
      
      private function _MainStage_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeIn = _loc1_;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1500;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      public function set _maskCanvasSceneButtton(param1:Canvas) : void
      {
         var _loc2_:Object = this._1146462423_maskCanvasSceneButtton;
         if(_loc2_ !== param1)
         {
            this._1146462423_maskCanvasSceneButtton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasSceneButtton",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelete() : Button
      {
         return this._1338722904_btnDelete;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopy() : IconTextButton
      {
         return this._1731020110_btnCopy;
      }
      
      public function set _uiCanvasAutoSave(param1:Canvas) : void
      {
         var _loc2_:Object = this._766521513_uiCanvasAutoSave;
         if(_loc2_ !== param1)
         {
            this._766521513_uiCanvasAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasAutoSave",_loc2_,param1));
         }
      }
      
      public function set _cnvTheater(param1:Canvas) : void
      {
         var _loc2_:Object = this._1664615877_cnvTheater;
         if(_loc2_ !== param1)
         {
            this._1664615877_cnvTheater = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cnvTheater",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelScene() : Label
      {
         return this._572770409_labelScene;
      }
      
      public function get btnDelScene() : Button
      {
         return this._btnDelScene;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblUpload() : Canvas
      {
         return this._895512220_uiLblUpload;
      }
      
      private function _MainStage_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         this._efAutoSave = _loc1_;
         _loc1_.children = [this._MainStage_Move1_i(),this._MainStage_Fade1_i(),this._MainStage_Pause1_i(),this._MainStage_Fade2_i(),this._MainStage_Move2_i()];
         return _loc1_;
      }
      
      public function drawDashBorder(param1:Boolean = true) : void
      {
         this._dashBorder.graphics.clear();
         if(param1)
         {
            this._dashBorder.graphics.lineStyle(5);
            UtilDraw.drawDashRect(this._dashBorder,AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT,6,8);
         }
      }
      
      public function ___btnUndo_click(param1:MouseEvent) : void
      {
         Console.getConsole().undo();
      }
      
      private function drawBg(param1:Number = 51) : void
      {
         this._cnvTheater.graphics.clear();
         this._cnvTheater.graphics.beginFill(StyleManager.getStyleDeclaration(".outerCanvasTheater").getStyle("backgroundColor"));
         this._cnvTheater.graphics.drawRoundRectComplex(0,0,this._cnvTheater.width,this._cnvTheater.height,10,10,10,10);
         this._cnvTheater.graphics.beginFill(StyleManager.getStyleDeclaration(".innerCanvasTheater").getStyle("backgroundColor"));
         this._cnvTheater.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this._cnvTheater.graphics.endFill();
      }
      
      public function set _uiLblUpload(param1:Canvas) : void
      {
         var _loc2_:Object = this._895512220_uiLblUpload;
         if(_loc2_ !== param1)
         {
            this._895512220_uiLblUpload = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblUpload",_loc2_,param1));
         }
      }
      
      public function set _cnvTheaterShadow(param1:Panel) : void
      {
         var _loc2_:Object = this._518700219_cnvTheaterShadow;
         if(_loc2_ !== param1)
         {
            this._518700219_cnvTheaterShadow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cnvTheaterShadow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cnvTheater() : Canvas
      {
         return this._1664615877_cnvTheater;
      }
      
      [Bindable(event="propertyChange")]
      public function get moveOut() : Move
      {
         return this._1243553213moveOut;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasSceneButtton() : Canvas
      {
         return this._1146462423_maskCanvasSceneButtton;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function ___uiLblUpload_creationComplete(param1:FlexEvent) : void
      {
         this.refreshUploadShortCut(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get moveId() : Move
      {
         return this._1068264244moveId;
      }
      
      public function set _labelSceneNum(param1:Label) : void
      {
         var _loc2_:Object = this._501891183_labelSceneNum;
         if(_loc2_ !== param1)
         {
            this._501891183_labelSceneNum = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelSceneNum",_loc2_,param1));
         }
      }
      
      public function get btnAddScene() : Button
      {
         return this._btnAddScene;
      }
      
      public function ___btnImportVideo_click(param1:MouseEvent) : void
      {
         this.onLinkClick(AnimeConstants.ASSET_TYPE_PROP_VIDEO);
      }
      
      private function doShowImporterWindow() : void
      {
         if(Console.getConsole().thumbTray.assetTheme != ThumbTray.USER_THEME)
         {
            Console.getConsole().thumbTray.assetTheme = ThumbTray.USER_THEME;
         }
         var _loc1_:String = Console.getConsole().thumbTray.uploadType;
         Console.getConsole().showImporterWindow(this._targetUploadType_in_importer);
      }
      
      public function set updatable(param1:Boolean) : void
      {
         this._uiLblUpload.enabled = param1;
         this._uiLblUpload.mouseEnabled = param1;
         this._uiLblUpload.mouseChildren = param1;
      }
      
      public function ___btnDelScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().doDeleScene();
      }
      
      public function ___MainStage_Button1_click(param1:MouseEvent) : void
      {
         this.onLinkClick(AnimeConstants.ASSET_TYPE_PROP);
      }
      
      private function _MainStage_Move2_i() : Move
      {
         var _loc1_:Move = new Move();
         this.moveOut = _loc1_;
         _loc1_.yFrom = 2;
         _loc1_.yTo = -20;
         _loc1_.duration = 500;
         BindingManager.executeBindings(this,"moveOut",this.moveOut);
         return _loc1_;
      }
      
      public function ___btnPaste_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().pasteAsset();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnImportVideo() : Button
      {
         return this._344164871_btnImportVideo;
      }
      
      public function set _dashBorder(param1:Canvas) : void
      {
         var _loc2_:Object = this._2048733181_dashBorder;
         if(_loc2_ !== param1)
         {
            this._2048733181_dashBorder = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dashBorder",_loc2_,param1));
         }
      }
      
      private function drawSimpleBg() : void
      {
         this._cnvTheater.graphics.clear();
         this._cnvTheater.graphics.beginFill(16777215);
         this._cnvTheater.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this._cnvTheater.graphics.endFill();
      }
      
      public function set _btnDelScene(param1:Button) : void
      {
         var _loc2_:Object = this._1960351742_btnDelScene;
         if(_loc2_ !== param1)
         {
            this._1960351742_btnDelScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelScene",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPaste() : IconTextButton
      {
         return this._2110424330_btnPaste;
      }
      
      public function changeToMessageMode() : void
      {
         this._cnvTheaterShadow.visible = false;
         this._cnvOffStage.visible = false;
         this._addSceneEffContainer.visible = false;
         this._btnAddScene.visible = false;
         this._btnDelScene.visible = false;
         this._uiCanvasAutoSave.visible = false;
         this._maskCanvasScene.visible = false;
         this._maskCanvasSceneButtton.visible = false;
         this._labelScene.visible = this._labelSceneNum.visible = this._uiLblUpload.visible = false;
         this.drawSimpleBg();
      }
   }
}
