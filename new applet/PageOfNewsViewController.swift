//
//  PageOfNewsViewController.swift
//  new applet
//
//  Created by Pavel on 14.09.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class PageOfNewsViewController: UIViewController {
    
    var name = ""

    @IBOutlet weak var headerTF: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var newsTF: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = name
    }
    
    func set (newsModel: Articles){
        self.headerTF.text = newsModel.title
        self.newsTF.text = newsModel.content
        self.imageField.load(url: newsModel.urlToImage)
    }
}
