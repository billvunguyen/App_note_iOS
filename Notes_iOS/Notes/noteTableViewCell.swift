//
//  noteTableViewCell.swift
//  Notes
//
//  Created by Bill on 11/18/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTimeTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Styles
        shadowView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.cornerRadius = 2
        
        noteImageView.layer.cornerRadius = 2
        
        noteTimeTotal.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(note: Note) {
        
        self.noteNameLabel.text = note.noteName?.uppercased()
        self.noteDescriptionLabel.text = note.noteDescription
        self.noteTimeTotal.text = "Total Time " + String(format: "%.1f" ,note.noteTotalTime)
        self.noteImageView.image = UIImage(data: note.noteImage! as Data)
        
    }

}
