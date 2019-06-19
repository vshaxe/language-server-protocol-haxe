package languageServerProtocol.protocol.proposed;

import haxe.extern.EitherType;
import jsonrpc.Types;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

@:publicFields
class SelectionRangeMethods {
	/**
		A request to provide selection ranges in a document. The request's
		parameter is of type [SelectionRangeParams](#SelectionRangeParams), the
		response is of type [SelectionRange[]](#SelectionRange[]) or a Thenable
		that resolves to such.
	**/
	static inline var SelectionRange = new RequestMethod<SelectionRangeParams, Null<Array<SelectionRange>>, NoData, NoData>("textDocument/selectionRange");
}

typedef SelectionRangeClientCapabilities = {
	/**
		Capabilities specific to `textDocument/selectionRange` requests
	**/
	var ?selectionRange:{
		/**
			Whether implementation supports dynamic registration for selection range providers. If this is set to `true`
			the client supports the new `(SelectionRangeProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;
	};
}

typedef SelectionRangeProviderOptions = {}

typedef SelectionRangeServerCapabilities = {
	/**
		The server provides selection range support.
	**/
	var ?selectionRangeProvider:EitherType<Bool, TextDocumentRegistrationOptions & StaticRegistrationOptions & SelectionRangeProviderOptions>;
}

/**
	A parameter literal used in selection range requests.
**/
typedef SelectionRangeParams = {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The positions inside the text document.
	**/
	var positions:Array<Position>;
}
