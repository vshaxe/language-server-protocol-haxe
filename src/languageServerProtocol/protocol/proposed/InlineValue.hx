package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

// ---- capabilities

/**
	Client capabilities specific to inline values.

	@since 3.17.0
	@proposed
**/
typedef InlineValueClientCapabilities = {
	/**
		Whether implementation supports dynamic registration for inline value providers.
	**/
	var ?dynamicRegistration:Bool;
};

/**
	Client workspace capabilities specific to inline values.

	@since 3.17.0
	@proposed
**/
typedef InlineValueWorkspaceClientCapabilities = {
	/**
		Whether the client implementation supports a refresh request sent from the
		server to the client.

		Note that this event is global and will force the client to refresh all
		inline values currently shown. It should be used with absolute care and is
		useful for situation where a server for example detects a project wide
		change that requires such a calculation.
	**/
	var ?refreshSupport:Bool;
};

/**
	Inline value options used during static registration.

	@since 3.17.0
	@proposed
**/
typedef InlineValueOptions = WorkDoneProgressOptions;

/**
	Inline value options used during static or dynamic registration.

	@since 3.17.0
	@proposed
**/
typedef InlineValueRegistrationOptions = InlineValueOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions;

/**
	A parameter literal used in inline value requests.

	@since 3.17.0
	@proposed
**/
typedef InlineValueParams = WorkDoneProgressParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The document range for which inline values should be computed.
	**/
	var range:Range;

	/**
		Additional information about the context in which inline values were
		requested.
	**/
	var context:InlineValueContext;
};

/**
	A request to provide inline values in a document. The request's parameter is of
	type [InlineValueParams](#InlineValueParams), the response is of type
	[InlineValue[]](#InlineValue[]) or a Thenable that resolves to such.

	@since 3.17.0
	@proposed
**/
class InlineValueRequest {
	public static inline final type = new ProtocolRequestType<InlineValueParams, Null<Array<InlineValueParams>>, Array<InlineValueParams>, NoData,
		InlineValueRegistrationOptions>("textDocument/inlineValue");
}

/**
	@since 3.17.0
	@proposed
**/
class InlineValueRefreshRequest {
	public static inline final type = new ProtocolRequestType<NoData, NoData, NoData, NoData, NoData>("workspace/inlineValue/refresh");
}
