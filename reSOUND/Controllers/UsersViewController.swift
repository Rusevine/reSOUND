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
  @IBOutlet weak var skillsFilterButton: UIButton!
  
  var users: [DataSnapshot]! = []
  var ref: DatabaseReference!
  fileprivate var _refHandle: DatabaseHandle!
  var skillsArray = ["Lyricist", "Singer","Producer"]
  
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
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.lightGrey)
    
  }
  
  
  
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
    let id = user["id"] ?? ""
    
    let _user = User(name: name, city: city, province: province, email: email, id: id)
    
    cell.configureCell(withUser: _user)
    
    return cell
  }
  
  //#Pragma Mark: Filter
  
  
  @IBAction func skillsFilterButtonPressed(_ sender: UIButton) {
    self.users = []
    filterSkills { (keys) in
      self.applyFilter(filter: keys, completion: { (_) in
        self.collectionView.reloadData()
    })
  }
}
  

  
  func filterSkills(completion: @escaping ([String])->()){
    var keys = [String]()
    var count = 0 {
      didSet {
        if count == skillsArray.count{
          completion(keys)
        }
      }
    }
    
    let userID = ref.child("skills")
    for skill in skillsArray{
      let query = userID.queryOrdered(byChild: "\(skill)").queryEqual(toValue: true)
      query.observeSingleEvent(of: .value) { (snapshot) in
        for childSnapshot in snapshot.children {
          let snapshot = childSnapshot as? DataSnapshot
          
          if keys.contains((snapshot?.key)!){
          } else {
            keys.append((snapshot?.key)!)
          }
        }
        count = count + 1
//        self.applyFilter(filter: keys, completion: { (_) in
//          self.collectionView.reloadData()
        
      }
    }
  }
  
  func applyFilter(filter: [String], completion: @escaping (Bool)->()){
    var count = 0 {
      didSet {
        if count == filter.count {
          completion(true)
        }
      }
    }
    for id in filter {
      self.ref.child("users").child("\(id)").observeSingleEvent(of: .value) { (snapshot) in
        self.users.append(snapshot)
        count = count + 1
      }
    }
    
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


