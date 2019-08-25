package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

typedef CallHierarchyClientCapabilities = {
	/**
		Capabilities specific to the `textDocument/callHierarchy`
	**/
	var ?callHierarchy:{
		/**
			Whether implementation supports dynamic registration. If this is set to `true`
			the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;
	};
}

typedef CallHierarchyOptions = WorkDoneProgressOptions;
typedef CallHierarchyRegistrationOptions = TextDocumentRegistrationOptions & CallHierarchyOptions;

typedef CallHierarchyServerCapabilities = {
	/**
		The server provides Call Hierarchy support.
	**/
	var ?callHierarchyProvider:EitherType<Bool, EitherType<CallHierarchyOptions, CallHierarchyRegistrationOptions & StaticRegistrationOptions>>;
}

/**
	The parameter of a `textDocument/callHierarchy` request extends the `TextDocumentPositionParams` with the direction of calls to resolve.
**/
typedef CallHierarchyParams = TextDocumentPositionParams &
	WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The direction of calls to provide.
	**/
	var direction:CallHierarchyDirection;
}

/**
	The direction of a call hierarchy request.
**/
enum abstract CallHierarchyDirection(Int) {
	/**
		The callers
	**/
	var CallsFrom = 1;

	/**
		The callees
	**/
	var CallsTo = 2;
}

typedef CallHierarchyItem = {
	/**
		The name of the symbol targeted by the call hierarchy request.
	**/
	var name:String;

	/**
		More detail for this symbol, e.g the signature of a function.
	**/
	var ?detail:String;

	/**
		The kind of this symbol.
	**/
	var kind:SymbolKind;

	/**
		URI of the document containing the symbol.
	**/
	var uri:String;

	/**
		The range enclosing this symbol not including leading/trailing whitespace but everything else
		like comments. This information is typically used to determine if the the clients cursor is
		inside the symbol to reveal in the symbol in the UI.
	**/
	var range:Range;

	/**
		The range that should be selected and revealed when this symbol is being picked, e.g the name of a function.
		Must be contained by the the `range`.
	**/
	var selectionRange:Range;
}

/**
	The result of a `textDocument/callHierarchy` request.
**/
typedef CallHierarchyCall = {
	/**
		The source range of the reference. The range is a sub range of the `from` symbol range.
	**/
	var range:Range;

	/**
		The symbol that contains the reference.
	**/
	var from:CallHierarchyItem;

	/**
		The symbol that is referenced.
	**/
	var to:CallHierarchyItem;
}

/**
	Request to provide the call hierarchy at a given text document position.

	The request's parameter is of type [CallHierarchyParams](#CallHierarchyParams). The response
	is of type [CallHierarchyCall[]](#CallHierarchyCall) or a Thenable that resolves to such.

	Evaluates the symbol defined (or referenced) at the given position, and returns all incoming or outgoing calls to the symbol(s).
**/
class CallHierarchyRequest {
	public static inline var CallHierarchy = new RequestType<CallHierarchyParams, Array<CallHierarchyCall>, NoData,
		CallHierarchyRegistrationOptions>("textDocument/callHierarchy");

	public static final CallHierarchyResult = new ProgressType<Array<CallHierarchyCall>>();
}
