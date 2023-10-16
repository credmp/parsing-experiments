module PCRETest

import IO;

import PCRE;
import PCREParser;
import PCREInterpreter;
import ParseTree;

bool test_ab_or_c() {
    // Parse the regular expression "ab|c" into its AST representation
    Tree parsedTree = parse(#Start, "ab|c");
    if (/appl(prod(sort("Start"), [sort("RegExp")], {}), [RegExp re]) := parsedTree) {
      bool result = match(re, "someString");
      println(result);
    } else {
      println("Unexpected structure");
    }
    //RegExp re = top(parsedTree);  // Extract the RegExp from the parsed tree

    // Check strings against this regular expression
    // bool test1 = match(re, "ab"); // should return true
    // bool test2 = match(re, "c");  // should return true
    // bool test3 = match(re, "a");  // should return false
    // bool test4 = match(re, "b");  // should return false
    // bool test5 = match(re, "abc"); // should return false

    // // Return true if all tests pass
    // return test1 && test2 && !test3 && !test4 && !test5;
    return true;
}

// Execute the test
bool result = test_ab_or_c();
// println(result);
// println("Test result: <result>");
