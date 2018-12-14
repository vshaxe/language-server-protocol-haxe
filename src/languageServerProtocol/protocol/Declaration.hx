package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;
import jsonrpc.Types;

@:publicFields
class DeclarationMethods {
	/**
		A request to resolve the type definition locations of a symbol at a given text document position.
	**/
	static inline var Declaration = new RequestMethod<TextDocumentPositionParams, Null<EitherType<Declaration, Array<Declaration>>>, NoData,
		TextDocumentRegistrationOptions>("textDocument/declaration");
}

typedef DeclarationClientCapabilities = {
	/**
	 * Capabilities specific to the `textDocument/declaration`
	 */
	var ?declaration:{
		/**
			 Whether declaration supports dynamic registration. If this is set to `true`
			 the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;

		/**
			The client supports additional metadata in the form of declaration links.
		**/
		var ?linkSupport:Bool;
	};
}

typedef DeclarationServerCapabilities = {
	/**
	 * The server provides Goto Type Definition support.
	 */
	var ?declarationProvider:EitherType<Bool, TextDocumentRegistrationOptions & StaticRegistrationOptions>;
}
