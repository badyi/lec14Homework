//
//  NewViewController.swift
//  Lec14TableView
//
//  Created by badyi on 24.05.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var spot: Spot
    
    init(with spot: Spot) {
        self.spot = spot
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
}

extension SecondViewController {
    private func configView() {
        view.addSubview(label)
        label.text = spot.name
        self.title = "Second VC"
        NSLayoutConstraint.activate([ label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        if spot.visited {
            view.backgroundColor = .magenta
            return
        }
        view.backgroundColor = .systemTeal
    }
}
