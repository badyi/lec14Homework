//
//  ViewController.swift
//  Lec14TableView
//
//  Created by badyi on 24.05.2021.
//

import UIKit

final class Spot {
    private(set) var name: String
    var visited: Bool
    
    init(_ name: String? = "",_ visited: Bool = false) {
        self.name = name!
        self.visited = visited
    }
}

final class ViewController: UIViewController {
    
    private var spots = ["Korriban", "Nabu", "Corusant", "Mandalor", "Mustafar"].map { Spot($0) }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.alwaysBounceVertical = true
        tv.register(SpotCell.self, forCellReuseIdentifier: SpotCell.id)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
}

extension ViewController {
    private func configView() {
        self.title = "First VC"
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func addTapped() {
        let alert = UIAlertController(title: "New Spot", message: "Enter name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Type here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] _ in
            guard let alert = alert else { return }
            let textField = alert.textFields![0]
            
            guard let text = textField.text else { return }
            self?.addNewSpot(with: text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewSpot(with name: String) {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if name != "" {
            spots.append(Spot(name))
            tableView.insertRows(at: [IndexPath(row: spots.count - 1, section: 0)], with: .left)
        }
    }
}


//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController(with: spots[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SpotCell.id, for: indexPath) as! SpotCell
        let spot = spots[indexPath.row]
        cell.config(with: spot)
        
        cell.didTouchUpInsideButton = { spotCell in
            spot.visited = !spot.visited
            spotCell.config(with: spot)
        }
        
        return cell
    }
}
