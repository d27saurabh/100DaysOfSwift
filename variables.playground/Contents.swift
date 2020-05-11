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

