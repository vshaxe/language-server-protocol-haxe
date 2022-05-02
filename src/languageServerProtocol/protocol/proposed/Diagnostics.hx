package languageServerProtocol.protocol.proposed;

import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;

/**
	Client capabilities specific to diagnostic pull requests.

	@since 3.17.0
	@proposed
**/
typedef DiagnosticClientCapabilities = {
	/**
		Whether implementation supports dynamic registration. If this is set to `true`
		the client supports the new `(TextDocumentRegistrationOptions & StaticRegistrationOptions)`
		return value for the corresponding server capability as well.
	**/
	var ?dynamicRegistration:Bool;

	/**
		Whether the clients supports related documents for document diagnostic pulls.
	**/
	var ?relatedDocumentSupport:Bool;
};

/**
	Workspace client capabilities specific to diagnostic pull requests.

	@since 3.17.0
	@proposed
**/
typedef DiagnosticWorkspaceClientCapabilities = {
	/**
		Whether the client implementation supports a refresh request sent from
		the server to the client.

		Note that this event is global and will force the client to refresh all
		pulled diagnostics currently shown. It should be used with absolute care and
		is useful for situation where a server for example detects a project wide
		change that requires such a calculation.
	**/
	var ?refreshSupport:Bool;
};

/**
	Diagnostic options.

	@since 3.17.0
	@proposed
**/
typedef DiagnosticOptions = WorkDoneProgressOptions & {
	/**
		An optional identifier under which the diagnostics are
		managed by the client.
	**/
	var ?identifier:String;

	/**
		Whether the language has inter file dependencies meaning that
		editing code in one file can result in a different diagnostic
		set in another file. Inter file dependencies are common for
		most programming languages and typically uncommon for linters.
	**/
	var interFileDependencies:Bool;

	/**
		The server provides support for workspace diagnostics as well.
	**/
	var workspaceDiagnostics:Bool;
};

/**
	Diagnostic registration options.

	@since 3.17.0
	@proposed
**/
typedef DiagnosticRegistrationOptions = TextDocumentRegistrationOptions & DiagnosticOptions & StaticRegistrationOptions;

typedef DiagnosticServerCapabilities = {
	var ?diagnosticProvider:DiagnosticOptions;
};

/**
	Cancellation data returned from a diagnostic request.

	@since 3.17.0
	@proposed
**/
typedef DiagnosticServerCancellationData = {
	var retriggerRequest:Bool;
};

/**
	Parameters of the document diagnostic request.

	@since 3.17.0
	@proposed
**/
typedef DocumentDiagnosticParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The text document.
	**/
	var textDocument:TextDocumentIdentifier;

	/**
		The additional identifier  provided during registration.
	**/
	var ?identifier:String;

	/**
		The result id of a previous response if provided.
	**/
	var ?previousResultId:String;
};

/**
	The document diagnostic report kinds.

	@since 3.17.0
	@proposed
**/
enum abstract DocumentDiagnosticReportFullKind(String) {
	/**
		A diagnostic report with a full
		set of problems.
	**/
	var Full = 'full';
}

/**
	The document diagnostic report kinds.

	@since 3.17.0
	@proposed
**/
enum abstract DocumentDiagnosticReportUnchangedKind(String) {
	/**
		A report indicating that the last
		returned report is still accurate.
	**/
	var Unchanged = 'unchanged';
}

/**
	A diagnostic report with a full set of problems.

	@since 3.17.0
	@proposed
**/
typedef FullDocumentDiagnosticReport = {
	/**
		A full document diagnostic report.
	**/
	var kind:DocumentDiagnosticReportFullKind;

	/**
		An optional result id. If provided it will
		be sent on the next diagnostic request for the
		same document.
	**/
	var ?resultId:String;

	/**
		The actual items.
	**/
	var items:Array<Diagnostic>;
};

/**
	A full diagnostic report with a set of related documents.

	@since 3.17.0
	@proposed
**/
typedef RelatedFullDocumentDiagnosticReport = FullDocumentDiagnosticReport & {
	/**
		Diagnostics of related documents. This information is useful
		in programming languages where code in a file A can generate
		diagnostics in a file B which A depends on. An example of
		such a language is C/C++ where marco definitions in a file
		a.cpp and result in errors in a header file b.hpp.

		@since 3.17.0
		@proposed
	**/
	var ?relatedDocuments:haxe.DynamicAccess<EitherType<FullDocumentDiagnosticReport, UnchangedDocumentDiagnosticReport>>;
};

/**
	A diagnostic report indicating that the last returned
	report is still accurate.

	@since 3.17.0
	@proposed
**/
typedef UnchangedDocumentDiagnosticReport = {
	/**
		A document diagnostic report indicating
		no changes to the last result. A server can
		only return `unchanged` if result ids are
		provided.
	**/
	var kind:DocumentDiagnosticReportUnchangedKind;

	/**
		A result id which will be sent on the next
		diagnostic request for the same document.
	**/
	var resultId:String;
};

/**
	An unchanged diagnostic report with a set of related documents.

	@since 3.17.0
	@proposed
**/
typedef RelatedUnchangedDocumentDiagnosticReport = UnchangedDocumentDiagnosticReport & {
	/**
		Diagnostics of related documents. This information is useful
		in programming languages where code in a file A can generate
		diagnostics in a file B which A depends on. An example of
		such a language is C/C++ where marco definitions in a file
		a.cpp and result in errors in a header file b.hpp.

		@since 3.17.0
		@proposed
	**/
	var ?relatedDocuments:haxe.DynamicAccess<EitherType<FullDocumentDiagnosticReport, UnchangedDocumentDiagnosticReport>>;
};

/**
	The result of a document diagnostic pull request. A report can
	either be a full report containing all diagnostics for the
	requested document or a unchanged report indicating that nothing
	has changed in terms of diagnostics in comparison to the last
	pull request.

	@since 3.17.0
	@proposed
**/
typedef DocumentDiagnosticReport = EitherType<RelatedFullDocumentDiagnosticReport, RelatedUnchangedDocumentDiagnosticReport>;

/**
	A partial result for a document diagnostic report.

	@since 3.17.0
	@proposed
**/
typedef DocumentDiagnosticReportPartialResult = {
	var relatedDocuments:haxe.DynamicAccess<EitherType<FullDocumentDiagnosticReport, UnchangedDocumentDiagnosticReport>>;
};

/**
	The document diagnostic request definition.

	@since 3.17.0
	@proposed
**/
class DocumentDiagnosticRequest {
	public static inline final type = new ProtocolRequestType<DocumentDiagnosticParams, DocumentDiagnosticReport, DocumentDiagnosticReportPartialResult,
		DiagnosticServerCancellationData, DiagnosticRegistrationOptions>("textDocument/diagnostic");
}

/**
	A previous result id in a workspace pull request.

	@since 3.17.0
	@proposed
**/
typedef PreviousResultId = {
	/**
		The URI for which the client knowns a
		result id.
	**/
	var uri:DocumentUri;

	/**
		The value of the previous result id.
	**/
	var value:String;
};

/**
	Parameters of the workspace diagnostic request.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceDiagnosticParams = WorkDoneProgressParams &
	PartialResultParams & {
	/**
		The additional identifier provided during registration.
	**/
	var ?identifier:String;

	/**
		The currently known diagnostic reports with their
		previous result ids.
	**/
	var previousResultIds:Array<PreviousResultId>;
};

/**
	A full document diagnostic report for a workspace diagnostic result.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceFullDocumentDiagnosticReport = FullDocumentDiagnosticReport & {
	/**
		The URI for which diagnostic information is reported.
	**/
	var uri:DocumentUri;

	/**
		The version number for which the diagnostics are reported.
		If the document is not marked as open `null` can be provided.
	**/
	var version:Null<Int>;
};

/**
	An unchanged document diagnostic report for a workspace diagnostic result.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceUnchangedDocumentDiagnosticReport = UnchangedDocumentDiagnosticReport & {
	/**
		The URI for which diagnostic information is reported.
	**/
	var uri:DocumentUri;

	/**
		The version number for which the diagnostics are reported.
		If the document is not marked as open `null` can be provided.
	**/
	var version:Null<Int>;
};

/**
	A workspace diagnostic document report.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceDocumentDiagnosticReport = EitherType<WorkspaceFullDocumentDiagnosticReport, WorkspaceUnchangedDocumentDiagnosticReport>;

/**
	A workspace diagnostic report.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceDiagnosticReport = {
	var items:Array<WorkspaceDocumentDiagnosticReport>;
};

/**
	A partial result for a workspace diagnostic report.

	@since 3.17.0
	@proposed
**/
typedef WorkspaceDiagnosticReportPartialResult = {
	var items:Array<WorkspaceDocumentDiagnosticReport>;
};

/**
	The workspace diagnostic request definition.

	@since 3.17.0
	@proposed
**/
class WorkspaceDiagnosticRequest {
	public static inline final type = new ProtocolRequestType<WorkspaceDiagnosticParams, WorkspaceDiagnosticReport, WorkspaceDiagnosticReportPartialResult,
		DiagnosticServerCancellationData, NoData>("workspace/diagnostic");
}

/**
	The diagnostic refresh request definition.

	@since 3.17.0
	@proposed
**/
class DiagnosticRefreshRequest {
	public static inline final type = new ProtocolRequestType<NoData, NoData, NoData, NoData, NoData>("workspace/diagnostic/refresh");
}
