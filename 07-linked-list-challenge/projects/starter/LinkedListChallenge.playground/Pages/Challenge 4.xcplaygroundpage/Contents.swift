// Copyright (c) 2021 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 4: Merge two lists

 Create a function that takes two sorted linked lists and merges them into a single sorted linked list. Your goal is to return a new linked list that contains the nodes from two lists in sorted order. You may assume the sort order is ascending.
 */
func mergeSorted<T: Comparable>(_ left: LinkedList<T>,
                                _ right: LinkedList<T>) -> LinkedList<T> {
    // 左边空，返回右边
    guard !left.isEmpty else {
        return right
    }
    
    // 右边空，返回左边
    guard !right.isEmpty else {
        return left
    }
    
    var newHead: Node<T>?
    var tail: Node<T>?
    
    var currentLeft = left.head
    var currentRight = right.head
    
    // 找到头结点
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        tail = newHead
    }
    
    // 按顺序后移尾结点
    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }
    
    // 如果左边还有结点就继续
    if let leftNodes = currentLeft {
        tail?.next = leftNodes
    }
    
    // 如果右边还有结点就继续
    if let rightNodes = currentRight {
        tail?.next = rightNodes
    }
    
    var list = LinkedList<T>()
    list.head = newHead
    list.tail = {
        // tail 还没有移到链表的尾部
        while let next = tail?.next {
            tail = next
        }
        return tail
    }()
    
    return list
}

example(of: "Merge two lists") {
    var list = LinkedList<Int>()
    list.append(4)
    list.append(9)
    list.append(17)

    var list2 = LinkedList<Int>()
    list2.append(3)
    list2.append(10)
    list2.append(12)
    print(mergeSorted(list2, list))
}
//: [Next Challenge](@next)
