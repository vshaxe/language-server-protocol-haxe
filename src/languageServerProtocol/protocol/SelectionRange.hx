package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import jsonrpc.Types;
import languageServerProtocol.Types.Range;
import languageServerProtocol.protocol.Protocol;

@:publicFields
class SelectionRangeMethods {
	/**
		A request to provide selection ranges in a document. The request's
		parameter is of type [TextDocumentPositionParams](#TextDocumentPositionParams), the
		response is of type [SelectionRange[]](#SelectionRange[]) or a Thenable
		that resolves to such.
	**/
	static inline var SelectionRange = new RequestMethod<TextDocumentPositionParams, Null<Array<SelectionRange>>, NoData, NoData>
		("textDocument/selectionRange");
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
	var ?selectionRangeProvider:EitherType<Bool,
		EitherType<SelectionRangeProviderOptions, SelectionRangeProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions>>;
}

/**
	Enum of known selection range kinds
**/
enum abstract SelectionRangeKind(String) {
	/**
		Empty Kind.
	**/
	var Empty = "";

	/**
		The statment kind, its value is `statement`, possible extensions can be
		`statement.if` etc
	**/
	var Statement = "statement";

	/**
		The declaration kind, its value is `declaration`, possible extensions can be
		`declaration.function`, `declaration.class` etc.
	**/
	var Declaration = "declaration";
}

/**
	Represents a selection range
**/
typedef SelectionRange = {
	/**
		Range of the selection.
	**/
	var range:Range;

	/**
		Describes the kind of the selection range such as `statemet' or 'declaration'. See
		[SelectionRangeKind](#SelectionRangeKind) for an enumeration of standardized kinds.
	**/
	var kind:String;
}
