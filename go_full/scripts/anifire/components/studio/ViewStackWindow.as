package anifire.components.studio
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.util.UtilHashArray;
   import com.adobe.ac.mxeffects.DistortionConstants;
   import com.adobe.ac.mxeffects.Flip;
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
   import mx.containers.ViewStack;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.Resize;
   import mx.effects.Zoom;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class ViewStackWindow extends ViewStack implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private const SHOW_DURATION:Number = 600;
      
      mx_internal var _watchers:Array;
      
      private var _1616519305publishExpand:Parallel;
      
      private const FLIP_DURATION:Number = 600;
      
      private var _241096279closeEffect:Parallel;
      
      private var _65508229openEffect:Parallel;
      
      private const RESIZE_DURATION:Number = 200;
      
      private var _2002618360publishShrink:Parallel;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _235365105publish:anifire.components.studio.PublishWindow;
      
      private var _318184504preview:anifire.components.studio.PreviewWindow;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ViewStackWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewStack,
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":anifire.components.studio.PreviewWindow,
                     "id":"preview",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":616,
                           "height":500
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":anifire.components.studio.PublishWindow,
                     "id":"publish",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":616,
                           "height":280
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
         this.width = 616;
         this.height = 500;
         this._ViewStackWindow_Parallel2_i();
         this._ViewStackWindow_Parallel1_i();
         this._ViewStackWindow_Parallel4_i();
         this._ViewStackWindow_Parallel3_i();
         this.addEventListener("creationComplete",this.___ViewStackWindow_ViewStack1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ViewStackWindow._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get publishExpand() : Parallel
      {
         return this._1616519305publishExpand;
      }
      
      public function initAndPreviewMovie(param1:XML, param2:UtilHashArray, param3:UtilHashArray, param4:String = "Untitled") : void
      {
         this.preview.initAndPreviewMovie(param1,param2,param3);
         this.preview.movieName = param4;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ViewStackWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ViewStackWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ViewStackWindowWatcherSetupUtil");
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
      
      public function destory() : void
      {
         this.preview.destoryMC();
         this.preview = null;
         this.publish = null;
      }
      
      public function set publishExpand(param1:Parallel) : void
      {
         var _loc2_:Object = this._1616519305publishExpand;
         if(_loc2_ !== param1)
         {
            this._1616519305publishExpand = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publishExpand",_loc2_,param1));
         }
      }
      
      private function _ViewStackWindow_Move2_c() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.yTo = 0;
         return _loc1_;
      }
      
      private function _ViewStackWindow_Zoom1_c() : Zoom
      {
         var _loc1_:Zoom = new Zoom();
         _loc1_.duration = 500;
         _loc1_.zoomHeightFrom = 0.5;
         _loc1_.zoomHeightTo = 1;
         _loc1_.zoomWidthFrom = 0.5;
         _loc1_.zoomWidthTo = 1;
         _loc1_.easingFunction = Exponential.easeOut;
         return _loc1_;
      }
      
      public function set preview(param1:anifire.components.studio.PreviewWindow) : void
      {
         var _loc2_:Object = this._318184504preview;
         if(_loc2_ !== param1)
         {
            this._318184504preview = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preview",_loc2_,param1));
         }
      }
      
      private function _ViewStackWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = [this.publish,this.preview];
         _loc1_ = this.RESIZE_DURATION;
         _loc1_ = [this.publish,this.preview];
         _loc1_ = this.RESIZE_DURATION;
      }
      
      public function flipToPublish() : void
      {
         var _loc1_:Flip = new Flip(this.preview);
         _loc1_.siblings = [this.publish];
         _loc1_.direction = DistortionConstants.RIGHT;
         _loc1_.duration = this.FLIP_DURATION;
         _loc1_.addEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect,false,0,true);
         _loc1_.play();
         this.preview.pause(true);
         var _loc2_:Rectangle = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this.publish.initPublishWindow(this.preview,Console.getConsole().tempPublished,Console.getConsole().tempPrivateShared,Console.getConsole().getThumbnailCaptures(),Console.getConsole().tempMetaData.title,Console.getConsole().tempMetaData.getUgcTagString(),Console.getConsole().tempMetaData.description,Console.getConsole().tempMetaData.lang,"< Back to preview");
         Console.getConsole().publishW = this.publish;
      }
      
      [Bindable(event="propertyChange")]
      public function get closeEffect() : Parallel
      {
         return this._241096279closeEffect;
      }
      
      private function _ViewStackWindow_Parallel2_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.closeEffect = _loc1_;
         _loc1_.children = [this._ViewStackWindow_Zoom2_c()];
         return _loc1_;
      }
      
      private function _ViewStackWindow_Parallel4_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.publishExpand = _loc1_;
         _loc1_.children = [this._ViewStackWindow_Resize2_c(),this._ViewStackWindow_Move2_c()];
         _loc1_.addEventListener("effectEnd",this.__publishExpand_effectEnd);
         BindingManager.executeBindings(this,"publishExpand",this.publishExpand);
         return _loc1_;
      }
      
      public function set publish(param1:anifire.components.studio.PublishWindow) : void
      {
         var _loc2_:Object = this._235365105publish;
         if(_loc2_ !== param1)
         {
            this._235365105publish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publish",_loc2_,param1));
         }
      }
      
      private function _ViewStackWindow_Resize2_c() : Resize
      {
         var _loc1_:Resize = new Resize();
         _loc1_.widthTo = 616;
         _loc1_.heightTo = 500;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get publish() : anifire.components.studio.PublishWindow
      {
         return this._235365105publish;
      }
      
      [Bindable(event="propertyChange")]
      public function get preview() : anifire.components.studio.PreviewWindow
      {
         return this._318184504preview;
      }
      
      public function hide() : void
      {
         PopUpManager.removePopUp(ViewStackWindow(this));
         if(Console.getConsole().currentScene != null)
         {
            Console.getConsole().currentScene.playScene();
         }
      }
      
      public function set closeEffect(param1:Parallel) : void
      {
         var _loc2_:Object = this._241096279closeEffect;
         if(_loc2_ !== param1)
         {
            this._241096279closeEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"closeEffect",_loc2_,param1));
         }
      }
      
      public function onCancelHandler(param1:Event) : void
      {
         this.preview.pause(true);
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      private function _ViewStackWindow_Move1_c() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.yTo = 80;
         return _loc1_;
      }
      
      private function onChangeHandler(param1:Event) : void
      {
         if(param1.currentTarget == this.preview)
         {
            this.flipToPublish();
         }
         else
         {
            this.publishExpand.play();
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function popupCloseEffect(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number;
         var _loc6_:Number = (_loc5_ = (param1 = param1 / param4) * param1) * param1;
         return param2 + param3 * (0.0028901734104049837 * _loc6_ * _loc5_ + 0 * _loc5_ * _loc5_ + 3.98843930635838 * _loc6_ + -8.98843930635838 * _loc5_ + 5.997109826589595 * param1);
      }
      
      private function _ViewStackWindow_Zoom2_c() : Zoom
      {
         var _loc1_:Zoom = new Zoom();
         _loc1_.startDelay = 0;
         _loc1_.duration = 500;
         _loc1_.zoomHeightFrom = 1;
         _loc1_.zoomHeightTo = 0.5;
         _loc1_.zoomWidthFrom = 1;
         _loc1_.zoomWidthTo = 0.5;
         _loc1_.easingFunction = Exponential.easeIn;
         return _loc1_;
      }
      
      public function flipToPreview() : void
      {
         var _loc1_:Flip = new Flip(this.publish);
         _loc1_.siblings = [this.preview];
         _loc1_.direction = DistortionConstants.LEFT;
         _loc1_.duration = this.FLIP_DURATION;
         _loc1_.addEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect,false,0,true);
         _loc1_.play();
         this.preview.play(true);
      }
      
      private function _ViewStackWindow_Resize1_c() : Resize
      {
         var _loc1_:Resize = new Resize();
         _loc1_.widthTo = 616;
         _loc1_.heightTo = 500;
         return _loc1_;
      }
      
      private function _ViewStackWindow_Parallel1_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.openEffect = _loc1_;
         _loc1_.children = [this._ViewStackWindow_Zoom1_c()];
         return _loc1_;
      }
      
      private function _ViewStackWindow_Parallel3_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.publishShrink = _loc1_;
         _loc1_.children = [this._ViewStackWindow_Resize1_c(),this._ViewStackWindow_Move1_c()];
         BindingManager.executeBindings(this,"publishShrink",this.publishShrink);
         return _loc1_;
      }
      
      public function set publishShrink(param1:Parallel) : void
      {
         var _loc2_:Object = this._2002618360publishShrink;
         if(_loc2_ !== param1)
         {
            this._2002618360publishShrink = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publishShrink",_loc2_,param1));
         }
      }
      
      private function initApp() : void
      {
         this.preview.addEventListener(Event.CHANGE,this.onChangeHandler,false,0,true);
         this.preview.addEventListener(Event.CANCEL,this.onCancelHandler,false,0,true);
         this.publish.addEventListener(Event.CHANGE,this.onChangeHandler,false,0,true);
      }
      
      private function onEndPublishEffect(param1:EffectEvent) : void
      {
         if(Flip(param1.currentTarget).target == this.preview)
         {
            this.preview.visible = false;
            this.preview.alpha = 0;
         }
         else
         {
            this.preview.visible = true;
            this.preview.alpha = 1;
         }
         param1.currentTarget.removeEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect);
      }
      
      public function __publishExpand_effectEnd(param1:EffectEvent) : void
      {
         this.flipToPreview();
      }
      
      [Bindable(event="propertyChange")]
      public function get publishShrink() : Parallel
      {
         return this._2002618360publishShrink;
      }
      
      [Bindable(event="propertyChange")]
      public function get openEffect() : Parallel
      {
         return this._65508229openEffect;
      }
      
      private function _ViewStackWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Array
         {
            return [publish,preview];
         },function(param1:Array):void
         {
            publishShrink.targets = param1;
         },"publishShrink.targets");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return RESIZE_DURATION;
         },function(param1:Number):void
         {
            publishShrink.duration = param1;
         },"publishShrink.duration");
         result[1] = binding;
         binding = new Binding(this,function():Array
         {
            return [publish,preview];
         },function(param1:Array):void
         {
            publishExpand.targets = param1;
         },"publishExpand.targets");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return RESIZE_DURATION;
         },function(param1:Number):void
         {
            publishExpand.duration = param1;
         },"publishExpand.duration");
         result[3] = binding;
         return result;
      }
      
      public function set openEffect(param1:Parallel) : void
      {
         var _loc2_:Object = this._65508229openEffect;
         if(_loc2_ !== param1)
         {
            this._65508229openEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"openEffect",_loc2_,param1));
         }
      }
      
      public function ___ViewStackWindow_ViewStack1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
   }
}
