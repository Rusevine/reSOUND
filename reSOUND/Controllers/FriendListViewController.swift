//
//  FriendListViewController.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-09-26.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var friendsTable: UITableView!
    @IBOutlet weak var chatsTables: UITableView!
    @IBOutlet weak var requestTables: UITableView!
    
   // var friends : [DataSnapshot]! = []
    var chats: [DataSnapshot]! = []
    var database = DatabaseManager.shared
//    override func viewWillAppear(_ animated: Bool) {
//        filter = filterFriendRequests()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        configureFriendsList()
        configureActiveChats()
        configureFriendRequest()
        chatsTables.rowHeight = chatsTables.frame.height/4
        friendsTable.rowHeight = friendsTable.frame.height/4
        requestTables.rowHeight = requestTables.frame.height/4
      view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)

    }
    func configureFriendsList() {
       
        guard let userID = database.currentUser?.uid else {return}
        database.reference.child("friendList/\(userID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.database.friends.append(snapshot)
            strongSelf.friendsTable.insertRows(at: [IndexPath(row: strongSelf.database.friends.count-1, section: 0)], with: .automatic)
        
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
    
    func configureFriendRequest() {
        guard let userID = database.currentUser?.uid else {return}
        database.reference.child("friendRequest/\(userID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.database.requests.append(snapshot)
            strongSelf.requestTables.insertRows(at: [IndexPath(row: strongSelf.database.requests.count-1, section: 0)], with: .automatic)
        
        })
    }
    
//    func filterFriendRequests() -> [String]{
//        guard let userID = database.currentUser?.uid else {fatalError()}
//        var rejectList = [String]()
//        database.reference.child("friendRequest/\(userID)").observeSingleEvent(of: .value) { (snapshot) in
//
//            let dictionary = snapshot.value
//            let users = dictionary as! [String:Any]
//
//            for id in users.keys {
//                let user = users[id] as! [String:Any]
//                let pending = user["pending"] as! Bool
//                let rejected = user["rejected"] as! Bool
//                if pending == true && rejected == false {
//                    rejectList.append(id)
//                }
//
//            }
//        }
//        return rejectList
//    }


    
    @IBAction func left(_ sender: Any) {
        scrollView.contentOffset.x = 0
        navigationItem.title = "Friends"
    }
    
    @IBAction func middle(_ sender: Any) {
        scrollView.contentOffset.x = scrollView.frame.width
        navigationItem.title = "Chats"
    }
    
    @IBAction func right(_ sender: Any) {
        scrollView.contentOffset.x = scrollView.frame.width * 2
        navigationItem.title = "Requests"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case friendsTable:
            return database.friends.count
        case chatsTables:
            return chats.count
        case requestTables:
            return database.requests.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
    
        switch tableView {
            case friendsTable:
            let friendsCell = self.friendsTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendCell
            
            let snapshot = self.database.friends[indexPath.row]
            let id = snapshot.key
            guard let name = snapshot.value as? String else {fatalError()}
            
            friendsCell.configureCell(name: name, id: id)
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
            
        case requestTables:
            let requestCell = self.requestTables.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! FriendRequestCell
            let snapshot = self.database.requests[indexPath.row]
            let values = snapshot.value as! [String:Any]
            let name = values["name"] as! String
            let id = snapshot.key
            
            requestCell.configureCell(name: name, id: id)
            requestCell.acceptButton.tag = indexPath.row
            requestCell.acceptButton.addTarget(self, action: #selector(accepted), for: .touchUpInside)
            cell = requestCell
            
            break
            default: break
            }
        
        return cell!
  }
    
    @objc func accepted(sender: UIButton) {
        if database.requests.count < 1 {
            database.requests = []
        } else {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        database.requests.remove(at: sender.tag)
        requestTables.deleteRows(at: [indexPath], with: .fade)
        var index = 0
        while index < database.requests.count {
            
            requestTables.cellForRow(at: IndexPath(row: index, section: 0))?.tag = index
            index += 1
        }
    }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        switch scrollView.contentOffset.x {
        case 0:
            navigationItem.title = "Friends"
            break
        case scrollView.frame.width:
            navigationItem.title = "Chats"
            break
        case (scrollView.frame.width * 2):
            navigationItem.title = "Requests"
            break
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chatSegue" {
            let chatCell = sender as! ActiveChatsCell
            let vc = segue.destination as! ChatController
            vc.user = chatCell.user
        }
        if segue.identifier == "detailSegue" {
            let friendsCell = sender as! FriendCell
            let vc = segue.destination as! UsersDetailViewController
            vc.user = friendsCell.user
            
        }
    }
}

