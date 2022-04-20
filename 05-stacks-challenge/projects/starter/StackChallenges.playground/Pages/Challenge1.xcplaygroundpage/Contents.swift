// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Stack Challenges
 
 ## #1. Reserve an Array
 
 Create a function that prints the contents of an array in reversed order.
 */

let array: [Int] = [1, 2, 3, 4, 5]

// Your code here

// printInReverse(array)

func printInReverse<T>(_ arr: Array<T>) {
    var stack = Stack(arr)
    var arr2: [T] = []
    for _ in 0..<arr.count {
        arr2.append(stack.pop()!)
    }
    print(arr2)
}

printInReverse(array)
//: [Next Challenge](@next)
