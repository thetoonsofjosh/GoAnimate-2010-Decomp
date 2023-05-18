package anifire.command
{
   public class MovePropCommand extends SuperCommand
   {
       
      
      public function MovePropCommand(param1:XML)
      {
         super();
         sceneUndoXML = param1;
         _type = "MovePropCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
