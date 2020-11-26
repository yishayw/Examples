package components
{

	import org.apache.royale.events.Event;
	import org.apache.royale.events.ValueChangeEvent;

	import org.apache.royale.core.IChild;

	import mx.core.IVisualElement;
	import mx.core.mx_internal;

	import spark.components.Group;
	import spark.events.IndexChangeEvent;
	import spark.layouts.HorizontalLayout;


	use namespace mx_internal;

	[Event( name="change", type="org.apache.royale.events.ValueChangeEvent" )]

	public class Ribbon2 extends Group
	{

		private var _selectedItem : RibbonButton2;

		private var _items : Object;

		public function Ribbon2()
		{
			super();
			var l : HorizontalLayout = new HorizontalLayout();
			l.verticalAlign = "middle";
			layout = l;
			_items = {};
			useHandCursor = true;
			buttonMode = true;
		}

		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			super.addElement(c, dispatchEvent);

			// if we're adding a toggleable button
			if( c is RibbonButton2 )
			{
				var rB : RibbonButton2 = c as RibbonButton2;

				// ignore non-toggled buttons
				if( !rB.toggle )
				{
					return;
				}

				_items[ rB.name ] = rB;
				rB.addEventListener( Event.CHANGE, onToggleButton );
			}
		}

		protected function onToggleButton( event : Event ) : void
		{

			var rB : RibbonButton2 = event.target as RibbonButton2;

			var ribonEvent : ValueChangeEvent = new ValueChangeEvent( Event.CHANGE, true )

			if( selectedItem )
			{
				ribonEvent.oldValue = selectedItem;
			}


			if( rB.selected )
			{
				selectedItem = rB;
				ribonEvent.newValue = selectedItem;
					// if the selected item was the button, deselect
			}
			else if( selectedItem == rB )
			{
				selectedItem = null;
			}

			dispatchEvent( ribonEvent );
		}

		public function get selectedItem() : RibbonButton2
		{
			return _selectedItem;
		}

		public function set selectedItem( value : RibbonButton2 ) : void
		{
			if( _selectedItem == value )
			{
				return;
			}

			if( _selectedItem )
			{
				_selectedItem.selected = false;
			}

			_selectedItem = value;

			if( _selectedItem && !_selectedItem.selected )
			{
				_selectedItem.selected = true;
			}
		}

		public function get selectedItemName() : String
		{
			return _selectedItem ? _selectedItem.name : "";
		}

		public function set selectedItemName( name : String ) : void
		{

			for( var p : String in _items )
			{
				if( p == name )
				{
					trace( p + "-" + name + ">" + _items[ name ] );
					selectedItem = _items[ name ];
					return;
				}
			}
			selectedItem = null;
		}
	}
}
