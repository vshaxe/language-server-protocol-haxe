package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

typedef CallHierarchyItem = {
	/**
		The name of this item.
	**/
	var name:String;

	/**
		The kind of this item.
	**/
	var kind:SymbolKind;

	/**
		Tags for this item.
	**/
	var ?tags:Array<SymbolTag>;

	/**
		More detail for this item, e.g. the signature of a function.
	**/
	var ?detail:String;

	/**
		The resource identifier of this item.
	**/
	var uri:DocumentUri;

	/**
		The range enclosing this symbol not including leading/trailing whitespace but everything else, e.g. comments and code.
	**/
	var range:Range;

	/**
		The range that should be selected and revealed when this symbol is being picked, e.g. the name of a function.
		Must be contained by the [`range`](#CallHierarchyItem.range).
	**/
	var selectionRange:Range;
}

/**
	Represents an incoming call, e.g. a caller of a method or constructor.
**/
typedef CallHierarchyIncomingCall = {
	/**
		The item that makes the call.
	**/
	var from:CallHierarchyItem;

	/**
		The range at which at which the calls appears. This is relative to the caller
		denoted by [`this.from`](#CallHierarchyIncomingCall.from).
	**/
	var fromRanges:Array<Range>;
}

/**
	Represents an outgoing call, e.g. calling a getter from a method or a method from a constructor etc.
**/
typedef CallHierarchyOutgoingCall = {
	/**
		The item that is called.
	**/
	var to:CallHierarchyItem;

	/**
		The range at which this item is called. This is the range relative to the caller, e.g the item
		passed to [`provideCallHierarchyOutgoingCalls`](#CallHierarchyItemProvider.provideCallHierarchyOutgoingCalls)
		and not [`this.to`](#CallHierarchyOutgoingCall.to).
	**/
	var fromRanges:Array<Range>;
}

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
	The parameter of a `textDocument/prepareCallHierarchy` request.
**/
typedef CallHierarchyPrepareParams = TextDocumentPositionParams & WorkDoneProgressParams;

class CallHierarchyPrepareRequest {
	public static inline var type = new RequestType<CallHierarchyPrepareParams, Null<Array<CallHierarchyItem>>, NoData,
		CallHierarchyRegistrationOptions>("textDocument/prepareCallHierarchy");
}

typedef CallHierarchyIncomingCallsParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:CallHierarchyItem;
}

class CallHierarchyIncomingCallsRequest {
	public static inline var type = new RequestType<CallHierarchyIncomingCallsParams, Null<Array<CallHierarchyIncomingCall>>, NoData,
		NoData>("callHierarchy/incomingCalls");

	public static final resultType = new ProgressType<Array<CallHierarchyIncomingCall>>();
}

typedef CallHierarchyOutgoingCallsParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:CallHierarchyItem;
}

class CallHierarchyOutgoingCallsRequest {
	public static inline var type = new RequestType<CallHierarchyOutgoingCallsParams, Null<Array<CallHierarchyOutgoingCall>>, NoData,
		NoData>("callHierarchy/outgoingCalls");

	public static final resultType = new ProgressType<Array<CallHierarchyOutgoingCall>>();
}
