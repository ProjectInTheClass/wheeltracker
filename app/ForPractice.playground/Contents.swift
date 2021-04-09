import UIKit

var str = "Hello, playground"

//과제


//구구단

let numbers = Array(arrayLiteral: 2, 3, 4, 5, 6, 7, 8, 9)
let numbers2 = Array(arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 8, 9)

for number in numbers {
    for number2 in numbers {
        let res = number * number2
        print (String(number) + " * " + String(number2) + " = " + String(res))
    }
}

// 별찍기(정사각형)

let n = 5
for _ in 1 ... n {
    for _ in 1 ... n{
        print("*", terminator:"")
    }
    print()
}

// 별찍기2(직각 삼각형), There are two versions

//ver 1.
let n2 = 5
for i in 1 ... n2 {
    for _ in 1 ... i{
        print("*", terminator:"")
    }
    print()
}

//ver 2.
var s = "*"
for _ in 1...5{
    print(s)
    s+="*"
}

// 별찍기3(정삼각형)

let n3 = 5
let m = (n3+1)*2-1
for i in 1...n3{
    let star = i*2-1
    for _ in 1 ... (m-star)/2{
        print(" ", terminator:"")
    }
    for _ in 1 ... star{
        print("*", terminator:"")
    }
    for _ in 1 ... (m-star)/2{
        print(" ", terminator:"")
    }
    print()
}


// 구간의 합

let start = 4
let end = 10
var sum = 0
for i in start ... end {
    sum += i
}
print(sum)

// 1부터 100까지 소수구하기

let n4 = 100
for i in 1 ... n4 {
    var is_prime = 0
    for  j in 1...i{
        if i%j==0{
            is_prime+=1
        }
    }
    if is_prime==2{
        print(i, " is prime number.", separator : "")
    }
}
