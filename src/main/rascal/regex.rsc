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
  > caption: Capture;


//  | characterclass: CharacterClass

// TODO add {0,3}
syntax Quantifier
  = kleeneStar: '*' //('?' | '+' |  '*')
  // | exactly: '{' Integer '}'  // (',' Integer)? of {',' Integer}? werkt niet
  ;

// [a-z]
// syntax CharacterClass
//   = characterClass: '[' '^'? CharacterClassRange+  ']'
//   ;

// syntax CharacterClassRange
//   = range: Character '-' Character
//   ;

// syntax Character
//   = letter: Letter
//   | digit: Digit
//   ;

// In Linz the () are used to define grouping/ordering a|b(d|c) so a or b followd by d or c.
syntax Capture =
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
  // parse(#RegExp, "a+b*");
  // parse(#RegExp, "a+(b*)?");
  // parse(#RegExp, "[a-z]");
  // parse(#RegExp, "[a-zA-Z]");
  // parse(#RegExp, "[^a-zA-Z]");
  // parse(#RegExp, "[a-zA-Z0-9]");
  // parse(#RegExp, "[a-zA-Z0-9]{2}");
  // parse(#RegExp, "ab?[a-zA-Z0-9]{2}d{5}");
    parse(#RegExp, "a");
    parse(#RegExp, "ε");
    parse(#RegExp, "ab*");
    parse(#RegExp, "a|b");
    parse(#RegExp, "ab|ε");
    parse(#RegExp, "a(b|c)");
    parse(#RegExp, "a*");
    parse(#RegExp, "(ab)*");
    parse(#RegExp, "a(b|c)d*");
  return true;
}

