//
//  NewsTableViewCell.swift
//  new applet
//
//  Created by Pavel on 30.08.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabelCell: UILabel!
    @IBOutlet weak var newTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                   guard segue.identifier == "nameSeg" else { return }
                   guard let destination = segue.destination as? PageOfNewsViewController else { return }
                   destination.name = "dsgfh"
               }
        // Initialization code
    }

    func set (newsModel: Articles){
        self.headerLabelCell.text = newsModel.title
        self.newTextLabel.text = newsModel.content
        self.dateLabel.text = newsModel.publishedAt
        self.picLabel.load(url: newsModel.urlToImage)
    }

}
