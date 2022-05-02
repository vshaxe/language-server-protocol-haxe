package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	@since 3.16.0
**/
typedef CallHierarchyClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is set to `true`
		the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;
}

/**
	Call hierarchy options used during static registration.

	@since 3.16.0
**/
typedef CallHierarchyOptions = WorkDoneProgressOptions;

/**
	Call hierarchy options used during static or dynamic registration.

	@since 3.16.0
**/
typedef CallHierarchyRegistrationOptions = TextDocumentRegistrationOptions & CallHierarchyOptions & StaticRegistrationOptions;

/**
	The parameter of a `textDocument/prepareCallHierarchy` request.

	@since 3.16.0
**/
typedef CallHierarchyPrepareParams = TextDocumentPositionParams & WorkDoneProgressParams;

/**
	A request to result a `CallHierarchyItem` in a document at a given position.
	Can be used as an input to a incoming or outgoing call hierarchy.

	@since 3.16.0
**/
class CallHierarchyPrepareRequest {
	public static inline final type = new ProtocolRequestType<CallHierarchyPrepareParams, Null<Array<CallHierarchyItem>>, Never, NoData,
		CallHierarchyRegistrationOptions>("textDocument/prepareCallHierarchy");
}

/**
	The parameter of a `callHierarchy/incomingCalls` request.

	@since 3.16.0
**/
typedef CallHierarchyIncomingCallsParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:CallHierarchyItem;
}

/**
	A request to resolve the incoming calls for a given `CallHierarchyItem`.

	@since 3.16.0
**/
class CallHierarchyIncomingCallsRequest {
	public static inline final type = new ProtocolRequestType<CallHierarchyIncomingCallsParams, Null<Array<CallHierarchyIncomingCall>>,
		Array<CallHierarchyIncomingCall>, NoData, NoData>("callHierarchy/incomingCalls");
}

/**
	The parameter of a `callHierarchy/outgoingCalls` request.

	@since 3.16.0
**/
typedef CallHierarchyOutgoingCallsParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:CallHierarchyItem;
}

/**
	A request to resolve the outgoing calls for a given `CallHierarchyItem`.

	@since 3.16.0
**/
class CallHierarchyOutgoingCallsRequest {
	public static inline final type = new ProtocolRequestType<CallHierarchyOutgoingCallsParams, Null<Array<CallHierarchyOutgoingCall>>,
		Array<CallHierarchyOutgoingCall>, NoData, NoData>("callHierarchy/outgoingCalls");
}
