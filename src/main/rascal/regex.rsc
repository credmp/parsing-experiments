module regex;

// Syntax

data RegExp =
  letter()
  ;

// Parser

layout Layout = [\t\n\ \r]*;  // Define allowed whitespace characters

syntax RegExp =
  letter: [a-z]
  ;

start syntax RegExp = RegExp;  // Entry point for the parser
