package;

import jsfl.Library;
import jsfl.Item;
import jsfl.ItemType;
import jsfl.Lib;

class LibraryItemDuplication
{
	private var library:Library;

	public static function main(){
		new LibraryItemDuplication();
	}
	public function new()
	{
		if(Lib.fl.getDocumentDOM() == null) return;
		Lib.fl.trace("--- Duplicate library items ---");

		library = Lib.fl.getDocumentDOM().library;
		var selectedItems = library.getSelectedItems();

		if(selectedItems.length == 0){
			Lib.fl.trace("Select item in library.");
			return;
		}
		var selectedItemParser = new SelectedItemParser(library, selectedItems);
		var duplicationSymbolMap = selectedItemParser.execute();
		var errorNameSet = execute(duplicationSymbolMap);
		outputErrorNameSet(errorNameSet);
	}
	private function execute(duplicationSymbolMap:Map<String, Array<Symbol>>):Array<String>
	{
		var errorNameSet = [];
		for(copiedDirectoryPath in duplicationSymbolMap.keys())
		{
			if(!library.itemExists(copiedDirectoryPath)){
				library.newFolder(copiedDirectoryPath);
			}
			var symbols:Array<Symbol> = duplicationSymbolMap[copiedDirectoryPath];
			for (i in 0...symbols.length)
			{
				var symbol = symbols[i];
				if(library.itemExists(symbol.duplicationItemPath)){
					errorNameSet.push(symbol.originalItemPath);
					continue;
				}

				library.selectItem(symbol.originalItemPath);
				if(!library.duplicateItem(symbol.originalItemPath)){
					errorNameSet.push(symbol.originalItemPath);
					continue;
				}

				library.moveToFolder(copiedDirectoryPath);
				library.getSelectedItems()[0].name = symbol.name;

				trace('${symbol.originalItemPath} -> ${copiedDirectoryPath}${Common.PATH_CLUM}${symbol.name}');
			}
		}
		return errorNameSet;
	}
	/*
	private function execute(selectedItems:Array<Item>):Array<String>
	{
		var errorNameSet = [];
		for(i in 0...selectedItems.length)
		{
			var item = selectedItems[i];
			if(item.itemType == ItemType.FOLDER) continue;

			var itemPath = item.name;
			var itemDirectory = itemPath.split("/");
			var symbolName = itemDirectory.pop();
			var duplicatedName = symbolName + Common.POST_POSITION;

			if(library.itemExists(itemPath + Common.POST_POSITION)){
				errorNameSet.push(itemPath);
				continue;
			}
			library.selectItem(itemPath);
			if(!library.duplicateItem(itemPath)){
				errorNameSet.push(itemPath);
				continue;
			}
			library.getSelectedItems()[0].name = duplicatedName;
			Lib.fl.trace('$itemPath -> ${itemDirectory.join("/")}/$duplicatedName');
		}
		return errorNameSet;
	}
	*/
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
