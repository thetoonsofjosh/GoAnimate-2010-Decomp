package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   
   public class ResizeZoomEffectCommand extends SuperCommand
   {
       
      
      private var _originalUndoXML:XML;
      
      private var _originalRedoXML:XML;
      
      private var _id:String;
      
      public function ResizeZoomEffectCommand(param1:String, param2:XML)
      {
         super();
         this._id = param1;
         this._originalUndoXML = param2;
         _type = "ResizeZoomEffectCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:EffectAsset = EffectAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            this._originalRedoXML = new XML(_loc2_.serialize());
            _loc2_.deSerialize(this._originalUndoXML,_loc1_);
            _loc2_.redraw();
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:EffectAsset = EffectAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc2_.deSerialize(this._originalRedoXML,_loc1_);
            _loc2_.redraw();
         }
      }
   }
}
