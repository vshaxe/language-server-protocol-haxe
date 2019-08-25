package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

typedef TypeDefinitionClientCapabilities = {
	/**
		Capabilities specific to the `textDocument/typeDefinition`
	**/
	var ?typeDefinition:{
		/**
			Whether implementation supports dynamic registration. If this is set to `true`
			the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client supports additional metadata in the form of definition links.
		**/
		var ?linkSupport:Bool;
	};
}

typedef TypeDefinitionOptions = WorkDoneProgressOptions;
typedef TypeDefinitionRegistrationOptions = TextDocumentRegistrationOptions & TypeDefinitionOptions;

typedef TypeDefinitionServerCapabilities = {
	/**
		The server provides Goto Type Definition support.
	**/
	var ?typeDefinitionProvider:EitherType<Bool, EitherType<TypeDefinitionOptions, TypeDefinitionRegistrationOptions & StaticRegistrationOptions>>;
}

typedef TypeDefinitionParams = TextDocumentPositionParams & WorkDoneProgressParams & PartialResultParams;

/**
	A request to resolve the type definition locations of a symbol at a given text
	document position. The request's parameter is of type [TextDocumentPositioParams]
	(#TextDocumentPositionParams) the response is of type [Definition](#Definition) or a
	Thenable that resolves to such.
**/
class TypeDefinitionRequest {
	public static inline var type = new RequestType<TypeDefinitionParams, Null<EitherType<Definition, Array<DefinitionLink>>>, NoData,
		TypeDefinitionRegistrationOptions>("textDocument/typeDefinition");

	public static final resultType = new ProgressType<EitherType<Array<Location>, Array<DefinitionLink>>>();
}
