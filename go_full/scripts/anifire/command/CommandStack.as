package anifire.command
{
   import flash.events.EventDispatcher;
   
   public class CommandStack extends EventDispatcher
   {
      
      private static var _instance:anifire.command.CommandStack;
       
      
      private var _commands:Array;
      
      private var _maxLength:int;
      
      private var _index:uint;
      
      public function CommandStack(param1:SingletonEnforcer)
      {
         super();
         this._commands = new Array();
         this._index = 0;
      }
      
      public static function getInstance() : anifire.command.CommandStack
      {
         if(_instance == null)
         {
            _instance = new anifire.command.CommandStack(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function reset() : void
      {
         this._commands = new Array();
         this._index = 0;
      }
      
      public function next() : ICommand
      {
         return this._commands[this._index++];
      }
      
      public function hasNextCommands() : Boolean
      {
         return this._index < this._commands.length;
      }
      
      public function previous() : ICommand
      {
         return this._commands[--this._index];
      }
      
      public function hasPreviousCommands() : Boolean
      {
         return this._index > 0;
      }
      
      public function putCommand(param1:ICommand) : void
      {
         var _loc2_:* = this._index++;
         this._commands[_loc2_] = param1;
         this._commands.splice(this._index,this._commands.length - this._index);
         dispatchEvent(new CommandEvent(CommandEvent.ADDED,param1.toString(),this._commands.length));
      }
   }
}

class SingletonEnforcer
{
    
   
   public function SingletonEnforcer()
   {
      super();
   }
}
