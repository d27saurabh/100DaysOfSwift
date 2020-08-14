//
//  DetailViewController.swift
//  ConsolidationII
//
//  Created by Saurabh Deshpande on 8/13/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var countryName: String?
    var flagName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the navigationBar item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // set the country to title and flag to the image view
        if let imageToLoad = countryName, let flagToLoad = flagName {
            title = imageToLoad
            imageView.image = UIImage(named: flagToLoad)
        }
        
        // show the title in small
        navigationItem.largeTitleDisplayMode = .never
        
        // TODO: - Figure out a way to wrap the imageView to the image size so that we can border it to distinguish the flag whites and blacks from the background
        //set imageView properties
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, "This flag represents \(countryName!)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
