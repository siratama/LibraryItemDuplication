package ;

import jsfl.Item;
import jsfl.Library;
import jsfl.ItemType;
import jsfl.Lib;

class DuplicationRename
{
	private var library:Library;

	public static function main(){
		new DuplicationRename();
	}
	public function new()
	{
		if(Lib.fl.getDocumentDOM() == null) return;
		Lib.fl.trace("---");

		library = Lib.fl.getDocumentDOM().library;
		var selectedItems = library.getSelectedItems();

		if(selectedItems.length == 0){
			Lib.fl.trace("Select item in library.");
			return;
		}
		var errorNameSet = execute(selectedItems);
		outputErrorNameSet(errorNameSet);

		Lib.fl.trace("finish");
	}
	private function execute(selectedItems:Array<Item>):Array<String>
	{
		var errorNameSet = [];
		for(i in 0...selectedItems.length)
		{
			var item = selectedItems[i];
			if(item.itemType == ItemType.FOLDER) continue;

			var itemName = item.name;

			var postPositionIndex = itemName.indexOf(Common.POST_POSITION);
			if(postPositionIndex == -1) continue;

			itemName.substring(postPositionIndex);
			if(library.itemExists(itemName)){
				errorNameSet.push(item.name);
				continue;
			}
			item.name = itemName;
			Lib.fl.trace(itemName);
		}
		return errorNameSet;
	}
	private function outputErrorNameSet(errorNameSet:Array<String>)
	{
		var errorNameSetLength = errorNameSet.length;
		if(errorNameSetLength == 0) return;

		Lib.fl.trace("--- duplication error files ---");
		for(i in 0...errorNameSetLength)
		{
			Lib.fl.trace(errorNameSet[i]);
		}
	}
}
