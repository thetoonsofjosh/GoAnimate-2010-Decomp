package anifire.command
{
   public class MoveAssetsCommand extends SuperCommand
   {
       
      
      public function MoveAssetsCommand()
      {
         super();
         _type = "MoveAssetsCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
