public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    // 为了公开，默认是 internal
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value, next: nil)
        tail = tail!.next
    }
    
    public mutating func insert(at index: Int, value: Value) {
        copyNodes()
        // 链表为空，直接压入
        if isEmpty {
            push(value)
        } else {
            // 表头插入
            guard index > 0 else {
                push(value)
                return
            }
            // 表尾添加
            guard node(at: index) != nil else {
                append(value)
                return
            }
            // 表中插入
            let prev = node(at: index - 1)
            prev!.next = Node(value: value, next: prev!.next)
        }
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value>? {
      // 这里也需要改为 copyNodes(returningCopyOf:) 而不是 copyNodes()
      guard let node = copyNodes(returningCopyOf: node) else { return nil }
      guard tail !== node else {
        append(value)
        return tail!
      }
      node.next = Node(value: value, next: node.next)
      return node.next!
    }
    
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        // 空
        guard let head = head else {
            return nil
        }
        
        // 只有一个结点
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Value? {
        copyNodes()
        if isEmpty {
            return nil
        }
        
        // 移除表头
        guard index > 0 else {
            defer {
                head = head!.next
                if head == nil {
                    tail = nil
                }
            }
            return head!.value
        }
        
        guard let prev = node(at: index - 1) else {
            return nil
        }

        guard let current = prev.next else {
            return nil
        }
        
        guard let prevNext = current.next else {
            // 移除表尾
            prev.next = nil
            tail = prev
            return current.value
        }
        
        prev.next = prevNext
        
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        // 这里移除的 node 是原先链表里的 node，而使用 copyNodes 之后创建了新的一个链表
        // 所以移除的 node 是旧链表的结点
        // copyNodes()
        // 在创建新链表的过程中，找到与 node 对应的结点并返回到这里
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
          return
        }
        
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
      guard !isKnownUniquelyReferenced(&head) else {
          // 这里需要返回 node 而不是 nil
          return node
      }
      guard var oldNode = head else {
        return nil
      }

      head = Node(value: oldNode.value)
      var newNode = head
      var nodeCopy: Node<Value>?

      while let nextOldNode = oldNode.next {
        if oldNode === node {
          nodeCopy = newNode
        }
        newNode!.next = Node(value: nextOldNode.value)
        newNode = newNode!.next
        oldNode = nextOldNode
      }
        // 这里需要重复调用一遍，否则 node 为表尾是会被忽略
        if oldNode === node {
            nodeCopy = newNode
        }
        // 这里也需要添加这一行，否则表尾结点没有记录
      tail = newNode
      return nodeCopy
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?

        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }

        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            /// 什么意思
            return nodes.contains { $0 === rhs.node }
        }
    }

    public var startIndex: Index {
        Index(node: head)
    }

    public var endIndex: Index {
        Index(node: tail?.next)
    }

    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }

    public subscript(position: Index) -> Value {
        position.node!.value
    }
}
