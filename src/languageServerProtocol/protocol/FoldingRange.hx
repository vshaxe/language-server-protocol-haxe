package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;
import jsonrpc.Types;

@:publicFields
class FoldingRangeMethods {
	/**
		A request to provide folding ranges in a document. The request's
		parameter is of type [FoldingRangeParams](#FoldingRangeParams), the
		response is of type [FoldingRangeList](#FoldingRangeList) or a Thenable
		that resolves to such.
	**/
	static inline var FoldingRange = new RequestMethod<FoldingRangeParams, Null<Array<FoldingRange>>, NoData, NoData>("textDocument/foldingRange");
}

typedef FoldingRangeClientCapabilities = {
	/**
		Capabilities specific to `textDocument/foldingRange` requests
	**/
	var ?foldingRange:{
		/**
			Whether implementation supports dynamic registration for folding range providers. If this is set to `true`
			the client supports the new `(FoldingRangeProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
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
	};
}

typedef FoldingRangeProviderOptions = {}

typedef FoldingRangeServerCapabilities = {
	/**
		The server provides folding provider support.
	**/
	var ?foldingRangeProvider:EitherType<Bool,
		EitherType<FoldingRangeProviderOptions, FoldingRangeProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions>>;
}

/**
	Parameters for a [FoldingRangeRequest](#FoldingRangeRequest).
**/
typedef FoldingRangeParams = {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;
}
