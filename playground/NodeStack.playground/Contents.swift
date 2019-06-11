public class StackNode<T> {
    var value: T // 값
    var next: StackNode? // 다음 노드 ? 는 마지막인지 아닌지 구분하기 위해
    weak var previous: StackNode? // 이전 노드 weak인 이유는 이전노드가 해당 노드를 서로 weak가 아니게 가르키게 되면 강한참조가 일어나서 메모리가 누수된다.
    
    public init(value: T) {
        self.value = value
    }
}

public class Stack<T> {
    public typealias Node = StackNode<T>
    
    private var top: Node?
    
    public var first: Node? {
        return top
    }
    
    public var last: Node? {
        guard var node = top else {
            return nil
        }
        
        while let previous = node.previous {
            node = previous
        }
        return node
    }
    
    public var isEmpty: Bool {
        return top == nil
    }
    
    public func push(_ node: Node) {
        if isEmpty {
            top = node
        }
        print(top?.value)
        top?.next = node
        node.previous = top
        top = node
        print(top?.value)
    }
    
    public func pop() -> T?{ //항상 마지막것만
        guard let lastNode = last else {
            return nil
        }
        let item = lastNode.value
        lastNode.previous?.next = nil
        return item
    }
    
    public init() {}
    
    public var count: Int {
        guard var node = first else {
            return 0
        }
        
        var count = 1
        while let next = node.previous {
            node = next
            count += 1
        }
        return count
    }
    
}

let stack = Stack<Int>()
stack.isEmpty
stack.first
stack.push(StackNode.init(value: 7))
stack.push(StackNode.init(value: 8))
stack.push(StackNode.init(value: 9))
stack.push(StackNode.init(value: 10))

print(stack.count)

let item = stack.pop()
if let it = item {
    print(it)
} else {
    print("nil")
}

if let first = stack.first {
    print(first.value)
} else {
    print("nil")
}


