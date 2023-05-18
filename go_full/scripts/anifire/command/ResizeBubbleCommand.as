package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   
   public class ResizeBubbleCommand extends SuperCommand
   {
       
      
      private var _originalUndoXML:XML;
      
      private var _originalRedoXML:XML;
      
      private var _id:String;
      
      public function ResizeBubbleCommand(param1:String, param2:XML)
      {
         super();
         this._id = param1;
         this._originalUndoXML = param2;
         _type = "ResizeBubbleCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:BubbleAsset = BubbleAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            this._originalRedoXML = _loc2_.bubble.serialize();
            _loc2_.bubble.deSerialize(this._originalUndoXML);
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:BubbleAsset = BubbleAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc2_.bubble.deSerialize(this._originalRedoXML);
         }
      }
   }
}
