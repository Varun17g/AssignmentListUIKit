//
//  ViewModel.swift
//  AssignmentUIKit
//
//  Created by Varun Bhati on 16/04/25.
//
import Foundation
import UIKit

class ViewModel {
    
    var fruits: [Fruit]
    var caraousels: [Caraousel]
    var filtereFruits = [Fruit]()
    
    init(fruits: [Fruit] = [], caraousels: [Caraousel] = []) {
        self.fruits = fruits
        self.caraousels = caraousels
        self.filtereFruits = self.fruits
    }
    
    var sections: Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        return section == 0 ? 1 : self.filtereFruits.count
    }
    
    func heightForRow(at indexPath: IndexPath, tableViewHeight: CGFloat) -> CGFloat {
        return indexPath.section == 0 ? tableViewHeight / 4 : UITableView.automaticDimension
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        return section == 0 ? CGFloat.leastNonzeroMagnitude : 44
    }
    
    func setFruits(_ enteredText: String) {
        if enteredText.isEmpty {
            self.filtereFruits = fruits
        } else {
            print(enteredText.lowercased())
            self.filtereFruits = fruits.filter { $0.title.lowercased().contains(enteredText.lowercased()) }
        }
    }
    
    func getTopCharacters() -> String {
        let allTitles = filtereFruits.map { $0.title.lowercased() }.joined()
        
        let frequency = allTitles.reduce(into: [Character: Int]()) { counts, char in
            guard char.isLetter else { return }
            counts[char, default: 0] += 1
        }
        
        let sorted = frequency.sorted { $0.value > $1.value }.prefix(3)
        
        var result = "Fruits count \(filtereFruits.count) items\n"
        for (char, count) in sorted {
            result += "\(char) = \(count)\n"
        }
        
        return result
    }

}
