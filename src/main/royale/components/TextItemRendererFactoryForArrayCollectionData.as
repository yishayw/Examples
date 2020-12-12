package components
{

	import org.apache.royale.utils.sendStrandEvent;
	import org.apache.royale.html.beads.TextItemRendererFactoryForArrayData;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.ItemRendererEvent;
	import org.apache.royale.core.ILabelFieldItemRenderer;
	import org.apache.royale.core.IIndexedItemRenderer;
	import org.apache.royale.html.beads.IListView;
	import mx.collections.ArrayCollection;
	import org.apache.royale.core.IStrandWithModelView;
	import org.apache.royale.core.IItemRendererOwnerView;

	public class TextItemRendererFactoryForArrayCollectionData extends TextItemRendererFactoryForArrayData
	{
		override protected function dataProviderChangeHandler(event:Event):void
		{
			var selectionModel:ISelectionModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			var dp:ArrayCollection = selectionModel.dataProvider as ArrayCollection;
			if (!dp)
				return;

			var view:IListView = (_strand as IStrandWithModelView).view as IListView;
			var dataGroup:IItemRendererOwnerView = view.dataGroup;

			dataGroup.removeAllItemRenderers();

			var n:int = dp.length;
			for (var i:int = 0; i < n; i++)
			{
				var ir:IIndexedItemRenderer = itemRendererFactory.createItemRenderer() as IIndexedItemRenderer;
				var tf:ILabelFieldItemRenderer = ir as ILabelFieldItemRenderer;
				ir.index = i;
				dataGroup.addItemRenderer(ir, false);
				if (tf && selectionModel.labelField) {
					tf.labelField = selectionModel.labelField;
				}
				ir.data = dp.getItemAt(i);

				var newEvent:ItemRendererEvent = new ItemRendererEvent(ItemRendererEvent.CREATED);
				newEvent.itemRenderer = ir;
				dispatchEvent(newEvent);
			}

			sendStrandEvent(_strand,"itemsCreated");
		}

	}
}
