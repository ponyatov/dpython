import pegged.grammar;

import ast;

mixin(grammar(`
    PY:
        syntax < (comment/any)*
        comment <~ '#'(!'\n'.)*
        any < .
`));
