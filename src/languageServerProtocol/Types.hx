package languageServerProtocol;

import haxe.extern.EitherType;
import jsonrpc.Types;

/**
    Method names for the protocol requests and notifications.
    Each value must be typed as either `RequestMethod` or `NotificationMethod`.
**/
@:publicFields
class Methods {
    /**
        The initialize request is sent as the first request from the client to the server.
    **/
    static inline var Initialize = new RequestMethod<InitializeParams,InitializeResult,InitializeError>("initialize");

    /**
        The initialized notification is sent from the client to the server after the client is fully initialized
        and is able to listen to arbritary requests and notifications sent from the server.
    **/
    static inline var Initialized = new RequestMethod<NoData,NoData,NoData>("initialized");

    /**
        The shutdown request is sent from the client to the server.
        It asks the server to shut down, but to not exit (otherwise the response might not be delivered correctly to the client).
        There is a separate exit notification that asks the server to exit.
    **/
    static inline var Shutdown = new RequestMethod<NoData,NoData,NoData>("shutdown");

    /**
        A notification to ask the server to exit its process.
        The server should exit with success code 0 if the shutdown request has been received before; otherwise with error code 1.
    **/
    static inline var Exit = new NotificationMethod<NoData>("exit");

    /**
        The show message notification is sent from a server to a client to ask the client to display a particular message in the user interface.
    **/
    static inline var ShowMessage = new NotificationMethod<ShowMessageParams>("window/showMessage");

    /**
        The show message request is sent from a server to a client to ask the client to display a particular message in the user interface.
        In addition to the show message notification the request allows to pass actions and to wait for an answer from the client.
    **/
    static inline var ShowMessageRequest = new RequestMethod<ShowMessageRequestParams,MessageActionItem,NoData>("window/showMessageRequest");

    /**
        The log message notification is send from the server to the client to ask the client to log a particular message.
    **/
    static inline var LogMessage = new NotificationMethod<LogMessageParams>("window/logMessage");

    /**
        The telemetry notification is sent from the server to the client to ask the client to log a telemetry event.
    **/
    static inline var Telemetry = new NotificationMethod<Dynamic>("telemetry/event");

    /**
        The client/registerCapability request is sent from the server to the client to register for a new capability on the client side.
        Not all clients need to support dynamic capability registration. A client opts in via the `ClientCapabilities.dynamicRegistration` property.
    **/
    static inline var RegisterCapability = new RequestMethod<RegistrationParams,NoData,NoData>("client/registerCapability");

    /**
        The client/unregisterCapability request is sent from the server to the client to unregister a previously register capability.
    **/
    static inline var UnregisterCapability = new RequestMethod<UnregistrationParams,NoData,NoData>("client/unregisterCapability ");

    /**
        A notification send from the client to the server to signal the change of configuration settings.
    **/
    static inline var DidChangeConfiguration = new NotificationMethod<DidChangeConfigurationParams>("workspace/didChangeConfiguration");

    /**
        The document open notification is sent from the client to the server to signal newly opened text documents.
        The document's truth is now managed by the client and the server must not try to read the document's truth using the document's uri.
    **/
    static inline var DidOpenTextDocument = new NotificationMethod<DidOpenTextDocumentParams>("textDocument/didOpen");

    /**
        The document change notification is sent from the client to the server to signal changes to a text document.
    **/
    static inline var DidChangeTextDocument = new NotificationMethod<DidChangeTextDocumentParams>("textDocument/didChange");

    /**
        The document will save notification is sent from the client to the server before the document is actually saved.
    **/
    static inline var WillSaveTextDocument = new NotificationMethod<WillSaveTextDocumentParams>("textDocument/willSave");

    /**
        The document will save request is sent from the client to the server before the document is actually saved.
        The request can return an array of TextEdits which will be applied to the text document before it is saved.
        Please note that clients might drop results if computing the text edits took too long or if a server constantly fails on this request.
        This is done to keep the save fast and reliable.
    **/
    static inline var WillSaveWaitUntilTextDocument = new RequestMethod<WillSaveTextDocumentParams,Array<TextEdit>,NoData>("textDocument/willSaveWaitUntil");

    /**
        The document close notification is sent from the client to the server when the document got closed in the client.
        The document's truth now exists where the document's uri points to (e.g. if the document's uri is a file uri the truth now exists on disk).
    **/
    static inline var DidCloseTextDocument = new NotificationMethod<DidCloseTextDocumentParams>("textDocument/didClose");

    /**
        The document save notification is sent from the client to the server when the document for saved in the clinet.
    **/
    static inline var DidSaveTextDocument = new NotificationMethod<DidSaveTextDocumentParams>("textDocument/didSave");

    /**
        The watched files notification is sent from the client to the server when the client detects changes to file watched by the lanaguage client.
    **/
    static inline var DidChangeWatchedFiles = new NotificationMethod<DidChangeWatchedFilesParams>("workspace/didChangeWatchedFiles");

    /**
        Diagnostics notification are sent from the server to the client to signal results of validation runs.
    **/
    static inline var PublishDiagnostics = new NotificationMethod<PublishDiagnosticsParams>("textDocument/publishDiagnostics");

    /**
        The Completion request is sent from the client to the server to compute completion items at a given cursor position.
        Completion items are presented in the IntelliSense user interface.
        If computing complete completion items is expensive servers can additional provide a handler for the resolve completion item request.
        This request is send when a completion item is selected in the user interface.
    **/
    static inline var Completion = new RequestMethod<TextDocumentPositionParams,EitherType<Array<CompletionItem>,CompletionList>,NoData>("textDocument/completion");

    /**
        The request is sent from the client to the server to resolve additional information for a given completion item.
    **/
    static inline var CompletionItemResolve = new RequestMethod<CompletionItem,CompletionItem,NoData>("completionItem/resolve");

    /**
        The hover request is sent from the client to the server to request hover information at a given text document position.
    **/
    static inline var Hover = new RequestMethod<TextDocumentPositionParams,Hover,NoData>("textDocument/hover");

    /**
        The signature help request is sent from the client to the server to request signature information at a given cursor position.
    **/
    static inline var SignatureHelp = new RequestMethod<TextDocumentPositionParams,SignatureHelp,NoData>("textDocument/signatureHelp");

    /**
        The goto definition request is sent from the client to the server to to resolve the defintion location of a symbol at a given text document position.
    **/
    static inline var GotoDefinition = new RequestMethod<TextDocumentPositionParams,EitherType<Location,Array<Location>>,NoData>("textDocument/definition");

    /**
        The references request is sent from the client to the server to resolve project-wide references for the symbol denoted by the given text document position.
    **/
    static inline var FindReferences = new RequestMethod<ReferenceParams,Array<Location>,NoData>("textDocument/references");

    /**
        The document highlight request is sent from the client to the server to to resolve a document highlights for a given text document position.
    **/
    static inline var DocumentHighlights = new RequestMethod<TextDocumentPositionParams,Array<DocumentHighlight>,NoData>("textDocument/documentHighlight");

    /**
        The document symbol request is sent from the client to the server to list all symbols found in a given text document.
    **/
    static inline var DocumentSymbols = new RequestMethod<DocumentSymbolParams,Array<SymbolInformation>,NoData>("textDocument/documentSymbol");

    /**
        The workspace symbol request is sent from the client to the server to list project-wide symbols matching the query string.
    **/
    static inline var WorkspaceSymbols = new RequestMethod<WorkspaceSymbolParams,Array<SymbolInformation>,NoData>("workspace/symbol");

    /**
        The code action request is sent from the client to the server to compute commands for a given text document and range.
        The request is trigger when the user moves the cursor into an problem marker in the editor or presses the lightbulb associated with a marker.
    **/
    static inline var CodeAction = new RequestMethod<CodeActionParams,Array<Command>,NoData>("textDocument/codeAction");

    /**
        The code lens request is sent from the client to the server to compute code lenses for a given text document.
    **/
    static inline var CodeLens = new RequestMethod<CodeLensParams,Array<CodeLens>,NoData>("textDocument/codeLens");

    /**
        The code lens resolve request is sent from the clien to the server to resolve the command for a given code lens item.
    **/
    static inline var CodeLensResolve = new RequestMethod<CodeLens,CodeLens,NoData>("codeLens/resolve");

    /**
        The document links request is sent from the client to the server to request the location of links in a document.
    **/
    static inline var DocumentLink = new RequestMethod<DocumentLinkParams,Null<Array<DocumentLink>>,NoData>("textDocument/documentLink");

    /**
        The document link resolve request is sent from the client to the server to resolve the target of a given document link.
    **/
    static inline var DocumentLinkResolve = new RequestMethod<DocumentLink,DocumentLink,NoData>("documentLink/resolve");

    /**
        The document formatting resquest is sent from the server to the client to format a whole document.
    **/
    static inline var DocumentFormatting = new RequestMethod<DocumentFormattingParams,Array<TextEdit>,NoData>("textDocument/formatting");

    /**
        The document range formatting request is sent from the client to the server to format a given range in a document.
    **/
    static inline var DocumentRangeFormatting = new RequestMethod<DocumentRangeFormattingParams,Array<TextEdit>,NoData>("textDocument/rangeFormatting");

    /**
        The document on type formatting request is sent from the client to the server to format parts of the document during typing.
    **/
    static inline var DocumentOnTypeFormatting = new RequestMethod<DocumentOnTypeFormattingParams,Array<TextEdit>,NoData>("textDocument/onTypeFormatting");

    /**
        The rename request is sent from the client to the server to do a workspace wide rename of a symbol.
    **/
    static inline var Rename = new RequestMethod<RenameParams,WorkspaceEdit,NoData>("textDocument/rename");

    /**
        The workspace/executeCommand request is sent from the client to the server to trigger command execution on the server.
        In most cases the server creates a `WorkspaceEdit` structure and applies the changes to the workspace using the request `workspace/applyEdit`
        which is sent from the server to the client.
    **/
    static inline var ExecuteCommand = new RequestMethod<ExecuteCommandParams,Dynamic,NoData>("workspace/executeCommand");

    /**
        The workspace/applyEdit request is sent from the server to the client to modify resource on the client side.
    **/
    static inline var ApplyEdit = new RequestMethod<ApplyWorkspaceEditParams,ApplyWorkspaceEditResponse,NoData>("workspace/applyEdit");
}

typedef DocumentUri = String;

/**
    Position in a text document expressed as zero-based line and character offset.
**/
typedef Position = {
    /**
        Line position in a document (zero-based).
    **/
    var line:Int;

    /**
        Character offset on a line in a document (zero-based).
    **/
    var character:Int;
}

/**
    A range in a text document expressed as (zero-based) start and end positions.
**/
typedef Range = {
    /**
        The range's start position
    **/
    var start:Position;

    /**
        The range's end position
    **/
    var end:Position;
}

/**
    Represents a location inside a resource, such as a line inside a text file.
**/
typedef Location = {
    var uri:DocumentUri;
    var range:Range;
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
    @:optional var severity:DiagnosticSeverity;

    /**
        The diagnostic's code.
    **/
    @:optional var code:EitherType<Int,String>;

    /**
        A human-readable string describing the source of this diagnostic, e.g. 'typescript' or 'super lint'.
    **/
    @:optional var source:String;

    /**
        The diagnostic's message.
    **/
    var message:String;
}

@:enum abstract DiagnosticSeverity(Int) {
    var Error = 1;
    var Warning = 2;
    var Information = 3;
    var Hint = 4;
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
    @:optional var arguments:Array<Dynamic>;
}

/**
    A textual edit applicable to a text document.
**/
typedef TextEdit = {
    /**
        The range of the text document to be manipulated.
        To insert text into a document create a range where start == end.
    **/
    var range:Range;

    /**
        The string to be inserted.
        For delete operations use an empty string.
    **/
    var newText:String;
}

/**
    A workspace edit represents changes to many resources managed in the workspace.
**/
typedef WorkspaceEdit = {
    /**
        Holds changes to existing resources.
    **/
    var changes:haxe.DynamicAccess<Array<TextEdit>>;
}

/**
    Text documents are identified using an URI.
    On the protocol level URI's are passed as strings.
**/
typedef TextDocumentIdentifier = {
    /**
        The text document's uri.
    **/
    var uri:DocumentUri;
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
    An identifier to denote a specific version of a text document.
**/
typedef VersionedTextDocumentIdentifier = {
    >TextDocumentIdentifier,

    /**
        The version number of this document.
    **/
    var version:Int;
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
    Denotes a document through properties like language, schema or pattern.
**/
typedef DocumentFilter = {
    /**
        A language id, like `haxe`.
    **/
    @:optional var language:String;

    /**
        A Uri [scheme](#Uri.scheme), like `file` or `untitled`.
    **/
    @:optional var scheme:String;

    /**
        A glob pattern, like `*.{hx,hxml}`.
    **/
    @:optional var pattern:String;
}

/**
    A document selector is the combination of one or many document filters.
**/
typedef DocumentSelector = Array<DocumentFilter>;

typedef InitializeParams = {
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
    var rootPath:Null<String>;

    /**
        The rootUri of the workspace.
        Is null if no folder is open.
        If both `rootPath` and `rootUri` are set `rootUri` wins.
    **/
    var rootUri:Null<DocumentUri>;

    /**
        The capabilities provided by the client (editor or tool).
    **/
    var capabilities:ClientCapabilities;

    /**
        Initialization options passed from the client.
    **/
    @:optional var initializationOptions:Dynamic;

    /**
        The initial trace setting.
        If omitted trace is disabled ('off').
    **/
    @:optional var trace:TraceMode;
}

/**
    Tracing mode.
**/
@:enum abstract TraceMode(String) to String {
    var Off = "off";
    var Messages = "messages";
    var Verbose = "verbose";
}

typedef InitializeResult = {
    /**
        The capabilities the language server provides.
    **/
    var capabilities:ServerCapabilities;
}

typedef InitializeError = {
    /**
        Indicates whether the client should retry to send the initilize request
        after showing the message provided in the `ResponseError`.
    **/
    var retry:Bool;
}

/**
    Workspace specific client capabilities.

    Define capabilities the editor / tool provides on the workspace.
**/
typedef WorkspaceClientCapabilites = {
    /**
        The client supports applying batch edits to the workspace.
    **/
    @:optional var applyEdit:Bool;

    /**
        Capabilities specific to the `workspace/didChangeConfiguration` notification.
    **/
    @:optional var didChangeConfiguration:{
        /**
            Did change configuration notification supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `workspace/didChangeWatchedFiles` notification.
    **/
    @:optional var didChangeWatchedFiles:{
        /**
            Did change watched files notification supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `workspace/symbol` request.
    **/
    @:optional var symbol:{
        /**
            Symbol request supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `workspace/executeCommand` request.
    **/
    @:optional var executeCommand:{
        /**
            Execute command supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };
}

/**
    Text document specific client capabilities.
    Define capabilities the editor / tool provides on text documents.
**/
typedef TextDocumentClientCapabilities = {
    @:optional var synchronization:{
        /**
            Whether text document synchronization supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;

        /**
            The client supports sending will save notifications.
        **/
        @:optional var willSave:Bool;

        /**
            The client supports sending a will save request and
            waits for a response providing text edits which will
            be applied to the document before it is saved.
        **/
        @:optional var willSaveWaitUntil:Bool;

        /**
            The client supports did save notifications.
        **/
        @:optional var didSave:Bool;
    };

    /**
        Capabilities specific to the `textDocument/completion`
    **/
    @:optional var completion:{
        /**
            Whether completion supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;

        /**
            The client supports the following `CompletionItem` specific
            capabilities.
        **/
        @:optional var completionItem:{
            /**
                Client supports snippets as insert text.

                A snippet can define tab stops and placeholders with `$1`, `$2`
                and `${3:foo}`. `$0` defines the final tab stop, it defaults to
                the end of the snippet. Placeholders with equal identifiers are linked,
                that is typing in one will update others too.
            **/
            @:optional var snippetSupport:Bool;
        }
    };

    /**
        Capabilities specific to the `textDocument/hover`
    **/
    @:optional var hover:{
        /**
            Whether hover supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/signatureHelp`
    **/
    @:optional var signatureHelp:{
        /**
            Whether signature help supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/references`
    **/
    @:optional var references:{
        /**
            Whether references supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/documentHighlight`
    **/
    @:optional var documentHighlight:{
        /**
            Whether document highlight supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/documentSymbol`
    **/
    @:optional var documentSymbol:{
        /**
            Whether document symbol supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/formatting`
    **/
    @:optional var formatting:{
        /**
            Whether formatting supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/rangeFormatting`
    **/
    @:optional var rangeFormatting:{
        /**
            Whether range formatting supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/onTypeFormatting`
    **/
    @:optional var onTypeFormatting:{
        /**
            Whether on type formatting supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/definition`
    **/
    @:optional var definition:{
        /**
            Whether definition supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/codeAction`
    **/
    @:optional var codeAction:{
        /**
            Whether code action supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/codeLens`
    **/
    @:optional var codeLens:{
        /**
            Whether code lens supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/documentLink`
    **/
    @:optional var documentLink:{
        /**
            Whether document link supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };

    /**
        Capabilities specific to the `textDocument/rename`
    **/
    @:optional var rename:{
        /**
            Whether rename supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;
    };
};

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
    @:optional var workspace:WorkspaceClientCapabilites;

    /**
        Text document specific client capabilities.
    **/
    @:optional var textDocument:TextDocumentClientCapabilities;

    /**
        Experimental client capabilities.
    **/
    @:optional var experimental:Dynamic;
};

/**
    Defines how the host (editor) should sync document changes to the language server.
**/
@:enum abstract TextDocumentSyncKind(Int) {
    /**
        Documents should not be synced at all.
    **/
    var None = 0;

    /**
        Documents are synced by always sending the full content of the document.
    **/
    var Full = 1;

    /**
        Documents are synced by sending the full content on open.
        After that only incremental updates to the document are send.
    **/
    var Incremental = 2;
}

/**
    Completion options.
**/
typedef CompletionOptions = {
    /**
        The server provides support to resolve additional information for a completion item.
    **/
    @:optional var resolveProvider:Bool;

    /**
        The characters that trigger completion automatically.
    **/
    @:optional var triggerCharacters:Array<String>;
}

/**
    Signature help options.
**/
typedef SignatureHelpOptions = {
    /**
        The characters that trigger signature help automatically.
    **/
    @:optional var triggerCharacters:Array<String>;
}

typedef CodeLensOptions = {
    /**
        Code lens has a resolve provider as well.
    **/
    @:optional var resolveProvider:Bool;
}

typedef DocumentOnTypeFormattingOptions = {
    /**
        A character on which formatting should be triggered, like `}`.
    **/
    var firstTriggerCharacter:String;

    /**
        More trigger characters.
    **/
    @:optional var moreTriggerCharacter:Array<String>;
}

/**
    Save options.
**/
typedef SaveOptions = {
    /**
        The client is supposed to include the content on save.
    **/
    @:optional var includeText:Bool;
}

typedef TextDocumentSyncOptions = {
    /**
        Open and close notifications are sent to the server.
    **/
    @:optional var openClose:Bool;

    /**
        Change notificatins are sent to the server. See TextDocumentSyncKind.None, TextDocumentSyncKind.Full
        and TextDocumentSyncKindIncremental.
    **/
    @:optional var change:TextDocumentSyncKind;

    /**
        Will save notifications are sent to the server.
    **/
    @:optional var willSave:Bool;

    /**
        Will save wait until requests are sent to the server.
    **/
    @:optional var willSaveWaitUntil:Bool;

    /**
        Save notifications are sent to the server.
    **/
    @:optional var save:SaveOptions;
}

/**
    Document link options
**/
typedef DocumentLinkOptions = {
    /**
        Document links have a resolve provider as well.
    **/
    @:optional var resolveProvider:Bool;
}

typedef ServerCapabilities = {
    /**
        Defines how text documents are synced.
        Is either a detailed structure defining each notification or for backwards compatibility the TextDocumentSyncKind number.
    **/
    @:optional var textDocumentSync:EitherType<TextDocumentSyncOptions,TextDocumentSyncKind>;

    /**
        The server provides hover support.
    **/
    @:optional var hoverProvider:Bool;

    /**
        The server provides completion support.
    **/
    @:optional var completionProvider:CompletionOptions;

    /**
        The server provides signature help support.
    **/
    @:optional var signatureHelpProvider:SignatureHelpOptions;

    /**
        The server provides goto definition support.
    **/
    @:optional var definitionProvider:Bool;

    /**
        The server provides find references support.
    **/
    @:optional var referencesProvider:Bool;

    /**
        The server provides document highlight support.
    **/
    @:optional var documentHighlightProvider:Bool;

    /**
        The server provides document symbol support.
    **/
    @:optional var documentSymbolProvider:Bool;

    /**
        The server provides workspace symbol support.
    **/
    @:optional var workspaceSymbolProvider:Bool;

    /**
        The server provides code actions.
    **/
    @:optional var codeActionProvider:Bool;

    /**
        The server provides code lens.
    **/
    @:optional var codeLensProvider:CodeLensOptions;

    /**
        The server provides document formatting.
    **/
    @:optional var documentFormattingProvider:Bool;

    /**
        The server provides document range formatting.
    **/
    @:optional var documentRangeFormattingProvider:Bool;

    /**
        The server provides document formatting on typing.
    **/
    @:optional var documentOnTypeFormattingProvider:DocumentOnTypeFormattingOptions;

    /**
        The server provides rename support.
    **/
    @:optional var renameProvider:Bool;

    /**
        The server provides document link support.
    **/
    @:optional var documentLinkProvider:DocumentLinkOptions;

    /**
        The server provides execute command support.
    **/
    @:optional var executeCommandProvider:ExecuteCommandOptions;

    /**
        Experimental server capabilities.
    **/
    @:optional var experimental:Dynamic;
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

@:enum abstract MessageType(Int) to Int {
    /**
        An error message.
    **/
    var Error = 1;
    /**
        A warning message.
    **/
    var Warning = 2;

    /**
        An information message.
    **/
    var Info = 3;

    /**
        A log message.
    **/
    var Log = 4;
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
    @:optional var actions:Array<MessageActionItem>;
}

typedef MessageActionItem = {
    /**
        A short title like 'Retry', 'Open Log' etc.
    **/
    var title:String;
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
    General paramters to to regsiter for a capability.
**/
typedef Registration = {
    /**
        The id used to register the request. The id can be used to deregister
        the request again.
    **/
    var id:String;

    /**
        The method / capability to register for.
    **/
    var method:String;

    /**
        Options necessary for the registration.
    **/
    @:optional var registerOptions:Dynamic;
}

typedef RegistrationParams = {
    var registrations:Array<Registration>;
}

typedef TextDocumentRegistrationOptions = {
    /**
        A document selector to identify the scope of the registration. If set to null
        the document selector provided on the client side will be used.
    **/
    var documentSelector:Null<DocumentSelector>;
}

/**
    General parameters to unregister a capability.
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

typedef DidChangeConfigurationParams = {
    /**
        The actual changed settings.
    **/
    var settings:Dynamic;
}

typedef DidOpenTextDocumentParams = {
    /**
        The document that was opened.
    **/
    var textDocument:TextDocumentItem;
}

typedef DidChangeTextDocumentParams = {
    /**
        The document that did change.
        The version number points to the version after all provided content changes have been applied.
    **/
    var textDocument:VersionedTextDocumentIdentifier;

    /**
        The actual content changes.
    **/
    var contentChanges:Array<TextDocumentContentChangeEvent>;
}

/**
    The parameters send in a will save text document notification.
**/
typedef WillSaveTextDocumentParams  = {
    /**
        The document that will be saved.
     */
    var textDocument:TextDocumentIdentifier;

    /**
        The 'TextDocumentSaveReason'.
    **/
    var reason:TextDocumentSaveReason;
}

/**
    Represents reasons why a text document is saved.
**/
@:enum abstract TextDocumentSaveReason(Int) {
    /**
        Manually triggered, e.g. by the user pressing save, by starting debugging, or by an API call.
    **/
    var Manual = 1;

    /**
        Automatic after a delay.
    **/
    var AfterDelay = 2;

    /**
        When the editor lost focus.
    **/
    var FocusOut = 3;
}

/**
    An event describing a change to a text document.
    If `range` and `rangeLength` are omitted the new text is considered to be the full content of the document.
**/
typedef TextDocumentContentChangeEvent = {
    /**
        The range of the document that changed.
    **/
    @:optional var range:Range;

    /**
        The length of the range that got replaced.
    **/
    @:optional var rangeLength:Int;

    /**
        The new text of the document.
    **/
    var text:String;
}

/**
    Descibe options to be used when registered for text document change events.
**/
typedef TextDocumentChangeRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    /**
        How documents are synced to the server. See TextDocumentSyncKind.Full and TextDocumentSyncKindIncremental.
    **/
    var syncKind:TextDocumentSyncKind;
}

typedef DidCloseTextDocumentParams = {
    /**
        The document that was closed.
    **/
    var textDocument:TextDocumentIdentifier;
}

typedef DidSaveTextDocumentParams = {
    /**
        The document that was saved.
    **/
    var textDocument:TextDocumentIdentifier;

    /**
        Optional the content when saved. Depends on the `includeText` value when the save notifcation was requested.
    **/
    @:optional var text:String;
}

typedef TextDocumentSaveRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >SaveOptions,
}

typedef DidChangeWatchedFilesParams = {
    /**
        The actual file events.
    **/
    var changes:Array<FileEvent>;
}

/**
    The file event type.
**/
@:enum abstract FileChangeType(Int) to Int {
    /**
        The file got created.
    **/
    var Created = 1;

    /**
        The file got changed.
    **/
    var Changed = 2;

    /**
        The file got deleted.
    **/
    var Deleted = 3;
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

typedef CompletionItem = {
    /**
        The label of this completion item.
        By default also the text that is inserted when selecting this completion.
    **/
    var label:String;

    /**
        The kind of this completion item.
        Based of the kind an icon is chosen by the editor.
    **/
    @:optional var kind:CompletionItemKind;

    /**
        A human-readable string with additional information about this item, like type or symbol information.
    **/
    @:optional var detail:String;

    /**
        A human-readable string that represents a doc-comment.
    **/
    @:optional var documentation:String;

    /**
        A string that shoud be used when comparing this item with other items.
        When `falsy` the label is used.
    **/
    @:optional var sortText:String;

    /**
        A string that should be used when filtering a set of completion items.
        When `falsy` the label is used.
    **/
    @:optional var filterText:String;

    /**
        A string that should be inserted a document when selecting this completion.
        When `falsy` the label is used.
    **/
    @:optional var insertText:String;

    /**
        The format of the insert text. The format applies to both the `insertText` property
        and the `newText` property of a provided `textEdit`.
    **/
    @:optional var insertTextFormat:InsertTextFormat;

    /**
        An edit which is applied to a document when selecting this completion.
        When an edit is provided the value of `insertText` is ignored.
    **/
    @:optional var textEdit:TextEdit;

    /**
        An optional array of additional text edits that are applied when
        selecting this completion. Edits must not overlap with the main edit
        nor with themselves.
    **/
    @:optional var additionalTextEdits:Array<TextEdit>;

    /**
        An optional command that is executed *after* inserting this completion. *Note* that
        additional modifications to the current document should be described with the
        additionalTextEdits-property.
    **/
    @:optional var command:Command;

    /**
        An data entry field that is preserved on a completion item between a completion and a completion resolve request.
    **/
    @:optional var data:Dynamic;
}

/**
    Defines whether the insert text in a completion item should be interpreted as
    plain text or a snippet.
**/
@:enum abstract InsertTextFormat(Int) {
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
    Represents a collection of completion items to be presented in the editor.
**/
typedef CompletionList = {
    /**
        This list it not complete. Further typing should result in recomputing this list.
    **/
    var isIncomplete:Bool;

    /**
        The completion items.
    **/
    var items:Array<CompletionItem>;
}

/**
    The kind of a completion entry.
**/
@:enum abstract CompletionItemKind(Int) to Int {
    var Text = 1;
    var Method = 2;
    var Function = 3;
    var Constructor = 4;
    var Field = 5;
    var Variable = 6;
    var Class = 7;
    var Interface = 8;
    var Module = 9;
    var Property = 10;
    var Unit = 11;
    var Value = 12;
    var Enum = 13;
    var Keyword = 14;
    var Snippet = 15;
    var Color = 16;
    var File = 17;
    var Reference = 18;
}

typedef CompletionRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >CompletionOptions,
}

/**
    MarkedString can be used to render human readable text. It is either a markdown string
    or a code-block that provides a language and a code snippet. The language identifier
    is sematically equal to the optional language identifier in fenced code blocks in GitHub
    issues. See https://help.github.com/articles/creating-and-highlighting-code-blocks/#syntax-highlighting

    The pair of a language and a value is an equivalent to markdown:
    ```${language}
    ${value}
    ```

    Note that markdown strings will be sanitized - that means html will be escaped.
**/
typedef MarkedString = EitherType<String,{language:String, value:String}>;

/**
    The result of a hove request.
**/
typedef Hover = {
    /**
        The hover's content.
    **/
    var contents:EitherType<MarkedString,Array<MarkedString>>;

    /**
        An optional range.
    **/
    @:optional var range:Range;
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
        The active signature.
    **/
    @:optional var activeSignature:Int;

    /**
        The active parameter of the active signature.
    **/
    @:optional var activeParameter:Int;
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
    @:optional var documentation:String;

    /**
        The parameters of this signature.
    **/
    @:optional var parameters:Array<ParameterInformation>;
}

/**
    Represents a parameter of a callable-signature.
    A parameter can have a label and a doc-comment.
**/
typedef ParameterInformation = {
    /**
        The label of this signature.
        Will be shown in the UI.
    **/
    var label:String;

    /**
        The human-readable doc-comment of this signature.
        Will be shown in the UI but can be omitted.
    **/
    @:optional var documentation:String;
}

typedef SignatureHelpRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >SignatureHelpOptions,
}

typedef ReferenceParams = {
    >TextDocumentPositionParams,
    var context:ReferenceContext;
}

typedef ReferenceContext = {
    /**
        Include the declaration of the current symbol.
    **/
    var includeDeclaration:Bool;
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
    @:optional var kind:DocumentHighlightKind;
}

/**
    A document highlight kind.
**/
@:enum abstract DocumentHighlightKind(Int) to Int {
    /**
        A textual occurrance.
    **/
    var Text = 1;

    /**
        Read-access of a symbol, like reading a variable.
    **/
    var Read = 2;

    /**
        Write-access of a symbol, like writing to a variable.
    **/
    var Write = 3;
}

typedef DocumentSymbolParams = {
    /**
        The text document.
    **/
    var textDocument:TextDocumentIdentifier;
}

/**
    Represents information about programming constructs like variables, classes, interfaces etc.
**/
typedef SymbolInformation = {
    /**
        The name of this symbol.
    **/
    var name:String;

    /**
        The kind of this symbol.
    **/
    var kind:SymbolKind;

    /**
        The location of this symbol.
    **/
    var location:Location;

    /**
        The name of the symbol containing this symbol.
    **/
    @:optional var containerName:String;
}

@:enum abstract SymbolKind(Int) to Int {
    var File = 1;
    var Module = 2;
    var Namespace = 3;
    var Package = 4;
    var Class = 5;
    var Method = 6;
    var Property = 7;
    var Field = 8;
    var Constructor = 9;
    var Enum = 10;
    var Interface = 11;
    var Function = 12;
    var Variable = 13;
    var Constant = 14;
    var String = 15;
    var Number = 16;
    var Boolean = 17;
    var Array = 18;
}

/**
    The parameters of a Workspace Symbol Request.
**/
typedef WorkspaceSymbolParams = {
    /**
        A non-empty query string.
    **/
    var query:String;
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

/**
    Contains additional diagnostic information about the context in which a code action is run.
**/
typedef CodeActionContext = {
    /**
        An array of diagnostics.
    **/
    var diagnostics:Array<Diagnostic>;
}

typedef CodeLensParams = {
    /**
        The document to request code lens for.
    **/
    var textDocument:TextDocumentIdentifier;
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
    @:optional var command:Command;

    /**
        An data entry field that is preserved on a code lens item between a code lens and a code lens resolve request.
    **/
    @:optional var data:Dynamic;
}

typedef CodeLensRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >CodeLensOptions,
}

typedef DocumentLinkParams = {
    /**
        The document to provide document links for.
    **/
    var textDocument:TextDocumentIdentifier;
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
    @:optional var target:DocumentUri;
}

typedef DocumentLinkRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >DocumentLinkOptions,
}

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

typedef DocumentOnTypeFormattingRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >DocumentOnTypeFormattingOptions,
}

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

typedef ExecuteCommandParams = {
    /**
        The identifier of the actual command handler.
    **/
    var command:String;

    /**
        Arguments that the command should be invoked with.
    **/
    @:optional var arguments:Array<Dynamic>;
}

/**
    Execute command registration options.
**/
typedef ExecuteCommandRegistrationOptions = {
    >ExecuteCommandOptions,
}

typedef ApplyWorkspaceEditParams = {
    /**
        The edits to apply.
    **/
    var edit:WorkspaceEdit;
}

typedef ApplyWorkspaceEditResponse = {
    /**
        Indicates whether the edit was applied or not.
    **/
    var applied:Bool;
}
