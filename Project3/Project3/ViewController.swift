//
//  ViewController.swift
//  Project3
//
//  Created by Omar Makran on 3/16/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // to store the content in the array.
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        title = "Flags of Countries"
         navigationController?.navigationBar.prefersLargeTitles = true

        // to look for files.
        let fm = FileManager.default
        
        // to find the path using Bundle Directory.
        let path = Bundle.main.resourcePath!
        
        // set the content of directory to a Path.
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // let's loop and Find the correct content and store them in the array.
        for item in items {
            if item.hasSuffix(".png") {
                // add the content in the array.
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    // that's function return how many rows in section.
    override func   tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    // to give more detail for users; like a index path of an image...
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        // to show the path of the image in each row.
        cell.textLabel?.text = pictures[indexPath.row]
        // return a sub class that's have the last details to propreties.
        return cell
    }
    
    // to check the image if didselcted or not
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // vc is a sub class.
        if let  vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            // copy the content in a new variable to use it for animation.
            vc.allPictures = pictures
            // when I tapped on the row, the view controller should be pushed.
            navigationController?.pushViewController(vc, animated: true)
            // let's showing the image using 'DetailViewController file'
        }
    }
}
