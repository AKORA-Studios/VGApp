//
//  ShppinglistCell.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import UIKit

class ItemsCell: UITableViewCell {
    static let identifier = "ItemsCell"
    var itemBase: Item?
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .systemOrange
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(itemLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width-20, height: contentView.frame.size.height)
        
        itemLabel.frame = CGRect(x: -15, y: 0, width: contentView.frame.size.width-30, height: contentView.frame.size.height)
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        itemLabel.text = nil
    }
    
    public func configure(with model: ItemOption){
        label.text =  model.title.count > 23 ? String(model.title.prefix(21)) + "..." : model.title
        itemLabel.text = model.subtitle.count != 0 ? model.subtitle : ""
        
        self.selectionStyle = .none
        self.accessoryType = .none
        self.itemBase = model.item
    }
}
