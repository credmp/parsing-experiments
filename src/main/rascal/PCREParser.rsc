module PCREParser

import PCRE;

layout Layout = [\t\n\ \r]*;  // Define allowed whitespace characters

syntax RegExp
    = epsilon: ""
    | PrimaryRegExp
    | ConcatRegExp
    > left union: RegExp "|" RegExp
    ;

syntax PrimaryRegExp
    = symbol: [a-zA-Z]
    | kleeneStar: PrimaryRegExp "*"
    ;

syntax ConcatRegExp
    = left concat: PrimaryRegExp PrimaryRegExp
    ;

start syntax Start = RegExp;  // Entry point for the parser
