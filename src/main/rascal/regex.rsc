module regex

import ParseTree;
import IO;

// A regular expression does not have whitespace
//layout Whitespace = [\t\n\r\ ]*;

lexical Integer = integer: [0-9]+ !>> [0-9];

start syntax RegExp = alternation: Expression lhs ('|' Expression rhs )*;

syntax Expression = elements: Element+;

syntax Element = element: Atom Quantifier?;

syntax Atom
  = emptyString: "ε"
  | letter: Letter
  | digit: Digit
  > order: Order;


syntax Quantifier
  = kleeneStar: '*'
  ;

syntax Order =
  elements: '(' RegExp ')'
  ;

lexical Letter = [a-zA-Z];
lexical Digit  = [0-9];
lexical Integer = [0-9]+ !>> [0-9];


test bool simpleTest() {
  // Success
  parse(#RegExp, "a");
  parse(#RegExp, "ε");
  parse(#RegExp, "ab");
  parse(#RegExp, "aεb");
  parse(#RegExp, "a|b");
  parse(#RegExp, "a|b|c");
  parse(#RegExp, "a|b(d|c)");
  parse(#RegExp, "a");
  parse(#RegExp, "ε");
  parse(#RegExp, "ab*");
  parse(#RegExp, "a|b");
  parse(#RegExp, "ab|ε");
  parse(#RegExp, "a(b|c)");
  parse(#RegExp, "a*");
  parse(#RegExp, "(ab)*");
  parse(#RegExp, "a(b|c)d*");
  parse(#RegExp, "a(b|c)d*");
  return true;
}

