package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	Client capabilities for the linked editing range request.

	@since 3.16.0
**/
typedef LinkedEditingRangeClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is set to `true`
		the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;
}

typedef LinkedEditingRangeParams = TextDocumentPositionParams & WorkDoneProgressParams;
typedef LinkedEditingRangeOptions = WorkDoneProgressOptions;
typedef LinkedEditingRangeRegistrationOptions = TextDocumentRegistrationOptions & LinkedEditingRangeOptions & StaticRegistrationOptions;

/**
	The result of a linked editing range request.

	@since 3.16.0
**/
typedef LinkedEditingRanges = {
	/**
		A list of ranges that can be edited together. The ranges must have
		identical length and contain identical text content. The ranges cannot overlap.
	**/
	var ranges:Array<Range>;

	/**
		An optional word pattern (regular expression) that describes valid contents for
		the given ranges. If no pattern is provided, the client configuration's word
		pattern will be used.
	**/
	var ?wordPattern:String;
}

/**
	A request to provide ranges that can be edited together.

	@since 3.16.0
**/
class LinkedEditingRangeRequest {
	public static inline final type = new ProtocolRequestType<LinkedEditingRangeParams, Null<LinkedEditingRanges>, NoData, NoData,
		LinkedEditingRangeRegistrationOptions>("textDocument/linkedEditingRange");
}
