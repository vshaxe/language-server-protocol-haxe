package vscodeProtocol;

import vscodeProtocol.Types.MethodNames;

class Protocol extends jsonrpc.Protocol {
    override function logError(message:String) {
        sendNotification(MethodNames.LogMessage, {type: Warning, message: message});
    }
}
