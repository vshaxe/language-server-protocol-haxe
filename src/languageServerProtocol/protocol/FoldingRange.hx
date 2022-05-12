package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

// ---- capabilities

typedef FoldingRangeClientCapabilities = {
	/**
		Whether implementation supports dynamic registration for folding range providers. If this is set to `true`
		the client supports the new `FoldingRangeRegistrationOptions` return value for the corresponding server
		capability as well.
	**/
	var ?dynamicRegistration:Bool;

	/**
		The maximum number of folding ranges that the client prefers to receive per document. The value serves as a
		hint, servers are free to follow the limit.
	**/
	var ?rangeLimit:Int;

	/**
		If set, the client signals that it only supports folding complete lines. If set, client will
		ignore specified `startCharacter` and `endCharacter` properties in a FoldingRange.
	**/
	var ?lineFoldingOnly:Bool;

	/**
		Specific options for the folding range kind.

		@since 3.17.0
	**/
	var ?foldingRangeKind:{
		/**
			The folding range kind values the client supports. When this
			property exists the client also guarantees that it will
			handle values outside its set gracefully and falls back
			to a default value when unknown.
		**/
		var ?valueSet:Array<FoldingRangeKind>;
	};

	/**
		Specific options for the folding range.
		@since 3.17.0
	**/
	var ?foldingRange:{
		/**
			If set, the client signals that it supports setting collapsedText on
			folding ranges to display custom labels instead of the default text.

			@since 3.17.0
		**/
		var ?collapsedText:Bool;
	};
}

typedef FoldingRangeOptions = WorkDoneProgressOptions & {};
typedef FoldingRangeRegistrationOptions = TextDocumentRegistrationOptions & FoldingRangeOptions & StaticRegistrationOptions;

/**
	Parameters for a [FoldingRangeRequest](#FoldingRangeRequest).
**/
typedef FoldingRangeParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;
}

/**
	A request to provide folding ranges in a document. The request's
	parameter is of type [FoldingRangeParams](#FoldingRangeParams), the
	response is of type [FoldingRangeList](#FoldingRangeList) or a Thenable
	that resolves to such.
**/
class FoldingRangeRequest {
	public static inline final type = new ProtocolRequestType<FoldingRangeParams, Null<Array<FoldingRange>>, Array<FoldingRange>, NoData,
		FoldingRangeRegistrationOptions>("textDocument/foldingRange");
}
