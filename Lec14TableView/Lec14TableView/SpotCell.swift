//
//  CustomCell.swift
//  Lec14TableView
//
//  Created by badyi on 24.05.2021.
//

import UIKit

final class SpotCell: UITableViewCell {
    static let id = "SpotCell"
    
    var didTouchUpInsideButton: ((SpotCell) -> ())?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return button
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        didTouchUpInsideButton = nil
        contentView.addSubview(label)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            label.trailingAnchor.constraint(equalTo: button.leadingAnchor)
        ])
        
    }
}

extension SpotCell {
    func config(with spot: Spot) {
        if spot.visited {
            contentView.backgroundColor = .magenta
            label.text = spot.name + " was Visited"
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            return
        }
        contentView.backgroundColor = .lightGray
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        label.text = spot.name
    }
    
    @objc func clicked() {
        if didTouchUpInsideButton != nil {
            didTouchUpInsideButton!(self)
        }
    }
}
