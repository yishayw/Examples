package components
{

	import mx.controls.ToggleButtonBar;
	import org.apache.royale.events.Event;
	import spark.events.IndexChangeEvent;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.core.ISelectionModel;

	public class ButtonBarNoToggle extends ToggleButtonBar
	{
		public function ButtonBarNoToggle() : void
		{
			super();
			addBead(new TextItemRendererFactoryForArrayCollectionData());
			toggleOnClick = false;
		}

		override public function addedToParent():void
		{
			super.addedToParent();
			(getBeadByType(ISelectionModel) as ISelectionModel).labelField = "label";
			(model as IEventDispatcher).addEventListener("selectedIndexChanged", selectedIndexChangedHandler);
		}

		private function selectedIndexChangedHandler(e:Event):void
		{
			dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGING));
		}

	}
}
