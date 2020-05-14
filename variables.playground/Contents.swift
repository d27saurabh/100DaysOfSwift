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
