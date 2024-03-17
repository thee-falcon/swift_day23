//
//  DetailViewController.swift
//  Project3
//
//  Created by Omar Makran on 3/16/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var allPictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        
        /* ######################################### */
        //          Let's make a Share Button.       //
        // ######################################### */
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
    
        // Unwrapped the selected image because it's optional variable.
        if let imageToLoad = selectedImage {
            // showing the image in view controller using UIImage.
            imageView.image = UIImage(named: imageToLoad)
            
            var animationImages: [UIImage] = []

            // Loop through all pictures and add them to the animationImages array.
            for imageName in allPictures {
                if let image = UIImage(named: imageName) {
                    animationImages.append(image)
                }
            }

            /* ######################################### */
            //          Let's make some Animation.       //
            // ######################################### */
            // Set the initial image to the first image in the animationImages array.
            imageView.image = animationImages.first
            // Set animation properties.
            imageView.animationImages = animationImages
            imageView.animationDuration = 1.0
            imageView.animationRepeatCount = 1
            // Start the animation.
            imageView.startAnimating()

            // After the animation completes, show the selected image with a crossfade transition.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.transition(with: self.imageView, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.imageView.image = UIImage(named: imageToLoad)
                }, completion: nil)
            }

            imageView.layer.borderWidth = 0.1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // ########## function that's share the content ############
    @objc func sharedTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        // without the code will crash on iPad.
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    // To hide Bar on TOP when the user tapped in the image.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
