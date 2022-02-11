//
//  DeleteCell.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import UIKit

class DeleteCell: UITableViewCell {
    static let identifier = "DeleteCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .systemRed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width-20, height: contentView.frame.size.height)
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    public func configure(with model: DeleteOption){
        label.text =  "Alle löschen"
        
        self.selectionStyle = .none
        self.accessoryType = .none
    }
}
