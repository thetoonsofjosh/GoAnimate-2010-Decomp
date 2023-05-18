package anifire.command
{
   public class MoveCharacterCommand extends SuperCommand
   {
       
      
      public function MoveCharacterCommand(param1:XML)
      {
         super();
         sceneUndoXML = param1;
         _type = "MoveCharacterCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
