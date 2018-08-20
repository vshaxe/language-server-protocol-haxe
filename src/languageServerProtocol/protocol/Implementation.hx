package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;
import jsonrpc.Types;

@:publicFields
class ImplementationMethods {
	/**
		A request to resolve the implementation locations of a symbol at a given text
		document position.
	**/
	static inline var Implementation = new RequestMethod<TextDocumentPositionParams, Null<Definition>, NoData, TextDocumentRegistrationOptions>
		("textDocument/implementation");
}

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
	};
}

typedef ImplementationServerCapabilities = {
	/**
		The server provides Goto Implementation support.
	**/
	var ?implementationProvider:EitherType<Bool, TextDocumentRegistrationOptions & StaticRegistrationOptions>;
}
