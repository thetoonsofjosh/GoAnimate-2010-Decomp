package anifire.command
{
   public class MoveZoomEffectCommand extends SuperCommand
   {
       
      
      public function MoveZoomEffectCommand(param1:XML)
      {
         super();
         sceneUndoXML = param1;
         _type = "MoveZoomEffectCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
