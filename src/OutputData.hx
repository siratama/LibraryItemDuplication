package ;
class OutputData
{
	public var copiedDirectoryPath(default, null):String;
	public var symbols(default, null):Array<Symbol>;
	public function new(copiedDirectoryPath:String, symbols:Array<Symbol>)
	{
		this.copiedDirectoryPath = copiedDirectoryPath;
		this.symbols = symbols;

		trace("---" + copiedDirectoryPath);
		for (symbol in symbols)
		{
			trace(symbol.originalItemPath);
			trace(symbol.duplicationItemPath);
		}
	}
}
