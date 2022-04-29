// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 5: Remove all occurrences of a specific element

 Create a function that removes all occurrences of a specific element from a linked list. The implementation is similar to the `remove(at:)` method that you implemented for the linked list.
 */

extension LinkedList where Value: Equatable {
  mutating func removeAll(_ value: Value) {
      if head?.value == value {
          head = head?.next
      }
      
      var prevNode = self.head
      var currentNode = self.head?.next
      
      while currentNode != nil {
          if currentNode!.value == value {
              prevNode!.next = currentNode!.next
          } else {
              prevNode = currentNode
          }
          currentNode = currentNode!.next
      }
      tail = prevNode
  }
}

example(of: "Remove all occurrences of a specific element") {
    var list = LinkedList<Int>()
    list.append(4)
    list.append(4)
    list.append(4)
    list.append(17)
    list.append(4)
    list.append(9)
    list.append(17)
    list.append(4)
    list.append(9)
    list.append(17)
    list.removeAll(17)
    print(list)
}
