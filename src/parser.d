import pegged.grammar;

import ast;

import std.stdio;
import std.file : readText;

mixin(grammar(`
    PY:
        syntax < (comment/any)*
        comment <~ '#'(!'\n'.)*
        any < .
`));

/// process .py file
Obj py(string pyfile) {
    writeln(PY(readText(pyfile)));
    return new ast.Module(new ast.File(pyfile));
}
