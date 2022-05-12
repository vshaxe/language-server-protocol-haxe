package languageServerProtocol;

/**
	A tagging type for string properties that are actually URIs

	@since 3.16.0
**/
abstract URI(String) {
	public inline function new(uri:String) {
		this = uri;
	}

	public inline function toString() {
		return this;
	}
}

/**
	The LSP any type.

	In the current implementation we map LSPAny to any. This is due to the fact
	that the TypeScript compilers can't infer string access signatures for
	interface correctly (it can though for types). See the following issue for
	details: https://github.com/microsoft/TypeScript/issues/15300.

	When the issue is addressed LSPAny can be defined as follows:

	```ts
	export type LSPAny = LSPObject | LSPArray | string | integer | uinteger | decimal | boolean | null | undefined;
	export type LSPObject = { [key: string]: LSPAny };
	export type LSPArray = LSPAny[];
	```

	Please note that strictly speaking a property with the value `undefined`
	can't be converted into JSON preserving the property name. However for
	convenience it is allowed and assumed that all these properties are
	optional as well.

	@since 3.17.0
**/
typedef LSPAny = Dynamic;

/**
	LSP object definition.

	@since 3.17.0
**/
typedef LSPObject = haxe.DynamicAccess<Array<LSPAny>>;

/**
	LSP arrays.

	@since 3.17.0
**/
typedef LSPArray = Array<LSPAny>;

/**
	Represents a location inside a resource, such as a line inside a text file.
**/
typedef Location = {
	var uri:DocumentUri;
	var range:Range;
}

/**
	Represents the connection of two locations. Provides additional metadata over normal [locations](#Location),
	including an origin range.
**/
typedef LocationLink = {
	/**
		Span of the origin of this link.

		Used as the underlined span for mouse definition hover. Defaults to the word range at
		the definition position.
	**/
	var ?originSelectionRange:Range;

	/**
		The target resource identifier of this link.
	**/
	var targetUri:DocumentUri;

	/**
		The full target range of this link. If the target for example is a symbol then target range is the
		range enclosing this symbol not including leading/trailing whitespace but everything else
		like comments. This information is typically used to highlight the range in the editor.
	**/
	var targetRange:Range;

	/**
		The range that should be selected and revealed when this link is being followed, e.g the name of a function.
		Must be contained by the the `targetRange`. See also `DocumentSymbol#range`
	**/
	var targetSelectionRange:Range;
}

/**
	Represents a color in RGBA space.
**/
typedef Color = {
	/**
		The red component of this color in the range [0-1].
	**/
	final red:Float;

	/**
		The green component of this color in the range [0-1].
	**/
	final green:Float;

	/**
		The blue component of this color in the range [0-1].
	**/
	final blue:Float;

	/**
		The alpha component of this color in the range [0-1].
	**/
	final alpha:Float;
}

/**
	Represents a color range from a document.
**/
typedef ColorInformation = {
	/**
		The range in the document where this color appers.
	**/
	var range:Range;

	/**
		The actual color value for this color range.
	**/
	var color:Color;
}

typedef ColorPresentation = {
	/**
		The label of this color presentation. It will be shown on the color
		picker header. By default this is also the text that is inserted when selecting
		this color presentation.
	**/
	var label:String;

	/**
		An edit which is applied to a document when selecting
		this presentation for the color. When `falsy` the `label`
		is used.
	**/
	var ?textEdit:TextEdit;

	/**
		An optional array of additional text edits that are applied when
		selecting this color presentation. Edits must not overlap with the main `edit` nor with themselves.
	**/
	var ?additionalTextEdits:Array<TextEdit>;
}

/**
	A set of predefined range kinds.
**/
enum abstract FoldingRangeKind(String) from String {
	/**
		Folding range for a comment
	**/
	var Comment = 'comment';

	/**
		Folding range for a imports or includes
	**/
	var Imports = 'imports';

	/**
		Folding range for a region (e.g. `#region`)
	**/
	var Region = 'region';
}

/**
	Represents a folding range.
**/
typedef FoldingRange = {
	/**
		The zero-based line number from where the folded range starts.
	**/
	var startLine:Int;

	/**
		The zero-based character offset from where the folded range starts. If not defined, defaults to the length of the start line.
	**/
	var ?startCharacter:Int;

	/**
		The zero-based line number where the folded range ends.
	**/
	var endLine:Int;

	/**
		The zero-based character offset before the folded range ends. If not defined, defaults to the length of the end line.
	**/
	var ?endCharacter:Int;

	/**
		Describes the kind of the folding range such as `comment' or 'region'. The kind
		is used to categorize folding ranges. See [FoldingRangeKind](#FoldingRangeKind)
		for an enumeration of standardized kinds.
	**/
	var ?kind:FoldingRangeKind;

	/**
		The text that the client should show when the specified range is
		collapsed. If not defined or not supported by the client, a default
		will be chosen by the client.

		@since 3.17.0
	**/
	var ?collapsedText:String;
}

/**
	Represents a related message and source code location for a diagnostic. This should be
	used to point to code locations that cause or related to a diagnostics, e.g when duplicating
	a symbol in a scope.
**/
typedef DiagnosticRelatedInformation = {
	/**
		The location of this related diagnostic information.
	**/
	var location:Location;

	/**
		The message of this related diagnostic information.
	**/
	var message:String;
}

/**
	The diagnostic's serverity.
**/
enum abstract DiagnosticSeverity(Int) {
	/**
		Reports an error.
	**/
	var Error = 1;

	/**
		Reports a warning.
	**/
	var Warning;

	/**
		Reports an information.
	**/
	var Information;

	/**
		Reports a hint.
	**/
	var Hint;
}

/**
	The diagnostic tags.

	@since 3.15.0
**/
enum abstract DiagnosticTag(Int) {
	/**
		Unused or unnecessary code.

		Clients are allowed to render diagnostics with this tag faded out instead of having
		an error squiggle.
	**/
	var Unnecessary = 1;

	/**
		Deprecated or obsolete code.

		Clients are allowed to rendered diagnostics with this tag strike through.
	**/
	var Deprecated = 2;
}

/**
	Structure to capture a description for an error code.

	@since 3.16.0
**/
typedef CodeDescription = {
	/**
		An URI to open with more information about the diagnostic error.
	**/
	var href:URI;
}

/**
	Represents a diagnostic, such as a compiler error or warning.
	Diagnostic objects are only valid in the scope of a resource.
**/
typedef Diagnostic = {
	/**
		The range at which the message applies
	**/
	var range:Range;

	/**
		The diagnostic's severity.
		If omitted it is up to the client to interpret diagnostics as error, warning, info or hint.
	**/
	var ?severity:DiagnosticSeverity;

	/**
		The diagnostic's code, which usually appear in the user interface.
	**/
	var ?code:EitherType<Int, String>;

	/**
		An optional property to describe the error code.
		Requires the code field (above) to be present/not null.

		@since 3.16.0
	**/
	var ?codeDescription:CodeDescription;

	/**
		A human-readable string describing the source of this diagnostic, e.g. 'typescript' or 'super lint'.
	**/
	var ?source:String;

	/**
		The diagnostic's message. It usually appears in the user interface
	**/
	var message:String;

	/** 
		Additional metadata about the diagnostic.

		@since 3.15.0
	**/
	var ?tags:Array<DiagnosticTag>;

	/**
		An array of related diagnostic information, e.g. when symbol-names within
		a scope collide all definitions can be marked via this property.
	**/
	var ?relatedInformation:Array<DiagnosticRelatedInformation>;

	/**
		A data entry field that is preserved between a `textDocument/publishDiagnostics`
		notification and `textDocument/codeAction` request.

		@since 3.16.0
	**/
	var ?data:LSPAny;
}

/**
	Represents a reference to a command.
	Provides a title which will be used to represent a command in the UI and,
	optionally, an array of arguments which will be passed to the command handler function when invoked.
**/
typedef Command = {
	/**
		Title of the command, like `save`.
	**/
	var title:String;

	/**
		The identifier of the actual command handler.
	**/
	var command:String;

	/**
		Arguments that the command handler should be invoked with.
	**/
	var ?arguments:Array<LSPAny>;
}

/**
	Additional information that describes document changes.

	@since 3.16.0
**/
typedef ChangeAnnotation = {
	/**
		A human-readable string describing the actual change. The string
		is rendered prominent in the user interface.
	**/
	var label:String;

	/**
		A flag which indicates that user confirmation is needed
		before applying the change.
	**/
	var ?needsConfirmation:Bool;

	/**
		A human-readable string which is rendered less prominent in
		the user interface.
	**/
	var ?description:String;
}

/**
	An identifier to refer to a change annotation stored with a workspace edit.
**/
typedef ChangeAnnotationIdentifier = String;

/**
	A special text edit with an additional change annotation.

	@since 3.16.0
**/
typedef AnnotatedTextEdit = TextEdit & {
	/**
		The actual identifier of the change annotation
	**/
	var annotationId:ChangeAnnotationIdentifier;
}

/**
	Describes textual changes on a text document. A TextDocumentEdit describes all changes
	on a document version Si and after they are applied move the document to version Si+1.
	So the creator of a TextDocumentEdit doesn't need to sort the array of edits or do any
	kind of ordering. However the edits must be non overlapping.
**/
typedef TextDocumentEdit = {
	/**
		The text document to change.
	**/
	var textDocument:OptionalVersionedTextDocumentIdentifier;

	/**
		The edits to be applied.
	**/
	var edits:Array<EitherType<TextEdit, AnnotatedTextEdit>>;
}

/**
	A generic resource operation.
**/
typedef ResourceOperation<T> = {
	/**
		The resource operation kind.
	**/
	var kind:T;

	/**
		An optional annotation identifier describing the operation.

		@since 3.16.0
	**/
	var ?annotationId:ChangeAnnotationIdentifier;
}

enum abstract CreateFileKind(String) {
	var Create = "create";
}

/**
	Options to create a file.
**/
typedef CreateFileOptions = {
	/**
		Overwrite existing file. Overwrite wins over `ignoreIfExists`
	**/
	var ?overwrite:Bool;

	/**
		Ignore if exists.
	**/
	var ?ignoreIfExists:Bool;
}

/**
	Create file operation.
**/
typedef CreateFile = ResourceOperation<CreateFileKind> & {
	/**
		The resource to create.
	**/
	var uri:DocumentUri;

	/**
		Additional options
	**/
	var ?options:CreateFileOptions;
}

enum abstract RenameFileKind(String) {
	var Kind = "rename";
}

/**
	Rename file options
**/
typedef RenameFileOptions = {
	/**
		Overwrite target if existing. Overwrite wins over `ignoreIfExists`
	**/
	var ?overwrite:Bool;

	/**
		Ignores if target exists.
	**/
	var ?ignoreIfExists:Bool;
}

/**
	Rename file operation
**/
typedef RenameFile = ResourceOperation<RenameFileKind> & {
	/**
		The old (existing) location.
	**/
	var oldUri:DocumentUri;

	/**
		The new location.
	**/
	var newUri:DocumentUri;

	/**
		Rename options.
	**/
	var ?options:RenameFileOptions;
}

enum abstract DeleteFileKind(String) {
	var Delete = "Delete";
}

/**
	Delete file options
**/
typedef DeleteFileOptions = {
	/**
		Delete the content recursively if a folder is denoted.
	**/
	var ?recursive:Bool;

	/**
		Ignore the operation if the file doesn't exist.
	**/
	var ?ignoreIfNotExists:Bool;
}

/**
	Delete file operation
**/
typedef DeleteFile = ResourceOperation<DeleteFileKind> & {
	/**
		The file to delete.
	**/
	var uri:DocumentUri;

	/**
		Delete options.
	**/
	var ?options:DeleteFileOptions;
}

/**
	A workspace edit represents changes to many resources managed in the workspace. The edit
	should either provide `changes` or `documentChanges`. If documentChanges are present
	they are preferred over `changes` if the client can handle versioned document edits.

	Since version 3.13.0 a workspace edit can contain resource operations as well. If resource
	operations are present clients need to execute the operations in the order in which they
	are provided. So a workspace edit for example can consist of the following two changes:
	(1) a create file a.txt and (2) a text document edit which insert text into file a.txt.

	An invalid sequence (e.g. (1) delete file a.txt and (2) insert text into file a.txt) will
	cause failure of the operation. How the client recovers from the failure is described by
	the client capability: `workspace.workspaceEdit.failureHandling`
**/
typedef WorkspaceEdit = {
	/**
		Holds changes to existing resources.
	**/
	var ?changes:haxe.DynamicAccess<Array<TextEdit>>;

	/**
		Depending on the client capability `workspace.workspaceEdit.resourceOperations` document changes
		are either an array of `TextDocumentEdit`s to express changes to n different text documents
		where each text document edit addresses a specific version of a text document. Or it can contain
		above `TextDocumentEdit`s mixed with create, rename and delete file / folder operations.

		Whether a client supports versioned document edits is expressed via
		`workspace.workspaceEdit.documentChanges` client capability.

		If a client neither supports `documentChanges` nor `workspace.workspaceEdit.resourceOperations` then
		only plain `TextEdit`s using the `changes` property are supported.
	**/
	var ?documentChanges:Array<EitherType<TextDocumentEdit, EitherType<CreateFile, EitherType<RenameFile, DeleteFile>>>>;

	/**
		A map of change annotations that can be referenced in `AnnotatedTextEdit`s or create, rename and
		delete file / folder operations.

		Whether clients honor this property depends on the client capability `workspace.changeAnnotationSupport`.

		@since 3.16.0
	**/
	var ?changeAnnotations:haxe.DynamicAccess<ChangeAnnotation>;
}

/**
	A change to capture text edits for existing resources.
**/
extern interface TextEditChange {
	/**
		Gets all text edits for this change.

		@return An array of text edits.

		@since 3.16.0 - support for annotated text edits. This is usually
		guarded using a client capability.
	**/
	function all():Array<EitherType<TextEdit, AnnotatedTextEdit>>;

	/**
		Clears the edits for this change.
	**/
	function clear():Void;

	/**
		Adds a text edit.

		@param edit the text edit to add.

		@since 3.16.0 - support for annotated text edits. This is usually
		guarded using a client capability.
	**/
	function add(edit:EitherType<TextEdit, AnnotatedTextEdit>):Void;

	/**
		Insert the given text at the given position.

		@param position A position.
		@param newText A string.
		@param annotation An optional annotation.
	**/
	extern overload function insert(position:Position, newText:String):Void;

	extern overload function insert(position:Position, newText:String,
		annotation:EitherType<ChangeAnnotation, ChangeAnnotationIdentifier>):ChangeAnnotationIdentifier;

	/**
		Replace the given range with given text for the given resource.

		@param range A range.
		@param newText A string.
		@param annotation An optional annotation.
	**/
	extern overload function replace(range:Range, newText:String):Void;

	extern overload function replace(range:Range, newText:String,
		?annotation:EitherType<ChangeAnnotation, ChangeAnnotationIdentifier>):ChangeAnnotationIdentifier;

	/**
		Delete the text at the given range.

		@param range A range.
		@param annotation An optional annotation.
	**/
	extern overload function delete(range:Range):Void;

	extern overload function delete(range:Range, ?annotation:EitherType<ChangeAnnotation, ChangeAnnotationIdentifier>):ChangeAnnotationIdentifier;
}

/**
	A literal to identify a text document in the client.
**/
typedef TextDocumentIdentifier = {
	/**
		The text document's uri.
	**/
	var uri:DocumentUri;
}

/**
	An identifier to denote a specific version of a text document.
**/
typedef VersionedTextDocumentIdentifier = TextDocumentIdentifier & {
	/**
		The version number of this document. If a versioned text document identifier
		is sent from the server to the client and the file is not open in the editor
		(the server has not received an open notification before) the server can send
		`null` to indicate that the version is known and the content on disk is the
		truth (as speced with document content ownership).
	**/
	var version:Int;
}

/**
	A text document identifier to optionally denote a specific version of a text document.
**/
typedef OptionalVersionedTextDocumentIdentifier = TextDocumentIdentifier & {
	/**
		The version number of this document. If a versioned text document identifier
		is sent from the server to the client and the file is not open in the editor
		(the server has not received an open notification before) the server can send
		`null` to indicate that the version is unknown and the content on disk is the
		truth (as specified with document content ownership).
	**/
	var version:Null<Int>;
}

/**
	An item to transfer a text document from the client to the server.
**/
typedef TextDocumentItem = {
	/**
		The text document's uri.
	**/
	var uri:DocumentUri;

	/**
		The text document's language identifier.
	**/
	var languageId:String;

	/**
		The version number of this document (it will strictly increase after each change, including undo/redo).
	**/
	var version:Int;

	/**
		The content of the opened text document.
	**/
	var text:String;
}

/**
	Describes the content type that a client supports in various
	result literals like `Hover`, `ParameterInfo` or `CompletionItem`.

	Please note that `MarkupKinds` must not start with a `$`. This kinds
	are reserved for internal usage.
**/
enum abstract MarkupKind(String) {
	/**
		Plain text is supported as a content format
	**/
	var PlainText = "plaintext";

	/**
		Markdown is supported as a content format
	**/
	var MarkDown = "markdown";
}

/**
	A `MarkupContent` literal represents a string value which content is interpreted base on its
	kind flag. Currently the protocol supports `plaintext` and `markdown` as markup kinds.

	If the kind is `markdown` then the value can contain fenced code blocks like in GitHub issues.
	See https://help.github.com/articles/creating-and-highlighting-code-blocks/#syntax-highlighting

	Here is an example how such a string can be constructed using JavaScript / TypeScript:
	```ts
	let markdown: MarkdownContent = {
		kind: MarkupKind.Markdown,
		value: [
			'# Header',
			'Some text',
			'```typescript',
			'someCode();',
			'```'
		].join('\n')
	};
	```

	*Please Note* that clients might sanitize the return markdown. A client could decide to
	remove HTML from the markdown to avoid script execution.
**/
typedef MarkupContent = {
	/**
		The type of the Markup
	**/
	var kind:MarkupKind;

	/**
		The content itself
	**/
	var value:String;
}

/**
	The kind of a completion entry.
**/
enum abstract CompletionItemKind(Int) to Int {
	var Text = 1;
	var Method;
	var Function;
	var Constructor;
	var Field;
	var Variable;
	var Class;
	var Interface;
	var Module;
	var Property;
	var Unit;
	var Value;
	var Enum;
	var Keyword;
	var Snippet;
	var Color;
	var File;
	var Reference;
	var Folder;
	var EnumMember;
	var Constant;
	var Struct;
	var Event;
	var Operator;
	var TypeParameter;
}

/**
	Defines whether the insert text in a completion item should be interpreted as
	plain text or a snippet.
**/
enum abstract InsertTextFormat(Int) {
	/**
		The primary text to be inserted is treated as a plain string.
	**/
	var PlainText = 1;

	/**
		The primary text to be inserted is treated as a snippet.

		A snippet can define tab stops and placeholders with `$1`, `$2`
		and `${3:foo}`. `$0` defines the final tab stop, it defaults to
		the end of the snippet. Placeholders with equal identifiers are linked,
		that is typing in one will update others too.

		See also: https://github.com/Microsoft/vscode/blob/master/src/vs/editor/contrib/snippet/common/snippet.md
	**/
	var Snippet = 2;
}

/**
	Completion item tags are extra annotations that tweak the rendering of a completion
	item.

	@since 3.15.0
**/
enum abstract CompletionItemTag(Int) {
	/**
		Render a completion as obsolete, usually using a strike-out.
	**/
	var Deprecated = 1;
}

/**
	A special text edit to provide an insert and a replace operation.

	@since 3.16.0
**/
typedef InsertReplaceEdit = {
	/**
		The string to be inserted.
	**/
	var newText:String;

	/**
		The range if the insert is requested
	**/
	var insert:Range;

	/**
		The range if the replace is requested.
	**/
	var replace:Range;
}

/**
	How whitespace and indentation is handled during completion
	item insertion.

	@since 3.16.0
**/
enum abstract InsertTextMode(Int) {
	/**
		The insertion or replace strings is taken as it is. If the
		value is multi line the lines below the cursor will be
		inserted using the indentation defined in the string value.
		The client will not apply any kind of adjustments to the
		string.
	**/
	var asIs = 1;

	/**
		The editor adjusts leading whitespace of new lines so that
		they match the indentation up to the cursor of the line for
		which the item is accepted.

		Consider a line like this: <2tabs><cursor><3tabs>foo. Accepting a
		multi line completion item is indented using 2 tabs and all
		following lines inserted will be indented using 2 tabs as well.
	**/
	var adjustIndentation = 2;
}

/**
	Additional details for a completion item label.

	@since 3.17.0
**/
typedef CompletionItemLabelDetails = {
	/**
		An optional string which is rendered less prominently directly after {@link CompletionItem.label label},
		without any spacing. Should be used for function signatures or type annotations.
	**/
	var ?detail:String;

	/**
		An optional string which is rendered less prominently after {@link CompletionItem.detail}. Should be used
		for fully qualified names or file path.
	**/
	var ?description:String;
}

/**
	A completion item represents a text snippet that is
	proposed to complete text that is being typed.
**/
typedef CompletionItem = {
	/**
		The label of this completion item.
		By default also the text that is inserted when selecting this completion.
	**/
	var label:String;

	/**
		Additional details for the label

		@since 3.17.0
	**/
	var ?labelDetails:CompletionItemLabelDetails;

	/**
		The kind of this completion item.
		Based of the kind an icon is chosen by the editor.
	**/
	var ?kind:CompletionItemKind;

	/**
		Tags for this completion item.

		@since 3.15.0
	**/
	var ?tags:Array<CompletionItemTag>;

	/**
		A human-readable string with additional information about this item, like type or symbol information.
	**/
	var ?detail:String;

	/**
		A human-readable string that represents a doc-comment.
	**/
	var ?documentation:EitherType<String, MarkupContent>;

	/**
		Indicates if this item is deprecated.
	**/
	@:deprecated("Use `tags` instead.")
	var ?deprecated:Bool;

	/**
		Select this item when showing.

		*Note* that only one completion item can be selected and that the
		tool / client decides which item that is. The rule is that thefirst*
		item of those that match best is selected.
	**/
	var ?preselect:Bool;

	/**
		A string that should be used when comparing this item with other items.
		When `falsy` the label is used.
	**/
	var ?sortText:String;

	/**
		A string that should be used when filtering a set of completion items.
		When `falsy` the label is used.
	**/
	var ?filterText:String;

	/**
		A string that should be inserted into a document when selecting
		this completion. When `falsy` the [label](#CompletionItem.label)
		is used.

		The `insertText` is subject to interpretation by the client side.
		Some tools might not take the string literally. For example
		VS Code when code complete is requested in this example
		`con<cursor position>` and a completion item with an `insertText` of
		`console` is provided it will only insert `sole`. Therefore it is
		recommended to use `textEdit` instead since it avoids additional client
		side interpretation.
	**/
	var ?insertText:String;

	/**
		The format of the insert text. The format applies to both the
		`insertText` property and the `newText` property of a provided
		`textEdit`. If omitted defaults to `InsertTextFormat.PlainText`.

		Please note that the insertTextFormat doesn't apply to
		`additionalTextEdits`.
	**/
	var ?insertTextFormat:InsertTextFormat;

	/**
		How whitespace and indentation is handled during completion
		item insertion. If ignored the clients default value depends on
		the `textDocument.completion.insertTextMode` client capability.

		@since 3.16.0
	**/
	var ?insertTextMode:InsertTextMode;

	/**
		An [edit](#TextEdit) which is applied to a document when selecting
		this completion. When an edit is provided the value of
		[insertText](#CompletionItem.insertText) is ignored.

		Most editors support two different operation when accepting a completion
		item. One is to insert a completion text and the other is to replace an
		existing text with a completion text. Since this can usually not
		predetermined by a server it can report both ranges. Clients need to
		signal support for `InsertReplaceEdits` via the
		`textDocument.completion.insertReplaceSupport` client capability
		property.

		*Note 1:* The text edit's range as well as both ranges from a insert
		replace edit must be a [single line] and they must contain the position
		at which completion has been requested.
		*Note 2:* If an `InsertReplaceEdit` is returned the edit's insert range
		must be a prefix of the edit's replace range, that means it must be
		contained and starting at the same position.

		@since 3.16.0 additional type `InsertReplaceEdit` - Proposed state
	**/
	var ?textEdit:EitherType<TextEdit, InsertReplaceEdit>;

	/**
		The edit text used if the completion item is part of a CompletionList and
		CompletionList defines an item default for the text edit range.

		Clients will only honor this property if they opt into completion list
		item defaults using the capability `completionList.itemDefaults`.

		If not provided and a list's default range is provided the label
		property is used as a text.

		@since 3.17.0
	**/
	var ?textEditText:String;

	/**
		An optional array of additional [text edits](#TextEdit) that are applied when
		selecting this completion. Edits must not overlap (including the same insert position)
		with the main [edit](#CompletionItem.textEdit) nor with themselves.

		Additional text edits should be used to change text unrelated to the current cursor position
		(for example adding an import statement at the top of the file if the completion item will
		insert an unqualified type).
	**/
	var ?additionalTextEdits:Array<TextEdit>;

	/**
		An optional set of characters that when pressed while this completion is active will accept it first and
		then type that character.Note* that all commit characters should have `length=1` and that superfluous
		characters will be ignored.
	**/
	var ?commitCharacters:Array<String>;

	/**
		An optional command that is executedafter* inserting this completion.Note* that
		additional modifications to the current document should be described with the
		additionalTextEdits-property.
	**/
	var ?command:Command;

	/**
		An data entry field that is preserved on a completion item between a completion and a completion resolve request.
	**/
	var ?data:LSPAny;
}

/**
	Represents a collection of completion items to be presented in the editor.
**/
typedef CompletionList = {
	/**
		This list it not complete. Further typing should result in recomputing this list.
	**/
	var isIncomplete:Bool;

	/**
		In many cases the items of an actual completion result share the same
		value for properties like `commitCharacters` or the range of a text
		edit. A completion list can therefore define item defaults which will
		be used if a completion item itself doesn't specify the value.

		If a completion list specifies a default value and a completion item
		also specifies a corresponding value the one from the item is used.

		Servers are only allowed to return default values if the client
		signals support for this via the `completionList.itemDefaults`
		capability.

		@since 3.17.0
	**/
	var ?itemDefaults:{
		/**
			A default commit character set.

			@since 3.17.0
		**/
		var ?commitCharacters:Array<String>;

		/**
			A default edit range.

			@since 3.17.0
		**/
		var ?editRange:EitherType<Range, {
			var insert:Range;
			var replace:Range;
		}>;

		/**
			A default insert text format.

			@since 3.17.0
		**/
		var ?insertTextFormat:InsertTextFormat;

		/**
			A default insert text mode.

			@since 3.17.0
		**/
		var ?insertTextMode:InsertTextMode;

		/**
			A default data value.

			@since 3.17.0
		**/
		var ?data:LSPAny;
	};

	/**
		The completion items.
	**/
	var items:Array<CompletionItem>;
}

/**
	MarkedString can be used to render human readable text. It is either a markdown string
	or a code-block that provides a language and a code snippet. The language identifier
	is semantically equal to the optional language identifier in fenced code blocks in GitHub
	issues. See https://help.github.com/articles/creating-and-highlighting-code-blocks/#syntax-highlighting

	The pair of a language and a value is an equivalent to markdown:
	```${language}
	${value}
	```

	Note that markdown strings will be sanitized - that means html will be escaped.
**/
@:deprecated("use MarkupContent instead")
typedef MarkedString = EitherType<String, {language:String, value:String}>;

/**
	The result of a hover request.
**/
typedef Hover = {
	/**
		The hover's content.
	**/
	var contents:EitherType<MarkupContent, EitherType<MarkedString, Array<MarkedString>>>;

	/**
		An optional range.
	**/
	var ?range:Range;
}

/**
	Represents a parameter of a callable-signature.
	A parameter can have a label and a doc-comment.
**/
typedef ParameterInformation = {
	/**
		The label of this parameter information.

		Either a string or an inclusive start and exclusive end offsets within its containing
		signature label. (see SignatureInformation.label). The offsets are based on a UTF-16
		string representation as `Position` and `Range` does.

		*Note*: a label of type string should be a substring of its containing signature label.
		Its intended use case is to highlight the parameter label part in the `SignatureInformation.label`.
	**/
	var label:EitherType<String, Array<Int>>;

	/**
		The human-readable doc-comment of this signature.
		Will be shown in the UI but can be omitted.
	**/
	var ?documentation:EitherType<String, MarkupContent>;
}

/**
	Represents the signature of something callable.
	A signature can have a label, like a function-name, a doc-comment, and a set of parameters.
**/
typedef SignatureInformation = {
	/**
		The label of this signature.
		Will be shown in the UI.
	**/
	var label:String;

	/**
		The human-readable doc-comment of this signature.
		Will be shown in the UI but can be omitted.
	**/
	var ?documentation:EitherType<String, MarkupContent>;

	/**
		The parameters of this signature.
	**/
	var ?parameters:Array<ParameterInformation>;

	/**
		The index of the active parameter.

		If provided, this is used in place of `SignatureHelp.activeParameter`.

		@since 3.16.0
	**/
	var ?activeParameter:Int;
}

/**
	Signature help represents the signature of something callable.
	There can be multiple signature but only one active and only one active parameter.
**/
typedef SignatureHelp = {
	/**
		One or more signatures.
	**/
	var signatures:Array<SignatureInformation>;

	/**
		The active signature. Set to `null` if no
		signatures exist.
	**/
	var ?activeSignature:Int;

	/**
		The active parameter of the active signature. Set to `null`
		if the active signature has no parameters.
	**/
	var ?activeParameter:Int;
}

/**
	The definition of a symbol represented as one or many [locations](#Location).
	For most programming languages there is only one location at which a symbol is
	defined.

	Servers should prefer returning `DefinitionLink` over `Definition` if supported
	by the client.
**/
typedef Definition = EitherType<Location, Array<Location>>;

/**
	Information about where a symbol is defined.

	Provides additional metadata over normal [location](#Location) definitions, including the range of
	the defining symbol
**/
typedef DefinitionLink = LocationLink;

/**
	The declaration of a symbol representation as one or many [locations](#Location).
**/
typedef Declaration = EitherType<Location, Array<Location>>;

/**
	Information about where a symbol is declared.

	Provides additional metadata over normal [location](#Location) declarations, including the range of
	the declaring symbol.

	Servers should prefer returning `DeclarationLink` over `Declaration` if supported
	by the client.
**/
typedef DeclarationLink = LocationLink;

/**
	Value-object that contains additional information when
	requesting references.
**/
typedef ReferenceContext = {
	/**
		Include the declaration of the current symbol.
	**/
	var includeDeclaration:Bool;
}

/**
	A document highlight kind.
**/
enum abstract DocumentHighlightKind(Int) to Int {
	/**
		A textual occurrence.
	**/
	var Text = 1;

	/**
		Read-access of a symbol, like reading a variable.
	**/
	var Read;

	/**
		Write-access of a symbol, like writing to a variable.
	**/
	var Write;
}

/**
	A document highlight is a range inside a text document which deserves special attention.
	Usually a document highlight is visualized by changing the background color of its range.
**/
typedef DocumentHighlight = {
	/**
		The range this highlight applies to.
	**/
	var range:Range;

	/**
		The highlight kind, default is `DocumentHighlightKind.Text`.
	**/
	var ?kind:DocumentHighlightKind;
}

/**
	A symbol kind.
**/
enum abstract SymbolKind(Int) to Int {
	var File = 1;
	var Module;
	var Namespace;
	var Package;
	var Class;
	var Method;
	var Property;
	var Field;
	var Constructor;
	var Enum;
	var Interface;
	var Function;
	var Variable;
	var Constant;
	var String;
	var Number;
	var Boolean;
	var Array;
	var Object;
	var Key;
	var Null;
	var EnumMember;
	var Struct;
	var Event;
	var Operator;
	var TypeParameter;
}

/**
	Symbol tags are extra annotations that tweak the rendering of a symbol.
	@since 3.15
**/
enum abstract SymbolTag(Int) {
	/**
		Render a symbol as obsolete, usually using a strike-out.
	**/
	var Deprecated = 1;
}

/**
	A base for all symbol information.
**/
typedef BaseSymbolInformation = {
	/**
		The name of this symbol.
	**/
	var name:String;

	/**
		The kind of this symbol.
	**/
	var kind:SymbolKind;

	/**
		Tags for this completion item.

		@since 3.16.0
	**/
	var ?tags:Array<SymbolTag>;

	/**
		The name of the symbol containing this symbol. This information is for
		user interface purposes (e.g. to render a qualifier in the user interface
		if necessary). It can't be used to re-infer a hierarchy for the document
		symbols.
	**/
	var ?containerName:String;
}

/**
	Represents information about programming constructs like variables, classes, interfaces etc.
**/
typedef SymbolInformation = BaseSymbolInformation & {
	/**
		Indicates if this symbol is deprecated.
	**/
	@:deprecated("Use tags instead")
	var ?deprecated:Bool;

	/**
		The location of this symbol. The location's range is used by a tool
		to reveal the location in the editor. If the symbol is selected in the
		tool the range's start information is used to position the cursor. So
		the range usually spans more than the actual symbol's name and does
		normally include thinks like visibility modifiers.

		The range doesn't have to denote a node range in the sense of a abstract
		syntax tree. It can therefore not be used to re-construct a hierarchy of
		the symbols.
	**/
	var location:Location;
}

/**
	A special workspace symbol that supports locations without a range.

	See also SymbolInformation.

	@since 3.17.0
**/
typedef WorkspaceSymbol = BaseSymbolInformation & {
	/**
		The location of the symbol. Whether a server is allowed to
		return a location without a range depends on the client
		capability `workspace.symbol.resolveSupport`.

		See SymbolInformation#location for more details.
	**/
	var location:EitherType<Location, {
		var uri:DocumentUri;
	}>;

	/**
		A data entry field that is preserved on a workspace symbol between a
		workspace symbol request and a workspace symbol resolve request.
	**/
	var ?data:LSPAny;
}

/**
	Represents programming constructs like variables, classes, interfaces etc.
	that appear in a document. Document symbols can be hierarchical and they
	have two ranges: one that encloses its definition and one that points to
	its most interesting range, e.g. the range of an identifier.
**/
typedef DocumentSymbol = {
	/**
		The name of this symbol. Will be displayed in the user interface and therefore must not be
		an empty string or a string only consisting of white spaces.
	**/
	var name:String;

	/**
		More detail for this symbol, e.g the signature of a function.
	**/
	var ?detail:String;

	/**
		The kind of this symbol.
	**/
	var kind:SymbolKind;

	/**
		Tags for this completion item.

		@since 3.16.0 - Proposed state
	**/
	var ?tags:Array<SymbolTag>;

	/**
		Indicates if this symbol is deprecated.
	**/
	@:deprecated("Use tags instead")
	var ?deprecated:Bool;

	/**
		The range enclosing this symbol not including leading/trailing whitespace but everything else
		like comments. This information is typically used to determine if the the clients cursor is
		inside the symbol to reveal in the symbol in the UI.
	**/
	var range:Range;

	/**
		The range that should be selected and reveal when this symbol is being picked, e.g the name of a function.
		Must be contained by the the `range`.
	**/
	var selectionRange:Range;

	/**
		Children of this symbol, e.g. properties of a class.
	**/
	var ?children:Array<DocumentSymbol>;
}

/**
	The kind of a code action.

	Kinds are a hierarchical list of identifiers separated by `.`, e.g. `"refactor.extract.function"`.

	The set of kinds is open and client needs to announce the kinds it supports to the server during
	initialization.

	This enum has a set of predefined code action kinds.
**/
enum abstract CodeActionKind(String) from String to String {
	/**
		Empty kind.
	**/
	var Empty = '';

	/**
		Base kind for quickfix actions: 'quickfix'
	**/
	var QuickFix = 'quickfix';

	/**
		Base kind for refactoring actions: 'refactor'
	**/
	var Refactor = 'refactor';

	/**
		Base kind for refactoring extraction actions: 'refactor.extract'

		Example extract actions:

		- Extract method
		- Extract function
		- Extract variable
		- Extract interface from class
		- ...
	**/
	var RefactorExtract = 'refactor.extract';

	/**
		Base kind for refactoring inline actions: 'refactor.inline'

		Example inline actions:

		- Inline function
		- Inline variable
		- Inline constant
		- ...
	**/
	var RefactorInline = 'refactor.inline';

	/**
		Base kind for refactoring rewrite actions: 'refactor.rewrite'

		Example rewrite actions:

		- Convert JavaScript function to class
		- Add or remove parameter
		- Encapsulate field
		- Make method static
		- Move method to base class
		- ...
	**/
	var RefactorRewrite = 'refactor.rewrite';

	/**
		Base kind for source actions: `source`

		Source code actions apply to the entire file.
	**/
	var Source = 'source';

	/**
		Base kind for an organize imports source action: `source.organizeImports`
	**/
	var SourceOrganizeImports = 'source.organizeImports';

	/**
		Base kind for auto-fix source actions: `source.fixAll`.

		Fix all actions automatically fix errors that have a clear fix that do not require user input.
		They should not suppress errors or perform unsafe fixes such as generating new types or classes.

		@since 3.15.0
	**/
	var SourceFixAll = 'source.fixAll';
}

/**
	The reason why code actions were requested.

	@since 3.17.0
**/
enum abstract CodeActionTriggerKind(Int) {
	/**
		Code actions were explicitly requested by the user or by an extension.
	**/
	var Invoked = 1;

	/**
		Code actions were requested automatically.

		This typically happens when current selection in a file changes, but can
		also be triggered when file content changes.
	**/
	var Automatic = 2;
}

/**
	Contains additional diagnostic information about the context in which a code action is run.
**/
typedef CodeActionContext = {
	/**
		An array of diagnostics known on the client side overlapping the range provided to the
		`textDocument/codeAction` request. They are provied so that the server knows which
		errors are currently presented to the user for the given range. There is no guarantee
		that these accurately reflect the error state of the resource. The primary parameter
		to compute code actions is the provided range.
	**/
	var diagnostics:Array<Diagnostic>;

	/**
		Requested kind of actions to return.

		Actions not of this kind are filtered out by the client before being shown. So servers
		can omit computing them.
	**/
	var ?only:Array<CodeActionKind>;

	/**
		The reason why code actions were requested.

		@since 3.17.0
	**/
	var ?triggerKind:CodeActionTriggerKind;
}

/**
	A code action represents a change that can be performed in code, e.g. to fix a problem or
	to refactor code.

	A CodeAction must set either `edit` and/or a `command`. If both are supplied, the `edit` is applied first, then the `command` is executed.
**/
typedef CodeAction = {
	/**
		A short, human-readable, title for this code action.
	**/
	var title:String;

	/**
		The kind of the code action.

		Used to filter code actions.
	**/
	var ?kind:CodeActionKind;

	/**
		The diagnostics that this code action resolves.
	**/
	var ?diagnostics:Array<Diagnostic>;

	/**
		Marks this as a preferred action. Preferred actions are used by the `auto fix` command and can be targeted
		by keybindings.

		A quick fix should be marked preferred if it properly addresses the underlying error.
		A refactoring should be marked preferred if it is the most reasonable choice of actions to take.

		@since 3.15.0
	**/
	var ?isPreferred:Bool;

	/**
		Marks that the code action cannot currently be applied.

		Clients should follow the following guidelines regarding disabled code actions:

		  - Disabled code actions are not shown in automatic [lightbulb](https://code.visualstudio.com/docs/editor/editingevolved#_code-action)
			code action menu.

		  - Disabled actions are shown as faded out in the code action menu when the user request a more specific type
			of code action, such as refactorings.

		  - If the user has a [keybinding](https://code.visualstudio.com/docs/editor/refactoring#_keybindings-for-code-actions)
			that auto applies a code action and only a disabled code actions are returned, the client should show the user an
			error message with `reason` in the editor.

		@since 3.16.0
	**/
	var ?disabled:{
		/**
			Human readable description of why the code action is currently disabled.

			This is displayed in the code actions UI.
		**/
		var reason:String;
	};

	/**
		The workspace edit this code action performs.
	**/
	var ?edit:WorkspaceEdit;

	/**
		A command this code action executes. If a code action
		provides a edit and a command, first the edit is
		executed and then the command.
	**/
	var ?command:Command;

	/**
		A data entry field that is preserved on a code action between
		a `textDocument/codeAction` and a `codeAction/resolve` request.

		@since 3.16.0
	**/
	var ?data:LSPAny;
}

/**
	A code lens represents a command that should be shown along with source text,
	like the number of references, a way to run tests, etc.

	A code lens is _unresolved_ when no command is associated to it.
	For performance reasons the creation of a code lens and resolving should be done to two stages.
**/
typedef CodeLens = {
	/**
		The range in which this code lens is valid.
		Should only span a single line.
	**/
	var range:Range;

	/**
		The command this code lens represents.
	**/
	var ?command:Command;

	/**
		An data entry field that is preserved on a code lens item between a code lens and a code lens resolve request.
	**/
	var ?data:LSPAny;
}

/**
	Value-object describing what options formatting should use.
	This object can contain additional fields of type Bool/Int/Float/String.
**/
typedef FormattingOptions = {
	/**
		Size of a tab in spaces.
	**/
	var tabSize:Int;

	/**
		Prefer spaces over tabs.
	**/
	var insertSpaces:Bool;

	/**
		Trim trailing whitespaces on a line.

		@since 3.15.0
	**/
	var ?trimTrailingWhitespace:Bool;

	/**
		Insert a newline character at the end of the file if one does not exist.

		@since 3.15.0
	**/
	var ?insertFinalNewline:Bool;

	/**
		Trim all newlines after the final newline at the end of the file.

		@since 3.15.0
	**/
	var ?trimFinalNewlines:Bool;
}

/**
	A document link is a range in a text document that links to an internal or external resource, like another
	text document or a web site.
**/
typedef DocumentLink = {
	/**
		The range this link applies to.
	**/
	var range:Range;

	/**
		The uri this link points to. If missing a resolve request is sent later.
	**/
	var ?target:String;

	/**
		The tooltip text when you hover over this link.

		If a tooltip is provided, is will be displayed in a string that includes instructions on how to
		trigger the link, such as `{0} (ctrl + click)`. The specific instructions vary depending on OS,
		user settings, and localization.

		@since 3.15.0
	**/
	var ?tooltip:String;

	/**
		A data entry field that is preserved on a document link between a
		DocumentLinkRequest and a DocumentLinkResolveRequest.
	**/
	var ?data:LSPAny;
}

/**
	A selection range represents a part of a selection hierarchy. A selection range
	may have a parent selection range that contains it.
**/
typedef SelectionRange = {
	/**
		The [range](#Range) of this selection range.
	**/
	var range:Range;

	/**
		The parent selection range containing this range. Therefore `parent.range` must contain `this.range`.
	**/
	var ?parent:SelectionRange;
}

/**
	Represents programming constructs like functions or constructors in the context
	of call hierarchy.

	@since 3.16.0
**/
typedef CallHierarchyItem = {
	/**
		The name of this item.
	**/
	var name:String;

	/**
		The kind of this item.
	**/
	var kind:SymbolKind;

	/**
		Tags for this item.
	**/
	var ?tags:Array<SymbolTag>;

	/**
		More detail for this item, e.g. the signature of a function.
	**/
	var ?etail:String;

	/**
		The resource identifier of this item.
	**/
	var ?uri:DocumentUri;

	/**
		The range enclosing this symbol not including leading/trailing whitespace but everything else, e.g. comments and code.
	**/
	var ?range:Range;

	/**
		The range that should be selected and revealed when this symbol is being picked, e.g. the name of a function.
		Must be contained by the [`range`](#CallHierarchyItem.range).
	**/
	var ?selectionRange:Range;

	/**
		A data entry field that is preserved between a call hierarchy prepare and
		incoming calls or outgoing calls requests.
	**/
	var ?data:LSPAny;
}

/**
	Represents an incoming call, e.g. a caller of a method or constructor.

	@since 3.16.0
**/
typedef CallHierarchyIncomingCall = {
	/**
		The item that makes the call.
	**/
	var from:CallHierarchyItem;

	/**
		The ranges at which the calls appear. This is relative to the caller
		denoted by [`this.from`](#CallHierarchyIncomingCall.from).
	**/
	var fromRanges:Array<Range>;
}

/**
	Represents an outgoing call, e.g. calling a getter from a method or a method from a constructor etc.

	@since 3.16.0
**/
typedef CallHierarchyOutgoingCall = {
	/**
		The item that is called.
	**/
	var to:CallHierarchyItem;

	/**
		The range at which this item is called. This is the range relative to the caller, e.g the item
		passed to [`provideCallHierarchyOutgoingCalls`](#CallHierarchyItemProvider.provideCallHierarchyOutgoingCalls)
		and not [`this.to`](#CallHierarchyOutgoingCall.to).
	**/
	var fromRanges:Array<Range>;
}

/**
	A set of predefined token types. This set is not fixed
	an clients can specify additional token types via the
	corresponding client capabilities.

	@since 3.16.0
**/
enum abstract SemanticTokenTypes(String) {
	var namespace = 'namespace';

	/**
		Represents a generic type. Acts as a fallback for types which can't be mapped to
		a specific type like class or enum.
	**/
	var Type = 'type';

	var Class = 'class';
	var Enum = 'enum';
	var Interface = 'interface';
	var Struct = 'struct';
	var TypeParameter = 'typeParameter';
	var Parameter = 'parameter';
	var Variable = 'variable';
	var Property = 'property';
	var EnumMember = 'enumMember';
	var Event = 'event';
	var Function = 'function';
	var Method = 'method';
	var Macro = 'macro';
	var Keyword = 'keyword';
	var Modifier = 'modifier';
	var Comment = 'comment';
	var StringToken = 'string';
	var Number = 'number';
	var Regexp = 'regexp';
	var Operator = 'operator';

	/**
		@since 3.17.0
	**/
	var Decorator = 'decorator';
}

/**
	A set of predefined token modifiers. This set is not fixed
	an clients can specify additional token types via the
	corresponding client capabilities.

	@since 3.16.0
**/
enum abstract SemanticTokenModifiers(String) {
	var Declaration = 'declaration';
	var Definition = 'definition';
	var Readonly = 'readonly';
	var Static = 'static';
	var Deprecated = 'deprecated';
	var Abstract = 'abstract';
	var Async = 'async';
	var Modification = 'modification';
	var Documentation = 'documentation';
	var DefaultLibrary = 'defaultLibrary';
}

/**
	@since 3.16.0
**/
typedef SemanticTokensLegend = {
	/**
		The token types a server uses.
	**/
	var tokenTypes:Array<String>;

	/**
		The token modifiers a server uses.
	**/
	var tokenModifiers:Array<String>;
}

/**
	@since 3.16.0
**/
typedef SemanticTokens = {
	/**
		An optional result id. If provided and clients support delta updating
		the client will include the result id in the next semantic token request.
		A server can then instead of computing all semantic tokens again simply
		send a delta.
	**/
	var ?resultId:String;

	/**
		The actual tokens.
	**/
	var data:Array<Int>;
}

/**
	@since 3.16.0
**/
typedef SemanticTokensEdit = {
	/**
		The start offset of the edit.
	**/
	var start:Int;

	/**
		The count of elements to remove.
	**/
	var deleteCount:Int;

	/**
		The elements to insert.
	**/
	var ?data:Array<Int>;
}

/**
	@since 3.16.0
**/
typedef SemanticTokensDelta = {
	var ?resultId:String;

	/**
		The semantic token edits to transform a previous result into a new result.
	**/
	var ?edits:Array<SemanticTokensEdit>;
}

/**
	@since 3.17.0
**/
typedef TypeHierarchyItem = {
	/**
		The name of this item.
	**/
	var name:String;

	/**
		The kind of this item.
	**/
	var kind:SymbolKind;

	/**
		Tags for this item.
	**/
	var ?tags:Array<SymbolTag>;

	/**
		More detail for this item, e.g. the signature of a function.
	**/
	var ?detail:String;

	/**
		The resource identifier of this item.
	**/
	var uri:DocumentUri;

	/**
		The range enclosing this symbol not including leading/trailing whitespace
		but everything else, e.g. comments and code.
	**/
	var range:Range;

	/**
		The range that should be selected and revealed when this symbol is being
		picked, e.g. the name of a function. Must be contained by the
		[`range`](#TypeHierarchyItem.range).
	**/
	var selectionRange:Range;

	/**
		A data entry field that is preserved between a type hierarchy prepare and
		supertypes or subtypes requests. It could also be used to identify the
		type hierarchy in the server, helping improve the performance on
		resolving supertypes and subtypes.
	**/
	var ?data:LSPAny;
};

/**
	Provide inline value as text.

	@since 3.17.0
**/
typedef InlineValueText = {
	/**
		The document range for which the inline value applies.
	**/
	var range:Range;

	/**
		The text of the inline value.
	**/
	var text:String;
};

/**
	Provide inline value through a variable lookup.
	If only a range is specified, the variable name will be extracted from the underlying document.
	An optional variable name can be used to override the extracted name.

	@since 3.17.0
**/
typedef InlineValueVariableLookup = {
	/**
		The document range for which the inline value applies.
		The range is used to extract the variable name from the underlying document.
	**/
	var range:Range;

	/**
		If specified the name of the variable to look up.
	**/
	var ?variableName:String;

	/**
		How to perform the lookup.
	**/
	var caseSensitiveLookup:Bool;
};

/**
	Provide an inline value through an expression evaluation.
	If only a range is specified, the expression will be extracted from the underlying document.
	An optional expression can be used to override the extracted expression.

	@since 3.17.0
**/
typedef InlineValueEvaluatableExpression = {
	/**
		The document range for which the inline value applies.
		The range is used to extract the evaluatable expression from the underlying document.
	**/
	var range:Range;

	/**
		If specified the expression overrides the extracted expression.
	**/
	var ?expression:String;
};

/**
	Inline value information can be provided by different means:
	- directly as a text value (class InlineValueText).
	- as a name to use for a variable lookup (class InlineValueVariableLookup)
	- as an evaluatable expression (class InlineValueEvaluatableExpression)
	The InlineValue types combines all inline value types into one type.

	@since 3.17.0
**/
typedef InlineValue = EitherType<InlineValueText, EitherType<InlineValueVariableLookup, InlineValueEvaluatableExpression>>;

/**
	@since 3.17.0
**/
typedef InlineValueContext = {
	/**
		The stack frame (as a DAP Id) where the execution has stopped.
	**/
	var frameId:Float;

	/**
		The document range where execution has stopped.
		Typically the end position of the range denotes the line where the inline values are shown.
	**/
	var stoppedLocation:Range;
};

/**
	Inlay hint kinds.

	@since 3.17.0
**/
enum abstract InlayHintKind(Int) {
	/**
		An inlay hint that for a type annotation.
	**/
	var Type = 1;

	/**
		An inlay hint that is for a parameter.
	**/
	var Parameter = 2;
}

/**
	An inlay hint label part allows for interactive and composite labels
	of inlay hints.

	@since 3.17.0
**/
typedef InlayHintLabelPart = {
	/**
		The value of this label part.
	**/
	var value:String;

	/**
		The tooltip text when you hover over this label part. Depending on
		the client capability `inlayHint.resolveSupport` clients might resolve
		this property late using the resolve request.
	**/
	var ?tooltip:EitherType<String, MarkupContent>;

	/**
		An optional source code location that represents this
		label part.

		The editor will use this location for the hover and for code navigation
		features: This part will become a clickable link that resolves to the
		definition of the symbol at the given location (not necessarily the
		location itself), it shows the hover that shows at the given location,
		and it shows a context menu with further code navigation commands.

		Depending on the client capability `inlayHint.resolveSupport` clients
		might resolve this property late using the resolve request.
	**/
	var ?location:Location;

	/**
		An optional command for this label part.

		Depending on the client capability `inlayHint.resolveSupport` clients
		might resolve this property late using the resolve request.
	**/
	var ?command:Command;
};

/**
	Inlay hint information.

	@since 3.17.0
**/
typedef InlayHint = {
	/**
		The position of this hint.
	**/
	var position:Position;

	/**
		The label of this hint. A human readable string or an array of
		InlayHintLabelPart label parts.

		*Note* that neither the string nor the label part can be empty.
	**/
	var label:EitherType<String, Array<InlayHintLabelPart>>;

	/**
		The kind of this hint. Can be omitted in which case the client
		should fall back to a reasonable default.
	**/
	var ?kind:InlayHintKind;

	/**
		Optional text edits that are performed when accepting this inlay hint.

		*Note* that edits are expected to change the document so that the inlay
		hint (or its nearest variant) is now part of the document and the inlay
		hint itself is now obsolete.
	**/
	var ?textEdits:Array<TextEdit>;

	/**
		The tooltip text when you hover over this item.
	**/
	var ?tooltip:EitherType<String, MarkupContent>;

	/**
		Render padding before the hint.

		Note: Padding should use the editor's background color, not the
		background color of the hint itself. That means padding can be used
		to visually align/separate an inlay hint.
	**/
	var ?paddingLeft:Bool;

	/**
		Render padding after the hint.

		Note: Padding should use the editor's background color, not the
		background color of the hint itself. That means padding can be used
		to visually align/separate an inlay hint.
	**/
	var ?paddingRight:Bool;

	/**
		A data entry field that is preserved on a inlay hint between
		a `textDocument/inlayHint` and a `inlayHint/resolve` request.
	**/
	var ?data:LSPAny;
};

/**
	A workspace folder inside a client.
**/
typedef WorkspaceFolder = {
	/**
		The associated URI for this workspace folder.
	**/
	var uri:DocumentUri;

	/**
		The name of the workspace folder. Used to refer to this
		workspace folder in thge user interface.
	**/
	var name:String;
}

/**
	A simple text document. Not to be implemented. The document keeps the content
	as string.
 */
@:deprecated("Use the text document from the new vscode-languageserver-textdocument package.")
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
}
