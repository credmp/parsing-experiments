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
    case appl(prod(label, symbols, attrs), args): {
      // rprint(t);
      // str id = replaceAll(toString(t.src), "[\<\>,:/]", "_");
      str nodeId = "<label>"; //_<id>"; // Unique ID for the node
      res += "  \"<parentId>\" -\> \"<nodeId>\" [label=\"<label>\"];\n";
      for (child <- symbols) {
        rprint(child);
        res += treeToDotHelper(child, nodeId);
      }
    }
    case char(c): {
      str nodeId = "char_<c>";
      res += "  \"<parentId>\" -\> \"<nodeId>\";\n";
    }
    default:
      println("Found something I do not know yet");
    }
                return res;
}

// see: https://github.com/cwi-swat/drambiguity/blob/feac1ac8d334202ea2c95368eb5fe3a3d4b655f5/src/analysis/grammars/dramb/Simplify.rsc#L25
Tree simplify(Tree t, int indent) {
  if (a:appl(p, args) := t) {
    for (i <- index(args)) {
      // println("Simplifying <indent> <args>");
      n = simplify(args[i], indent+1);

      if (n != args[i]) {
        return appl(p, [*args[..i], n, *args[i+1..]])[@\loc=a@\loc];
      }
    }
  }
  // println("<t>");
  switch (t) {
     case Tree a:appl(p:prod(v,s,a), _): {
       println("Production: <v> <a>" );
       return t;
     }
     // case Tree a:appl(Production r:regular(\iter-seps(_,list[Symbol] seps)),list[Tree] args:![_]) : {
     //   println("Application with Production regular: " + args);
     //   return appl(r, [args]);
     // }

     // // // remove elements from star separated lists
     // case a:appl(r:regular(\iter-star-seps(_,seps)), list[Tree] args:![]) : {
     //   println("remove elements from star separated lists: " + args);
     //      return appl(r, []);
     // }

     // // removes elements from non-nullable lists
     // case a:appl(r:regular(\iter(_)), list[Tree] args:![_]) : {
     //   rand = arbInt(size(args));

     //   if (arbBool()) {
     //      return appl(r, [args[rand]]);
     //   }

     //   return appl(r, args[..rand] + args[(rand+1)..])[@\loc=a@\loc];
     // }

     // // removes elements from nullable lists
     // case a:appl(r:regular(\iter-star(_)), list[Tree] args:![]) : {
     //   if (arbBool()) {
     //      return appl(r, []);
     //   }

     //   rand = arbInt(size(args));
     //   return appl(r, args[..rand] + args[(rand+1)..])[@\loc=a@\loc];
     // }

     // // removes optionals
     // case a:appl(r:regular(\opt(_)),[_]) :
     //   if (arbBool()) {
     //     return appl(r, [])[@\loc=a@\loc];
     //   }
     //   else {
     //     fail;
     //   }

     // // removes direct recursion
     // case appl(prod(p,_,_),[*_,b:appl(prod(q,_,_),_),*_]) : {
     //   if (arbBool()) {
     //     fail; // skip to another match
     //   } else if (delabel(p) == delabel(q)) {
     //     return b;
     //   } else {
     //     fail;
     //   }
     // }

     // // removes indirect recursion (one level removed)
     // case appl(prod(p,_,_),[*_,appl(_,[*_,b:appl(prod(q,_,_),_),*_]),*_]) : {
     //   if (arbBool()) {
     //     fail; // skip to another match
     //   } else if (delabel(p) == delabel(q)) {
     //     found = true;
     //     return b;
     //   } else {
     //     fail;
     //   }
     // }

     // // just pick a random child to continue simplifcation in
     // case a:appl(p, args): {
     //   for (i <- index(args), arbBool()) {
     //      n = simplify(args[i]);

     //      if (n != args[i]) {
     //        return appl(p, [*args[..i], n, *args[i+1..]])[@\loc=a@\loc];
     //      }
     //   }
     // }

     // // pick an ambiguous alternative, arbitrarily, not randomly
     // case amb(alts) : {
     //   return getOneFrom(alts);
     // }
  }
  return t;
}

void printTree(RegExp e) {
    switch(e) {
        case a:appl(Production p, attrs): {
          println("<attrs>");
            }
        case letter(s):{
            println("letter: <s>");
            break;
            }
        default:
            println("Unknown");
    }
}

