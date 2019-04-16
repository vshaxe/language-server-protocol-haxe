package languageServerProtocol.protocol.proposed;

import jsonrpc.Types;
import languageServerProtocol.protocol.Protocol;

@:publicFields
class ProgressMethods {
	/**
		The `window/progress/start` notification is sent from the server to the client
		to initiate a progress.
	**/
	static inline var ProgressStart = new NotificationMethod<ProgressStartParams, NoData>("window/progress/start");

	/**
		The `window/progress/report` notification is sent from the server to the client
		to initiate a progress.
	**/
	static inline var ProgressReport = new NotificationMethod<ProgressReportParams, NoData>("window/progress/report");

	/**
		The `window/progress/done` notification is sent from the server to the client
		to initiate a progress.
	**/
	static inline var ProgressDone = new NotificationMethod<ProgressDoneParams, NoData>("window/progress/done");

	/**
		The `window/progress/cancel` notification is sent client to the server to cancel a progress
		initiated on the server side.
	**/
	static inline var ProgressCancel = new NotificationMethod<ProgressDoneParams, NoData>("window/progress/cancel");
}

typedef ProgressClientCapabilities = {
	/**
		Window specific client capabilities.
	**/
	var ?window:{
		/**
			Whether client supports handling progress notifications.
		**/
		var ?progress:Bool;
	}
}

typedef ProgressStartParams = {
	/**
		A unique identifier to associate multiple progress notifications with
		the same progress.
	**/
	var id:String;

	/**
		Mandatory title of the progress operation. Used to briefly inform about
		the kind of operation being performed.

		Examples: "Indexing" or "Linking dependencies".
	**/
	var title:String;

	/**
		Controls if a cancel button should show to allow the user to cancel the
		long running operation. Clients that don't support cancellation are allowed
		to ignore the setting.
	**/
	var ?cancellable:Bool;

	/**
		Optional, more detailed associated progress message. Contains
		complementary information to the `title`.

		Examples: "3/25 files", "project/src/module2", "node_modules/some_dep".
		If unset, the previous progress message (if any) is still valid.
	**/
	var ?message:String;

	/**
		Optional progress percentage to display (value 100 is considered 100%).
		If not provided infinite progress is assumed and clients are allowed
		to ignore the `percentage` value in subsequent in report notifications.

		The value should be steadily rising. Clients are free to ignore values
		that are not following this rule.
	**/
	var ?percentage:Float;
}

typedef ProgressReportParams = {
	/**
		A unique identifier to associate multiple progress notifications with the same progress.
	**/
	var id:String;

	/**
		Optional, more detailed associated progress message. Contains
		complementary information to the `title`.

		Examples: "3/25 files", "project/src/module2", "node_modules/some_dep".
		If unset, the previous progress message (if any) is still valid.
	**/
	var ?message:String;

	/**
		Optional progress percentage to display (value 100 is considered 100%).
		If not provided infinite progress is assumed and clients are allowed
		to ignore the `percentage` value in subsequent in report notifications.

		The value should be steadily rising. Clients are free to ignore values
		that are not following this rule.
	**/
	var ?percentage:Float;
}

typedef ProgressDoneParams = {
	/**
		A unique identifier to associate multiple progress notifications with the same progress.
	**/
	var id:String;
}

typedef ProgressCancelParams = {
	/**
		A unique identifier to associate multiple progress notifications with the same progress.
	**/
	var id:String;
}
