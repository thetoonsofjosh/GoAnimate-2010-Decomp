package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import mx.events.IndexChangedEvent;
   
   public class RemoveSceneCommand extends SuperCommand
   {
       
      
      private var _numOfTotalScene:int;
      
      private var _redoSoundInfos:Array;
      
      private var _undoXML:XML;
      
      private var _prevSceneId:String = "";
      
      private var _currSceneId:String;
      
      private var _undoSoundInfos:Array;
      
      public function RemoveSceneCommand()
      {
         super();
         this._numOfTotalScene = Console.getConsole().scenes.length;
         this._currSceneId = Console.getConsole().currentSceneId;
         var _loc1_:AnimeScene = Console.getConsole().getPrevScene(Console.getConsole().currentScene);
         if(_loc1_ != null)
         {
            this._prevSceneId = _loc1_.id;
         }
         this._undoSoundInfos = Console.getConsole().timeline.getAllSoundInfo();
         _type = "RemoveSceneCommand";
      }
      
      override public function undo() : void
      {
         var doUpdateSound:Boolean;
         var scene:AnimeScene = null;
         var onIndexChangedHandler:Function = null;
         onIndexChangedHandler = function(param1:IndexChangedEvent):void
         {
            param1.currentTarget.removeEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            var _loc2_:AnimeScene = Console.getConsole().addScene(_currSceneId,_undoXML,1,false);
            Console.getConsole().timeline.setAllSoundInfo(_undoSoundInfos);
            Console.getConsole().setCurrentSceneById(_loc2_.id);
         };
         var soundInfos:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._redoSoundInfos = soundInfos;
         scene = Console.getConsole().currentScene;
         scene.unloadAllAssets();
         doUpdateSound = true;
         if(this._numOfTotalScene <= 1)
         {
            scene = Console.getConsole().currentScene;
            scene.id = this._currSceneId;
            scene.name = this._currSceneId;
            scene.deSerialize(this._undoXML);
            Console.getConsole().scenes.removeAll();
            Console.getConsole().scenes.push(this._currSceneId,scene);
         }
         else if(this._prevSceneId == "")
         {
            Console.getConsole().currentScene = null;
            scene = Console.getConsole().addScene(this._currSceneId,this._undoXML,1,false);
            Console.getConsole().timeline.setCurrentSceneByIndex(0);
         }
         else if(Console.getConsole().currentSceneId != this._prevSceneId)
         {
            Console.getConsole().addEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            Console.getConsole().setCurrentSceneById(this._prevSceneId);
            doUpdateSound = false;
         }
         else
         {
            scene = Console.getConsole().addScene(this._currSceneId,this._undoXML,1,false);
            Console.getConsole().setCurrentSceneById(scene.id);
         }
         if(doUpdateSound)
         {
            Console.getConsole().timeline.setAllSoundInfo(this._undoSoundInfos);
         }
      }
      
      override public function execute() : void
      {
         this._undoXML = backupSceneData();
         super.execute();
      }
      
      override public function redo() : void
      {
         var onIndexChangedHandler:Function = null;
         onIndexChangedHandler = function(param1:IndexChangedEvent):void
         {
            param1.currentTarget.removeEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            Console.getConsole().deleteCurrentScene();
            Console.getConsole().setCurrentSceneVisible();
            Console.getConsole().timeline.setAllSoundInfo(_redoSoundInfos);
         };
         if(Console.getConsole().currentSceneId != this._currSceneId)
         {
            Console.getConsole().addEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            Console.getConsole().setCurrentSceneById(this._currSceneId);
         }
         else
         {
            Console.getConsole().deleteCurrentScene();
            Console.getConsole().setCurrentSceneVisible();
            Console.getConsole().timeline.setAllSoundInfo(this._redoSoundInfos);
         }
      }
   }
}
