//
//  NYNewsDetailViewController.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 01/09/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit
import SDWebImage

class NYNewsDetailViewController: UIViewController {

    var news:jsonDict = [:]
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAbstract: UILabel!
    
    @IBOutlet weak var keywords: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
    }
    
    func setUpData() -> Void {
        self.newImageView.layer.cornerRadius  = self.newImageView.frame.height/2
        self.newImageView.layer.masksToBounds  = true
        
        self.newsTitle.text  = news["title"] as? String ?? ""
        self.newsAbstract.text  =    news["abstract"] as? String
        self.keywords.text  =    news["adx_keywords"] as? String
        
        if let media = (news["media"] as? [jsonDict]), media.count > 0, let meta = media[0]["media-metadata"] as? [jsonDict] {
            self.newImageView.sd_setImage(with: URL(string: meta[0]["url"] as? String ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }


}
