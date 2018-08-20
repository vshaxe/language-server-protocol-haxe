package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;
import jsonrpc.Types;

@:publicFields
class ColorProviderMethods {
	/**
		A request to list all color symbols found in a given text document.
	**/
	static inline var DocumentColor = new RequestMethod<DocumentColorParams, Array<ColorInformation>, NoData, TextDocumentRegistrationOptions>
		("textDocument/documentColor");

	/**
		A request to list all presentation for a color.
	**/
	static inline var ColorPresentation = new RequestMethod<ColorPresentationParams, Array<ColorPresentation>, NoData, TextDocumentRegistrationOptions>
		("textDocument/colorPresentation");
}

typedef ColorClientCapabilities = {
	/**
		Capabilities specific to the colorProvider
	**/
	var ?colorProvider:{
		/**
			Whether implementation supports dynamic registration. If this is set to `true`
			the client supports the new `(ColorProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;
	};
}

typedef ColorProviderOptions = {}

typedef ColorServerCapabilities = {
	/**
		The server provides color provider support.
	**/
	var ?colorProvider:EitherType<ColorProviderOptions, ColorProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions>;
}

/**
	Parameters for a `DocumentColor` request.
**/
typedef DocumentColorParams = {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;
}

/**
 * Parameters for a `ColorPresentation` request.
 */
typedef ColorPresentationParams = {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The color to request presentations for.
	**/
	var color:Color;

	/**
		The range where the color would be inserted. Serves as a context.
	**/
	var range:Range;
}
