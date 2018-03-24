package languageServerProtocol.protocol;

import haxe.extern.EitherType;
import languageServerProtocol.Types;
import languageServerProtocol.protocol.Protocol;
import jsonrpc.Types;

@:publicFields
class ColorProviderMethods {
    /**
        A request to list all color symbols found in a given text document.
    **/
    static inline var DocumentColor = new RequestMethod<DocumentColorParams,Array<ColorInformation>,NoData,TextDocumentRegistrationOptions>("textDocument/documentColor");

    /**
        A request to list all presentation for a color.
    **/
    static inline var ColorPresentation = new RequestMethod<ColorPresentationParams,Array<ColorPresentation>,NoData,TextDocumentRegistrationOptions>("textDocument/colorPresentation");
}

typedef ColorClientCapabilities = {
    /**
        Capabilities specific to the colorProvider
    **/
    @:optional var colorProvider:{
        /**
            Whether implementation supports dynamic registration. If this is set to `true`
            the client supports the new `(ColorProviderOptions & TextDocumentRegistrationOptions & StaticRegistrationOptions)`
            return value for the corresponding server capability as well.
        **/
        @:optional var dynamicRegistration:Bool;
    };
}

typedef ColorProviderOptions = {
}

typedef ColorServerCapabilities = {
    /**
        The server provides color provider support.
    **/
    @:optional var colorProvider:EitherType<ColorProviderOptions,{>ColorProviderOptions,>TextDocumentRegistrationOptions,>StaticRegistrationOptions,}>;
}

/**
    Parameters for a `DocumentColor` request.
**/
typedef DocumentColorParams = {
    /**
        The text document.
    **/
    var textDocument:TextDocumentIdentifier;
}

/**
 * Parameters for a `ColorPresentation` request.
 */
typedef ColorPresentationParams = {
    /**
        The text document.
    **/
    var textDocument:TextDocumentIdentifier;

    /**
        The color to request presentations for.
    **/
    var color:Color;

    /**
        The range where the color would be inserted. Serves as a context.
    **/
    var range:Range;
}

/**
    Represents a color in RGBA space.
**/
typedef Color = {
    /**
        The red component of this color in the range [0-1].
    **/
    final red:Float;

    /**
     * The green component of this color in the range [0-1].
     */
    final green:Float;

    /**
     * The blue component of this color in the range [0-1].
     */
    final blue:Float;

    /**
     * The alpha component of this color in the range [0-1].
     */
    final alpha:Float;
}

/**
    Represents a color range from a document.
**/
typedef ColorInformation = {
    /**
        The range in the document where this color appers.
    **/
    var range:Range;

    /**
        The actual color value for this color range.
    **/
    var color:Color;
}

typedef ColorPresentation = {
    /**
        The label of this color presentation. It will be shown on the color
        picker header. By default this is also the text that is inserted when selecting
        this color presentation.
    **/
    var label:String;

    /**
        An edit which is applied to a document when selecting
        this presentation for the color. When `falsy` the `label`
        is used.
    **/
    @:optional var textEdit:TextEdit;

    /**
        An optional array of additional text edits that are applied when
        selecting this color presentation. Edits must not overlap with the main `edit` nor with themselves.
    **/
    @:optional var additionalTextEdits:Array<TextEdit>;
}
