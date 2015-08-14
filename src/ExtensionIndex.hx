package ;

import flash_extension.csinterface.CSInterfaceUtil;
import jQuery.JQuery;
import js.Browser;

class ExtensionIndex
{
	private var csInterfaceUtil:CSInterfaceUtil;
	private static inline var JSFL_DUPLICATION = "LibraryItemDuplication.jsfl";
	private static inline var JSFL_RENAME = "DuplicationRename.jsfl";
	private static inline var JSFL_DIRECTORY = "lib/";

	public static function main(){
		new ExtensionIndex();
	}
	public function new(){
		Browser.window.addEventListener("load", initialize);
	}
	private function initialize(event)
	{
		csInterfaceUtil = CSInterfaceUtil.create();

		var runButtonElement = new JQuery("#duplication");
		runButtonElement.mousedown(function(event){
			runJsfl(JSFL_DUPLICATION);
		});

		var renameButtonElement = new JQuery("#rename");
		renameButtonElement.mousedown(function(event){
			runJsfl(JSFL_RENAME);
		});
	}
	private function runJsfl(jsfl:String)
	{
		csInterfaceUtil.runJsflScript(
			csInterfaceUtil.getExtensionUri() + "/" + JSFL_DIRECTORY + jsfl
		);
	}
}

