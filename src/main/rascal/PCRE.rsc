module PCRE

data RegExp =
      epsilon()
    | symbol(str s)              // A single character
    | concat(RegExp left, RegExp right)   // Concatenation of two regex patterns
    | union(RegExp left, RegExp right)    // Choice between two regex patterns
    | kleeneStar(RegExp r)       // Zero or more repetitions of a regex pattern
    ;
