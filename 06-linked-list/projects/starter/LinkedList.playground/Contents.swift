// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.next = node3
    
    print(node1)
}

example(of: "push-append-insert") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print(list)
    list.append(4)
    print(list)
    list.insert(at: 0, value: 0)
    print(list)
    list.insert(at: 10, value: 10)
    print(list)
    list.insert(at: 2, value: 222)
    print(list)
}

example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    list.append(4)
    list.insert(at: 0, value: 0)
    list.insert(at: 10, value: 10)
    list.insert(at: 2, value: 222)
    
    print(list.pop() as Any)
    print(list)
}

example(of: "removing the last node") {
  var list = LinkedList<Int>()
  list.push(3)
  list.push(2)
  list.push(1)

  print("Before removing last node: \(list)")
  let removedValue = list.removeLast()

  print("After removing last node: \(list)")
  print("Removed value: " + String(describing: removedValue))
}

example(of: "remove at index") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)

    print("Before removing last node: \(list)")
    let removedValue = list.remove(at: 1)
    print("After removing last node: \(list)")
    print("Removed value: " + String(describing: removedValue))
}

example(of: "using collection") {
    var list = LinkedList<Int>()
    for i in 0...9 {
        list.append(i)
    }

    print("List: \(list)")
    print("First element: \(list[list.startIndex])")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elements: \(Array(list.suffix(3)))")

    let sum = list.reduce(0, +)
    print("Sum of all values: \(sum)")
}

example(of: "array cow") {
  let array1 = [1, 2]
  var array2 = array1

  print("array1: \(array1)")
  print("array2: \(array2)")

  print("---After adding 3 to array 2---")
  array2.append(3)
  print("array1: \(array1)")
  print("array2: \(array2)")
}

example(of: "linked list cow") {
  var list1 = LinkedList<Int>()
  list1.append(1)
  list1.append(2)
  print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
  var list2 = list1
  print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")


  print("List1: \(list1)")
  print("List2: \(list2)")

  print("After appending 3 to list2")
  list2.append(3)
  print("List1: \(list1)")
  print("List2: \(list2)")
}
