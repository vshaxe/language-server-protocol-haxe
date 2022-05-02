package languageServerProtocol.protocol;

import languageServerProtocol.Types;

/**
	Client capabilities for the show document request.

	@since 3.16.0
**/
typedef ShowDocumentClientCapabilities = {
	/**
		The client has support for the show document
		request.
	**/
	var support:Bool;
}

/**
	Params to show a document.

	@since 3.16.0
**/
typedef ShowDocumentParams = {
	/**
		The document uri to show.
	**/
	var uri:URI;

	/**
		Indicates to show the resource in an external program.
		To show for example `https://code.visualstudio.com/`
		in the default WEB browser set `external` to `true`.
	**/
	var ?external:Bool;

	/**
		An optional property to indicate whether the editor
		showing the document should take focus or not.
		Clients might ignore this property if an external
		program in started.
	**/
	var ?takeFocus:Bool;

	/**
		An optional selection range if the document is a text
		document. Clients might ignore the property if an
		external program is started or the file is not a text
		file.
	**/
	var ?selection:Range;
}

/**
	The result of an show document request.

	@since 3.16.0
**/
typedef ShowDocumentResult = {
	/**
		A boolean indicating if the show was successful.
	**/
	var success:Bool;
}

/**
	A request to show a document. This request might open an
	external program depending on the value of the URI to open.
	For example a request to open `https://code.visualstudio.com/`
	will very likely open the URI in a WEB browser.

	@since 3.16.0
**/
class ShowDocumentRequest {
	public static inline final type = new ProtocolRequestType<ShowDocumentParams, ShowDocumentResult, NoData, NoData, NoData>("window/showDocument");
}
