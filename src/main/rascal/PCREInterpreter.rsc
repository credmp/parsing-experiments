module PCREInterpreter

import PCRE;
import String;

bool match(RegExp re, str s) {
    switch(re) {
        case epsilon(): return s == "";
        case symbol(c): return s == c;
        case concat(left, right): {
            // Try all possible splits of s and check if the left part matches 'left'
            // and the right part matches 'right'
            for(int i <- [0..size(s)]) {
                if(match(left, s[0..i]) && match(right, s[i..])) return true;
            }
            return false;
            }
        case union(left, right):
            return match(left, s) || match(right, s);
        case kleeneStar(r): {
            if(s == "") return true;
            //Try all non-empty prefixes of s and check if they match 'r'
            for(int i <- [1..size(s)]) {
                if(match(r, s[0..i]) && match(kleeneStar(r), s[i..])) return true;
            }
            return false;
            }
    }
}
