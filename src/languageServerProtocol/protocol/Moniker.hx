package languageServerProtocol.protocol;

import languageServerProtocol.protocol.Protocol;

/**
	Moniker uniqueness level to define scope of the moniker.

	@since 3.16.0
**/
enum abstract UniquenessLevel(String) {
	/**
		The moniker is only unique inside a document
	**/
	var Document = 'document';

	/**
		The moniker is unique inside a project for which a dump got created
	**/
	var Project = 'project';

	/**
		The moniker is unique inside the group to which a project belongs
	**/
	var Group = 'group';

	/**
		The moniker is unique inside the moniker scheme.
	**/
	var Scheme = 'scheme';

	/**
		The moniker is globally unique
	**/
	var Global = 'global';
}

/**
	The moniker kind.

	@since 3.16.0
**/
enum abstract MonikerKind(String) {
	/**
		The moniker represent a symbol that is imported into a project
	**/
	var Import = 'import';

	/**
		The moniker represents a symbol that is exported from a project
	**/
	var Export = 'export';

	/**
		The moniker represents a symbol that is local to a project (e.g. a local
		variable of a function, a class not visible outside the project, ...)
	**/
	var Local = 'local';
}

/**
	Moniker definition to match LSIF 0.5 moniker definition.

	@since 3.16.0
**/
typedef Moniker = {
	/**
		The scheme of the moniker. For example tsc or .Net
	**/
	var scheme:String;

	/**
		The identifier of the moniker. The value is opaque in LSIF however
		schema owners are allowed to define the structure if they want.
	**/
	var identifier:String;

	/**
		The scope in which the moniker is unique
	**/
	var unique:UniquenessLevel;

	/**
		The moniker kind if known.
	**/
	var ?kind:MonikerKind;
}

/**
	Client capabilities specific to the moniker request.

	@since 3.16.0
**/
typedef MonikerClientCapabilities = {
	/**
		Whether moniker supports dynamic registration. If this is set to `true`
		the client supports the new `MonikerRegistrationOptions` return value
		for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;
}

typedef MonikerServerCapabilities = {};
typedef MonikerOptions = WorkDoneProgressOptions;
typedef MonikerRegistrationOptions = TextDocumentRegistrationOptions & MonikerOptions;
typedef MonikerParams = TextDocumentPositionParams & WorkDoneProgressParams & PartialResultParams;

/**
	A request to get the moniker of a symbol at a given text document position.
	The request parameter is of type [TextDocumentPositionParams](#TextDocumentPositionParams).
	The response is of type [Moniker[]](#Moniker[]) or `null`.
**/
class MonikerRequest {
	public static inline final type = new ProtocolRequestType<MonikerParams, Null<Array<Moniker>>, Array<Moniker>, NoData,
		MonikerRegistrationOptions>("textDocument/moniker");
}
