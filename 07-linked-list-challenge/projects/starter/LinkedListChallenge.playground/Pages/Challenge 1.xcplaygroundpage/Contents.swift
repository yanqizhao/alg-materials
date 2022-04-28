// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Linked List Challenges
 ## Challenge 1: Print in reverse

 Create a function that prints the nodes of a linked list in reverse order.
 */
func printInReverse<T>(_ list: LinkedList<T>) {
    printInReverse(list.head)
}

private func printInReverse<T>(_ node: Node<T>?) {
    guard let node = node else { return }
    printInReverse(node.next)
    print(node.value)
}

example(of: "Reverse LinkedList") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    printInReverse(list)
}
//: [Next Challenge](@next)
