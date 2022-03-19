//
//  MenuCell.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import UIKit

class MenuCell: UITableViewCell {
    private var id = 0
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with item: MenuItem) {
        id = item.id
        titleLabel.text = item.name
        setupColor(name: item.name)
    }
}

// MARK: Private
private extension MenuCell{
    func setupView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        selectionStyle = .none
        backgroundColor = UIColor(named: "transparent")
        
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18)
        ])
    }
    
    func setupColor(name: String) {
        if name == "Wyloguj" {
            titleLabel.textColor = UIColor(named: "failure")
        } else {
            titleLabel.textColor = UIColor(named: "darkGray")
        }
    }
}
