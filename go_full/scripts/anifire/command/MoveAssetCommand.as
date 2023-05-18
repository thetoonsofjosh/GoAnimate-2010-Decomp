package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Console;
   
   public class MoveAssetCommand extends SuperCommand
   {
       
      
      private var _orginalUndoY:Number;
      
      private var _orginalRedoX:Number;
      
      private var _orginalRedoY:Number;
      
      private var _id:String;
      
      private var _orginalUndoX:Number;
      
      public function MoveAssetCommand(param1:String, param2:Number, param3:Number)
      {
         super();
         this._id = param1;
         this._orginalUndoX = param2;
         this._orginalUndoY = param3;
         _type = "MoveAssetCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = _loc1_.getAssetById(this._id);
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            this._orginalRedoX = _loc2_.x;
            this._orginalRedoY = _loc2_.y;
            _loc2_.x = this._orginalUndoX;
            _loc2_.y = this._orginalUndoY;
            Console.getConsole().changed = true;
         }
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = _loc1_.getAssetById(this._id);
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc2_.x = this._orginalRedoX;
            _loc2_.y = this._orginalRedoY;
            Console.getConsole().changed = true;
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
