//
//  PictureViewController.swift
//  SnappyChat
//
//  Created by Thomas Carlson on 15/5/18.
//  Copyright © 2018 SurfMachina. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var descriptiontext: UITextField!
    
    @IBOutlet weak var nextbuttonoutlet: UIButton!
    
    var imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        nextbuttonoutlet.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageview.image = image
        imageview.backgroundColor = UIColor.clear
        imagepicker.dismiss(animated: true, completion: nil)
        nextbuttonoutlet.isEnabled = true
    }
    
    @IBAction func cameratapped(_ sender: Any) {
        imagepicker.sourceType = .savedPhotosAlbum
        imagepicker.allowsEditing = false
        present(imagepicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func usernexttapped(_ sender: Any) {
        
        nextbuttonoutlet.isEnabled = false
        let imagedata = UIImageJPEGRepresentation(imageview.image!,0.1)!
        
//        StorageReference.downloadURLWithCompletion()
        
        let imagesfolder = Storage.storage().reference().child("images")
//        let img_url : String = "nothing"
        let img_id = NSUUID()
        
        imagesfolder.child("\(img_id).png").putData(imagedata, metadata: nil, completion: {(metadata,error) in
            print("We tried to upload")
            if error != nil {
                print("we had an error \(error!)")
                
            } else {
                print("uploaded")
                imagesfolder.child("\(img_id).png").downloadURL(completion: { (url, error) in
                    print("we made it this far")
                    
                    if error != nil{
                        print(error!)
                        return
                    }
                    
                    if url != nil {                        
                        print(url!.absoluteString)
                    }
                    
                })

                
//                print("here is the url \(String(describing: img_url))")
                self.performSegue(withIdentifier: "selectusersegue", sender: nil)

            }
        })
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
