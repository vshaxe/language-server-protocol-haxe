package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	@since 3.17.0
	@proposed
**/
typedef TypeHierarchyClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is set to `true`
		the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;
};

/**
	Type hierarchy options used during static registration.

	@since 3.17.0
	@proposed
**/
typedef TypeHierarchyOptions = WorkDoneProgressOptions;

/**
	Type hierarchy options used during static or dynamic registration.

	@since 3.17.0
	@proposed
**/
typedef TypeHierarchyRegistrationOptions = TextDocumentRegistrationOptions & TypeHierarchyOptions & StaticRegistrationOptions;

/**
	The parameter of a `textDocument/prepareTypeHierarchy` request.

	@since 3.17.0
	@proposed
**/
typedef TypeHierarchyPrepareParams = TextDocumentPositionParams & WorkDoneProgressParams;

/**
	A request to result a `TypeHierarchyItem` in a document at a given position.
	Can be used as an input to a subtypes or supertypes type hierarchy.

	@since 3.17.0
	@proposed
**/
class TypeHierarchyPrepareRequest {
	public static inline final type = new ProtocolRequestType<TypeHierarchyPrepareParams, Null<Array<TypeHierarchyItem>>, Never, NoData,
		TypeHierarchyRegistrationOptions>("textDocument/prepareTypeHierarchy");
}

/**
	The parameter of a `typeHierarchy/supertypes` request.

	@since 3.17.0
	@proposed
**/
typedef TypeHierarchySupertypesParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:TypeHierarchyItem;
};

/**
	A request to resolve the supertypes for a given `TypeHierarchyItem`.

	@since 3.17.0
	@proposed
**/
class TypeHierarchySupertypesRequest {
	public static inline final type = new ProtocolRequestType<TypeHierarchySupertypesParams, Null<Array<TypeHierarchyItem>>, Array<TypeHierarchyItem>, NoData,
		NoData>("typeHierarchy/supertypes");
}

/**
	The parameter of a `typeHierarchy/subtypes` request.

	@since 3.17.0
	@proposed
**/
typedef TypeHierarchySubtypesParams = WorkDoneProgressParams &
	PartialResultParams & {
	var item:TypeHierarchyItem;
};

/**
	A request to resolve the subtypes for a given `TypeHierarchyItem`.

	@since 3.17.0
	@proposed
**/
class TypeHierarchySubtypesRequest {
	public static inline final type = new ProtocolRequestType<TypeHierarchySubtypesParams, Null<Array<TypeHierarchyItem>>, Array<TypeHierarchyItem>, NoData,
		NoData>("typeHierarchy/subtypes");
}
