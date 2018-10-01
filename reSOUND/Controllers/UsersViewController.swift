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

  @IBOutlet weak var singerButton: UIButton!
  @IBOutlet weak var engineerButton: UIButton!
  @IBOutlet weak var producerButton: UIButton!
  @IBOutlet weak var lyricistButton: UIButton!
  @IBOutlet weak var popOverFilter: UIView!
  @IBOutlet weak var popOverFilterHeightContraint: NSLayoutConstraint!
  @IBOutlet weak var popOverFilterTopConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var filterButton: UIButton!
  
  var users: [DataSnapshot]! = []
  let database = DatabaseManager.shared
  var skillsArray = [String]()
  var pressed = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    configureDatabase()

    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
    filterButton.setTitleColor(colors.fontBlue, for: UIControlState.normal)

  }
  
  func configureDatabase() {

      database.reference.child(database.usersPath).observe(.childAdded, with: {[weak self] (snapshot) -> Void in
      guard let strongSelf = self else { return }
      strongSelf.users.append(snapshot)
      strongSelf.collectionView.insertItems(at: [IndexPath(row: strongSelf.users.count-1, section: 0)])
    })
  }
  
  //#Pragma Mark UICollectionViewDatasource methods
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return users.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UsersCollectionViewCell
    
    let userSnapshot = self.users[indexPath.row]
    guard  let user =  userSnapshot.value as? [String: String] else { return cell }
    let name = user[database.name] ?? ""
    let city = user[database.city] ?? ""
    let province = user[database.province] ?? ""
    let email = user[database.email] ?? ""
    let id = user[database.id] ?? ""
    let userDescription = user[database.userDescription] ?? ""
    let userlink = user[database.userLink] ?? ""
    
    let _user = User(name: name, city: city, province: province, email: email, id: id, userDescription: userDescription, userLink: userlink)
    
    cell.configureCell(withUser: _user)
    
    return cell
  }
  
  //#Pragma Mark: Filter
  @IBAction func pickedSkillsPressed(_ sender: UIButton) {
    if skillsArray.contains(sender.currentTitle!){
      if let index = skillsArray.index(of: sender.currentTitle!) {
        skillsArray.remove(at: index)
      }
    } else {
    self.skillsArray.append(sender.currentTitle!)
    }
    self.users = []
    
    filterSkills { (keys) in
      self.applyFilter(filter: keys, completion: { (_) in
        self.collectionView.reloadData()
      })
    }
  }
  
  @IBAction func filterButtonPressed(_ sender: Any) {
    print("filter button was pressed")
    if (!pressed) {
      popOverFilterTopConstraint.constant += popOverFilterHeightContraint.constant
      pressed = true
      filterButton.setTitle("done", for: UIControlState.normal)
      filterButton.setTitleColor(colors.fontBlue, for: UIControlState.normal)

    } else {
      popOverFilterTopConstraint.constant -= popOverFilterHeightContraint.constant
      pressed = false
      filterButton.setTitle("filter", for: UIControlState.normal)

    }
    UIView.animate(withDuration: 2) {}
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
    
    let userID = database.reference.child(database.skillsPath)
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
        database.reference.child(database.usersPath + "/" + id).observeSingleEvent(of: .value) { (snapshot) in
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


