//
//  ViewController.swift
//  AssignmentUIKit
//
//  Created by Varun Bhati on 15/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let searchBar = UISearchBar()
    
    private var viewModel = ViewModel(fruits: [
        Fruit(title: "Apple", subTitle: "This is Apple subTitle", image: "Dummy_1"),
        Fruit(title: "Banana", subTitle: "This is Banana subTitle", image: "Dummy_2"),
        Fruit(title: "Orange", subTitle: "This is Orange subTitle", image: "Dummy_3"),
        Fruit(title: "Blueberry", subTitle: "This is Blueberry subTitle", image: "Dummy_4"),
        Fruit(title: "Mango", subTitle: "This is Mango subTitle", image: "Dummy_5"),
        Fruit(title: "Kiwi", subTitle: "This is Kiwi subTitle", image: "Dummy_1"),
        Fruit(title: "Papaya", subTitle: "This is Papaya subTitle", image: "Dummy_3"),
        Fruit(title: "PineApple", subTitle: "This is PineApple subTitle", image: "Dummy_4")
    ],
    caraousels: [
        Caraousel(imageName: "Dummy_1"),
        Caraousel(imageName: "Dummy_2"),
        Caraousel(imageName: "Dummy_3"),
        Caraousel(imageName: "Dummy_4"),
        Caraousel(imageName: "Dummy_5")
    ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CarouselTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CarouselTableViewCell")
        
        let contentNib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        tableView.register(contentNib, forCellReuseIdentifier: "ContentTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.reloadData()
    }
    
    @IBAction func floatingTapped(_ sender: UIButton) {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.statsText = viewModel.getTopCharacters()
            
            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            present(bottomSheetVC, animated: true, completion: nil)

    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath, tableViewHeight: tableView.frame.height)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }

        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: containerView.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselTableViewCell", for: indexPath) as? CarouselTableViewCell else {
                return UITableViewCell()
            }
            cell.caraousels = viewModel.caraousels
            cell.setPageControls()
            cell.collectionView.reloadData()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as? ContentTableViewCell else {
                return UITableViewCell()
            }
            cell.topConstraint.constant = indexPath.row == 0 ? 20 : 0
            let fruit = viewModel.filtereFruits[indexPath.row]
            cell.titleLabel.text = fruit.title
            cell.subTitleLabel.text = fruit.subTitle
            cell.fruitImage.image = UIImage(named: fruit.image)
            return cell
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.setFruits(searchText)
        self.tableView.reloadData()
    }
}
