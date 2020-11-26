
package components
{

	import org.apache.royale.events.Event;
	import mx.events.MouseEvent;
	import org.apache.royale.utils.getTimer;

	import mx.collections.ArrayList;
	import mx.events.FlexEvent;

	import spark.components.DataGroup;
	import spark.components.supportClasses.ButtonBase;
	import org.apache.royale.html.beads.models.ImageAndTextModel;

	[Event( name = "change", type = "org.apache.royale.events.Event" )]

	public class RibbonButton2 extends ButtonBase
	{

		private var _selected : Boolean;

		private var _toggle : Boolean;

		private var _lastClickTime : int;

		public var isExternalLink : Boolean = false;


		/*
		private var _icons : Array;

		private var _iconChanged : Boolean;


		public var iconsGroup : DataGroup;
*/
		public function RibbonButton2()
		{
			super();
			model = new ImageAndTextModel();
			_toggle = true;
			_lastClickTime = getTimer();
			focusEnabled = false;
			addEventListener(MouseEvent.CLICK, clickHandler);
		}

		[Bindable]
		public function get selected() : Boolean
		{
			return _selected;
		}

		public function set selected( value : Boolean ) : void
		{
			if( value == _selected )
			{
				return;
			}

			_selected = value;
			dispatchEvent( new FlexEvent( FlexEvent.VALUE_COMMIT ) );
			invalidateSkinState();
		}

		[Bindable]
		public function get toggle() : Boolean
		{
			return _toggle;
		}

		public function set toggle( value : Boolean ) : void
		{
			if( value == _toggle )
			{
				return;
			}

			_toggle = value;
			invalidateSkinState();
		}

		protected override function getCurrentSkinState() : String
		{
			if( selected )
			{
				return "selected";
			}
			else
			{
				return super.getCurrentSkinState();
			}
		}

		protected function clickHandler( event : MouseEvent ) : void
		{
			var clickTime : int = getTimer();
			var isDoubleClick : Boolean = ( _lastClickTime + 400 ) > clickTime;
			_lastClickTime = clickTime;

			if( isDoubleClick )
			{
				return;
			}

			if( _toggle && !isExternalLink )
			{
				selected = !selected;
				dispatchEvent( new Event( Event.CHANGE ) );
				event.updateAfterEvent();
			}
		}

		override public function stylesInitialized() : void
		{
			super.stylesInitialized();
			//this.setStyle( "skinClass", Class( RibbonButtonSkin2 ) );
		}

	}
}
