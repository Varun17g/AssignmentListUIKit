//
//  BottomSheetViewController.swift
//  AssignmentUIKit
//
//  Created by Varun Bhati on 16/04/25.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    private let statsLabel = UILabel()

    var statsText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        
        statsLabel.numberOfLines = 0
        statsLabel.textAlignment = .center
        statsLabel.text = statsText ?? "No data"
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statsLabel)
        
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            statsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

