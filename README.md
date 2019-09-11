[![Build Status](https://travis-ci.org/vshaxe/language-server-protocol-haxe.svg?branch=master)](https://travis-ci.org/vshaxe/language-server-protocol-haxe)

This is an implementation of the [Language Server Protocol](https://microsoft.github.io/language-server-protocol) in [Haxe](http://haxe.org/). Essentially it's a Haxe port of the vscode-languageserver-protocol / vscode-languageserver-types types from [vscode-languageserver-node](https://github.com/microsoft/vscode-languageserver-node). It depends on [vscode-json-rpc](https://github.com/vshaxe/vscode-json-rpc).

It's used by the [Haxe Language Server](https://github.com/vshaxe/haxe-language-server) and was separated from it
so one could implement their own client and/or server using Haxe.
