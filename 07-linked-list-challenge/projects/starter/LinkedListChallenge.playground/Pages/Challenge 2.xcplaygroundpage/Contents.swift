// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 2: Find the middle node

 Create a function that finds the middle node of a linked list.
 */
func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    let count = list.count / 2
    var node = list.head
    for _ in 0..<count {
        node = node?.next
    }
    return node
}

example(of: "Find the middle node") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    list.append(4)
    list.append(5)
    print(getMiddle(list) as Any)
}
//: [Next Challenge](@next)
