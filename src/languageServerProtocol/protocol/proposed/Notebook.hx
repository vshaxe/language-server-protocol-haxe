package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	Notebook specific client capabilities.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocumentSyncClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is
		set to `true` the client supports the new
		`(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;

	/**
		The client supports sending execution summary data per cell.
	**/
	var ?executionSummarySupport:Bool;
};

/**
	A notebook cell kind.

	@since 3.17.0
	@proposed
**/
enum abstract NotebookCellKind(Int) {
	/**
		A markup-cell is formatted source that is used for display.
	**/
	var Markup = 1;

	/**
		A code-cell is source code.
	**/
	var Code = 2;
}

typedef ExecutionSummary = {
	/**
		A strict monotonically increasing value
		indicating the execution order of a cell
		inside a notebook.
	**/
	var executionOrder:Int;

	/**
		Whether the execution was successful or
		not if known by the client.
	**/
	var success:Bool;
};

/**
	A notebook cell.

	A cell's document URI must be unique across ALL notebook
	cells and can therefore be used to uniquely identify a
	notebook cell or the cell's text document.

	@since 3.17.0
	@proposed
**/
typedef NotebookCell = {
	/**
		The cell's kind
	**/
	var kind:NotebookCellKind;

	/**
		The URI of the cell's text document
		content.
	**/
	var document:DocumentUri;

	/**
		Additional metadata stored with the cell.
	**/
	var ?metadata:LSPObject;

	/**
		Additional execution summary information
		if supported by the client.
	**/
	var executionSummary:ExecutionSummary;
};

/**
	A notebook document.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocument = {
	/**
		The notebook document's uri.
	**/
	var uri:URI;

	/**
		The type of the notebook.
	**/
	var notebookType:String;

	/**
		The version number of this document (it will increase after each
		change, including undo/redo).
	**/
	var version:Int;

	/**
		Additional metadata stored with the notebook
		document.
	**/
	var ?metadata:LSPObject;

	/**
		The cells of a notebook.
	**/
	var cells:Array<NotebookCell>;
};

/**
	A literal to identify a notebook document in the client.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocumentIdentifier = {
	/**
		The notebook document's uri.
	**/
	var uri:URI;
};

/**
	A versioned notebook document identifier.

	@since 3.17.0
	@proposed
**/
typedef VersionedNotebookDocumentIdentifier = {
	/**
		The version number of this notebook document.
	**/
	var version:Int;

	/**
		The notebook document's uri.
	**/
	var uri:URI;
};

/**
	Options specific to a notebook plus its cells
	to be synced to the server.

	If a selector provide a notebook document
	filter but no cell selector all cells of a
	matching notebook document will be synced.

	If a selector provides no notebook document
	filter but only a cell selector all notebook
	document that contain at least one matching
	cell will be synced.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocumentSyncOptions = {
	/**
		The notebooks to be synced
	**/
	var notebookSelector:Array<{
		/**
			The notebook to be synced If a string
			 	 	value is provided it matches against the
			notebook type. '*' matches every notebook.
		**/
		var ?notebook:EitherType<String, NotebookDocumentFilter>;

		/**
			The cells of the matching notebook to be synced.
		**/
		var ?cells:Array<{var language:String;}>;
	}>;

	/**
		Whether save notification should be forwarded to
		the server. Will only be honored if mode === `notebook`.
	**/
	var ?save:Bool;
};

/**
	Registration options specific to a notebook.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocumentSyncRegistrationOptions = NotebookDocumentSyncOptions & StaticRegistrationOptions;

class NotebookDocumentSyncRegistrationType {
	public static inline final type = new RegistrationType<NotebookDocumentSyncRegistrationOptions>("notebookDocument/sync");
}

/**
	The params sent in a open notebook document notification.

	@since 3.17.0
	@proposed
**/
typedef DidOpenNotebookDocumentParams = {
	/**
		The notebook document that got opened.
	**/
	var notebookDocument:NotebookDocument;

	/**
		The text documents that represent the content
		of a notebook cell.
	**/
	var cellTextDocuments:Array<TextDocumentItem>;
};

/**
	A notification sent when a notebook opens.

	@since 3.17.0
	@proposed
**/
class DidOpenNotebookDocumentNotification {
	public static inline final type = new ProtocolNotificationType<DidOpenNotebookDocumentParams, NoData>("notebookDocument/didOpen");
}

/**
	A change describing how to move a `NotebookCell`
	array from state S to S'.

	@since 3.17.0
	@proposed
**/
typedef NotebookCellArrayChange = {
	/**
		The start oftest of the cell that changed.
	**/
	var start:Int;

	/**
		The deleted cells
	**/
	var deleteCount:Int;

	/**
		The new cells, if any
	**/
	var ?cells:Array<NotebookCell>;
};

/**
	A change event for a notebook document.

	@since 3.17.0
	@proposed
**/
typedef NotebookDocumentChangeEvent = {
	/**
		The changed meta data if any.
	**/
	var ?metadata:LSPObject;

	/**
		Changes to cells
	**/
	var ?cells:{
		/**
			Changes to the cell structure to add or
			remove cells.
		**/
		var ?structure:{
			/**
				The change to the cell array.
			**/
			var array:NotebookCellArrayChange;

			/**
				Additional opened cell text documents.
			**/
			var ?didOpen:Array<TextDocumentItem>;

			/**
				Additional closed cell text documents.
			**/
			var ?didClose:Array<TextDocumentIdentifier>;
		};

		/**
			Changes to notebook cells properties like its
			kind, execution summary or metadata.
		**/
		var ?data:Array<NotebookCell>;

		/**
			Changes to the text content of notebook cells.
		**/
		var ?textContent:Array<{
			var document:VersionedTextDocumentIdentifier;
			var changes:Array<TextDocumentContentChangeEvent>;
		}>;
	};
};

/**
	The params sent in a change notebook document notification.

	@since 3.17.0
	@proposed
**/
typedef DidChangeNotebookDocumentParams = {
	/**
		The notebook document that did change. The version number points
		to the version after all provided changes have been applied. If
		only the text document content of a cell changes the notebook version
		doesn't necessarily have to change.
	**/
	var notebookDocument:VersionedNotebookDocumentIdentifier;

	/**
		The actual changes to the notebook document.

		The changes describe single state changes to the notebook document.
		So if there are two changes c1 (at array index 0) and c2 (at array
		index 1) for a notebook in state S then c1 moves the notebook from
		S to S' and c2 from S' to S''. So c1 is computed on the state S and
		c2 is computed on the state S'.

		To mirror the content of a notebook using change events use the following approach:
		- start with the same initial content
		- apply the 'notebookDocument/didChange' notifications in the order you receive them.
		- apply the `NotebookChangeEvent`s in a single notification in the order
		  you receive them.
	**/
	var change:NotebookDocumentChangeEvent;
};

class DidChangeNotebookDocumentNotification {
	public static inline final type = new ProtocolNotificationType<DidChangeNotebookDocumentParams, NoData>("notebookDocument/didChange");
}

/**
	The params sent in a save notebook document notification.

	@since 3.17.0
	@proposed
**/
typedef DidSaveNotebookDocumentParams = {
	/**
		The notebook document that got saved.
	**/
	var notebookDocument:NotebookDocumentIdentifier;
};

/**
	A notification sent when a notebook document is saved.

	@since 3.17.0
	@proposed
**/
class DidSaveNotebookDocumentNotification {
	public static inline final type = new ProtocolNotificationType<DidSaveNotebookDocumentParams, NoData>("notebookDocument/didSave");
}

/**
	The params sent in a close notebook document notification.

	@since 3.17.0
	@proposed
**/
typedef DidCloseNotebookDocumentParams = {
	/**
		The notebook document that got closed.
	**/
	var notebookDocument:NotebookDocumentIdentifier;

	/**
		The text documents that represent the content
		of a notebook cell that got closed.
	**/
	var cellTextDocuments:Array<TextDocumentIdentifier>;
};

/**
	A notification sent when a notebook closes.

	@since 3.17.0
	@proposed
**/
class DidCloseNotebookDocumentNotification {
	public static inline final type = new ProtocolNotificationType<DidCloseNotebookDocumentParams, NoData>("notebookDocument/didClose");
}
