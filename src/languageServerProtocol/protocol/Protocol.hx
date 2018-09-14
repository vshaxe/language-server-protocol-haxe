package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.ColorProvider;
import languageServerProtocol.protocol.Configuration;
import languageServerProtocol.protocol.Implementation;
import languageServerProtocol.protocol.TypeDefinition;
import languageServerProtocol.protocol.WorkspaceFolders;
import languageServerProtocol.protocol.FoldingRange;
import haxe.extern.EitherType;
import jsonrpc.Types;

/**
	Method names for the protocol requests and notifications.
	Each value must be typed as either `RequestMethod` or `NotificationMethod`.
**/
@:publicFields
class Methods {
	/**
		The `client/registerCapability` request is sent from the server to the client to register a new capability
		handler on the client side.
	**/
	static inline var RegisterCapability = new RequestMethod<RegistrationParams, NoData, NoData, NoData>("client/registerCapability");

	/**
		The `client/unregisterCapability` request is sent from the server to the client to unregister a previously registered capability
		handler on the client side.
	**/
	static inline var UnregisterCapability = new RequestMethod<UnregistrationParams, NoData, NoData, NoData>("client/unregisterCapability");

	/**
		The initialize request is sent from the client to the server.
		It is sent once as the request after starting up the server.
		The requests parameter is of type `InitializeParams`
		the response if of type `InitializeResult` of a Thenable that
		resolves to such.
	**/
	static inline var Initialize = new RequestMethod<InitializeParams, InitializeResult, InitializeError, NoData>("initialize");

	/**
		The initialized notification is sent from the client to the server after the client received the result of the initialize request
		but before the client is sending any other request or notification to the server. The server can use the initialized notification
		for example to dynamically register capabilities.
	**/
	static inline var Initialized = new NotificationMethod<InitializedParams, NoData>("initialized");

	/**
		A shutdown request is sent from the client to the server.
		It is sent once when the client decides to shutdown the
		server. The only notification that is sent after a shutdown request
		is the exit event.
	**/
	static inline var Shutdown = new RequestMethod<NoData, NoData, NoData, NoData>("shutdown");

	/**
		A notification to ask the server to exit its process.
		The server should exit with success code 0 if the shutdown request has been received before; otherwise with error code 1.
	**/
	static inline var Exit = new NotificationMethod<NoData, NoData>("exit");

	/**
		A notification send from the client to the server to signal the change of configuration settings.
	**/
	static inline var DidChangeConfiguration = new NotificationMethod<DidChangeConfigurationParams, DidChangeConfigurationRegistrationOptions>
		("workspace/didChangeConfiguration");

	/**
		The show message notification is sent from a server to a client to ask the client to display a particular message in the user interface.
	**/
	static inline var ShowMessage = new NotificationMethod<ShowMessageParams, NoData>("window/showMessage");

	/**
		The show message request is sent from the server to the client to show a message
		and a set of options actions to the user.
	**/
	static inline var ShowMessageRequest = new RequestMethod<ShowMessageRequestParams, Null<MessageActionItem>, NoData, NoData>("window/showMessageRequest");

	/**
		The log message notification is send from the server to the client to ask the client to log a particular message.
	**/
	static inline var LogMessage = new NotificationMethod<LogMessageParams, NoData>("window/logMessage");

	/**
		The telemetry notification is sent from the server to the client to ask the client to log a telemetry event.
	**/
	static inline var Telemetry = new NotificationMethod<Dynamic, NoData>("telemetry/event");

	/**
		The document open notification is sent from the client to the server to signal newly opened text documents. The document’s truth is now managed by the client and the server must not try to read the document’s truth using the document’s uri. Open in this sense means it is managed by the client. It doesn’t necessarily mean that its content is presented in an editor. An open notification must not be sent more than once without a corresponding close notification send before. This means open and close notification must be balanced and the max open count for a particular textDocument is one.
	**/
	static inline var DidOpenTextDocument = new NotificationMethod<DidOpenTextDocumentParams, TextDocumentRegistrationOptions>("textDocument/didOpen");

	/**
		The document change notification is sent from the client to the server to signal changes to a text document.
	**/
	static inline var DidChangeTextDocument = new NotificationMethod<DidChangeTextDocumentParams, TextDocumentChangeRegistrationOptions>
		("textDocument/didChange");

	/**
		The document close notification is sent from the client to the server when
		the document got closed in the client. The document's truth now exists where
		the document's uri points to (e.g. if the document's uri is a file uri the
		truth now exists on disk). As with the open notification the close notification
		is about managing the document's content. Receiving a close notification
		doesn't mean that the document was open in an editor before. A close
		notification requires a previous open notification to be sent.
	**/
	static inline var DidCloseTextDocument = new NotificationMethod<DidCloseTextDocumentParams, TextDocumentRegistrationOptions>("textDocument/didClose");

	/**
		The document save notification is sent from the client to the server when the document for saved in the clinet.
	**/
	static inline var DidSaveTextDocument = new NotificationMethod<DidSaveTextDocumentParams, TextDocumentSaveRegistrationOptions>("textDocument/didSave");

	/**
		The document will save notification is sent from the client to the server before the document is actually saved.
	**/
	static inline var WillSaveTextDocument = new NotificationMethod<WillSaveTextDocumentParams, TextDocumentRegistrationOptions>("textDocument/willSave");

	/**
		The document will save request is sent from the client to the server before the document is actually saved.
		The request can return an array of TextEdits which will be applied to the text document before it is saved.
		Please note that clients might drop results if computing the text edits took too long or if a server constantly fails on this request.
		This is done to keep the save fast and reliable.
	**/
	static inline var WillSaveWaitUntilTextDocument = new RequestMethod<WillSaveTextDocumentParams, Null<Array<TextEdit>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/willSaveWaitUntil");

	/**
		The watched files notification is sent from the client to the server when the client detects changes to file watched by the language client.
	**/
	static inline var DidChangeWatchedFiles = new NotificationMethod<DidChangeWatchedFilesParams, DidChangeWatchedFilesRegistrationOptions>
		("workspace/didChangeWatchedFiles");

	/**
		Diagnostics notification are sent from the server to the client to signal results of validation runs.
	**/
	static inline var PublishDiagnostics = new NotificationMethod<PublishDiagnosticsParams, NoData>("textDocument/publishDiagnostics");

	/**
		Request to request completion at a given text document position. The request's
		parameter is of type `TextDocumentPosition` the response is of type `Array<CompletionItem>` or `CompletionList` or a Thenable that resolves to such.

		The request can delay the computation of the `CompletionItem.detail` and `documentation` properties to the `completionItem/resolve`
		request. However, properties that are needed for the inital sorting and filtering, like `sortText`,
		`filterText`, `insertText`, and `textEdit`, must not be changed during resolve.
	**/
	static inline var Completion = new RequestMethod<CompletionParams, Null<EitherType<Array<CompletionItem>, CompletionList>>, NoData,
		CompletionRegistrationOptions>("textDocument/completion");

	/**
		The request is sent from the client to the server to resolve additional information for a given completion item.
	**/
	static inline var CompletionItemResolve = new RequestMethod<CompletionItem, CompletionItem, NoData, NoData>("completionItem/resolve");

	/**
		The hover request is sent from the client to the server to request hover information at a given text document position.
	**/
	static inline var Hover = new RequestMethod<TextDocumentPositionParams, Null<Hover>, NoData, TextDocumentRegistrationOptions>("textDocument/hover");

	/**
		The signature help request is sent from the client to the server to request signature information at a given cursor position.
	**/
	static inline var SignatureHelp = new RequestMethod<TextDocumentPositionParams, Null<SignatureHelp>, NoData, SignatureHelpRegistrationOptions>
		("textDocument/signatureHelp");

	/**
		The goto definition request is sent from the client to the server to to resolve the definition location of a symbol at a given text document position.
	**/
	static inline var GotoDefinition = new RequestMethod<TextDocumentPositionParams, Null<Definition>, NoData, TextDocumentRegistrationOptions>
		("textDocument/definition");

	/**
		The references request is sent from the client to the server to resolve project-wide references for the symbol denoted by the given text document position.
	**/
	static inline var FindReferences = new RequestMethod<ReferenceParams, Null<Array<Location>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/references");

	/**
		The document highlight request is sent from the client to the server to to resolve a document highlights for a given text document position.
	**/
	static inline var DocumentHighlights = new RequestMethod<TextDocumentPositionParams, Null<Array<DocumentHighlight>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/documentHighlight");

	/**
		The document symbol request is sent from the client to the server to list all symbols found in a given text document.
	**/
	static inline var DocumentSymbols = new RequestMethod<DocumentSymbolParams, Null<Array<EitherType<SymbolInformation, DocumentSymbol>>>, NoData,
		TextDocumentRegistrationOptions>("textDocument/documentSymbol");

	/**
		The workspace symbol request is sent from the client to the server to list project-wide symbols matching the query string.
	**/
	static inline var WorkspaceSymbols = new RequestMethod<WorkspaceSymbolParams, Null<Array<SymbolInformation>>, NoData, NoData>("workspace/symbol");

	/**
		The code action request is sent from the client to the server to compute commands for a given text document and range.
		These commands are typically code fixes to either fix problems or to beautify/refactor code.
	**/
	static inline var CodeAction = new RequestMethod<CodeActionParams, Null<Array<EitherType<Command, CodeAction>>>, NoData, CodeActionRegistrationOptions>
		("textDocument/codeAction");

	/**
		The code lens request is sent from the client to the server to compute code lenses for a given text document.
	**/
	static inline var CodeLens = new RequestMethod<CodeLensParams, Array<CodeLens>, NoData, NoData>("textDocument/codeLens");

	/**
		The code lens resolve request is sent from the clien to the server to resolve the command for a given code lens item.
	**/
	static inline var CodeLensResolve = new RequestMethod<CodeLens, CodeLens, NoData, NoData>("codeLens/resolve");

	/**
		The document formatting resquest is sent from the server to the client to format a whole document.
	**/
	static inline var DocumentFormatting = new RequestMethod<DocumentFormattingParams, Null<Array<TextEdit>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/formatting");

	/**
		The document range formatting request is sent from the client to the server to format a given range in a document.
	**/
	static inline var DocumentRangeFormatting = new RequestMethod<DocumentRangeFormattingParams, Null<Array<TextEdit>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/rangeFormatting");

	/**
		The document on type formatting request is sent from the client to the server to format parts of the document during typing.
	**/
	static inline var DocumentOnTypeFormatting = new RequestMethod<DocumentOnTypeFormattingParams, Null<Array<TextEdit>>, NoData, TextDocumentRegistrationOptions>
		("textDocument/onTypeFormatting");

	/**
		The rename request is sent from the client to the server to do a workspace wide rename of a symbol.
	**/
	static inline var Rename = new RequestMethod<RenameParams, Null<WorkspaceEdit>, NoData, RenameRegistrationOptions>("textDocument/rename");

	/**
		A request to test and perform the setup necessary for a rename.
	**/
	static inline var PrepareRename = new RequestMethod<TextDocumentPositionParams, Null<EitherType<Range, {range:Range, placeholder:String}>>, NoData, NoData>
		("textDocument/prepareRename");

	/**
		The document links request is sent from the client to the server to request the location of links in a document.
	**/
	static inline var DocumentLink = new RequestMethod<DocumentLinkParams, Null<Array<DocumentLink>>, NoData, DocumentLinkRegistrationOptions>
		("textDocument/documentLink");

	/**
		The document link resolve request is sent from the client to the server to resolve the target of a given document link.
	**/
	static inline var DocumentLinkResolve = new RequestMethod<DocumentLink, DocumentLink, NoData, NoData>("documentLink/resolve");

	/**
		The workspace/executeCommand request is sent from the client to the server to trigger command execution on the server.
		In most cases the server creates a `WorkspaceEdit` structure and applies the changes to the workspace using the request `workspace/applyEdit`
		which is sent from the server to the client.
	**/
	static inline var ExecuteCommand = new RequestMethod<ExecuteCommandParams, Null<Dynamic>, NoData, ExecuteCommandRegistrationOptions>
		("workspace/executeCommand");

	/**
		The workspace/applyEdit request is sent from the server to the client to modify resource on the client side.
	**/
	static inline var ApplyEdit = new RequestMethod<ApplyWorkspaceEditParams, ApplyWorkspaceEditResponse, NoData, NoData>("workspace/applyEdit");
}

/**
	A document filter denotes a document by different properties like
	the `TextDocument.languageId`, the `Uri.scheme` of
	its resource, or a glob-pattern that is applied to the `TextDocument.fileName`.

	@sample A language filter that applies to typescript files on disk: `{ language: 'typescript', scheme: 'file' }`
	@sample A language filter that applies to all package.json paths: `{ language: 'json', pattern: '**package.json' }`
**/
typedef DocumentFilter = {
	/**
		A language id, like `haxe`.
	**/
	var ?language:String;

	/**
		A Uri [scheme](#Uri.scheme), like `file` or `untitled`.
	**/
	var ?scheme:String;

	/**
		A glob pattern, like `*.{hx,hxml}`.
	**/
	var ?pattern:String;
}

/**
	A document selector is the combination of one or many document filters.

	@sample `let sel:DocumentSelector = [{ language: 'typescript' }, { language: 'json', pattern: '**∕tsconfig.json' }]`;
**/
typedef DocumentSelector = Array<EitherType<String, DocumentFilter>>;

/**
	General parameters to to register for an notification or to register a provider.
**/
typedef Registration = {
	/**
		The id used to register the request. The id can be used to deregister
		the request again.
	**/
	var id:String;

	/**
		The method to register for.
	**/
	var method:String;

	/**
		Options necessary for the registration.
	**/
	var ?registerOptions:Dynamic;
}

typedef RegistrationParams = {
	var registrations:Array<Registration>;
}

/**
	General parameters to unregister a request or notification.
**/
typedef Unregistration = {
	/**
		The id used to unregister the request or notification. Usually an id
		provided during the register request.
	**/
	var id:String;

	/**
		The method / capability to unregister for.
	**/
	var method:String;
}

typedef UnregistrationParams = {
	var unregisterations:Array<Unregistration>;
}

/**
	A parameter literal used in requests to pass a text document and a position inside that document.
**/
typedef TextDocumentPositionParams = {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The position inside the text document.
	**/
	var position:Position;
}

/**
	The kind of resource operations supported by the client.
**/
enum abstract ResourceOperationKind(String) {
	/**
		Supports creating new resources.
	**/
	var Create = "create";

	/**
		Supports renaming existing resources.
	**/
	var Rename = "rename";

	/**
		Supports deleting existing resources.
	**/
	var Delete = "delete";
}

enum abstract FailureHandlingKind(String) {
	/**
		Applying the workspace change is simply aborted if one of the changes provided
		fails. All operations executed before the failing operation stay executed.
	**/
	var Abort = "abort";

	/**
		All operations are executed transactional. That means they either all
		succeed or no changes at all are applied to the workspace.
	**/
	var Transactional = "transactional";

	/**
		If the workspace edit contains only textual file changes they are executed transactional.
		If resource changes (create, rename or delete file) are part of the change the failure
		handling startegy is abort.
	**/
	var TextOnlyTransactional = "textOnlyTransactional";

	/**
		The client tries to undo the operations already executed. But there is no
		guaruntee that this is succeeding.
	**/
	var Undo = "undo";
}

/**
	Workspace specific client capabilities.

	Define capabilities the editor / tool provides on the workspace.
**/
typedef WorkspaceClientCapabilites = ConfigurationClientCapabilities &
	WorkspaceFoldersClientCapabilities & {
	/**
		The client supports applying batch edits to the workspace by supporting
		the request 'workspace/applyEdit'
	**/
	var ?applyEdit:Bool;

	/**
		Capabilities specific to `WorkspaceEdit`s
	**/
	var ?workspaceEdit:{
		/**
			The client supports versioned document changes in `WorkspaceEdit`s
		**/
		var ?documentChanges:Bool;

		/**
			The resource operations the client supports. Clients should at least
			support 'create', 'rename' and 'delete'.
		**/
		var ?resourceOperations:Array<ResourceOperationKind>;

		/**
			The failure handling strategy of a client if applying the workspace edit
			failes.
		**/
		var ?failureHandling:FailureHandlingKind;
	};

	/**
		Capabilities specific to the `workspace/didChangeConfiguration` notification.
	**/
	var ?didChangeConfiguration:{
		/**
			Did change configuration notification supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `workspace/didChangeWatchedFiles` notification.
	**/
	var ?didChangeWatchedFiles:{
		/**
			Did change watched files notification supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `workspace/symbol` request.
	**/
	var ?symbol:{
		/**
			Symbol request supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			Specific capabilities for the `SymbolKind` in the `workspace/symbol` request.
		**/
		var ?symbolKind:{
			/**
				The symbol kind values the client supports. When this
				property exists the client also guarantees that it will
				handle values outside its set gracefully and falls back
				to a default value when unknown.

				If this property is not present the client only supports
				the symbol kinds from `File` to `Array` as defined in
				the initial version of the protocol.
			**/
			var ?valueSet:Array<SymbolKind>;
		};
	};

	/**
		Capabilities specific to the `workspace/executeCommand` request.
	**/
	var ?executeCommand:{
		/**
			Execute command supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};
}

/**
	Text document specific client capabilities.
**/
typedef TextDocumentClientCapabilities = ImplementationClientCapabilities &
	TypeDefinitionClientCapabilities &
	/* ColorClientCapabilities & */
	FoldingRangeClientCapabilities & {
	/**
		Defines which synchronization capabilities the client supports.
	**/
	var ?synchronization:{
		/**
			Whether text document synchronization supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client supports sending will save notifications.
		**/
		var ?willSave:Bool;

		/**
			The client supports sending a will save request and
			waits for a response providing text edits which will
			be applied to the document before it is saved.
		**/
		var ?willSaveWaitUntil:Bool;

		/**
			The client supports did save notifications.
		**/
		var ?didSave:Bool;
	};

	/**
		Capabilities specific to the `textDocument/completion`
	**/
	var ?completion:{
		/**
			Whether completion supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client supports the following `CompletionItem` specific
			capabilities.
		**/
		var ?completionItem:{
			/**
				Client supports snippets as insert text.

				A snippet can define tab stops and placeholders with `$1`, `$2`
				and `${3:foo}`. `$0` defines the final tab stop, it defaults to
				the end of the snippet. Placeholders with equal identifiers are linked,
				that is typing in one will update others too.
			**/
			var ?snippetSupport:Bool;

			/**
				Client supports commit characters on a completion item.
			**/
			var ?commitCharactersSupport:Bool;

			/**
				Client supports the follow content formats for the documentation
				property. The order describes the preferred format of the client.
			**/
			var ?documentationFormat:Array<MarkupKind>;

			/**
				Client supports the deprecated property on a completion item.
			**/
			var ?deprecatedSupport:Bool;

			/**
				Client supports the preselect property on a completion item.
			**/
			var ?preselectSupport:Bool;
		};
		var ?completionItemKind:{
			/**
				The completion item kind values the client supports. When this
				property exists the client also guarantees that it will
				handle values outside its set gracefully and falls back
				to a default value when unknown.

				If this property is not present the client only supports
				the completion items kinds from `Text` to `Reference` as defined in
				the initial version of the protocol.
			**/
			var ?valueSet:Array<CompletionItemKind>;
		};

		/**
			The client supports to send additional context information for a
			`textDocument/completion` requestion.
		**/
		var ?contextSupport:Bool;
	};

	/**
		Capabilities specific to the `textDocument/hover`
	**/
	var ?hover:{
		/**
			Whether hover supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			Client supports the follow content formats for the content
			property. The order describes the preferred format of the client.
		**/
		var ?contentFormat:Array<MarkupKind>;
	};

	/**
		Capabilities specific to the `textDocument/signatureHelp`
	**/
	var ?signatureHelp:{
		/**
			Whether signature help supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client supports the following `SignatureInformation`
			specific properties.
		**/
		var ?signatureInformation:{
			/**
				Client supports the follow content formats for the documentation
				property. The order describes the preferred format of the client.
			**/
			var ?documentationFormat:Array<MarkupKind>;
		};
	};

	/**
		Capabilities specific to the `textDocument/references`
	**/
	var ?references:{
		/**
			Whether references supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/documentHighlight`
	**/
	var ?documentHighlight:{
		/**
			Whether document highlight supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/documentSymbol`
	**/
	var ?documentSymbol:{
		/**
			Whether document symbol supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			Specific capabilities for the `SymbolKind`.
		**/
		var ?symbolKind:{
			/**
				The symbol kind values the client supports. When this
				property exists the client also guarantees that it will
				handle values outside its set gracefully and falls back
				to a default value when unknown.

				If this property is not present the client only supports
				the symbol kinds from `File` to `Array` as defined in
				the initial version of the protocol.
			**/
			var ?valueSet:Array<SymbolKind>;
		};

		/**
			The client support hierarchical document symbols.
		**/
		var ?hierarchicalDocumentSymbolSupport:Bool;
	};

	/**
		Capabilities specific to the `textDocument/formatting`
	**/
	var ?formatting:{
		/**
			Whether formatting supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/rangeFormatting`
	**/
	var ?rangeFormatting:{
		/**
			Whether range formatting supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/onTypeFormatting`
	**/
	var ?onTypeFormatting:{
		/**
			Whether on type formatting supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/definition`
	**/
	var ?definition:{
		/**
			Whether definition supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/codeAction`
	**/
	var ?codeAction:{
		/**
			Whether code action supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client support code action literals as a valid
			response of the `textDocument/codeAction` request.
		**/
		var ?codeActionLiteralSupport:{
			/**
				The code action kind is support with the following value
				set.
			**/
			var codeActionKind:{
				/**
					The code action kind values the client supports. When this
					property exists the client also guarantees that it will
					handle values outside its set gracefully and falls back
					to a default value when unknown.
				**/
				var valueSet:Array<CodeActionKind>;
			};
		};
	};

	/**
		Capabilities specific to the `textDocument/codeLens`
	**/
	var ?codeLens:{
		/**
			Whether code lens supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/documentLink`
	**/
	var ?documentLink:{
		/**
			Whether document link supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;
	};

	/**
		Capabilities specific to the `textDocument/rename`
	**/
	var ?rename:{
		/**
			Whether rename supports dynamic registration.
		**/
		var ?dynamicRegistration:Bool;

		/**
			Client supports testing for validity of rename operations
			before execution.
		**/
		var ?prepareSupport:Bool;
	};

	/**
		Capabilities specific to `textDocument/publishDiagnostics`.
	**/
	var ?publishDiagnostics:{
		/**
			Whether the clients accepts diagnostics with related information.
		**/
		var ?relatedInformation:Bool;
	};
}

/**
	Define capabilities for dynamic registration, workspace and text document features the client supports.
	The `experimental` can be used to pass experimential capabilities under development.
	For future compatibility a `ClientCapabilities` object literal can have more properties set than currently defined.
	Servers receiving a `ClientCapabilities` object literal with unknown properties should ignore these properties.
	A missing property should be interpreted as an absence of the capability.
**/
typedef ClientCapabilities = {
	/**
		Workspace specific client capabilities.
	**/
	var ?workspace:WorkspaceClientCapabilites;

	/**
		Text document specific client capabilities.
	**/
	var ?textDocument:TextDocumentClientCapabilities;

	/**
		Experimental client capabilities.
	**/
	var ?experimental:Dynamic;
}

/**
	Defines how the host (editor) should sync document changes to the language server.
**/
enum abstract TextDocumentSyncKind(Int) {
	/**
		Documents should not be synced at all.
	**/
	var None;

	/**
		Documents are synced by always sending the full content of the document.
	**/
	var Full;

	/**
		Documents are synced by sending the full content on open.
		After that only incremental updates to the document are send.
	**/
	var Incremental;
}

/**
	Static registration options to be returned in the initialize
	request.
**/
typedef StaticRegistrationOptions = {
	/**
		The id used to register the request. The id can be used to deregister
		the request again. See also Registration#id.
	**/
	var ?id:String;
}

/**
	General text document registration options.
**/
typedef TextDocumentRegistrationOptions = {
	/**
		A document selector to identify the scope of the registration. If set to null
		the document selector provided on the client side will be used.
	**/
	var documentSelector:Null<DocumentSelector>;
}

/**
	Completion options.
**/
typedef CompletionOptions = {
	/**
		Most tools trigger completion request automatically without explicitly requesting
		it using a keyboard shortcut (e.g. Ctrl+Space). Typically they do so when the user
		starts to type an identifier. For example if the user types `c` in a JavaScript file
		code complete will automatically pop up present `console` besides others as a
		completion item. Characters that make up identifiers don't need to be listed here.

		If code complete should automatically be trigger on characters not being valid inside
		an identifier (for example `.` in JavaScript) list them in `triggerCharacters`.
	**/
	var ?triggerCharacters:Array<String>;

	/**
		The server provides support to resolve additional information for a completion item.
	**/
	var ?resolveProvider:Bool;
}

/**
	Signature help options.
**/
typedef SignatureHelpOptions = {
	/**
		The characters that trigger signature help automatically.
	**/
	var ?triggerCharacters:Array<String>;
}

/**
	Code Lens options.
**/
typedef CodeLensOptions = {
	/**
		Code lens has a resolve provider as well.
	**/
	var ?resolveProvider:Bool;
}

/**
	Code Action options.
**/
typedef CodeActionOptions = {
	/**
		CodeActionKinds that this server may return.

		The list of kinds may be generic, such as `CodeActionKind.Refactor`, or the server
		may list out every specific kind they provide.
	**/
	var ?codeActionKinds:Array<CodeActionKind>;
}

/**
	Format document on type options
**/
typedef DocumentOnTypeFormattingOptions = {
	/**
		A character on which formatting should be triggered, like `}`.
	**/
	var firstTriggerCharacter:String;

	/**
		More trigger characters.
	**/
	var ?moreTriggerCharacter:Array<String>;
}

/**
	Rename options
**/
typedef RenameOptions = {
	/**
		Renames should be checked and tested before being executed.
	**/
	var ?prepareProvider:Bool;
}

/**
	Document link options
**/
typedef DocumentLinkOptions = {
	/**
		Document links have a resolve provider as well.
	**/
	var ?resolveProvider:Bool;
}

/**
	Execute command options.
**/
typedef ExecuteCommandOptions = {
	/**
		The commands to be executed on the server
	**/
	var commands:Array<String>;
}

/**
	Save options.
**/
typedef SaveOptions = {
	/**
		The client is supposed to include the content on save.
	**/
	var ?includeText:Bool;
}

typedef TextDocumentSyncOptions = {
	/**
		Open and close notifications are sent to the server.
	**/
	var ?openClose:Bool;

	/**
		Change notifications are sent to the server. See TextDocumentSyncKind.None, TextDocumentSyncKind.Full
		and TextDocumentSyncKind.Incremental.
	**/
	var ?change:TextDocumentSyncKind;

	/**
		Will save notifications are sent to the server.
	**/
	var ?willSave:Bool;

	/**
		Will save wait until requests are sent to the server.
	**/
	var ?willSaveWaitUntil:Bool;

	/**
		Save notifications are sent to the server.
	**/
	var ?save:SaveOptions;
}

/**
	Defines the capabilities provided by a language
	server.
**/
typedef ServerCapabilities = ImplementationServerCapabilities &
	TypeDefinitionServerCapabilities &
	WorkspaceFoldersServerCapabilities &
	ColorServerCapabilities &
	FoldingRangeServerCapabilities & {
	/**
		Defines how text documents are synced.
		Is either a detailed structure defining each notification or for backwards compatibility the TextDocumentSyncKind number.
	**/
	var ?textDocumentSync:EitherType<TextDocumentSyncOptions, TextDocumentSyncKind>;

	/**
		The server provides hover support.
	**/
	var ?hoverProvider:Bool;

	/**
		The server provides completion support.
	**/
	var ?completionProvider:CompletionOptions;

	/**
		The server provides signature help support.
	**/
	var ?signatureHelpProvider:SignatureHelpOptions;

	/**
		The server provides goto definition support.
	**/
	var ?definitionProvider:Bool;

	/**
		The server provides find references support.
	**/
	var ?referencesProvider:Bool;

	/**
		The server provides document highlight support.
	**/
	var ?documentHighlightProvider:Bool;

	/**
		The server provides document symbol support.
	**/
	var ?documentSymbolProvider:Bool;

	/**
		The server provides workspace symbol support.
	**/
	var ?workspaceSymbolProvider:Bool;

	/**
		The server provides code actions. CodeActionOptions may only be
		specified if the client states that it supports
		`codeActionLiteralSupport` in its initial `initialize` request.
	**/
	var ?codeActionProvider:EitherType<Bool, CodeActionOptions>;

	/**
		The server provides code lens.
	**/
	var ?codeLensProvider:CodeLensOptions;

	/**
		The server provides document formatting.
	**/
	var ?documentFormattingProvider:Bool;

	/**
		The server provides document range formatting.
	**/
	var ?documentRangeFormattingProvider:Bool;

	/**
		The server provides document formatting on typing.
	**/
	var ?documentOnTypeFormattingProvider:DocumentOnTypeFormattingOptions;

	/**
		The server provides rename support. RenameOptions may only be
		specified if the client states that it supports
		`prepareSupport` in its initial `initialize` request.
	**/
	var ?renameProvider:EitherType<Bool, RenameOptions>;

	/**
		The server provides document link support.
	**/
	var ?documentLinkProvider:DocumentLinkOptions;

	/**
		The server provides execute command support.
	**/
	var ?executeCommandProvider:ExecuteCommandOptions;

	/**
		Experimental server capabilities.
	**/
	var ?experimental:Dynamic;
}

/**
	The initialize parameters
**/
typedef InitializeParams = WorkspaceFoldersInitializeParams & {
	/**
		The process Id of the parent process that started the server.
		Is null if the process has not been started by another process.
		If the parent process is not alive then the server should exit (see exit notification) its process.
	**/
	var processId:Null<Int>;

	/**
		The rootPath of the workspace.
		Is null if no folder is open.
	**/
	@:deprecated("deprecated in favour of rootUri")
	var rootPath:Null<String>;

	/**
		The rootUri of the workspace.
		Is null if no folder is open.
		If both `rootPath` and `rootUri` are set `rootUri` wins.
	**/
	// @:deprecated("deprecated in favour of workspaceFolders")
	var rootUri:Null<DocumentUri>;

	/**
		The capabilities provided by the client (editor or tool).
	**/
	var capabilities:ClientCapabilities;

	/**
		User provided initialization options.
	**/
	var ?initializationOptions:Dynamic;

	/**
		The initial trace setting.
		If omitted trace is disabled ('off').
	**/
	var ?trace:TraceMode;
}

/**
	Tracing mode.
**/
enum abstract TraceMode(String) to String {
	var Off = "off";
	var Messages = "messages";
	var Verbose = "verbose";
}

/**
	The result returned from an initialize request.
	This object can contain additional fields of type String.
**/
typedef InitializeResult = {
	/**
		The capabilities the language server provides.
	**/
	var capabilities:ServerCapabilities;
}

/**
	The data type of the ResponseError if the
	initialize request fails.
**/
typedef InitializeError = {
	/**
		Indicates whether the client execute the following retry logic:
		(1) show the message provided by the ResponseError to the user
		(2) user selects retry or cancel
		(3) if user selected retry the initialize method is sent again.
	**/
	var retry:Bool;
}

typedef InitializedParams = {}

typedef DidChangeConfigurationRegistrationOptions = {
	var ?section:EitherType<String, Array<String>>;
}

/**
	The parameters of a change configuration notification.
**/
typedef DidChangeConfigurationParams = {
	/**
		The actual changed settings.
	**/
	var settings:Dynamic;
}

/**
	The message type
**/
enum abstract MessageType(Int) to Int {
	/**
		An error message.
	**/
	var Error = 1;

	/**
		A warning message.
	**/
	var Warning;

	/**
		An information message.
	**/
	var Info;

	/**
		A log message.
	**/
	var Log;
}

typedef ShowMessageParams = {
	/**
		The message type.
	**/
	var type:MessageType;

	/**
		The actual message.
	**/
	var message:String;
}

typedef MessageActionItem = {
	/**
		A short title like 'Retry', 'Open Log' etc.
	**/
	var title:String;
}

typedef ShowMessageRequestParams = {
	/**
		The message type.
	**/
	var type:MessageType;

	/**
		The actual message.
	**/
	var message:String;

	/**
		The message action items to present.
	**/
	var ?actions:Array<MessageActionItem>;
}

typedef LogMessageParams = {
	/**
		The message type.
	**/
	var type:MessageType;

	/**
		The actual message.
	**/
	var message:String;
}

/**
	The parameters send in a open text document notification
**/
typedef DidOpenTextDocumentParams = {
	/**
		The document that was opened.
	**/
	var textDocument:TextDocumentItem;
}

/**
	The change text document notification's parameters.
**/
typedef DidChangeTextDocumentParams = {
	/**
		The document that did change.
		The version number points to the version after all provided content changes have been applied.
	**/
	var textDocument:VersionedTextDocumentIdentifier;

	/**
		The actual content changes. The content changes describe single state changes
		to the document. So if there are two content changes c1 and c2 for a document
		in state S then c1 move the document to S' and c2 to S''.
	**/
	var contentChanges:Array<TextDocumentContentChangeEvent>;
}

/**
	Describe options to be used when registered for text document change events.
**/
typedef TextDocumentChangeRegistrationOptions = TextDocumentRegistrationOptions & {
	/**
		How documents are synced to the server.
	**/
	var syncKind:TextDocumentSyncKind;
}

/**
	The parameters send in a close text document notification
**/
typedef DidCloseTextDocumentParams = {
	/**
		The document that was closed.
	**/
	var textDocument:TextDocumentIdentifier;
}

/**
	The parameters send in a save text document notification
**/
typedef DidSaveTextDocumentParams = {
	/**
		The document that was saved.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		Optional the content when saved. Depends on the `includeText` value when the save notifcation was requested.
	**/
	var ?text:String;
}

/**
	Save registration options.
**/
typedef TextDocumentSaveRegistrationOptions = TextDocumentRegistrationOptions & SaveOptions;

/**
	The parameters send in a will save text document notification.
**/
typedef WillSaveTextDocumentParams = {
	/**
		The document that will be saved.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The 'TextDocumentSaveReason'.
	**/
	var reason:TextDocumentSaveReason;
}

/**
	The watched files change notification's parameters.
**/
typedef DidChangeWatchedFilesParams = {
	/**
		The actual file events.
	**/
	var changes:Array<FileEvent>;
}

/**
	The file event type.
**/
enum abstract FileChangeType(Int) to Int {
	/**
		The file got created.
	**/
	var Created = 1;

	/**
		The file got changed.
	**/
	var Changed;

	/**
		The file got deleted.
	**/
	var Deleted;
}

/**
	An event describing a file change.
**/
typedef FileEvent = {
	/**
		The file's uri.
	**/
	var uri:DocumentUri;

	/**
		The change type.
	**/
	var type:FileChangeType;
}

/**
	Describe options to be used when registered for text document change events.
**/
typedef DidChangeWatchedFilesRegistrationOptions = {
	/**
		The watchers to register.
	**/
	var watchers:Array<FileSystemWatcher>;
}

typedef FileSystemWatcher = {
	/**
		The  glob pattern to watch
	**/
	var globPattern:String;

	/**
		The kind of events of interest. If omitted it defaults
		to WatchKind.Create | WatchKind.Change | WatchKind.Delete
		which is 7.
	**/
	var ?kind:Int;
}

enum abstract WatchKind(Int) to Int {
	/**
		Interested in create events.
	**/
	var Create = 1;

	/**
		Interested in change events
	**/
	var Change;

	/**
		Interested in delete events
	**/
	var Delete;
}

/**
	The publish diagnostic notification's parameters.
**/
typedef PublishDiagnosticsParams = {
	/**
		The URI for which diagnostic information is reported.
	**/
	var uri:DocumentUri;

	/**
		An array of diagnostic information items.
	**/
	var diagnostics:Array<Diagnostic>;
}

/**
	Completion registration options.
**/
typedef CompletionRegistrationOptions = TextDocumentRegistrationOptions & CompletionOptions;

/**
	How a completion was triggered
**/
enum abstract CompletionTriggerKind(Int) {
	/**
		Completion was triggered by typing an identifier (24x7 code
		complete), manual invocation (e.g Ctrl+Space) or via API.
	**/
	var Invoked = 1;

	/**
		Completion was triggered by a trigger character specified by
		the `triggerCharacters` properties of the `CompletionRegistrationOptions`.
	**/
	var TriggerCharacter;

	/**
		Completion was re-triggered as current completion list is incomplete
	**/
	var TriggerForIncompleteCompletions;
}

/**
	Contains additional information about the context in which a completion request is triggered.
**/
typedef CompletionContext = {
	/**
		How the completion was triggered.
	**/
	var triggerKind:CompletionTriggerKind;

	/**
		The trigger character (a single character) that has trigger code complete.
		Is undefined if `triggerKind !== CompletionTriggerKind.TriggerCharacter`
	**/
	var ?triggerCharacter:String;
}

/**
	Completion parameters
**/
typedef CompletionParams = TextDocumentPositionParams & {
	/**
		The completion context. This is only available it the client specifies
		to send this using `ClientCapabilities.textDocument.completion.contextSupport === true`
	**/
	var ?context:CompletionContext;
}

/**
	Signature help registration options.
**/
typedef SignatureHelpRegistrationOptions = TextDocumentRegistrationOptions & SignatureHelpOptions;

typedef ReferenceParams = TextDocumentPositionParams & {
	var context:ReferenceContext;
}

/**
	Params for the CodeActionRequest
**/
typedef CodeActionParams = {
	/**
		The document in which the command was invoked.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The range for which the command was invoked.
	**/
	var range:Range;

	/**
		Context carrying additional information.
	**/
	var context:CodeActionContext;
}

typedef CodeActionRegistrationOptions = TextDocumentRegistrationOptions & CodeActionOptions;

typedef CodeLensParams = {
	/**
		The document to request code lens for.
	**/
	var textDocument:TextDocumentIdentifier;
}

typedef CodeLensRegistrationOptions = TextDocumentRegistrationOptions & CodeLensOptions;

typedef DocumentFormattingParams = {
	/**
		The document to format.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The format options.
	**/
	var options:FormattingOptions;
}

typedef DocumentRangeFormattingParams = {
	/**
		The document to format.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The range to format.
	**/
	var range:Range;

	/**
		The format options.
	**/
	var options:FormattingOptions;
}

typedef DocumentOnTypeFormattingParams = {
	/**
		The document to format.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The position at which this request was send.
	**/
	var position:Position;

	/**
		The character that has been typed.
	**/
	var ch:String;

	/**
		The format options.
	**/
	var options:FormattingOptions;
}

/**
	Format document on type options
**/
typedef DocumentOnTypeFormattingRegistrationOptions = TextDocumentRegistrationOptions & DocumentOnTypeFormattingOptions;

typedef RenameParams = {
	/**
		The document to format.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The position at which this request was send.
	**/
	var position:Position;

	/**
		The new name of the symbol.
		If the given name is not valid the request must return a `ResponseError` with an appropriate message set.
	**/
	var newName:String;
}

/**
 * Rename registration options.
 */
typedef RenameRegistrationOptions = TextDocumentRegistrationOptions & RenameOptions;

typedef DocumentLinkParams = {
	/**
		The document to provide document links for.
	**/
	var textDocument:TextDocumentIdentifier;
}

typedef DocumentLinkRegistrationOptions = TextDocumentRegistrationOptions & DocumentLinkOptions;

typedef ExecuteCommandParams = {
	/**
		The identifier of the actual command handler.
	**/
	var command:String;

	/**
		Arguments that the command should be invoked with.
	**/
	var ?arguments:Array<Dynamic>;
}

/**
	Execute command registration options.
**/
typedef ExecuteCommandRegistrationOptions = ExecuteCommandOptions;

/**
	The parameters passed via a apply workspace edit request.
**/
typedef ApplyWorkspaceEditParams = {
	/**
		The edits to apply.
	**/
	var edit:WorkspaceEdit;
}

/**
	A response returned from the apply workspace edit request.
**/
typedef ApplyWorkspaceEditResponse = {
	/**
		Indicates whether the edit was applied or not.
	**/
	var applied:Bool;

	/**
		Depending on the client's failure handling strategy `failedChange` might
		contain the index of the change that failed. This property is only available
		if the client signals a `failureHandlingStrategy` in its client capabilities.
	**/
	var ?failedChange:Int;
}
