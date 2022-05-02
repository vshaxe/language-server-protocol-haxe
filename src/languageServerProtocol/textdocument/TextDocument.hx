package languageServerProtocol.textdocument;

/**
	A tagging type for string properties that are actually document URIs.
**/
abstract DocumentUri(String) {
	public inline function new(uri:String) {
		this = uri;
	}

	public inline function toString() {
		return this;
	}
}

/**
	Position in a text document expressed as zero-based line and character offset.
	The offsets are based on a UTF-16 string representation. So a string of the form
	`a𐐀b` the character offset of the character `a` is 0, the character offset of `𐐀`
	is 1 and the character offset of b is 3 since `𐐀` is represented using two code
	units in UTF-16.

	Positions are line end character agnostic. So you can not specify a position that
	denotes `\r|\n` or `\n|` where `|` represents the character offset.
**/
typedef Position = {
	/**
		Line position in a document (zero-based).
		If a line number is greater than the number of lines in a document, it defaults back to the number of lines in the document.
		If a line number is negative, it defaults to 0.
	**/
	var line:Int;

	/**
		Character offset on a line in a document (zero-based). Assuming that the line is
		represented as a string, the `character` value represents the gap between the
		`character` and `character + 1`.

		If the character value is greater than the line length it defaults back to the
		line length.
		If a line number is negative, it defaults to 0.
	**/
	var character:Int;
}

/**
	A range in a text document expressed as (zero-based) start and end positions.

	If you want to specify a range that contains a line including the line ending
	character(s) then use an end position denoting the start of the next line.
	For example:
	```ts
	{
	start: { line: 5, character: 23 }
	end : { line 6, character : 0 }
	}
	```
**/
typedef Range = {
	/**
		The range's start position
	**/
	var start:Position;

	/**
		The range's end position.
	**/
	var end:Position;
}

/**
	A text edit applicable to a text document.
**/
typedef TextEdit = {
	/**
		The range of the text document to be manipulated. To insert
		text into a document create a range where start === end.
	**/
	var range:Range;

	/**
		The string to be inserted. For delete operations use an
		empty string.
	**/
	var newText:String;
}

/**
	An event describing a change to a text document. If range and rangeLength are omitted
	the new text is considered to be the full content of the document.
**/
typedef TextDocumentContentChangeEvent = {
	/**
		The range of the document that changed.
	**/
	var ?range:Range;

	/**
		The optional length of the range that got replaced.
	**/
	@:deprecated("use range instead.")
	var ?rangeLength:Int;

	/**
		The new text for the provided range.
	**/
	var text:String;
}

/**
	A simple text document. Not to be implemented. The document keeps the content
	as string.
**/
@:native("TextDocument")
extern class TextDocument {
	/**
		The associated URI for this document. Most documents have the __file__-scheme, indicating that they
		represent files on disk. However, some documents may have other schemes indicating that they are not
		available on disk.

		@readonly
	**/
	public var uri:DocumentUri;

	/**
		The identifier of the language associated with this document.

		@readonly
	**/
	public var languageId:String;

	/**
		The version number of this document (it will increase after each
		change, including undo/redo).

		@readonly
	**/
	public var version:Int;

	/**
		Get the text of this document. A substring can be retrieved by
		providing a range.

		@param range (optional) An range within the document to return.
		If no range is passed, the full content is returned.
		Invalid range positions are adjusted as described in [Position.line](#Position.line)
		and [Position.character](#Position.character).
		If the start range position is greater than the end range position,
		then the effect of getText is as if the two positions were swapped.

		@return The text of this document or a substring of the text if a
				range is provided.
	**/
	public function getText(?range:Range):String;

	/**
		Converts a zero-based offset to a position.

		@param offset A zero-based offset.
		@return A valid [position](#Position).
	**/
	public function positionAt(offset:Int):Position;

	/**
		Converts the position to a zero-based offset.
		Invalid positions are adjusted as described in [Position.line](#Position.line)
		and [Position.character](#Position.character).

		@param position A position.
		@return A valid zero-based offset.
	**/
	public function offsetAt(position:Position):Int;

	/**
		The number of lines in this document.

		@readonly
	**/
	public var lineCount:Int;

	/**
		Creates a new text document.

		@param uri The document's uri.
		@param languageId  The document's language Id.
		@param version The document's initial version number.
		@param content The document's content.
	**/
	public static function create(uri:DocumentUri, languageId:String, version:Int, content:String):TextDocument;

	/**
		Updates a TextDocument by modifying its content.

		@param document the document to update. Only documents created by TextDocument.create are valid inputs.
		@param changes the changes to apply to the document.
		@param version the changes version for the document.
		@returns The updated TextDocument. Note: That's the same document instance passed in as first parameter.

	**/
	public static function update(document:TextDocument, changes:Array<TextDocumentContentChangeEvent>, version:Int):TextDocument;

	public static function applyEdits(document:TextDocument, edits:Array<TextEdit>):String;
}
