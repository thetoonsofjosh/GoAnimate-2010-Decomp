package anifire.cc_theme_lib
{
   import anifire.util.UtilHashArray;
   
   public class CcAction
   {
      
      public static const XML_NODE_NAME:String = "action";
       
      
      private var _enable:Boolean;
      
      private var _selections:UtilHashArray;
      
      private var _name:String;
      
      private var _require_components:Array;
      
      private var _id:String;
      
      private var _category:String;
      
      public function CcAction()
      {
         this._selections = new UtilHashArray();
         this._require_components = new Array();
         super();
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function get requireComponents() : Array
      {
         return this._require_components;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getSelectionByComponentType(param1:String) : CcSelection
      {
         return this._selections.getValueByKey(param1) as CcSelection;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function deserialize(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         var _loc4_:CcRequireComponent = null;
         var _loc5_:CcSelection = null;
         this._id = param1.@id;
         this._name = param1.@name;
         this._enable = param1.@enable == "N" ? false : true;
         this._category = param1.@category;
         for each(_loc2_ in param1.child(CcSelection.XML_NODE_NAME))
         {
            (_loc5_ = new CcSelection()).deserialize(_loc2_);
            this._selections.push(_loc5_.type,_loc5_);
         }
         for each(_loc3_ in param1.child("require_component"))
         {
            (_loc4_ = new CcRequireComponent()).deserialize(_loc3_);
            this._require_components.push(_loc4_);
         }
      }
   }
}
