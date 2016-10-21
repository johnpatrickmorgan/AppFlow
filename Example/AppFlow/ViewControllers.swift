//
//  ViewController.swift
//  Flow
//
//  Created by johnmorgan on 07/22/2016.
//  Copyright (c) 2016 johnmorgan. All rights reserved.
//

import UIKit
import AppFlow

struct User {
    
    var name: String
}

class UsersVC: UITableViewController {
    
    var userSelected: ((User) -> Void)?
    
    var users = [
        User(name: "Tom"),
        User(name: "Dick"),
        User(name: "Harry"),
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userSelected?(users[indexPath.row])
    }
    
    deinit {
        
        print("DEINIT \(self)")
    }
}

class ProfileVC: UIViewController {
    
    var nameLabel: UILabel?
    
    var user: User? {
        didSet {
            updateView()
        }
    }
    
    var cancelTapped = Action<Void>()
    var editTapped = Action<User>()
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(user: User) {
        
        self.init()
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let nameLabel = UILabel()
        
        view.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameLabel = nameLabel
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: [])
        
        view.addSubview(cancelButton)
        
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        
        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: [])
        
        view.addSubview(editButton)
        
        editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor).isActive = true
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.addTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
        
        updateView()
    }
    
    func cancelTapped(sender: UIButton) {
        
        invoke(cancelTapped)
    }
    
    func editTapped(sender: UIButton) {
        
        guard let user = user else { return }
        
        invoke(editTapped, with: user)
    }
    
    func updateView() {
        
        nameLabel?.text = user?.name
    }
    
    deinit {
        
        print("DEINIT \(self)")
    }
}

class ProfileEditVC: UIViewController, UITextFieldDelegate {
    
    var usernameField: UITextField?
    
    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    var doneTapped = Action<User>()
    
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(user: User) {
        
        self.init()
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let usernameField = UITextField()
        usernameField.delegate = self
        
        view.addSubview(usernameField)
        
        usernameField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        usernameField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        self.usernameField = usernameField
        
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: [])
        
        view.addSubview(doneButton)
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.addTarget(self, action: #selector(doneTapped(sender:)), for: .touchUpInside)
        
        updateViews()
    }
    
    func updateViews() {
        
        usernameField?.text = user?.name
    }
    
    func doneTapped(sender: UIButton) {
        
        guard let user = user else { return }
        
        invoke(doneTapped, with: user)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if let name = textField.text {
            user?.name = name
        }
        
        return true
    }
    
    deinit {
        
        print("DEINIT \(self)")
    }
}
