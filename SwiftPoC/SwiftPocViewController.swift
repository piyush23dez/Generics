

import UIKit

class SwiftPocViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var someContainer = Stack<String>()
        someContainer.append(item: "Piyush")
        someContainer.append(item: "Abhas")
        someContainer.append(item: "Mohit")

        var otherContainer = Stack<String>()
        otherContainer.append(item: "Piyush")
        otherContainer.append(item: "Abhas")
        otherContainer.append(item: "Amrit")
        
        let stack = Stack<String>()
        let match = stack.allMatches(someContainer: someContainer, otherContainer: otherContainer)
        print(match)
        
        let index = someContainer.findIndex(valueTofind: "Abhas", items: someContainer.items)
        print(index!)
    }
}

//Example 1


//protocol with generic associated type
protocol Container {
    
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(index: Int) -> ItemType { get }
}

//Generic struct
struct Stack<T>: Container {
    
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(item: T) {
        self.push(item: item)
    }
    
    var count: Int {
        return  items.count
    }
    
    subscript (index: Int) -> T {
        return items[index]
    }

    //To compare generic values, we have to use Equatable protocol
    func findIndex<T: Equatable> (valueTofind: T, items: [T]) -> Int? {
        
        for (index,value) in items.enumerated() {
            if value == valueTofind {
                return index
            }
        }
        return nil
    }
    
    //To compare numeric values, we have to conform to Comparable protocol
    func getMin<T: Comparable>(x: T, y: T) -> T {
        return y < x ? y : x
    }

    //To increment any type of number, we have to conform to strideable protocol
    func increment<T: Strideable>(number: T) -> T {
        return number + 1
    }
    
    //Function conforms to container protocol, and accept only those values matches
    func allMatches<C1: Container, C2: Container> (someContainer: C1, otherContainer: C2) -> Bool
        where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
            
            if someContainer.count != otherContainer.count {
                return false
            }
            
            for i in 0..<someContainer.count {
                if someContainer[i] != otherContainer[i] {
                    return false
                }
            }
            return true
    }
}


//Example 2

class Car {}
class TV {}
class Phone {}

enum BirthdayPresent<T> {
    case NotPurchased
    case Purchased(presentType: T)
}

class Shop {
    
    var mohitBirthdayPresent = BirthdayPresent<Car>.NotPurchased
    var abhasBirthdayPresent = BirthdayPresent<Phone>.NotPurchased
    
    func updateBirthdayPresent() {
        abhasBirthdayPresent = .Purchased(presentType: Phone())
        mohitBirthdayPresent = .Purchased(presentType: Car())
    }
}




//Example 3

//Functions as arguments
class SwiftDemo {
    
    func divisibleByTwo(number: Int) -> Bool {
        return number % 2 == 0
    }
    
    //Generic function to filter any type of array
    func filterElements<Element>(elements: [Element], _ includedElement: (Element) -> Bool) -> [Element]? {
        var result = [Element]()
        
        for element in elements {
            if includedElement(element) {
                result.append(element)
            }
        }
        return result
    }
    
    func test() {
    
        let inlineClosureInts = filterElements(elements: [2,3,4,5,6]) { $0 % 2 == 0 }
        //or
        let genericResultForInts = filterElements(elements: [1,2,4,5,6], divisibleByTwo)
        
        let genericResultForString = filterElements(elements: ["Hi","Hello"]) { $0.characters.count < 5 }
        //or
        let inlineClosureString = filterElements(elements: ["Hi","Hello"]) { element in element.characters.count < 5  }

        print(genericResultForInts,inlineClosureInts,genericResultForString,inlineClosureString)
        
    }
}






