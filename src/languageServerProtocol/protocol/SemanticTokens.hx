package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	@since 3.16.0
**/
typedef SemanticTokensPartialResult = {
	var data:Array<Int>;
}

/**
	@since 3.16.0
**/
typedef SemanticTokensDeltaPartialResult = {
	var edits:Array<SemanticTokensEdit>;
}

//------- 'textDocument/semanticTokens' -----

enum abstract TokenFormat(String) {
	/**
		Supports creating new files and folders.
	**/
	var Relative = "relative";
}

/**
	@since 3.16.0
**/
typedef SemanticTokensClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is set to `true`
		the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;

	/**
		Which requests the client supports and might send to the server
		depending on the server's capability. Please note that clients might not
		show semantic tokens or degrade some of the user experience if a range
		or full request is advertised by the client but not provided by the
		server. If for example the client capability `requests.full` and
		`request.range` are both set to true but the server only provides a
		range provider the client might not render a minimap correctly or might
		even decide to not show any semantic tokens at all.
	**/
	var requests:{
		/**
			The client will send the `textDocument/semanticTokens/range` request if
			the server provides a corresponding handler.
		**/
		var ?range:EitherType<Bool, {}>;

		/**
			The client will send the `textDocument/semanticTokens/full` request if
			the server provides a corresponding handler.
		**/
		var ?full:EitherType<Bool, {
			/**
				The client will send the `textDocument/semanticTokens/full/delta` request if
				the server provides a corresponding handler.
			**/
			var ?delta:Bool;
		}>;
	};

	/**
		The token types that the client supports.
	**/
	var tokenTypes:Array<String>;

	/**
		The token modifiers that the client supports.
	**/
	var tokenModifiers:Array<String>;

	/**
		The token formats the clients supports.
	**/
	var formats:Array<TokenFormat>;

	/**
		Whether the client supports tokens that can overlap each other.
	**/
	var ?overlappingTokenSupport:Bool;

	/**
		Whether the client supports tokens that can span multiple lines.
	**/
	var ?multilineTokenSupport:Bool;

	/**
		Whether the client allows the server to actively cancel a
		semantic token request, e.g. supports returning
		LSPErrorCodes.ServerCancelled. If a server does the client
		needs to retrigger the request.

		@since 3.17.0
	**/
	var ?serverCancelSupport:Bool;

	/**
		Whether the client uses semantic tokens to augment existing
		syntax tokens. If set to `true` client side created syntax
		tokens and semantic tokens are both used for colorization. If
		set to `false` the client only uses the returned semantic tokens
		for colorization.

		If the value is `undefined` then the client behavior is not
		specified.

		@since 3.17.0
	**/
	var ?augmentsSyntaxTokens:Bool;
}

/**
	@since 3.16.0
**/
typedef SemanticTokensOptions = WorkDoneProgressOptions & {
	/**
		The legend used by the server
	**/
	var legend:SemanticTokensLegend;

	/**
		Server supports providing semantic tokens for a specific range
		of a document.
	**/
	var ?range:EitherType<Bool, {}>;

	/**
		Server supports providing semantic tokens for a full document.
	**/
	var ?full:EitherType<Bool, {
		/**
			The server supports deltas for full documents.
		**/
		var ?delta:Bool;
	}>;
}

/**
	@since 3.16.0
**/
typedef SemanticTokensRegistrationOptions = TextDocumentRegistrationOptions & SemanticTokensOptions & StaticRegistrationOptions;

class SemanticTokensRegistrationType {
	public static inline final type = new RegistrationType<SemanticTokensRegistrationOptions>("textDocument/semanticTokens");
}

//------- 'textDocument/semanticTokens' -----

/**
	@since 3.16.0
**/
typedef SemanticTokensParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;
}

/**
	@since 3.16.0
**/
class SemanticTokensRequest {
	public static inline final type = new ProtocolRequestType<SemanticTokensParams, Null<SemanticTokens>, SemanticTokensPartialResult, NoData,
		SemanticTokensRegistrationOptions>("textDocument/semanticTokens/full");
}

//------- 'textDocument/semanticTokens/edits' -----

/**
	@since 3.16.0
**/
typedef SemanticTokensDeltaParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The result id of a previous response. The result Id can either point to a full response
		or a delta response depending on what was received last.
	**/
	var previousResultId:String;
}

/**
	@since 3.16.0
**/
class SemanticTokensDeltaRequest {
	public static inline final type = new ProtocolRequestType<SemanticTokensDeltaParams, Null<EitherType<SemanticTokens, SemanticTokensDelta>>,
		EitherType<SemanticTokensPartialResult, SemanticTokensDeltaPartialResult>, NoData,
		SemanticTokensRegistrationOptions>("textDocument/semanticTokens/full/delta");
}

//------- 'textDocument/semanticTokens/range' -----

/**
	@since 3.16.0
**/
typedef SemanticTokensRangeParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The range the semantic tokens are requested for.
	**/
	var range:Range;
}

/**
	@since 3.16.0
**/
class SemanticTokensRangeRequest {
	public static inline final type = new ProtocolRequestType<SemanticTokensRangeParams, Null<SemanticTokens>, SemanticTokensPartialResult, NoData,
		NoData>("textDocument/semanticTokens/range");
}

//------- 'workspace/semanticTokens/refresh' -----

/**
	@since 3.16.0
**/
typedef SemanticTokensWorkspaceClientCapabilities = {
	/**
		Whether the client implementation supports a refresh request sent from
		the server to the client.

		Note that this event is global and will force the client to refresh all
		semantic tokens currently shown. It should be used with absolute care
		and is useful for situation where a server for example detects a project
		wide change that requires such a calculation.
	**/
	var ?refreshSupport:Bool;
}

/**
	@since 3.16.0
**/
class SemanticTokensRefreshRequest {
	public static inline final type = new ProtocolRequestType<NoData, NoData, NoData, NoData, NoData>("workspace/semanticTokens/refresh");
}
