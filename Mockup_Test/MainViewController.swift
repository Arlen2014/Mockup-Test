//
//  MainViewController.swift
//  Mockup_Test
//
//  Created by Macintosh on 07/01/17.
//  Copyright © 2017 Solucoes Digitais e Mobile. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Instance variables
    
    var modelArray = [model]()
//   {
//        didSet {
//            
//            print("ARRAY : \(modelArray)")
//        }
//    }
    var cellId = "cellId"
    
    // MARK: - Interface
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dummyModel()
    }
    
    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainViewCell
        
        cell.modelCell = modelArray[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    // MARK: - Custom Functions
    
    // MARK: - Transition between views
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            let destination = segue.destination as? DetailViewController
            //the below line is incorrect and should be something else
            let selectedIndexPath = sender as! NSIndexPath
            let index = modelArray[selectedIndexPath.row]
            //pass data on using the index
            destination?.detailModel = index
        }
    }
    
    // MARK: - Custom Buttons
    
    // MARK: - Dummy Test
    
    func dummyModel() {
        
        let item0 = model(id: 0, image: "iPhone6s", title: "iPhone 6S", subTitle: "Resume about the iPhone 6S.")
        let item1 = model(id: 1, image: "iPhone6s_Plus", title: "iPhone 6S Plus", subTitle: "Resume about the iPhone 6S Plus.")
        let item2 = model(id: 0, image: "iPad_Air", title: "iPad Air", subTitle: "Resume about the iPad Air.")
        let item3 = model(id: 0, image: "iPad_Mini", title: "iPad Mini", subTitle: "Resume about the iPad Mini.")
        let item4 = model(id: 0, image: "MacBook_Air", title: "MacBook Air", subTitle: "Resume about the MacBook Air.")
        let item5 = model(id: 0, image: "MacBook_Pro", title: "MacBook Pro", subTitle: "Resume about the MacBook Pro.")
        let item6 = model(id: 0, image: "iPod_Touch", title: "iPod Touch", subTitle: "Resume about the iPod Touch.")
        let item7 = model(id: 0, image: "iPod_Nano", title: "iPod Nano", subTitle: "Resume about the iPod Nano.")
        let item8 = model(id: 0, image: "iWatch", title: "iWatch", subTitle: "Resume about the iWatch.")
        let item9 = model(id: 0, image: "iTV", title: "iTV", subTitle: "Resume about the iTV.")
        
        modelArray = [item0, item1, item2, item3, item4, item5, item6, item7, item8, item9]
        
    }
}

// MARK: - Extensions

// MARK: - Cell Class

class MainViewCell: UITableViewCell {

// MARK: - Interface Cell
    
    @IBOutlet weak var imageModel: UIImageView!
    @IBOutlet weak var titleModelLabel: UILabel!
    @IBOutlet weak var subTitleModelLabel: UILabel!

// MARK: - Life Cycle Cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

// MARK: - Custom Functions Cell

// MARK: - Instance variables Cell
    
    var modelCell: model? {
    
        didSet {
            
            if let image = modelCell?.imageModel {
                imageModel.image = UIImage(named: image)
            }
            
            if let title = modelCell?.titleModel {
                titleModelLabel.text = title
                
            }
            
            if let subTitle = modelCell?.subTitleModel {
                subTitleModelLabel.text = subTitle
            }
        }
    }
}
