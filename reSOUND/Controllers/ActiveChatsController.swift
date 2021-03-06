//
//  ActiveChatsController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class ActiveChatsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var activeChatsTableView: UITableView!
  var chats = [String]()
  var id = [String]()
  var database = DatabaseManager.shared


    override func viewDidLoad() {
        super.viewDidLoad()
      activeChatsTableView.dataSource = self
      activeChatsTableView.delegate = self
      configureDatabase()
        // Do any additional setup after loading the view.
      view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)

    }

  func configureDatabase() {
    guard let userID = database.currentUser?.uid else {return}
    database.reference.child("activeChats/\(userID)").observeSingleEvent(of:  .value, with: {(snapshot) in
      guard let value = snapshot.value as? [String:String] else { return }
      for name in value {
        self.chats.append(name.value)
        self.id.append(name.key)
      }
    self.activeChatsTableView.reloadData()
        })
}


  //Pragma Mark: Data Source Delegate
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
    let cell = self.activeChatsTableView.dequeueReusableCell(withIdentifier: "activeChatCell", for: indexPath) as! ActiveChatsCell
    
    cell.configureCell(name: chats[indexPath.row], id: id[indexPath.row])
    
    return cell
  }
  
  //Pragma Mark: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "chatSegue" {
          let chatCell = sender as! ActiveChatsCell
          let vc = segue.destination as! ChatController
          vc.user = chatCell.user

          }
    }
}



