package
{
	public class Validator
	{
		/**
		 * <inject_html>
		 * <script src="https://momentjs.com/downloads/moment-with-locales.min.js"></script>
		 * </inject_html>
		 */

		public function Validator()
		{
		}

		public function isValid(str:String):Boolean
		{
			COMPILE::JS 
			{
				return (window["moment"](str) as Object).isValid() as Boolean;
			}
			COMPILE::SWF 
			{
				return true;
			}
		}

		public function format(str:String):String
		{
			COMPILE::JS 
			{
				return (window["moment"]() as Object).format(str) as String;
			}
			return str;
		}
	}
}