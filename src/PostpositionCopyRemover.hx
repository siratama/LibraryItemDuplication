package ;

import jsfl.Item;
import jsfl.Library;
import jsfl.ItemType;
import jsfl.Lib;

class PostpositionCopyRemover
{
	private var library:Library;

	public static function main(){
		new PostpositionCopyRemover();
	}
	public function new()
	{
		if(Lib.fl.getDocumentDOM() == null) return;
		Lib.fl.trace('--- Remove postposition "${Common.POST_POSITION}" ---');

		library = Lib.fl.getDocumentDOM().library;
		var selectedItems = library.getSelectedItems();

		if(selectedItems.length == 0){
			Lib.fl.trace("Select item in library.");
			return;
		}
		var errorNameSet = execute(selectedItems);
		outputErrorNameSet(errorNameSet);
	}
	private function execute(selectedItems:Array<Item>):Array<String>
	{
		var errorNameSet = [];
		for(i in 0...selectedItems.length)
		{
			var item = selectedItems[i];
			if(item.itemType == ItemType.FOLDER) continue;

			var itemPath = item.name;
			var postPositionIndex = itemPath.indexOf(Common.POST_POSITION);
			if(postPositionIndex == -1) continue;

			var renamePath = itemPath.substring(0, postPositionIndex);
			if(library.itemExists(renamePath)){
				errorNameSet.push(itemPath);
				continue;
			}
			var renameDirectory = renamePath.split("/");
			item.name = renameDirectory.pop();
			Lib.fl.trace('$itemPath -> ${item.name}');
		}
		return errorNameSet;
	}
	private function outputErrorNameSet(errorNameSet:Array<String>)
	{
		var errorNameSetLength = errorNameSet.length;
		if(errorNameSetLength == 0) return;

		Lib.fl.trace("*** failed items ***");
		for(i in 0...errorNameSetLength)
		{
			Lib.fl.trace(errorNameSet[i]);
		}
	}
}
