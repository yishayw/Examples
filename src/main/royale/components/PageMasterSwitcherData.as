package components
{
	public class PageMasterSwitcherData
	{
		private var _label:String;
		private var _type:String;
		private var _indented:Boolean;
		
		public function PageMasterSwitcherData(label:String, type:String, indented:Boolean)
		{
			_label = label;
			_type = type;
			_indented = indented;
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get indented():Boolean
		{
			return _indented;
		}
		
		public function toString():String
		{
			return "PageMasterSwitcherData - label: " + label +"  type: " + type + "   indented: " + indented;
		}
	}
}
