import SwiftUI


/// Finds the closest number to the target using an equation from the provided numbers and basic operations (+-*/)
/// - Parameters:
///   - target: The target number
///   - numbers: The array of numbers to use in the equation
/// - Returns: the expression and result that was the closest to the target
func findClosestResult(target: Int, numbers: [Int]) -> (expression: String, result: String)? {
    var closestResult: Double = 0.0
    var closestExpression = ""
    
    /// Tests each possible expression and sees if it is closer to the target number
    /// - Parameters:
    ///   - index: the index of the current expression being tested
    ///   - currentResult: the result of the current equation being tested
    ///   - expression: the current expression being built and tested
    ///   - used: the numbers that  have been used in the current expression
    ///   - currentExpression: the subexpression that is being built from the current number
    func testExpressions(index: Int, currentResult: Double, expression: String, used: Set<Int>, currentExpression: String) {
        // Test if the result is the closest to the target
        if index == numbers.count {
            let difference = abs(Double(target) - currentResult)
            if difference < abs(Double(target) - closestResult) {
                closestExpression = expression
                closestResult = currentResult

            }
            return
        }
        
        // Test all the possible permutations of the unused numbers
        for i in 0..<numbers.count {
            if !used.contains(i) {
                let currentNumber = Double(numbers[i])
                let nextExpression = currentExpression.isEmpty ? "\(numbers[i])" : currentExpression + " \(numbers[i])"
                
                
                if expression.isEmpty {
                    testExpressions(index: index + 1, currentResult: currentNumber, expression: "\(currentNumber)", used: used.union([i]), currentExpression: "")
                } else {
                    testExpressions(index: index + 1, currentResult: currentResult + currentNumber, expression: "\(expression) + \(nextExpression)", used: used.union([i]), currentExpression: "")
                    testExpressions(index: index + 1, currentResult: currentResult - currentNumber, expression: "\(expression) - \(nextExpression)", used: used.union([i]), currentExpression: "")
                    testExpressions(index: index + 1, currentResult: currentResult * currentNumber, expression: "\(expression) * \(nextExpression)", used: used.union([i]), currentExpression: "")
                    testExpressions(index: index + 1, currentResult: currentResult / currentNumber, expression: "\(expression) / \(nextExpression)", used: used.union([i]), currentExpression: "")
                }
            }
        }
    }

    testExpressions(index: 0, currentResult: 0, expression: "", used: Set(), currentExpression: "")
    
    return (closestExpression, String(closestResult))
}


/// Evaluates a mathematical expression
/// - Parameter expression: an expression that contains numbers and basic operators in the form of a string
/// - Returns: an optional string that contains the result or error message
func evaluateExpression(expression: String) -> String {
    var expression = expression
    expression = expression.replacingOccurrences(of: "×", with: "*")
    expression = expression.replacingOccurrences(of: "÷", with: "/")
    expression = expression.replacingOccurrences(of: "−", with: "-")
    
    
    let allowedCharacters = CharacterSet(charactersIn: "0123456789+-*/(). ")
    // Checks if any of the characters in the expression are not allowed
    if expression.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
        print("Invalid characters in expression '\(expression)'")
        return " "
    }
    
    // Checks if the expression is empty
    if expression.isEmpty || expression == " " {
        print("Empty expression")
        return " "
    }
    
    if expression.starts(with: /[\+\-\*\/]/) {
        print("Syntax error in expression '\(expression)")
        return " "
    }
    
    // Checks if the number of open '(' and close ')' parentheses are equal
    if expression.numberOf(string: "(") != expression.numberOf(string: ")") {
        print("Missing parentheses in expression '\(expression)'")
        return " "
    }
    
    // Checks if the expression ends with more than one operator and removes the last operator
    if expression.firstMatch(of: /[^\)\(0-9]$/) != nil {
        expression.removeLast()
        if expression.firstMatch(of: /[^\)0-9]$/) != nil {
            print("Syntax error in expression '\(expression)'")
            return " "
        }
    }
    
    
    if let matchedIndex = expression.firstIndex(where: {$0 == "("}) {
        if matchedIndex != expression.startIndex {
            let precedingIndex = expression.index(before: matchedIndex)
            if expression[precedingIndex].isNumber {
                print("Replacing '(' with '*(' in expression '\(expression)'")
                expression = expression.replacingCharacters(in: matchedIndex..<expression.index(after: matchedIndex), with: "*(")
            }
        }
    }
    
    if let matchedIndex = expression.firstIndex(where: {$0 == ")"}) {
        if matchedIndex != expression.index(before: expression.endIndex) {
            let followingIndex = expression.index(after: matchedIndex)
            if expression[followingIndex].isNumber {
                print("Replacing ')' with ')* in expression '\(expression)'")
                expression = expression.replacingCharacters(in: matchedIndex..<expression.index(after: matchedIndex), with: ")*")
            }
        }
    }
    
    // Checks if parentheses contain invalid expressions
    if expression.firstMatch(of: /\([\D]\)|\(\)/) != nil {
        print("Syntax error in expression '\(expression)'")
        return " "
    }
    
    // Checks if there are consecutive operators in the expression
    if expression.firstMatch(of: /[+*-\/]{2,}/) != nil {
        print("Consecutive operators in expression '\(expression)'")
        return " "
    }
    
    
    expression = expression.replacingOccurrences(of: "([\\+\\-\\/\\*\\(\\)])", with: " $1 ", options: .regularExpression)
    expression = expression.replacingOccurrences(of: "[\\ ()](\\d+)", with: " $1.0", options: .regularExpression)

    let exp = NSExpression(format: expression)
    
    // Calculates the expression
    
    if let result = exp.expressionValue(with: nil, context: nil) as? Double {
        print(String(format: "%.5f", result))
        let resultFormat = NumberFormatter()
        resultFormat.minimumFractionDigits = 0
        resultFormat.maximumFractionDigits = 2
        resultFormat.roundingMode = .halfUp
        
        return resultFormat.string(from: NSNumber(floatLiteral: result)) ?? " "
    } else {
        print("Failed to evaluate expression '\(expression)'")
        return " "
    }
}




/// Generates a random target number
/// - Returns: the target number generated
func generateTarget() -> Int {
    let targetNumber = Int.random(in: 200...999)
    return targetNumber
}


/// Generates an array of random numbers
/// - Returns: the array of numbers generated
func generateNumbers() -> [Int] {
    var numbers: [Int] = []
    
    // Generate random numbers using .shuffle() to avoid repeats
    let bigNumbers = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
    let smallNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    numbers.append(contentsOf: bigNumbers.shuffled().suffix(from: 16))
    numbers.append(contentsOf: smallNumbers.shuffled().suffix(from: 6))
    return numbers
}

func newGame(globalVar: GlobalVar) -> (target: Int, numbers: [Int]) {
    

    let target = generateTarget()
    let numbers = generateNumbers()
    
    let _ = print("Target Number: \(target)")
    let _ = print("Numbers: \(numbers)")
    
    // Find and print the closest result
    if let (expression, result) = findClosestResult(target: target, numbers: numbers) {
        let _ = print("Closest Expression: \(expression)")
        let _ = print("Closest Result: \(result)")
        
        if String(result).trimmingCharacters(in: ["0", "."]) == String(target) {
            print("Match Found - starting game")
            return (target, numbers)
        } else {
            print("Match not found - Searching again")
            return newGame(globalVar: globalVar)
        }
    } else {
        let _ = print("No valid expression found.")
    }
    
    // Reset values
    globalVar.resultLog = [""]
    globalVar.countdown = 60
    globalVar.enteredExpression = ""
    globalVar.score = 0
    
    return (404, [44, 44, 4, 4, 4])
}


func calculateScore(target: String, result: String, globalVar: GlobalVar) -> Int {
    /* Scoring:
     Distance  |  Points
     0            2500
     0   < 10     1250
     10  < 50     750
     50  < 100    500
     100 < 200    250
     200 < 300    100
     300 < 400    75
     400 < 500    50
     500 < ∞      25
     */
    print(globalVar.resultLog)
    
    
    guard !globalVar.resultLog.contains(result) else {
        return 0
    }
    
    globalVar.resultLog.append(result)
    
    let distance = abs((Double(target) ?? 0.0) - (Double(result) ?? 0.0))
    
    if distance > 500 {
        return 25
    }
 
    if distance > 400 {
        return 75
    }
    
    if distance > 300 {
        return 50
    }
    
    if distance > 200 {
        return 100
    }
    
    if distance > 100 {
        return 250
    }
    
    if distance > 50 {
        return 500
    }
    if distance > 10 {
        return 750
    }
    if distance > 0 {
        return 1250
    }
    if distance == 0 {
        return 2500
    }
    
    return 0
}


extension Array {
    
    /// Calculates all the possible permutations from an array of numbers
    /// - Returns: an array of possible permutations
    func permutations() -> [[Element]] {
        guard count > 0 else { return [[]] }
        
        var result: [[Element]] = []
        for i in 0..<count {
            var elements = self
            let element = elements.remove(at: i)
            
            let subPermutations = elements.permutations()
            for subPermutation in subPermutations {
                result.append([element] + subPermutation)
            }
        }
        
        return result
    }
}


extension String {
    
    /// Allows '.contains' to match an array of strings
    /// - Parameter filters: The array of strings to match against
    /// - Returns: Whether the string matches any in the array
    func contains(_ filters: [String]) -> Bool {
        filters.contains { contains($0) }
    }
    
    
    /// Counts the number of times a sub-string appears in a string
    /// - Parameter string: the sub-string to look for
    /// - Returns: the number of times the sub-string appears in the string
    func numberOf(string: String) -> Int {
        return self.components(separatedBy: string).count - 1
    }
}

