package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Console;
   
   public class ResizeCharacterCommand extends SuperCommand
   {
       
      
      private var _orginalUndoY:Number;
      
      private var _orginalRedoScaleX:Number;
      
      private var _orginalRedoScaleY:Number;
      
      private var _originalUndoRotation:Number;
      
      private var _orginalRedoX:Number;
      
      private var _orginalRedoY:Number;
      
      private var _orginalUndoScaleX:Number;
      
      private var _orginalUndoScaleY:Number;
      
      private var _originalRedoRotation:Number;
      
      private var _id:String;
      
      private var _orginalUndoX:Number;
      
      public function ResizeCharacterCommand(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number)
      {
         super();
         this._id = param1;
         this._orginalUndoX = param2;
         this._orginalUndoY = param3;
         this._orginalUndoScaleX = param4;
         this._orginalUndoScaleY = param5;
         this._originalUndoRotation = param6;
         _type = "ResizeCharacterCommand";
      }
      
      override public function redo() : void
      {
         var updateThumb:Function = null;
         var scene:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var asset:Asset = scene.getAssetById(this._id);
         if(asset != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            asset.x = this._orginalRedoX;
            asset.y = this._orginalRedoY;
            asset.scaleX = asset.displayElement.scaleX = this._orginalRedoScaleX;
            asset.scaleY = asset.displayElement.scaleY = this._orginalRedoScaleY;
            asset.rotation = this._originalRedoRotation;
            updateThumb = function():void
            {
               Console.getConsole().changed = true;
            };
            asset.bundle.callLater(updateThumb);
         }
      }
      
      override public function undo() : void
      {
         var updateThumb:Function = null;
         var scene:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var asset:Asset = scene.getAssetById(this._id);
         if(asset != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            this._orginalRedoX = asset.x;
            this._orginalRedoY = asset.y;
            this._orginalRedoScaleX = asset.displayElement.scaleX;
            this._orginalRedoScaleY = asset.displayElement.scaleY;
            this._originalRedoRotation = asset.rotation;
            asset.x = this._orginalUndoX;
            asset.y = this._orginalUndoY;
            asset.scaleX = asset.displayElement.scaleX = this._orginalUndoScaleX;
            asset.scaleY = asset.displayElement.scaleY = this._orginalUndoScaleY;
            asset.rotation = this._originalUndoRotation;
            updateThumb = function():void
            {
               Console.getConsole().changed = true;
            };
            asset.bundle.callLater(updateThumb);
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
