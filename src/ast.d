module ast;

import std.format;
import std.array : split, join;
import std.uni : toLower;
import std.range : repeat;

/// base object
class Obj {

    /// scalar name/value
    string value;

    /// reference counter
    size_t rc = 0;

    /// AST nested elements = ordered container
    Obj[] nest;

    /// attributes = associative array = attribute grammar
    Obj[string] slot;

    this() {
        rc = 0;
    }

    this(string name) {
        this();
        value = name;
    }

    /// type/class tag (lowercased class name w/o module refs)
    string tag() {
        return this.classinfo.name.split('.')[$ - 1].toLower();
    }

    /// stringified @ref value
    string val() {
        return value;
    }

    /// `<T:V>` header
    string head() {
        return format("<%s:%s>", tag(), val());

    }

    /// full text tree dump
    string dump(size_t depth = 0) {
        string ret = '\n' ~ "\t".repeat(depth).join() ~ head();
        return ret;
    }

    alias toString = dump;
}

/// comment item
class Comment : Obj {
}

class IO : Obj {
    string path; /// @ref path
}

class Path : IO {
}

class Dir : IO {

}

class File : IO {
    this(string path) {
        this.path = path;
    }

    /// base file name w/o path & extensions
    string basename() {
        return path.split('/')[$ - 1].split('.')[0];
    }
}

/// single module
class Module : Obj {

    /// construct with name only
    this(string name) {
        super(name);
    }

    /// construct with given source code file name
    this(File file) {
        super(file.basename());
    }
}
