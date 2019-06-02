// 1. 프로퍼티

// 1.1 저장 프로퍼티
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 범위 값은 0, 1, 2 입니다.
rangeOfThreeItems.firstValue = 6
// 범위 값은 6, 7, 8 입니다.
// 구조체를 let으로 선언한 경우 값 전달 방식으로 인해 내부 프로퍼티들을 수정할 수 없다.
// 그에 반해 클래스의 인스턴스는 참조 타입이므로 변경이 가능. let class의 var 는 수정 가능

// 1.2 지연 프로퍼티
class DataImporter {
    /*
     DataImporter는 외부 파일에서 데이터를 가져오는 클래스입니다.
     이 클래스는 초기화 하는데 매우 많은 시간이 소요된다고 가정하겠습니다.
     */
    var filename = "data.txt"
    // 데이터를 가져오는 기능의 구현이 이 부분에 구현돼 있다고 가정
}

class DataManager {
    lazy var importer = DataImporter() // 지연프로퍼티는 var로 선언해야한다.
    var data = [String]()
    // 데이터를 관리하는 기능이 이 부분에 구현돼 있다고 가정
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 인스턴스는 이 시점에 생성돼 있지 않습니다.
print(manager.importer.filename)
// DataImporter 에 접근을 시도하여 인스턴스가 생성됨

// 1.3 계산된 프로퍼티
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// "square.origin is now at (10.0, 10.0)" 출력

// 1.4 프로퍼티 옵저버 : 프로퍼티의 값이 변경될 때 일어날 이벤트를 지정하는 방식
// willSet : 값이 저장되기 바로 직전 (newValue) 를 기본인자로 사용
// didSet : 새 값이 저장되고난 바로 직후 (oldValue) 를 기본인자로 사용
//
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

//  $ 전역 변수들은 자동으로 지연변수로 설정되어 사용될때 할당된다.

// 오버라이드 : class 형으로 선언된 변수나 함수는 상속받은 자식 클래스에서 재정의할 수 있다. // final 오버라이드 방지자
// 오버로딩 : 같은 함수가 매개변수 타입에 따라 다르게 동작하는 함수를 복수개 작성하는 것

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 { // 일정 한계값을 넘지않도록하는 변수 설정하는 방식
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

// 2. 매소드
// 2.1 구조체안에서 매소드를 활용한 프로퍼티 값 변경
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point1(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// "The point is now at (3.0, 4.0)" 출력

// 2.2 class / static 타입 매소드
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// "highest unlocked level is now 2" 출력

// 3. subscripts 콜렉션 타입의 리턴을 편리하게 할 수 있도록하는 문법

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var mat = Matrix(rows: 4, columns: 5)
mat[2,4] = 7
print(mat)

// 4. 상속
// 4.1 상속 유의점
// get/set이 있는 변수를 get만 가능하게 오버라이딩 불가하다. (반대는 가능)

// 5. 초기화
// 5.1 초기화 유의점
// - init 위임 동작 구분 : 값타입(구조체,열겨헝)은 상속이 불가하여 값타입으로 자기자신의 init을 또 다른 자신의 init에서만 사용가능 / 참조 타입은 상속이 가능하여 부모의 초기화 함수를 자식에서 호출할 수 있음
// - convenience 특수 초기자? 는 결국 지정초기자를 호출해야한다.
// - 지정초기자는 값들을 초기화하는 과정에서 할당을 하기전에 superclass의 초기화들을 호출하여 초기화를 해야하며 할당의 과정은 최상위 부터 돌아서 내려온다.

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        print("init here2")
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        print("init here1")
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        print("init here")
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

let item1 = ShoppingListItem()
print(item1.description)
//ShoppingListItem 클래스는 새로 생성한 모든 프로퍼티에 대해 기본 값을 제공하고 새로운 초기자를 정의하지 않았기 때문에 자동으로 수퍼클래스의 모든 지정초기자와 편리한 초기자를 상속 받습니다.

// 규칙1 서브클래스가 지정초기자를 정의하지 않으면 자동으로 수퍼클래스의 모든 지정초기자를 상속합니다. 규칙2 서브클래스가 수퍼클래스의 지정초기자를 모두 구현한 경우(규칙 1의 경우 혹은 모든 지정초기자를 구현한 경우) 자동으로 수퍼클래스의 편리한 초기자를 추가합니다
