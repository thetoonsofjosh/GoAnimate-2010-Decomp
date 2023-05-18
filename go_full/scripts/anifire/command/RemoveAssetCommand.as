package anifire.command
{
   public class RemoveAssetCommand extends SuperCommand
   {
       
      
      public function RemoveAssetCommand()
      {
         super();
         _type = "RemoveAssetCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
