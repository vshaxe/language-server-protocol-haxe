package languageServerProtocol.protocol;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

typedef ColorClientCapabilities = {
	/**
		Capabilities specific to the colorProvider
	**/
	var ?colorProvider:{
		/**
			Whether implementation supports dynamic registration. If this is set to `true`
			the client supports the new `(ColorRegistrationOptions & StaticRegistrationOptions)`
			return value for the corresponding server capability as well.
		**/
		var ?dynamicRegistration:Bool;
	};
}

typedef ColorOptions = {}
typedef ColorRegistrationOptions = TextDocumentRegistrationOptions & ColorOptions;

typedef ColorServerCapabilities = {
	/**
		The server provides color provider support.
	**/
	var ?colorProvider:EitherType<ColorOptions, ColorRegistrationOptions & StaticRegistrationOptions>;
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
	A request to list all color symbols found in a given text document. The request's
	parameter is of type [DocumentColorParams](#DocumentColorParams) the
	response is of type [ColorInformation[]](#ColorInformation) or a Thenable
	that resolves to such.
**/
class DocumentColorRequest {
	public static inline var type = new RequestType<DocumentColorParams, Array<ColorInformation>, NoData,
		ColorRegistrationOptions>("textDocument/documentColor");

	public static final resultType = new ProgressType<Array<ColorInformation>>();
}

/**
	Parameters for a `ColorPresentation` request.
**/
typedef ColorPresentationParams = WorkDoneProgressParams &
	PartialResultParams & {
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

/**
	A request to list all presentation for a color. The request's
	parameter is of type [ColorPresentationParams](#ColorPresentationParams) the
	response is of type [ColorInformation[]](#ColorInformation) or a Thenable
	that resolves to such.
**/
class ColorPresentationRequest {
	public static inline var type = new RequestType<ColorPresentationParams, Array<ColorPresentation>, NoData, WorkDoneProgressOptions &
		TextDocumentRegistrationOptions>("textDocument/colorPresentation");
}
