package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   
   public class SuperCommand implements ICommand
   {
       
      
      private var _studioRedoXML:XML = null;
      
      private var _sceneUndoXML:XML = null;
      
      private var _sceneId:String = null;
      
      private var _undoSoundInfos:Array;
      
      private var _studioUndoXML:XML = null;
      
      protected var _type:String = "SuperCommand";
      
      private var _sceneRedoXML:XML = null;
      
      private var _redoSoundInfos:Array;
      
      public function SuperCommand(param1:String = "")
      {
         super();
         if(param1 == "")
         {
            param1 = Console.getConsole().currentSceneId;
         }
         this._sceneId = param1;
         var _loc2_:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._undoSoundInfos = _loc2_;
      }
      
      protected function get sceneId() : String
      {
         return this._sceneId;
      }
      
      public function set sceneUndoXML(param1:XML) : void
      {
         this._sceneUndoXML = param1;
      }
      
      public function undo() : void
      {
         var _loc1_:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._redoSoundInfos = _loc1_;
         var _loc2_:AnimeScene = Console.getConsole().getScenebyId(this._sceneId);
         if(_loc2_ != null)
         {
            this._sceneRedoXML = new XML(_loc2_.serialize(-1,false));
            if(this._sceneUndoXML != null)
            {
               this.restoreSceneData(this._sceneUndoXML);
            }
         }
         Console.getConsole().timeline.setAllSoundInfo(this._undoSoundInfos);
      }
      
      protected function restoreSceneData(param1:XML) : void
      {
         var _loc2_:AnimeScene = Console.getConsole().getScenebyId(this._sceneId);
         if(Console.getConsole().currentSceneId != this._sceneId)
         {
            Console.getConsole().setCurrentSceneById(this._sceneId);
         }
         _loc2_.deSerialize(param1,true,true,false);
         Console.getConsole().setCurrentSceneVisible();
         _loc2_.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      protected function backupSceneData() : XML
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(this._sceneId);
         this._sceneUndoXML = new XML(_loc1_.serialize(-1,false));
         return this._sceneUndoXML;
      }
      
      public function execute() : void
      {
         Console.getConsole().mainStage.enableUndo(true);
         CommandStack.getInstance().putCommand(this);
      }
      
      public function toString() : String
      {
         return this._type;
      }
      
      public function redo() : void
      {
         if(this._sceneRedoXML)
         {
            this.restoreSceneData(this._sceneRedoXML);
         }
         Console.getConsole().timeline.setAllSoundInfo(this._redoSoundInfos);
      }
   }
}
