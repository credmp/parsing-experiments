module util

import regex;
import ParseTree;
import String;
import IO;

str treeToDot(Tree t) {
    str res = "digraph G {\n";
    res += treeToDotHelper(t, "root");
    res += "}\n";
    return res;
}

str treeToDotHelper(Tree t, str parentId) {
    str res = "";
    visit (t) {
        case appl(prod(label, _, _), children, _): {
          println(label);
            str nodeId = label + "_" + replaceAll(toString(t.src), "[\<\>,:/]", "_"); // Unique ID for the node
            res += "  \"<parentId>\" -\> \"<nodeId>\" [label=\"<label>\"];\n";
            for (child <- children) {
                res += treeToDotHelper(child, nodeId);
            }
        }
        case char(c): {
            str nodeId = "char_<c>";
            res += "  \"<parentId>\" -\> \"<nodeId>\";\n";
        }
        //default: { /* Handle other cases if needed */ }
    }
    return res;
}
