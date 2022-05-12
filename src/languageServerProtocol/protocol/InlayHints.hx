package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	Inlay hint client capabilities

	@since 3.17.0
**/
typedef InlayHintClientCapabilities = {
	/**
		Whether inlay hints support dynamic registration.
	**/
	var ?dynamicRegistration:Bool;

	/**
		Indicates which properties a client can resolve lazily on a inlay
		hint.
	**/
	var ?resolveSupport:{
		/**
			The properties that a client can resolve lazily.
		**/
		var properties:Array<String>;
	};
};

/**
	Client workspace capabilities specific to inlay hints.

	@since 3.17.0
**/
typedef InlayHintWorkspaceClientCapabilities = {
	/**
		Whether the client implementation supports a refresh request sent from
		the server to the client.

		Note that this event is global and will force the client to refresh all
		inlay hints currently shown. It should be used with absolute care and
		is useful for situation where a server for example detects a project wide
		change that requires such a calculation.
	**/
	var ?refreshSupport:Bool;
};

/**
	Inlay hint options used during static registration.

	@since 3.17.0
**/
typedef InlayHintOptions = WorkDoneProgressOptions & {
	/**
		The server provides support to resolve additional
		information for an inlay hint item.
	**/
	var ?resolveProvider:Bool;
};

/**
	Inlay hint options used during static or dynamic registration.

	@since 3.17.0
**/
typedef InlayHintRegistrationOptions = InlayHintOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions;

/**
	A parameter literal used in inlay hints requests.

	@since 3.17.0
**/
typedef InlayHintParams = WorkDoneProgressParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The document range for which inlay hints should be computed.
	**/
	var range:Range;
};

/**
	A request to provide inlay hints in a document. The request's parameter is of
	type [InlayHintsParams](#InlayHintsParams), the response is of type
	[InlayHint[]](#InlayHint[]) or a Thenable that resolves to such.

	@since 3.17.0
**/
class InlayHintRequest {
	public static inline final type = new ProtocolRequestType<InlayHintParams, Null<Array<InlayHint>>, Array<InlayHint>, NoData,
		InlayHintRegistrationOptions>("textDocument/inlayHint");
}

class HaxeInlayHintRequest {
	public static inline final type = new ProtocolRequestType<InlayHintParams, Null<Array<InlayHint>>, Array<InlayHint>, NoData,
		InlayHintRegistrationOptions>("haxe/inlayHints");
}

/**
	A request to resolve additional properties for a inlay hint.
	The request's parameter is of type [InlayHint](#InlayHint), the response is
	of type [InlayHint](#InlayHint) or a Thenable that resolves to such.

	@since 3.17.0
**/
class InlayHintResolveRequest {
	public static inline final type = new ProtocolRequestType<InlayHint, InlayHint, Never, NoData, NoData>("inlayHint/resolve");
}

/**
	@since 3.17.0
**/
class InlayHintRefreshRequest {
	public static inline final type = new ProtocolRequestType<NoData, NoData, NoData, NoData, NoData>("workspace/inlayHint/refresh");
}
