//
//  WebService.swift
//  OverlokFilm
//
//  Created by hyasar on 11.09.2022.
//

import Foundation
import Firebase
import SDWebImage

class WebService {
    
    var post = Post()
    var postList = [Post]()
    
    func downloadData(completion: @escaping ([Post]) -> Void ){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            
            if error != nil {
                
                print(error?.localizedDescription ?? "error")
                
            }else {
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    DispatchQueue.global().async {
                        
                        for document in snapshot!.documents {
                            
                            if let postedBy = document.get("postedBy") as? String {
                                self.post.postedBy = postedBy
                            }
                            
                            if let postMovieName = document.get("postMovieName") as? String {
                                self.post.postMovieName = postMovieName
                            }
                            
                            if let postMovieYear = document.get("postMovieYear") as? String {
                                self.post.postMovieYear = postMovieYear
                            }
                            
                            if let postMovieDirector = document.get("postDirector") as? String {
                                self.post.postMovieDirector = postMovieDirector
                            }
                            
                            if let postMovieComment = document.get("postComment") as? String {
                                self.post.postMovieComment = postMovieComment
                            }
                            
                            if let postDate = document.get("date") as? String {
                                self.post.postDate = postDate
                            }
                            
                            self.postList.append(self.post)
                            
                        }
                        completion(self.postList)
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
}
