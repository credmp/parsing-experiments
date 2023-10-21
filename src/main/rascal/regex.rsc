module regex

import ParseTree;
import IO;

layout Whitespace = [\t\n\r\ ]*;

lexical Integer = [0-9]+ !>> [0-9];

start syntax RegExp = Alternation+;

syntax Alternation =
  Expression ('|' Expression? )*;

syntax Expression = Element+;

syntax Element = Atom Quantifier?;

syntax Atom
  = letter: Letter
  | digit: Digit
  | characterclass: CharacterClass
  > caption: Capture;

// TODO add {0,3}
syntax Quantifier
  = ('?' | '+' |  '*')
  | '{' Integer '}'  // (',' Integer)? of {',' Integer}? werkt niet
  ;

// [a-z]
syntax CharacterClass
  = '[' '^'? CharacterClassRange+  ']'
  ;

syntax CharacterClassRange
  = Character '-' Character
  ;

syntax Character
  = Letter
  | Digit
  ;

syntax Capture =
  '(' Element+ ')'
  ;

lexical Letter = [a-zA-Z];
lexical Digit  = [0-9];
lexical Integer = [0-9]+ !>> [0-9];


test bool simpleTest() {
  // Success
  parse(#RegExp, "a");
  parse(#RegExp, "ab");
  parse(#RegExp, "a|b");
  parse(#RegExp, "a+b*");
  parse(#RegExp, "a+(b*)?");
  parse(#RegExp, "[a-z]");
  parse(#RegExp, "[a-zA-Z]");
  parse(#RegExp, "[^a-zA-Z]");
  parse(#RegExp, "[a-zA-Z0-9]");
  parse(#RegExp, "[a-zA-Z0-9]{2}");
  parse(#RegExp, "ab?[a-zA-Z0-9]{2}d{5}");

  return true;
}
