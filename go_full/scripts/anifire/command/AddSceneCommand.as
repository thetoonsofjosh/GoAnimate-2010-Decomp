package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import mx.events.IndexChangedEvent;
   
   public class AddSceneCommand extends SuperCommand
   {
       
      
      private var _numOfTotalScene:int;
      
      private var _redoSoundInfos:Array;
      
      private var _prevSceneId:String = "";
      
      private var _currSceneId:String;
      
      private var _undoSoundInfos:Array;
      
      private var _redoXML:XML;
      
      public function AddSceneCommand(param1:String, param2:Array)
      {
         super(param1);
         this._currSceneId = param1;
         this._numOfTotalScene = Console.getConsole().scenes.length;
         var _loc3_:AnimeScene = Console.getConsole().getPrevScene(Console.getConsole().getScenebyId(param1));
         if(_loc3_ != null)
         {
            this._prevSceneId = _loc3_.id;
         }
         this._undoSoundInfos = param2;
         _type = "AddSceneCommand";
      }
      
      override public function undo() : void
      {
         var onIndexChangedHandler:Function = null;
         var soundInfos:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._redoSoundInfos = soundInfos;
         onIndexChangedHandler = function(param1:IndexChangedEvent):void
         {
            param1.currentTarget.removeEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            Console.getConsole().deleteCurrentScene();
            Console.getConsole().setCurrentSceneVisible();
            Console.getConsole().timeline.setAllSoundInfo(_undoSoundInfos);
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
            Console.getConsole().timeline.setAllSoundInfo(this._undoSoundInfos);
         }
      }
      
      override public function execute() : void
      {
         this._redoXML = backupSceneData();
         super.execute();
      }
      
      override public function redo() : void
      {
         var scene:AnimeScene = null;
         var onIndexChangedHandler:Function = null;
         onIndexChangedHandler = function(param1:IndexChangedEvent):void
         {
            param1.currentTarget.removeEventListener(IndexChangedEvent.CHANGE,onIndexChangedHandler);
            var _loc2_:AnimeScene = Console.getConsole().addScene(_currSceneId,_redoXML,1,false);
            Console.getConsole().timeline.setAllSoundInfo(_redoSoundInfos);
         };
         var doUpdateSound:Boolean = true;
         if(this._numOfTotalScene <= 1)
         {
            scene = Console.getConsole().currentScene;
            scene.id = this._currSceneId;
            scene.name = this._currSceneId;
            scene.deSerialize(this._redoXML,true,true,false);
            Console.getConsole().scenes.removeAll();
            Console.getConsole().scenes.push(this._currSceneId,scene);
         }
         else if(this._prevSceneId == "")
         {
            Console.getConsole().currentScene = Console.getConsole().getScene(0);
            scene = Console.getConsole().addScene(this._currSceneId,this._redoXML,0,false);
            Console.getConsole().currentSceneIndex = 0;
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
            scene = Console.getConsole().addScene(this._currSceneId,this._redoXML,1,false);
         }
         if(doUpdateSound)
         {
            Console.getConsole().timeline.setAllSoundInfo(this._redoSoundInfos);
         }
      }
   }
}
