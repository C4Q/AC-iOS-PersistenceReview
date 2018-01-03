//
//  ImagesHistoryViewController.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ImagesHistoryViewController: UIViewController {

    var images = [NasaImage]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
       let tbv = UITableView()
        tbv.dataSource = self
        tbv.delegate = self
        return tbv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .white
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        self.images = FileManagerHelper.manager.getAllNasaImages()
    }

    func configureConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}

extension ImagesHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nasaImage = images[indexPath.row]
        let myCell = UITableViewCell()
        myCell.textLabel?.text = nasaImage.title
        myCell.imageView?.contentMode = .scaleAspectFit
        myCell.imageView?.image = nil
        ImageAPIClient.manager.loadImage(from: nasaImage.url, completionHandler: {myCell.imageView?.image = $0; myCell.setNeedsLayout()}, errorHandler: {print($0)})
        return myCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
}

extension ImagesHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
