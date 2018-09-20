//
//  UsersViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase


class UsersViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var users: [DataSnapshot]! = []
  var ref: DatabaseReference!
  fileprivate var _refHandle: DatabaseHandle!
  //  var storageRef: StorageReference!
  //  var remoteConfig: RemoteConfig!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
  //  let user = userDetails(name: "Kyla2", city: "Windsor", province: "Manitoba", email: "kyla@kyla.com")
    //let user = ["name":"Kyla"]
    configureDatabase()
    //    configureStorage()
  //  sendUser(withUser: user)
    // Do any additional setup after loading the view.
  }
  
//  func sendUser(withUser user: userDetails) {
//    var user1 = [String:String]()
//    user1["name"] = user.name
//     user1["province"] = user.province
//    user1["email"] = user.email
//    user1["city"] = user.city
//    self.ref.child("users").childByAutoId().setValue(user1)
//
//  }
  
  func configureDatabase() {
    ref = Database.database().reference()
    
    // TODO: change fetch method to limit amount of users shown in collection view
    
    _refHandle = self.ref.child("users").observe(.childAdded, with: {[weak self] (snapshot) -> Void in
      guard let strongSelf = self else { return }
            strongSelf.users.append(snapshot)

            strongSelf.collectionView.insertItems(at: [IndexPath(row: strongSelf.users.count-1, section: 0)])
})
  }
  
  //  func configureStorage() {
  //    storageRef = Storage.storage().reference()
  //  }
  

  
  //#Pragma Mark UICollectionViewDatasource methods
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return users.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UsersCollectionViewCell
    
    let userSnapshot = self.users[indexPath.row]
    guard  let user =  userSnapshot.value as? [String: String] else { return cell }
    let name = user["name"] ?? ""
    let city = user["city"] ?? ""
    let province = user["province"] ?? ""
    let email = user["email"] ?? ""
    
    let _user = User(name: name, city: city, province: province, email: email)
    
    cell.configureCell(withUser: _user)
    
    return cell
  }

  //#Pragma Mark: Navigation
  
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue" {
    let usersCollectionViewCell = sender as! UsersCollectionViewCell
    let vc = segue.destination as! UsersDetailViewController
    vc.user = usersCollectionViewCell.user
  }
  }
  
  
}


