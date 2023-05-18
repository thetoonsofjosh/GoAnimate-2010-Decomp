package anifire.core
{
   public class GroupController
   {
       
      
      private var _currentGroup:anifire.core.Group;
      
      private var _schoolId:String = "-1";
      
      private var _groups:Array;
      
      private var _tempCurrentGroup:anifire.core.Group;
      
      public function GroupController()
      {
         this._currentGroup = new anifire.core.Group();
         super();
         this._groups = new Array();
      }
      
      public function isSchoolProject() : Boolean
      {
         if(this.schoolId != "-1")
         {
            return true;
         }
         return false;
      }
      
      public function setCurrentGroup(param1:anifire.core.Group) : void
      {
         this.currentGroup = param1;
      }
      
      public function set currentGroup(param1:anifire.core.Group) : void
      {
         this._currentGroup = param1;
      }
      
      public function get currentGroup() : anifire.core.Group
      {
         return this._currentGroup;
      }
      
      public function get schoolId() : String
      {
         return this._schoolId;
      }
      
      public function getGroups() : Array
      {
         return this.groups.concat();
      }
      
      public function set tempCurrentGroup(param1:anifire.core.Group) : void
      {
         this._tempCurrentGroup = param1;
      }
      
      public function addGroup(param1:anifire.core.Group) : void
      {
         this.groups.push(param1);
      }
      
      public function get tempCurrentGroup() : anifire.core.Group
      {
         return this._tempCurrentGroup;
      }
      
      private function get groups() : Array
      {
         return this._groups;
      }
      
      public function removeGroup(param1:anifire.core.Group) : void
      {
      }
      
      public function set schoolId(param1:String) : void
      {
         this._schoolId = param1;
      }
   }
}
