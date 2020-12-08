import Foundation

struct CustomDeclarationForm {
    var answers: Set<Character>
    
    init(_ data: String) {
        let characters = data.map { $0 }
        self.answers = Set(characters)
    }
}

struct CustomDeclarationFormsGroup {
    var forms: [CustomDeclarationForm]
    
    init(_ data: [String]) {
        self.forms = data.map { CustomDeclarationForm($0) }
    }
    
    var answered: Set<Character> {
        Set(forms.flatMap { $0.answers })
    }
    
    var allAnswered: Set<Character> {
        var allAnswered = answered
        forms.forEach { allAnswered = allAnswered.intersection($0.answers) }
        return allAnswered
    }
}

struct CustomDeclarationFormsGroups {
    var groups: [CustomDeclarationFormsGroup]
    
    init(_ data: [String]) {
        let separated = data.map { $0.split(separator: " ").map { String($0) } }
        self.groups = separated.map { CustomDeclarationFormsGroup($0) }
    }
    
    var answersCount: Int {
        groups.map { $0.answered }.map { $0.count }.reduce(0, +)
    }
    
    var allAnswersCount: Int {
        groups.map { $0.allAnswered }.map { $0.count }.reduce(0, +)
    }
}
