//
//  main.swift
//  BasicSwift
//
//  Created by Chí Thành on 5/8/24.
//

import Foundation

print("1.1.Check positive & negative number")
print("Input n: ", terminator: "")
if let n = Int(readLine()!) {
    if n > 0 {
        print("\(n) is positive number")
    } else {
        print("\(n) is negative number")
    }
} else {
    print("Correct your input")
}

print("1.2.Check odd and even number")
print("Input n: ", terminator: "")
if let n = Int(readLine()!) {
    if n % 2 == 0 {
        print("\(n) is even number")
    } else {
        print("\(n) is odd number")
    }
} else {
    print("Correct your input")
}

print("1.3. Check divided by 5 number")
print("Input n: ", terminator: "")
if let n = Int(readLine()!) {
    if n % 5 == 0 {
        print("\(n) is divided by 5")
    } else {
        print("\(n) is not divided by 5")
    }
} else {
    print("Correct your input")
}

print("1.4. Check prime number")
print("Input n: ", terminator: "")
if let n = Int(readLine()!) {
    if n <= 1 {
        print("\(n) is not a prime number")
    } else {
        var isPrime = true
        for i in 2..<n {
            if n % i == 0 {
                isPrime = false
                break
            }
        }
        if isPrime {
            print("\(n) is a prime number")
        } else {
            print("\(n) is not a prime number")
        }
    }
} else {
    print("Correct your input")
}

print("2.1.Check triangle")
print("Enter a: ", terminator: "")
let a = Double(readLine()!)!

print("Enter b: ", terminator: "")
let b = Double(readLine()!)!

print("Enter c: ", terminator: "")
let c = Double(readLine()!)!

func isTriangle(a: Double, b: Double, c: Double) -> Bool {
    return (a + b > c) && (a + c > b) && (b + c > a)
}

func triangleArea(a: Double, b: Double, c: Double) -> Double {
    let s = (a + b + c) / 2
    return sqrt(s * (s - a) * (s - b) * (s - c))
}

if isTriangle(a: a, b: b, c: c) {
    let area = triangleArea(a: a, b: b, c: c)
    print("Is a triagnle")
    print("Caculate area: \(area)")
} else {
    print("Is not a triangle.")
}

print("3.1.Check year nhuan")
print("Enter a year: ", terminator: "")
if let year = Int(readLine()!) {
    if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) {
        print("\(year) is a nhuan year")
    } else {
        print("\(year) is not a nhuan year")
    }
} else {
    print("Correct your input")
}

print("4.1.Find smallest n factorial")
print("Enter a number m: ", terminator: "")
if let m = Int(readLine()!) {
    var n = 1
    var factorial = 1

    while factorial <= m {
        n += 1
        factorial *= n
    }

    print("The smallest n such that n! > \(m) is \(n)")
} else {
    print("Correct your input")
}
