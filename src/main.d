import std.stdio;

import parser;

import std.range : enumerate;

void main(string[] args) {
    arg(0, args[0]);
    foreach (argc, argv; args[1 .. $].enumerate(1)) {
        arg(argc, argv);
        writeln(PY(readText(argv)));
    }
}

void arg(int argc, string argv) {
    writefln("argv[%s] = <%s>", argc, argv);
}
