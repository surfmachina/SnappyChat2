//
//  PictureViewController.swift
//  SnappyChat
//
//  Created by Thomas Carlson on 15/5/18.
//  Copyright © 2018 SurfMachina. All rights reserved.
//

import UIKit
import FirebaseStorage

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
        
        
        
        let imagesfolder = Storage.storage().reference().child("images")
        let img_url : String = "nothing"
        
        imagesfolder.child("\(NSUUID()).png").putData(imagedata, metadata: nil, completion: {(img_metadata,error) in
            print("We tried to upload")
            if error != nil {
                print("we had an error \(error!)")
                
            } else {
                
                self.performSegue(withIdentifier: "selectusersegue", sender: nil)
                
                img_metadata?.storageReference?.downloadURL(completion: { (img_url, error) in
                    print("******")
                })
                
                print("here is the url \(String(describing: img_url))")
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
