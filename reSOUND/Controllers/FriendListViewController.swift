//
//  FriendListViewController.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-09-26.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var friendsTable: UITableView!
    @IBOutlet weak var chatsTables: UITableView!
    @IBOutlet weak var requestTables: UITableView!
    
    var friends = [String]()
    var friendsID = [String]()
    var chats: [DataSnapshot]! = []
    var database = DatabaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFriendsList()
        configureActiveChats()
        // Do any additional setup after loading the view.
    }
    func configureFriendsList() {
        guard let userID = database.currentUser?.uid else {return}
        database.reference.child("friendList/\(userID)").observeSingleEvent(of:  .value, with: {(snapshot) in
            guard let value = snapshot.value as? [String:String] else { return }
            for name in value {
                self.friends.append(name.value)
                self.friendsID.append(name.key)
            }
            self.friendsTable.reloadData()
        })
        
    }
    
    func configureActiveChats() {
        guard let userID = database.currentUser?.uid else {return}
        
        database.reference.child("activeChats/\(userID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.chats.append(snapshot)
            strongSelf.chatsTables.insertRows(at: [IndexPath(row: strongSelf.chats.count-1, section: 0)], with: .automatic)
        })
    }



    
    @IBAction func left(_ sender: Any) {
        scrollView.contentOffset.x = 0
    }
    
    @IBAction func middle(_ sender: Any) {
        scrollView.contentOffset.x = scrollView.frame.width
    }
    
    @IBAction func right(_ sender: Any) {
        scrollView.contentOffset.x = scrollView.frame.width * 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case friendsTable:
            return friends.count
        case chatsTables:
            return chats.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
    
        switch tableView {
            
            case friendsTable:
                
            let friendsCell = self.friendsTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! ActiveChatsCell
            friendsCell.configureCell(name: friends[indexPath.row], id: friendsID[indexPath.row])
            cell = friendsCell
            break
            
            case chatsTables:
                
            let activeCell = self.chatsTables.dequeueReusableCell(withIdentifier: "activeChatCell", for: indexPath) as! ActiveChatsCell
            let snapshot = self.chats[indexPath.row]
            let id = snapshot.key
            guard let name = snapshot.value as? String else {fatalError()}
            activeCell.configureCell(name: name, id: id)
            cell = activeCell
            
            break
            
            default:
            break
            
            }

        
        return cell!
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chatSegue" {
            let chatCell = sender as! ActiveChatsCell
            let vc = segue.destination as! ChatController
            vc.user = chatCell.user
        }
        if segue.identifier == "detailSegue" {
            let friendsCell = sender as! ActiveChatsCell
            let vc = segue.destination as! UsersDetailViewController
            vc.user = friendsCell.user
            
        }
    }
}
