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
        The initialize request is sent from the client to the server.
        It is sent once as the request after starting up the server.
        The requests parameter is of type `InitializeParams`
        the response if of type `InitializeResult` of a Thenable that
        resolves to such.
    **/
    static inline var Initialize = new RequestMethod<InitializeParams,InitializeResult,InitializeError, NoData>("initialize");

    /**
        The initialized notification is sent from the client to the server after the client received the result of the initialize request
        but before the client is sending any other request or notification to the server. The server can use the initialized notification
        for example to dynamically register capabilities.
    **/
    static inline var Initialized = new NotificationMethod<InitializedParams,NoData>("initialized");

    /**
        A shutdown request is sent from the client to the server.
        It is sent once when the client descides to shutdown the
        server. The only notification that is sent after a shudown request
        is the exit event.
    **/
    static inline var Shutdown = new RequestMethod<NoData,NoData,NoData,NoData>("shutdown");

    /**
        A notification to ask the server to exit its process.
        The server should exit with success code 0 if the shutdown request has been received before; otherwise with error code 1.
    **/
    static inline var Exit = new NotificationMethod<NoData,NoData>("exit");

    /**
        The show message notification is sent from a server to a client to ask the client to display a particular message in the user interface.
    **/
    static inline var ShowMessage = new NotificationMethod<ShowMessageParams,NoData>("window/showMessage");

    /**
        The show message request is sent from a server to a client to ask the client to display a particular message in the user interface.
        In addition to the show message notification the request allows to pass actions and to wait for an answer from the client.
    **/
    static inline var ShowMessageRequest = new RequestMethod<ShowMessageRequestParams,Null<MessageActionItem>,NoData,NoData>("window/showMessageRequest");

    /**
        The log message notification is send from the server to the client to ask the client to log a particular message.
    **/
    static inline var LogMessage = new NotificationMethod<LogMessageParams,NoData>("window/logMessage");

    /**
        The telemetry notification is sent from the server to the client to ask the client to log a telemetry event.
    **/
    static inline var Telemetry = new NotificationMethod<Dynamic,NoData>("telemetry/event");

    /**
        The `client/registerCapability` request is sent from the server to the client to register a new capability
        handler on the client side.
    **/
    static inline var RegisterCapability = new RequestMethod<RegistrationParams,NoData,NoData,NoData>("client/registerCapability");

    /**
        The `client/unregisterCapability` request is sent from the server to the client to unregister a previously registered capability
        handler on the client side.
    **/
    static inline var UnregisterCapability = new RequestMethod<UnregistrationParams,NoData,NoData,NoData>("client/unregisterCapability");

    /**
        A notification send from the client to the server to signal the change of configuration settings.
    **/
    static inline var DidChangeConfiguration = new NotificationMethod<DidChangeConfigurationParams,DidChangeConfigurationRegistrationOptions>("workspace/didChangeConfiguration");

    /**
        The document open notification is sent from the client to the server to signal newly opened text documents. The document’s truth is now managed by the client and the server must not try to read the document’s truth using the document’s uri. Open in this sense means it is managed by the client. It doesn’t necessarily mean that its content is presented in an editor. An open notification must not be sent more than once without a corresponding close notification send before. This means open and close notification must be balanced and the max open count for a particular textDocument is one.
    **/
    static inline var DidOpenTextDocument = new NotificationMethod<DidOpenTextDocumentParams,TextDocumentRegistrationOptions>("textDocument/didOpen");

    /**
        The document change notification is sent from the client to the server to signal changes to a text document.
    **/
    static inline var DidChangeTextDocument = new NotificationMethod<DidChangeTextDocumentParams,TextDocumentChangeRegistrationOptions>("textDocument/didChange");

    /**
        The document will save notification is sent from the client to the server before the document is actually saved.
    **/
    static inline var WillSaveTextDocument = new NotificationMethod<WillSaveTextDocumentParams,TextDocumentRegistrationOptions>("textDocument/willSave");

    /**
        The document will save request is sent from the client to the server before the document is actually saved.
        The request can return an array of TextEdits which will be applied to the text document before it is saved.
        Please note that clients might drop results if computing the text edits took too long or if a server constantly fails on this request.
        This is done to keep the save fast and reliable.
    **/
    static inline var WillSaveWaitUntilTextDocument = new RequestMethod<WillSaveTextDocumentParams,Null<Array<TextEdit>>,NoData,TextDocumentRegistrationOptions>("textDocument/willSaveWaitUntil");

    /**
        The document close notification is sent from the client to the server when
        the document got closed in the client. The document's truth now exists where
        the document's uri points to (e.g. if the document's uri is a file uri the
        truth now exists on disk). As with the open notification the close notification
        is about managing the document's content. Receiving a close notification
        doesn't mean that the document was open in an editor before. A close
        notification requires a previous open notifaction to be sent.
    **/
    static inline var DidCloseTextDocument = new NotificationMethod<DidCloseTextDocumentParams,TextDocumentRegistrationOptions>("textDocument/didClose");

    /**
        The document save notification is sent from the client to the server when the document for saved in the clinet.
    **/
    static inline var DidSaveTextDocument = new NotificationMethod<DidSaveTextDocumentParams,TextDocumentSaveRegistrationOptions>("textDocument/didSave");

    /**
        The watched files notification is sent from the client to the server when the client detects changes to file watched by the lanaguage client.
    **/
    static inline var DidChangeWatchedFiles = new NotificationMethod<DidChangeWatchedFilesParams,DidChangeWatchedFilesRegistrationOptions>("workspace/didChangeWatchedFiles");

    /**
        Diagnostics notification are sent from the server to the client to signal results of validation runs.
    **/
    static inline var PublishDiagnostics = new NotificationMethod<PublishDiagnosticsParams,NoData>("textDocument/publishDiagnostics");

    /**
        Request to request completion at a given text document position. The request's
        parameter is of type `TextDocumentPosition` the response is of type `Array<CompletionItem>` or `CompletionList` or a Thenable that resolves to such.

        The request can delay the computation of the `CompletionItem.detail` and `documentation` properties to the `completionItem/resolve`
        request. However, properties that are needed for the inital sorting and filtering, like `sortText`,
        `filterText`, `insertText`, and `textEdit`, must not be changed during resolve.
    **/
    static inline var Completion = new RequestMethod<CompletionParams,Null<EitherType<Array<CompletionItem>,CompletionList>>,NoData,CompletionRegistrationOptions>("textDocument/completion");

    /**
        The request is sent from the client to the server to resolve additional information for a given completion item.
    **/
    static inline var CompletionItemResolve = new RequestMethod<CompletionItem,CompletionItem,NoData,NoData>("completionItem/resolve");

    /**
        The hover request is sent from the client to the server to request hover information at a given text document position.
    **/
    static inline var Hover = new RequestMethod<TextDocumentPositionParams,Null<Hover>,NoData,TextDocumentRegistrationOptions>("textDocument/hover");

    /**
        The signature help request is sent from the client to the server to request signature information at a given cursor position.
    **/
    static inline var SignatureHelp = new RequestMethod<TextDocumentPositionParams,Null<SignatureHelp>,NoData,SignatureHelpRegistrationOptions>("textDocument/signatureHelp");

    /**
        The goto definition request is sent from the client to the server to to resolve the defintion location of a symbol at a given text document position.
    **/
    static inline var GotoDefinition = new RequestMethod<TextDocumentPositionParams,Null<Definition>,NoData,TextDocumentRegistrationOptions>("textDocument/definition");

    /**
        The references request is sent from the client to the server to resolve project-wide references for the symbol denoted by the given text document position.
    **/
    static inline var FindReferences = new RequestMethod<ReferenceParams,Null<Array<Location>>,NoData,TextDocumentRegistrationOptions>("textDocument/references");

    /**
        The document highlight request is sent from the client to the server to to resolve a document highlights for a given text document position.
    **/
    static inline var DocumentHighlights = new RequestMethod<TextDocumentPositionParams,Null<Array<DocumentHighlight>>,NoData,TextDocumentRegistrationOptions>("textDocument/documentHighlight");

    /**
        The document symbol request is sent from the client to the server to list all symbols found in a given text document.
    **/
    static inline var DocumentSymbols = new RequestMethod<DocumentSymbolParams,Null<Array<SymbolInformation>>,NoData,TextDocumentRegistrationOptions>("textDocument/documentSymbol");

    /**
        The workspace symbol request is sent from the client to the server to list project-wide symbols matching the query string.
    **/
    static inline var WorkspaceSymbols = new RequestMethod<WorkspaceSymbolParams,Null<Array<SymbolInformation>>,NoData,NoData>("workspace/symbol");

    /**
        The code action request is sent from the client to the server to compute commands for a given text document and range.
        These commands are typically code fixes to either fix problems or to beautify/refactor code.
    **/
    static inline var CodeAction = new RequestMethod<CodeActionParams,Null<Array<Command>>,NoData,TextDocumentRegistrationOptions>("textDocument/codeAction");

    /**
        The code lens request is sent from the client to the server to compute code lenses for a given text document.
    **/
    static inline var CodeLens = new RequestMethod<CodeLensParams,Array<CodeLens>,NoData,NoData>("textDocument/codeLens");

    /**
        The code lens resolve request is sent from the clien to the server to resolve the command for a given code lens item.
    **/
    static inline var CodeLensResolve = new RequestMethod<CodeLens,CodeLens,NoData,NoData>("codeLens/resolve");

    /**
        The document links request is sent from the client to the server to request the location of links in a document.
    **/
    static inline var DocumentLink = new RequestMethod<DocumentLinkParams,Null<Array<DocumentLink>>,NoData,DocumentLinkRegistrationOptions>("textDocument/documentLink");

    /**
        The document link resolve request is sent from the client to the server to resolve the target of a given document link.
    **/
    static inline var DocumentLinkResolve = new RequestMethod<DocumentLink,DocumentLink,NoData,NoData>("documentLink/resolve");

    /**
        The document formatting resquest is sent from the server to the client to format a whole document.
    **/
    static inline var DocumentFormatting = new RequestMethod<DocumentFormattingParams,Null<Array<TextEdit>>,NoData,TextDocumentRegistrationOptions>("textDocument/formatting");

    /**
        The document range formatting request is sent from the client to the server to format a given range in a document.
    **/
    static inline var DocumentRangeFormatting = new RequestMethod<DocumentRangeFormattingParams,Null<Array<TextEdit>>,NoData,TextDocumentRegistrationOptions>("textDocument/rangeFormatting");

    /**
        The document on type formatting request is sent from the client to the server to format parts of the document during typing.
    **/
    static inline var DocumentOnTypeFormatting = new RequestMethod<DocumentOnTypeFormattingParams,Null<Array<TextEdit>>,NoData,TextDocumentRegistrationOptions>("textDocument/onTypeFormatting");

    /**
        The rename request is sent from the client to the server to do a workspace wide rename of a symbol.
    **/
    static inline var Rename = new RequestMethod<RenameParams,Null<WorkspaceEdit>,NoData,TextDocumentRegistrationOptions>("textDocument/rename");

    /**
        The workspace/executeCommand request is sent from the client to the server to trigger command execution on the server.
        In most cases the server creates a `WorkspaceEdit` structure and applies the changes to the workspace using the request `workspace/applyEdit`
        which is sent from the server to the client.
    **/
    static inline var ExecuteCommand = new RequestMethod<ExecuteCommandParams,Null<Dynamic>,NoData,ExecuteCommandRegistrationOptions>("workspace/executeCommand");

    /**
        The workspace/applyEdit request is sent from the server to the client to modify resource on the client side.
    **/
    static inline var ApplyEdit = new RequestMethod<ApplyWorkspaceEditParams,ApplyWorkspaceEditResponse,NoData,NoData>("workspace/applyEdit");
}

/**
    Position in a text document expressed as zero-based line and character offset.
    The offsets are based on a UTF-16 string representation. So a string of the form
    `a𐐀b` the character offset of the character `a` is 0, the character offset of `𐐀`
    is 1 and the character offset of b is 3 since `𐐀` is represented using two code
    units in UTF-16.

    Positions are line end character agnostic. So you can not specifiy a position that
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
    The diagnostic's serverity.
**/
@:enum abstract DiagnosticSeverity(Int) {
    /**
        Reports an error.
    **/
    var Error = 1;

    /**
        Reports a warning.
    **/
    var Warning = 2;

    /**
        Reports an information.
    **/
    var Information = 3;

    /**
        Reports a hint.
    **/
    var Hint = 4;
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
        The diagnostic's code, which might appear in the user interface.
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
    Describes textual changes on a text document.
**/
typedef TextDocumentEdit = {
    /**
        The text document to change.
    **/
    var textDocument:VersionedTextDocumentIdentifier;

    /**
        The edits to be applied.
    **/
    var edits:Array<TextEdit>;
}

/**
    A workspace edit represents changes to many resources managed in the workspace.
    The edit should either provide `changes` or `documentChanges`.
    If `documentChanges` are present they are preferred over `changes` if the client
    can handle versioned document edits.
**/
typedef WorkspaceEdit = {
    /**
        Holds changes to existing resources.
    **/
    @:optional var changes:haxe.DynamicAccess<Array<TextEdit>>;

    /**
        An array of `TextDocumentEdit`s to express changes to n different text documents
        where each text document edit addresses a specific version of a text document.
        Whether a client supports versioned document edits is expressed via
        `WorkspaceClientCapabilites.workspaceEdit.documentChanges`.
    **/
    @:optional var documentChanges:Array<TextDocumentEdit>;
}

abstract DocumentUri(String) {
    public inline function new(uri:String) {
        this = uri;
    }

    public inline function toString() {
        return this;
    }
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
typedef VersionedTextDocumentIdentifier = {
    >TextDocumentIdentifier,

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
@:enum abstract MarkupKind(String) {
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

    @sample `let sel:DocumentSelector = [{ language: 'typescript' }, { language: 'json', pattern: '**∕tsconfig.json' }]`;
**/
typedef DocumentSelector = Array<EitherType<String,DocumentFilter>>;

/**
    The initialize parameters
**/
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
    @:deprecated("deprecated in favour of rootUri")
    var rootPath:Null<String>;

    /**
        The rootUri of the workspace.
        Is null if no folder is open.
        If both `rootPath` and `rootUri` are set `rootUri` wins.
    **/
    @:deprecated("deprecated in favour of workspaceFolders")
    var rootUri:Null<DocumentUri>;

    /**
        The capabilities provided by the client (editor or tool).
    **/
    var capabilities:ClientCapabilities;

    /**
        User provided initialization options.
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

/**
    The result returned from an initilize request.
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

typedef InitializedParams = {
}

/**
    Workspace specific client capabilities.

    Define capabilities the editor / tool provides on the workspace.
**/
typedef WorkspaceClientCapabilites = {
    /**
        The client supports applying batch edits to the workspace by supporting
        the request 'workspace/applyEdit'
    **/
    @:optional var applyEdit:Bool;

    /**
        Capabilities specific to `WorkspaceEdit`s
    **/
    @:optional var workspaceEdit:{
        /**
            The client supports versioned document changes in `WorkspaceEdit`s
        **/
        @:optional var documentChanges:Bool;
    };

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

        /**
            Specific capabilities for the `SymbolKind` in the `workspace/symbol` request.
        **/
        @:optional var symbolKind:{
            /**
                The symbol kind values the client supports. When this
                property exists the client also guarantees that it will
                handle values outside its set gracefully and falls back
                to a default value when unknown.

                If this property is not present the client only supports
                the symbol kinds from `File` to `Array` as defined in
                the initial version of the protocol.
            **/
            @:optional var valueSet:Array<SymbolKind>;
        };
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
**/
typedef TextDocumentClientCapabilities = {
    /**
        Defines which synchronization capabilities the client supports.
    **/
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

            /**
                Client supports commit characters on a completion item.
            **/
            @:optional var commitCharactersSupport:Bool;

            /**
                Client supports the follow content formats for the documentation
                property. The order describes the preferred format of the client.
            **/
            @:optional var documentationFormat:Array<MarkupKind>;
        };

        @:optional var completionItemKind:{
            /**
                The completion item kind values the client supports. When this
                property exists the client also guarantees that it will
                handle values outside its set gracefully and falls back
                to a default value when unknown.

                If this property is not present the client only supports
                the completion items kinds from `Text` to `Reference` as defined in
                the initial version of the protocol.
            **/
            @:optional var valueSet:Array<CompletionItemKind>;
        };

        /**
            The client supports to send additional context information for a
            `textDocument/completion` requestion.
        **/
        @:optional var contextSupport:Bool;
    };

    /**
        Capabilities specific to the `textDocument/hover`
    **/
    @:optional var hover:{
        /**
            Whether hover supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;

        /**
            Client supports the follow content formats for the content
            property. The order describes the preferred format of the client.
        **/
        @:optional var contentFormat:Array<MarkupKind>;
    };

    /**
        Capabilities specific to the `textDocument/signatureHelp`
    **/
    @:optional var signatureHelp:{
        /**
            Whether signature help supports dynamic registration.
        **/
        @:optional var dynamicRegistration:Bool;

        /**
            The client supports the following `SignatureInformation`
            specific properties.
        **/
        @:optional var signatureInformation:{
            /**
                Client supports the follow content formats for the documentation
                property. The order describes the preferred format of the client.
            **/
            @:optional var documentationFormat:Array<MarkupKind>;
        };
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

        /**
            Specific capabilities for the `SymbolKind`.
        **/
        @:optional var symbolKind:{
            /**
                The symbol kind values the client supports. When this
                property exists the client also guarantees that it will
                handle values outside its set gracefully and falls back
                to a default value when unknown.

                If this property is not present the client only supports
                the symbol kinds from `File` to `Array` as defined in
                the initial version of the protocol.
            **/
            @:optional var valueSet:Array<SymbolKind>;
        };
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
        Most tools trigger completion request automatically without explicitly requesting
        it using a keyboard shortcut (e.g. Ctrl+Space). Typically they do so when the user
        starts to type an identifier. For example if the user types `c` in a JavaScript file
        code complete will automatically pop up present `console` besides others as a
        completion item. Characters that make up identifiers don't need to be listed here.

        If code complete should automatically be trigger on characters not being valid inside
        an identifier (for example `.` in JavaScript) list them in `triggerCharacters`.
    **/
    @:optional var triggerCharacters:Array<String>;

    /**
        The server provides support to resolve additional information for a completion item.
    **/
    @:optional var resolveProvider:Bool;
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

/**
    Code Lens options.
**/
typedef CodeLensOptions = {
    /**
        Code lens has a resolve provider as well.
    **/
    @:optional var resolveProvider:Bool;
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

/**
    The message type
**/
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
    General paramters to to regsiter for an notification or to register a provider.
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
    @:optional var registerOptions:Dynamic;
}

typedef RegistrationParams = {
    var registrations:Array<Registration>;
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
    The parameters of a change configuration notification.
**/
typedef DidChangeConfigurationParams = {
    /**
        The actual changed settings.
    **/
    var settings:Dynamic;
}

typedef DidChangeConfigurationRegistrationOptions = {
    @:optional var section:EitherType<String,Array<String>>;
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
        The actual content changes. The content changes descibe single state changes
        to the document. So if there are two content changes c1 and c2 for a document
        in state S10 then c1 move the document to S11 and c2 to S12.
    **/
    var contentChanges:Array<TextDocumentContentChangeEvent>;
}

/**
    Descibe options to be used when registered for text document change events.
**/
typedef TextDocumentChangeRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    /**
        How documents are synced to the server.
    **/
    var syncKind:TextDocumentSyncKind;
}

/**
    The parameters send in a will save text document notification.
**/
typedef WillSaveTextDocumentParams  = {
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
        The new text of the range/document.
    **/
    var text:String;
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
    @:optional var text:String;
}

/**
    Save registration options.
**/
typedef TextDocumentSaveRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >SaveOptions,
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

/**
    Descibe options to be used when registered for text document change events.
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
    @:optional var kind:Int;
}

@:enum abstract WatchKind(Int) to Int {
    /**
        Interested in create events.
    **/
    var Create = 1;

    /**
        Interested in change events
    **/
    var Change = 2;

    /**
        Interested in delete events
    **/
    var Delete = 3;
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
typedef CompletionRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >CompletionOptions,
}

/**
    How a completion was triggered
**/
@:enum abstract CompletionTriggerKind(Int) {
    /**
        Completion was triggered by typing an identifier (24x7 code
        complete), manual invocation (e.g Ctrl+Space) or via API.
    **/
    var Invoked = 1;

    /**
        Completion was triggered by a trigger character specified by
        the `triggerCharacters` properties of the `CompletionRegistrationOptions`.
    **/
    var TriggerCharacter = 2;

    /**
        Completion was re-triggered as current completion list is incomplete
    **/
    var TriggerForIncompleteCompletions = 3;
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
    @:optional var triggerCharacter:String;
}

/**
    Completion parameters
**/
typedef CompletionParams = {
    >TextDocumentPositionParams,
    /**
        The completion context. This is only available it the client specifies
        to send this using `ClientCapabilities.textDocument.completion.contextSupport === true`
    **/
    @:optional var context:CompletionContext;
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
    @:optional var documentation:EitherType<String,MarkupContent>;

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
        A string that should be inserted into a document when selecting
        this completion. When `falsy` the [label](#CompletionItem.label)
        is used.

        The `insertText` is subject to interpretation by the client side.
        Some tools might not take the string literally. For example
        VS Code when code complete is requested in this example `con<cursor position>`
        and a completion item with an `insertText` of `console` is provided it
        will only insert `sole`. Therefore it is recommended to use `textEdit` instead
        since it avoids additional client side interpretation.
    **/
    @:deprecated("Use textEdit instead")
    @:optional var insertText:String;

    /**
        The format of the insert text. The format applies to both the `insertText` property
        and the `newText` property of a provided `textEdit`.
    **/
    @:optional var insertTextFormat:InsertTextFormat;

    /**
        A `TextEdit` which is applied to a document when selecting
        this completion. When an edit is provided the value of
        `insertText` is ignored.

        *Note:* The text edit's range must be a [single line] and it must contain the position
        at which completion has been requested.
    **/
    @:optional var textEdit:TextEdit;

    /**
        An optional array of additional text edits that are applied when
        selecting this completion. Edits must not overlap with the main edit
        nor with themselves.
    **/
    @:optional var additionalTextEdits:Array<TextEdit>;

    /**
        An optional set of characters that when pressed while this completion is active will accept it first and
        then type that character. *Note* that all commit characters should have `length=1` and that superfluous
        characters will be ignored.
    **/
    @:optional var commitCharacters:Array<String>;

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
    var Folder = 19;
    var EnumMember = 20;
    var Constant = 21;
    var Struct = 22;
    var Event = 23;
    var Operator = 24;
    var TypeParameter = 25;
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
@:deprecated("use MarkupContent instead")
typedef MarkedString = EitherType<String,{language:String, value:String}>;

/**
    The result of a hover request.
**/
typedef Hover = {
    /**
        The hover's content.
    **/
    var contents:EitherType<MarkupContent,EitherType<MarkedString,Array<MarkedString>>>;

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
        The active signature. Set to `null` if no
        signatures exist.
    **/
    @:optional var activeSignature:Int;

    /**
        The active parameter of the active signature. Set to `null`
        if the active signature has no parameters.
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
    @:optional var documentation:EitherType<String,MarkupContent>;

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
    @:optional var documentation:EitherType<String,MarkupContent>;
}

/**
    The definition of a symbol represented as one or many `locations`.
    For most programming languages there is only one location at which a symbol is
    defined. If no definition can be found `null` is returned.
**/
typedef Definition = Null<EitherType<Location, Array<Location>>>;

typedef SignatureHelpRegistrationOptions = {
    >TextDocumentRegistrationOptions,
    >SignatureHelpOptions,
}

typedef ReferenceParams = {
    >TextDocumentPositionParams,
    var context:ReferenceContext;
}

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

/**
    Parameters for a `DocumentSymbols` request.
**/
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
        The location of this symbol. The location's range is used by a tool
        to reveal the location in the editor. If the symbol is selected in the
        tool the range's start information is used to position the cursor. So
        the range usually spwans more then the actual symbol's name and does
        normally include thinks like visibility modifiers.

        The range doesn't have to denote a node range in the sense of a abstract
        syntax tree. It can therefore not be used to re-construct a hierarchy of
        the symbols.
    **/
    var location:Location;

    /**
        The name of the symbol containing this symbol. This information is for
        user interface purposes (e.g. to render a qaulifier in the user interface
        if necessary). It can't be used to re-infer a hierarchy for the document
        symbols.
    **/
    @:optional var containerName:String;
}

/**
    A symbol kind.
**/
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
    var Object = 19;
    var Key = 20;
    var Null = 21;
    var EnumMember = 22;
    var Struct = 23;
    var Event = 24;
    var Operator = 25;
    var TypeParameter = 26;
}

/**
    The parameters of a `WorkspaceSymbols` request.
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
