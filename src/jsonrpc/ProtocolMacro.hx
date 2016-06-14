package jsonrpc;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;

class ProtocolMacro {
    static function build(methodsClass:String):Array<Field> {
        var methodNamesClass = switch (Context.getType(methodsClass)) {
            case TInst(_.get() => cl, _): cl;
            default: throw false;
        }

        var fields = Context.getBuildFields();

        var methodNamesClassPath = methodNamesClass.module.split(".");
        methodNamesClassPath.push(methodNamesClass.name);

        for (method in methodNamesClass.statics.get()) {
            var methodNameExpr = macro $p{methodNamesClassPath.concat([method.name])};
            var handlerName = "on" + method.name;
            switch (method.type) {
                case TAbstract(_.get() => {name: "RequestMethod"}, [params, resultData, errorData]):
                    var paramsCT = params.toComplexType();
                    var resultCT = resultData.toComplexType();
                    var errorCT = errorData.toComplexType();

                    var handlerCT = macro : jsonrpc.Protocol.RequestHandler<$paramsCT, $resultCT, $errorCT>;

                    fields.push({
                        pos: method.pos,
                        name: handlerName,
                        kind: FProp("never", "set", handlerCT),
                        access: [APublic],
                    });

                    fields.push({
                        pos: method.pos,
                        name: "set_" + handlerName,
                        access: [AInline],
                        kind: FFun({
                            args: [{name: "value", type: handlerCT}],
                            ret: handlerCT,
                            expr: macro {
                                onRequest($methodNameExpr, value);
                                return value;
                            }
                        })
                    });

                case TAbstract(_.get() => {name: "NotificationMethod"}, [params]):
                    var paramsCT = params.toComplexType();

                    var handlerCT = macro : jsonrpc.Protocol.NotificationHandler<$paramsCT>;

                    fields.push({
                        pos: method.pos,
                        name: handlerName,
                        kind: FProp("never", "set", handlerCT),
                        access: [APublic],
                    });

                    fields.push({
                        pos: method.pos,
                        name: "set_" + handlerName,
                        access: [AInline],
                        kind: FFun({
                            args: [{name: "value", type: handlerCT}],
                            ret: handlerCT,
                            expr: macro {
                                onNotification($methodNameExpr, value);
                                return value;
                            }
                        })
                    });

                    var sendArgDefs = [];
                    var sendCallArgs = [methodNameExpr];
                    if (params.match(TEnum(_.get() => {name: "NoData"}, _))) {
                        sendCallArgs.push(macro null);
                    } else {
                        sendArgDefs.push({name: "params", type: paramsCT});
                        sendCallArgs.push(macro params);
                    }

                    fields.push({
                        pos: method.pos,
                        name: "send" + method.name,
                        access: [APublic, AInline],
                        kind: FFun({
                            ret: macro : Void,
                            args: sendArgDefs,
                            expr: macro this.sendNotification($a{sendCallArgs})
                        })
                    });

                default:
                    throw false;
            }
        }

        return fields;
    }
}
#end
