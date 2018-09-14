package languageServerProtocol.protocol;

import jsonrpc.Types;

@:publicFields
class ConfigurationMethods {
	/**
		The 'workspace/configuration' request is sent from the server to the client to fetch a certain
		configuration setting.

		This pull model replaces the old push model were the client signaled configuration change via an
		event. If the server still needs to react to configuration changes (since the server caches the
		result of `workspace/configuration` requests) the server should register for an empty configuration
		change event and empty the cache if such an event is received.
	**/
	static inline var Configuration = new RequestMethod<ConfigurationParams, Array<Dynamic>, NoData, NoData>("workspace/configuration");
}

typedef ConfigurationClientCapabilities = {
	/**
		The client supports `workspace/configuration` requests.
	**/
	var ?configuration:Bool;
}

typedef ConfigurationItem = {
	/**
		The scope to get the configuration section for.
	**/
	var ?scopeUri:String;

	/**
		The configuration section asked for.
	**/
	var ?section:String;
}

/**
	The parameters of a configuration request.
**/
typedef ConfigurationParams = {
	var items:Array<ConfigurationItem>;
}
