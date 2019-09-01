//
//  NYMostPopularNewsCell.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 01/09/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit
import SDWebImage

class NYMostPopularNewsCell: UITableViewCell {
    
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsByLineLabel: UILabel!
    @IBOutlet weak var newsAbstractLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsImageView.layer.cornerRadius  = self.newsImageView.frame.height/2
        self.newsImageView.layer.masksToBounds  = true
    }
    
 
    func configureCell(data: jsonDict) {
        newsAbstractLabel.text  = data["abstract"] as? String ?? ""
        newsDateLabel.text  =    data["published_date"] as? String
        newsByLineLabel.text  =  data["byline"] as? String
        
        if let media = (data["media"] as? [jsonDict]), media.count > 0, let meta = media[0]["media-metadata"] as? [jsonDict] {
             newsImageView.sd_setImage(with: URL(string: meta[0]["url"] as? String ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}


