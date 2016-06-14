package jsonrpc;

import jsonrpc.Types;
import jsonrpc.CancellationToken;
import jsonrpc.ErrorUtils.errorToString;

typedef RequestHandler<P,R,E> = P->CancellationToken->(R->Void)->(ResponseError<E>->Void)->Void;
typedef NotificationHandler<P> = P->Void;

/**
    A simple JSON-RPC protocol base class.
**/
class Protocol {
    static inline var PROTOCOL_VERSION = "2.0";
    static inline var CANCEL_METHOD = new NotificationMethod<CancelParams>("$/cancelRequest");

    var writeMessage:Message->Void;
    var requestTokens:Map<String,CancellationTokenSource>;
    var nextRequestId:Int;
    var requestHandlers:Map<String,RequestHandler<Dynamic,Dynamic,Dynamic>>;
    var notificationHandlers:Map<String,NotificationHandler<Dynamic>>;
    var responseCallbacks:Map<Int,ResponseCallbackEntry>;

    public function new(writeMessage) {
        this.writeMessage = writeMessage;
        requestHandlers = new Map();
        notificationHandlers = new Map();
        requestTokens = new Map();
        nextRequestId = 0;
    }

    public function handleMessage(message:Message):Void {
        if ((Reflect.hasField(message, "result") || Reflect.hasField(message, "error")) && Reflect.hasField(message, "id")) {
            handleResponse(cast message);
        } else if (Reflect.hasField(message, "method")) {
            if (Reflect.hasField(message, "id"))
                handleRequest(cast message);
            else
                handleNotification(cast message);
        }
    }

    public inline function onRequest<P,R,E>(method:RequestMethod<P,R,E>, handler:RequestHandler<P,R,E>):Void {
        requestHandlers[method] = handler;
    }

    public inline function onNotification<P>(method:NotificationMethod<P>, handler:NotificationHandler<P>):Void {
        notificationHandlers[method] = handler;
    }

    function handleRequest(request:RequestMessage) {
        var tokenKey = Std.string(request.id);

        function resolve(result:Dynamic) {
            requestTokens.remove(tokenKey);

            var response:ResponseMessage = {
                jsonrpc: PROTOCOL_VERSION,
                id: request.id,
                result: result
            };
            writeMessage(response);
        }

        function reject(error:ResponseErrorData) {
            requestTokens.remove(tokenKey);

            var response:ResponseMessage = {
                jsonrpc: PROTOCOL_VERSION,
                id: request.id,
                error: error
            };
            writeMessage(response);
        }

        var handler = requestHandlers[request.method];
        if (handleMessage == null)
            return reject(new ResponseError(ResponseError.MethodNotFound, 'Unhandled method ${request.method}'));

        var tokenSource = new CancellationTokenSource();
        requestTokens[tokenKey] = tokenSource;

        try {
            handler(request.params, tokenSource.token, resolve, reject);
        } catch (e:Dynamic) {
            requestTokens.remove(tokenKey);

            var message = errorToString(e, 'Exception while handling request ${request.method}: ');
            reject(ResponseError.internalError(message));
            logError(message);
        }
    }

    function handleNotification(notification:NotificationMessage) {
        if (notification.method == CANCEL_METHOD) {
            var tokenKey = Std.string(notification.params.id);
            var tokenSource = requestTokens[tokenKey];
            if (tokenSource != null) {
                requestTokens.remove(tokenKey);
                tokenSource.cancel();
            }
        } else {
            var handler = notificationHandlers[notification.method];
            if (handler == null)
                return;
            try {
                handler(notification.params);
            } catch (e:Dynamic) {
                logError(errorToString(e, 'Exception while processing notification ${notification.method}: '));
            }
        }
    }

    function handleResponse(response:ResponseMessage) {
        if (!(response.id is Int)) {
            logError("Got response with non-integer id:\n" + haxe.Json.stringify(response, "    "));
            return;
        }
        var handler = responseCallbacks[response.id];
        if (handler != null) {
            responseCallbacks.remove(response.id);
            try {
                if (Reflect.hasField(response, "error"))
                    handler.reject(response.error);
                else
                    handler.resolve(response.result);
            } catch (e:Dynamic) {
                logError(errorToString(e, 'Exception while handing response ${handler.method}: '));
            }
        }
    }

    inline function sendNotification<P>(name:NotificationMethod<P>, params:P):Void {
        var message:NotificationMessage = {
            jsonrpc: PROTOCOL_VERSION,
            method: name
        };
        if (params != null)
            message.params = params;
        writeMessage(message);
    }

    function sendRequest<P,R,E>(method:RequestMethod<P,R,E>, params:P, token:Null<CancellationToken>, resolve:P->Void, reject:E->Void):Void {
        var id = nextRequestId++;
        var request:RequestMessage = {
            jsonrpc: PROTOCOL_VERSION,
            id: id,
            method: method,
        };
        if (params != null)
            request.params = params;
        responseCallbacks[id] = new ResponseCallbackEntry(method, resolve, reject);
        if (token != null)
            token.setCallback(function() sendNotification(CANCEL_METHOD, {id: id}));
        writeMessage(request);
    }

    function logError(message:String):Void {
    }
}

/**
    Parameters for request cancellation notification.
**/
private typedef CancelParams = {
    /**
        The request id to cancel.
    **/
    var id:RequestId;
}

private class ResponseCallbackEntry {
    public var method:String;
    public var resolve:Dynamic->Void;
    public var reject:Dynamic->Void;
    public function new(method, resolve, reject) {
        this.method = method;
        this.resolve = resolve;
        this.reject = reject;
    }
}
