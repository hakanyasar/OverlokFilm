//
//  UploadViewController.swift
//  OverlokFilm
//
//  Created by hyasar on 11.09.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieNameText: UITextField!
    @IBOutlet weak var movieYearText: UITextField!
    @IBOutlet weak var directorText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // in here, we activate clickable feature on image
        imageView.isUserInteractionEnabled = true
        
        // and here, we describe gesture recognizer for upload with click on image
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    

    @objc func chooseImage(){
        
        // we describe picker controller stuff for reach to user gallery
        let pickerController = UIImagePickerController()
        // we assign self to picker controller delegate so we can call some methods that we will use
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    // here is about what is gonna happen after choose image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        
        // after we create our folder, now we have to cast our UIImage to data because we can't save images to firebase storage as UIImage you know
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            // now we can save this data to storage anymore
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            // database
                            
                            let firestoreDb = Firestore.firestore()
                            var firestoreRef : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postMovieName" : self.movieNameText.text!, "postMovieYear" : self.movieYearText.text!, "postDirector" : self.directorText.text!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreRef = firestoreDb.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                
                                if error != nil{
                                    
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                                
                                }else{
                                    
                                    // we are giving back default values to views that in upload page
                                    self.imageView.image = UIImage(named: "pluss.png")
                                    self.movieNameText.text = ""
                                    self.movieYearText.text = ""
                                    self.directorText.text = ""
                                    self.commentText.text = ""
                                    
                                    // we actually doing performsegue in here
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
                
            }
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
   

}
