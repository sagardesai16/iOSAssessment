//
//  NYMostPopularNewsViewController.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit

class NYMostPopularNewsViewController: UIViewController {

    @IBOutlet weak var mostPopularNewsTableview: UITableView!
    var news: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NY Times Most Popular"
        
        NYAPIUtility.apiRequest(requestType: .mostPopuplarNews, apiData: [:], progessViewTitle: "Fetching..",paramsForUrl: "7", queryParams: [:] ) { (success, response, statusCode) in
            if success {
                if let results = response?["results"] as? [jsonDict], results.count > 0 {
                    self.news = results
                    self.mostPopularNewsTableview.reloadData()
                    
                }
            } else {
                if let status = response?["status"] as? String, status == "ERROR" {
                     UIAlertController.showAlert(titleString: "Error", messageString: "Something went wrong, please try again later")
                }
               
            }
        }
        
    }


}

extension NYMostPopularNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier:"NYMostPopularNewsCell", for: indexPath) as? NYMostPopularNewsCell{
            cell.configureCell(data: self.news[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
extension NYMostPopularNewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NYNewsDetailViewController") as! NYNewsDetailViewController
        newsDetailVC.news = self.news[indexPath.row]
        
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    
    }
}

