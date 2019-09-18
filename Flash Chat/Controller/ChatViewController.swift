//
//  ViewController.swift
//
// This is the Chat View Controller - this is the place in which ppl chat

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    //TODO: ???
    var messageArray : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set current ViewController as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        
        //TODO: Set current ViewController as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)) // retrive the tap gueture of user // the target of the tap is the current view Controller
        messageTableView.addGestureRecognizer(tapGesture) // tap anywhere else to end editting

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView() //resize the CELL message
        retrieveMessages() // call the message from database
        
        messageTableView.separatorStyle = .none
        
        //TODO: hide Back Button
        navigationItem.hidesBackButton = true
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods

    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].MessageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        //TODO: custom avataImageView
        cell.avatarImageView.image = UIImage(named: "background_character")
        cell.avatarImageView.frame.size.height = 120
        cell.avatarImageView.frame.size.width = 120
//        cell.avatarImageView.setRounded()
        
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email{
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor(hex: "#00987DFF")
        }else{
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatLime()
        }
        
        return cell
    }

    //TODO: Declare numberOfRowsInSection here:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextfield.endEditing(true)
    }
   
    //TODO: Declare configureTableView here: //Lam cho text fit in cell
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
       
            //UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
 
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3) /*, animations:*/ {     // closure -> can delete "animations:"
            self.heightConstraint.constant = 308 // set the height of textfield + keyboard
            self.view.layoutIfNeeded() // if something has changed -> redraw the whole thing
            }
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveMessages()
        return true
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        saveMessages()
    }
    
    func saveMessages(){
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        let messageDB = Database.database().reference().child("Message")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            if error != nil {
                print("We have an error: \(error!)")
            }else{
                print("Message saved successful!")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    //TODO: Create the retrieveMessages method:
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("Message")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.MessageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    
 
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
//        //TODO: Log out the user and send them back to WelcomeViewController
//        do{
//           try Auth.auth().signOut()
//            navigationController?.popToRootViewController(animated: true)
//        }catch{
//
//        }
    }
}

