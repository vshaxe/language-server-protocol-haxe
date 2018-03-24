package languageServerProtocol.protocol;

import jsonrpc.Types;

@:publicFields
class ConfigurationMethods {
    /**
        The 'workspace/configuration' request is sent from the server to the client to fetch a certain
        configuration setting.
    **/
    static inline var Configuration = new RequestMethod<ConfigurationParams,Array<Dynamic>,NoData,NoData>("workspace/configuration");
}

typedef ConfigurationClientCapabilities = {
    /**
        The client supports `workspace/configuration` requests.
    **/
    @:optional var configuration:Bool;
}

typedef ConfigurationItem = {
    /**
        The scope to get the configuration section for.
    **/
    @:optional var scopeUri:String;

    /**
        The configuration section asked for.
    **/
    @:optional var section:String;
}

/**
    The parameters of a configuration request.
**/
typedef ConfigurationParams = {
    var items:Array<ConfigurationItem>;
}
