package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

typedef ImplementationClientCapabilities = {
	/**
		Capabilities specific to the `textDocument/implementation`
	**/
	var ?implementation:{
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

typedef ImplementationOptions = WorkDoneProgressOptions;
typedef ImplementationRegistrationOptions = TextDocumentRegistrationOptions & ImplementationOptions;

typedef ImplementationServerCapabilities = {
	/**
		The server provides Goto Implementation support.
	**/
	var ?implementationProvider:EitherType<Bool, EitherType<ImplementationOptions, ImplementationRegistrationOptions & StaticRegistrationOptions>>;
}

typedef ImplementationParams = TextDocumentPositionParams & WorkDoneProgressParams & PartialResultParams;

/**
	A request to resolve the implementation locations of a symbol at a given text
	document position. The request's parameter is of type [TextDocumentPositioParams]
	(#TextDocumentPositionParams) the response is of type [Definition](#Definition) or a
	Thenable that resolves to such.
**/
class ImplementationRequest {
	public static inline var type = new RequestType<ImplementationParams, Null<Definition>, NoData,
		TextDocumentRegistrationOptions>("textDocument/implementation");

	public static final resultType = new ProgressType<EitherType<Array<Location>, Array<DefinitionLink>>>();
}
