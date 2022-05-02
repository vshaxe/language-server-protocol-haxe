package languageServerProtocol.protocol;

import languageServerProtocol.Types;

/**
	Options for notifications/requests for user operations on files.

	@since 3.16.0
**/
typedef FileOperationOptions = {
	/**
		The server is interested in didCreateFiles notifications.
	**/
	var ?didCreate:FileOperationRegistrationOptions;

	/**
		The server is interested in willCreateFiles requests.
	**/
	var ?willCreate:FileOperationRegistrationOptions;

	/**
		The server is interested in didRenameFiles notifications.
	**/
	var ?didRename:FileOperationRegistrationOptions;

	/**
		The server is interested in willRenameFiles requests.
	**/
	var ?willRename:FileOperationRegistrationOptions;

	/**
		The server is interested in didDeleteFiles file notifications.
	**/
	var ?didDelete:FileOperationRegistrationOptions;

	/**
		The server is interested in willDeleteFiles file requests.
	**/
	var ?willDelete:FileOperationRegistrationOptions;
}

/**
	The options to register for file operations.

	@since 3.16.0
**/
typedef FileOperationRegistrationOptions = {
	/**
		The actual filters.
	**/
	var filters:Array<FileOperationFilter>;
}

/**
	A pattern kind describing if a glob pattern matches a file a folder or
	both.

	@since 3.16.0
**/
enum abstract FileOperationPatternKind(String) {
	/**
		The pattern matches a file only.
	**/
	var file = 'file';

	/**
		The pattern matches a folder only.
	**/
	var folder = 'folder';
}

/**
	Matching options for the file operation pattern.

	@since 3.16.0
**/
typedef FileOperationPatternOptions = {
	/**
		The pattern should be matched ignoring casing.
	**/
	var ?ignoreCase:Bool;
}

/**
	A pattern to describe in which file operation requests or notifications
	the server is interested in.

	@since 3.16.0
**/
typedef FileOperationPattern = {
	/**
		The glob pattern to match. Glob patterns can have the following syntax:
		- `*` to match one or more characters in a path segment
		- `?` to match on one character in a path segment
		- `**` to match any number of path segments, including none
		- `{}` to group sub patterns into an OR expression. (e.g. `**​/*.{ts,js}` matches all TypeScript and JavaScript files)
		- `[]` to declare a range of characters to match in a path segment (e.g., `example.[0-9]` to match on `example.0`, `example.1`, …)
		- `[!...]` to negate a range of characters to match in a path segment (e.g., `example.[!0-9]` to match on `example.a`, `example.b`, but not `example.0`)
	**/
	var glob:String;

	/**
		Whether to match files or folders with this pattern.

		Matches both if undefined.
	**/
	var ?matches:FileOperationPatternKind;

	/**
		Additional options used during matching.
	**/
	var ?options:FileOperationPatternOptions;
}

/**
	A filter to describe in which file operation requests or notifications
	the server is interested in.

	@since 3.16.0
**/
typedef FileOperationFilter = {
	/**
		A Uri like `file` or `untitled`.
	**/
	var ?scheme:String;

	/**
		The actual file operation pattern.
	**/
	var pattern:FileOperationPattern;
}

/**
	Capabilities relating to events from file operations by the user in the client.

	These events do not come from the file system, they come from user operations
	like renaming a file in the UI.

	@since 3.16.0
**/
typedef FileOperationClientCapabilities = {
	/**
		Whether the client supports dynamic registration for file requests/notifications.
	**/
	var ?dynamicRegistration:Bool;

	/**
		The client has support for sending didCreateFiles notifications.
	**/
	var ?didCreate:Bool;

	/**
		The client has support for willCreateFiles requests.
	**/
	var ?willCreate:Bool;

	/**
		The client has support for sending didRenameFiles notifications.
	**/
	var ?didRename:Bool;

	/**
		The client has support for willRenameFiles requests.
	**/
	var ?willRename:Bool;

	/**
		The client has support for sending didDeleteFiles notifications.
	**/
	var ?didDelete:Bool;

	/**
		The client has support for willDeleteFiles requests.
	**/
	var ?willDelete:Bool;
}

/**
	The parameters sent in file create requests/notifications.

	@since 3.16.0
**/
typedef CreateFilesParams = {
	/**
		An array of all files/folders created in this operation.
	**/
	var files:Array<FileCreate>;
}

/**
	Represents information on a file/folder create.

	@since 3.16.0
**/
typedef FileCreate = {
	/**
		A file:// URI for the location of the file/folder being created.
	**/
	var uri:String;
}

/**
	The parameters sent in file rename requests/notifications.

	@since 3.16.0
**/
typedef RenameFilesParams = {
	/**
		An array of all files/folders renamed in this operation. When a folder is renamed, only
		the folder will be included, and not its children.
	**/
	var files:Array<FileRename>;
}

/**
	Represents information on a file/folder rename.

	@since 3.16.0
**/
typedef FileRename = {
	/**
		A file:// URI for the original location of the file/folder being renamed.
	**/
	var oldUri:String;

	/**
		A file:// URI for the new location of the file/folder being renamed.
	**/
	var newUri:String;
}

/**
	The parameters sent in file delete requests/notifications.

	@since 3.16.0
**/
typedef DeleteFilesParams = {
	/**
		An array of all files/folders deleted in this operation.
	**/
	var files:Array<FileDelete>;
}

/**
	Represents information on a file/folder delete.

	@since 3.16.0
**/
typedef FileDelete = {
	/**
		A file:// URI for the location of the file/folder being deleted.
	**/
	var uri:String;
}

/**
	The will create files request is sent from the client to the server before files are actually
	created as long as the creation is triggered from within the client.

	@since 3.16.0
**/
class WillCreateFilesRequest {
	public static inline final type = new ProtocolRequestType<CreateFilesParams, Null<WorkspaceEdit>, Never, NoData,
		FileOperationRegistrationOptions>("workspace/willCreateFiles");
}

/**
	The did create files notification is sent from the client to the server when
	files were created from within the client.

	@since 3.16.0
**/
class DidCreateFilesNotification {
	public static inline final type = new ProtocolNotificationType<CreateFilesParams, FileOperationRegistrationOptions>("workspace/didCreateFiles");
}

/**
	The will rename files request is sent from the client to the server before files are actually
	renamed as long as the rename is triggered from within the client.

	@since 3.16.0
**/
class WillRenameFilesRequest {
	public static inline final type = new ProtocolRequestType<RenameFilesParams, Null<WorkspaceEdit>, Never, NoData,
		FileOperationRegistrationOptions>("workspace/willRenameFiles");
}

/**
	The did rename files notification is sent from the client to the server when
	files were renamed from within the client.

	@since 3.16.0
**/
class DidRenameFilesNotification {
	public static inline final type = new ProtocolNotificationType<RenameFilesParams, FileOperationRegistrationOptions>("workspace/didRenameFiles");
}

/**
	The will delete files request is sent from the client to the server before files are actually
	deleted as long as the deletion is triggered from within the client.

	@since 3.16.0
**/
class DidDeleteFilesNotification {
	public static inline final type = new ProtocolNotificationType<DeleteFilesParams, FileOperationRegistrationOptions>("workspace/didDeleteFiles");
}

/**
	The did delete files notification is sent from the client to the server when
	files were deleted from within the client.

	@since 3.16.0
**/
class WillDeleteFilesRequest {
	public static inline final type = new ProtocolRequestType<DeleteFilesParams, Null<WorkspaceEdit>, Never, NoData,
		FileOperationRegistrationOptions>("workspace/willDeleteFiles");
}
