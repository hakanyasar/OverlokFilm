//
//  FeedViewController.swift
//  OverlokFilm
//
//  Created by hyasar on 11.09.2022.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var webService = WebService()
    var postListTemp = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        webService.downloadData { postList in
            
            self.postListTemp = postList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postListTemp.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfFeed", for: indexPath) as! FeedCell
        
        print("indexpath row = " + "\(indexPath.row)")
        cell.movieNameLabel.text = "\(postListTemp[indexPath.row].postMovieName)" + " (\(postListTemp[indexPath.row].postMovieYear))"
        cell.directorNameLabel.text = postListTemp[indexPath.row].postMovieDirector
        cell.commentLabel.text = postListTemp[indexPath.row].postMovieComment
        cell.dateLabel.text = postListTemp[indexPath.row].postDate
        
        return cell
    }
    
    
}


