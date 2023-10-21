module regex

import ParseTree;
import IO;

layout Whitespace = [\t\n\r\ ]*;

lexical Integer = [0-9]+ !>> [0-9];

start syntax RegExp = Element+;

syntax Element = Atom Quantifier?;

syntax Atom
  = letter: Letter
  | digit: Digit
  | characterclass: CharacterClass
  > caption: Capture;

// add {0} / {0,3}
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
  parse(#RegExp, "a+b*");
  parse(#RegExp, "a+(b*)?");


  return true;
}
