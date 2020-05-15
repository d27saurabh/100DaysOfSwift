import UIKit

var str = "Hello, playground"
var age = 38
var population = 8_000_000_000
var str2 = """
this is
multiple
line
string
"""
var str3 = """
this is \
multiple line \
string \
with formatting
"""

var str4 = "Your age is \(age)"
var str5 = "He said: \(str4)"
var str6 = """
I will quote his words: \
\(str5)
"""

let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

let saurabh = "Saurabh Deshpande"
let riya = "Riya Sinha"
let anju = "Anju Deshpande"
let sagar = "Sagar Doshi"

let arrayOfNames = [saurabh, riya, anju, sagar]
arrayOfNames[3]
arrayOfNames[0]

//Set
let colors = Set(["green", "red", "blue", "pink", "red"])

//Tuples
var tupleExample = (first: "Saurabh", last: "Deshpande")
tupleExample.0
tupleExample.1
tupleExample.first
tupleExample.last
tupleExample.0 = "riya"
tupleExample.first

//Dictonaries
let dictHeight = [
    "Saurabh": 6.1,
    "Riya": 5.8
]
dictHeight["Saurabh"]
dictHeight.values
dictHeight["sagar", default: 0.0]

//Creating Empty Collection
var teams = [Int]()
//or
var teamsFormat = Array<Int>()

var results = [String: String]()
results["history"] = "pravin"
results
//or
var resultsFormat = Dictionary<String, Int>()

var words = Set<String>()


//enum

enum Result{
    case success
    case failure
}

let reportForTest = Result.success
let reportForTest1 = Result.failure

//enum with associated values
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

let heIsTalkingAbout = talking

//enum raw value

enum Planet: Int {
    case mercury
    case venus
    case earth = 5
    case jupiter
}

let earthNumber = Planet(rawValue:5)

let fakers = "Fakers gonna"
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

var score = 95
score -= 5
var quote = "The rain in Spain falls mainly on the "
quote += "Spainards"

"Raylor" >= "Swifty"

"Saurabh" >= "Saurabi"

let firstCard = 10
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
//condition ? trueAction : falseAction

let weather = "sunny"
switch weather {
    case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap an warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
    case "windy":
    print("its windy")
default:
    print("Enjoy your day")
}

//The half-open range operator, ..<, creates ranges up to but excluding the final value, and the closed range operator, ..., creates ranges up to and including the final value.
//1..<5 = 1,2,3,4
//1...5 = 1,2,3,4,5

for _ in 1...5 {
    print("play")
}
let count = 1...10
for number in count {
    print("Number is \(number)")
}
//WHILE
var number1 = 1

while number1 <= 20 {
    print(number1)
    number1 += 1
}

print("Ready or not, here I come!")

//REPEAT
var number2 = 1

repeat {
    print(number2)
    number2 += 1
} while number2 <= 20

print("Ready or not, here I come!")

//existing loop
var countDown = 10
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}
//breaking multiple loops -
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
//continue - skips the further execution
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}

func writeToLog(message: String) -> Bool {
    if message != "" {
        print("Log: \(message)")
        return true
    } else {
        return false
    }
}

//default parameters
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet("Taylor")
greet("Taylor", nicely: false)

//variadic functions - accept any number of parameters
print("Haters", "gonna", "hate")
func squared(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
squared(numbers: 1, 2, 3, 4)
squared(numbers: 3, 4, 5)

//writing throwing functions
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
       throw PasswordError.obvious
    }
    return true
}

//running throwing functions
do {
    try checkPassword("password")
    print("good password to use")
} catch {
    print("You can't use that password")
}

//inout fucntion parameters
func doubleInPlace(number: inout Int) {
    number *= 2
}
var myNum = 10
doubleInPlace(number: &myNum)

//basic closures
let driving = { (place: String) -> String in
    return "I am driving in my car and going to \(place)"
}

let message = driving("London")
print(message)

//using closures as function parameters
let eating = {
    print("I am eating mangoes")
}
 
func dailyActivity(action: () -> Void) {
    print("We are doing something")
    action()
    print("next action awaited")
}
func dailyDoseOfInternet(area : String, news hotNews: () -> Void) {
     print("Internet presents")
    hotNews()
}

let OGHR = {
     print("og won against hell raisers 2-0")
}
 
dailyActivity(action: eating)

//trailing closures
dailyActivity {
    print("I am playing guitar")
}

dailyDoseOfInternet(area: "Gaming", news: OGHR)

dailyDoseOfInternet(area: "Gaming") {
    print("og won against hell raisers 2-0")
}

//using closure as parameters when they accept parameters and return


func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
     return "I'm going to \(place) in my car"
}

//shorthand parameter name
travel {
    "I'm going to \($0) in my car"
}

//example 2
func manipulate(numbers: [Int], using algorithm: (Int) -> Int) {
    for number in numbers {
        let result = algorithm(number)
        print("Manipulating \(number) produced \(result)")
    }
}
manipulate(numbers: [1, 2, 3]) { abc in
    return abc * abc
}

//example 3
func playSong(_ name: String, notes: () -> String) {
    print("I'm going to play \(name).")
    let playedNotes = notes()
    print(playedNotes)
}
playSong("Mary Had a Little Lamb") {
    return "EDCDEEEDDDEGG"
}

//closures with multiple parameter

func tournament(details: (String, Int) -> String) {
    let result = details("OG vs HR", 20)
    print(result)
}

tournament {
    return "Score for match \($0) is \($1) "
}

//returning closures from functions
func matchResult() -> (String) -> Void {
    var numOfMatch = 1
    return {
        print("\(numOfMatch) match result is \($0)")
        numOfMatch += 1
    }
}
 
let result = matchResult()
result("OG won")
result("OG won")
result("OG won")
let result2: Void = matchResult()("OG won")


//structs
struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    //computed properties. constants (let) cannot be computed properties. So always use var
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

//var tennis = Sport(name: "Tennis")
//print(tennis.name)
//tennis.name = "Lawn tennis"
//print(tennis.name)

let chessBoxing = Sport(name: "ChessBoxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//porperty observers
struct Game {
    
    //cannot use didset with let has to use var
    var score: Int {
        didSet {
            print("Your score is now \(score).")
        }
    }
}

//methods
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

//mutating methods
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

let cardGames = ["Poker", "Blackjack", "Whist"]
cardGames.firstIndex(of: "Whist")
cardGames.contains("whist")

//initializers
struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "Saurabh"
print(user.username)

//self reference
struct Conference {
    var name: String
    var location: String
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
let wwdc = Conference(name: "WWDC", location: "San Jose")

struct Cottage {
    var rooms: Int
    var rating = 5
    init(rooms: Int) {
        self.rooms = rooms
    }
}
let bailbrookHouse = Cottage(rooms: 4)

//lazy properties - for perfoemance optimizations
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
struct Person1 {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person1(name: "Ed")
ed.familyTree

//static

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
let ed1 = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)

//access - private
struct Person3 {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}
let ed2 = Person3(id: "12345")
// ed2.id - inaccessible due to private protection level
ed2.identify()

//class inheritance
//method overiding
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy = Poodle(name: "beetles")
poppy.makeNoise()
//final keyword - cannot inherit the final class
//protocol
protocol Washable {
    var dirtinessLevel: Int { get set }
}
protocol Climbable {
    var height: Double { get }
    var gradient: Int { get }
}

//only set is not allowed


//protocol inheritance
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
protocol Employee: Payable, NeedsTraining, HasVacation { }

//extention
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

extension String {
    var isLong: Bool {
        return count > 25
    }
}

//protocol extension
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles1 = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles1.summarize()

//protocol-oriented programming
protocol Identifiable {
    var id: String { get set }
    func identify()
}
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}
struct User1: Identifiable {
    var id: String
}

let twostraws = User1(id: "twostraws")
twostraws.identify()

protocol HasAge {
    var age: Int { get set }
    mutating func celebrateBirthday()
}


//optionals and unwrapping optional
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("missing name.")
}

func greet(name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("hello, \(unwrapped)")
}

var someoneName: String? = nil
greet(name: someoneName)

//forced unwrapping
let str27 = "5"
let num = Int(str27)!

//implicitly unwrapped optional
let age5: Int! = nil

//nil coalescing
var captain: String? = "Kathryn Janeway"
let name5 = captain ?? "Anonymous"

let distanceRan: Double? = 0.5
let distance: Double = distanceRan ?? 0

let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()

//optional chaining
let songs: [String]? = [String]()
let finalSong = songs?.last?.uppercased()

//optional try
//we have this code when we were talking aboput the throwing fucntions
//enum PasswordError: Error {
//    case obvious
//}
//
//func checkPassword(_ password: String) throws -> Bool {
//    if password == "password" {
//        throw PasswordError.obvious
//    }
//
//    return true
//}
//
//do {
//    try checkPassword("password")
//    print("That password is good!")
//} catch {
//    print("You can't use that password.")
//}

if let result = try? checkPassword("password") {
    print("result was \(result) ")
} else {
    print("D'oh.")
}

try! checkPassword("asdklf")
print("OK!")

struct Person67 {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
 var sadf = Bool("false")

//type caseting
 class Animal { }
 class Fish: Animal { }

 class Doggy: Animal {
     func makeNoise() {
         print("Woof!")
     }
 }
let pets = [Fish(), Doggy(), Fish(), Doggy()]

for pet in pets {
    if let dog = pet as? Doggy {
        dog.makeNoise()
    }
}


