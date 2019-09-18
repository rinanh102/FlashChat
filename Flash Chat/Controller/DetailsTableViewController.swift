//
//  DetailsTableViewController.swift
//
//  Created by henry on 07/09/2019.
//

import UIKit
import Firebase

class DetailsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            
            let alert = UIAlertController(title: "Are you sure?", message: "Logging out!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (Alert) in
                //TODO: Log out the user and send them back to WelcomeViewController
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }catch{
                    
                }
            }))
            present(alert,animated: true)
            
        case [0,0]:
            let picker = UIImagePickerController()
            
            let alert = UIAlertController(title: "Change Avatar", message: nil, preferredStyle: .actionSheet)
            //TODO: Use Camera to pick the image
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        picker.allowsEditing = true
                        picker.sourceType = .camera
                        //When you set self as the delegate, you'll need to conform not only to the UIImagePickerControllerDelegate protocol, but also the UINavigationControllerDelegate protocol.
                        picker.delegate = self
                        self.present(picker,animated: true)
                    }
            }))
            
                //TODO: Use library to pick the image
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (alert) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    picker.allowsEditing = true
                    picker.sourceType = .photoLibrary
                    picker.delegate = self
                    self.present(picker, animated: true)
                }
            }))
            
            //TODO: Dismiss the UIAlert
            alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
            
            //TODO: present the Alert
            present(alert, animated:  true)

        default:
            break
        }
    }
    
    //TODO: put the image and save it to disk
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //TODO: extract the image from dictionary, then pass it as a parameter
        guard let image = info[.editedImage] as? UIImage else { return }
        
        // use the universal unique value to assign to imageName in order to identify the image
        let imageName = UUID().uuidString
        //
        let imagePath = getDocumentsDicractory().appendingPathComponent(imageName)
        //TODO: Convert the image name String to
    }
    
    //TODO: a little helper function, because it makes it easy to locate the user's documents directory where you can save app files.
    func getDocumentsDicractory() -> URL {
        // return the array of URLs for spetified document directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

   

}
