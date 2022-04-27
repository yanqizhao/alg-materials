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
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value, next: nil)
    }
    
    public mutating func insert(at index: Int, value: Value) {
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
    
    public mutating func pop() -> Value? {
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
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}
