// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 
 ## #2. Balance Parentheses
 
 Check for balanced parentheses. Given a string, check if there are `(` and `)` characters, and return `true` if the parentheses in the string are balanced.
 ```
 // 1
 h((e))llo(world)() // balanced parentheses
 // 2
 (hello world // unbalanced parentheses
 ```
 */
var testString1 = "h((e))llo(world)()"

// your code here

// checkParentheses(testString1) // should be true

func checkParentheses(_ str: String) -> Bool {
    var stack = Stack<Character>()
    
    for s in str {
        if s == ")" && stack.peek() == "(" {
            stack.pop()
        } else if s == "(" {
            stack.push(s)
        }
    }
    
    return stack.isEmpty
}

checkParentheses(testString1)
