//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Jun Oh on 2019-02-21.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var customNavBarHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var plusIconButton: UIButton!
  @IBOutlet weak var customNavBar: UIView!
  
  @IBOutlet weak var tableView: UITableView!
  weak var stackView: UIStackView!
  weak var titleLabel: UILabel!
  
  var images: [UIImage?] = []
  
  var clickedFoods: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let stackView = UIStackView()
    self.stackView = stackView
    stackView.translatesAutoresizingMaskIntoConstraints = false
    customNavBar.addSubview(stackView)
    
    stackView.bottomAnchor.constraint(equalTo: customNavBar.bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: 20+plusIconButton.frame.height).isActive = true
    
    stackView.clipsToBounds = true
    stackView.axis = .horizontal
    stackView.isHidden = true
    stackView.distribution = .fillEqually
    
    images = [
      UIImage(named: "oreos"),
      UIImage(named: "pizza_pockets"),
      UIImage(named: "pop_tarts"),
      UIImage(named: "popsicle"),
      UIImage(named: "ramen")
                  ]
    for i in 0..<5 {
      let imageView = UIImageView()
      imageView.image = images[i]
      stackView.addArrangedSubview(imageView)
      
      imageView.isUserInteractionEnabled = true
      imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    let titleLabel = UILabel()
    self.titleLabel = titleLabel
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    customNavBar.addSubview(titleLabel)
    
    titleLabel.text = "SNACKS"
    titleLabel.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor).isActive = true
    let titleCenterYConstraint = titleLabel.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor)
    titleCenterYConstraint.isActive = true
    titleCenterYConstraint.identifier = "titleCenterYConstraint"
    
    
    tableView.delegate = self
    tableView.dataSource = self
  }

  @objc func imageTapped(_ sender: UITapGestureRecognizer) {
    if let imageView = sender.view as? UIImageView {
      switch imageView.image {
      case images[0]:
        clickedFoods.insert("Oreos", at: 0)
      case images[1]:
        clickedFoods.insert("Pizza Pockets", at: 0)
      case images[2]:
        clickedFoods.insert("Pop Tarts", at: 0)
      case images[3]:
        clickedFoods.insert("Popsicle", at: 0)
      case images[4]:
        clickedFoods.insert("Ramen", at: 0)
      default:
        print("Not found")
      }
      tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clickedFoods.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
      fatalError("Could not dequeue")
    }
    
    cell.textLabel?.text = clickedFoods[indexPath.row]
    
    return cell
  }
  
  @IBAction func plusIconPressed(_ sender: UIButton) {
    let isCustomNavBarOpen = customNavBarHeightConstraint.constant == 220
    if isCustomNavBarOpen {
      for constraint in customNavBar.constraints {
        if constraint.identifier == "titleCenterYConstraint" {
          constraint.constant = 0
        }
      }
      titleLabel.text = "SNACKS"
      customNavBarHeightConstraint.constant = 64
      
      UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [], animations: {
        self.view.layoutIfNeeded()
        self.plusIconButton.transform = CGAffineTransform.identity
        self.stackView.isHidden = true
      }, completion: nil)
    } else {
      for constraint in customNavBar.constraints {
        if constraint.identifier == "titleCenterYConstraint" {
          constraint.constant = -60
        }
      }
      
      customNavBarHeightConstraint.constant = 220
      titleLabel.text = "Add a SNACK"
      
      UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [], animations: {
        self.view.layoutIfNeeded()
        self.plusIconButton.transform = self.plusIconButton.transform.rotated(by: CGFloat.pi / 4.0)
        self.stackView.isHidden = false
      }, completion: nil)
    }
  }
  
}

