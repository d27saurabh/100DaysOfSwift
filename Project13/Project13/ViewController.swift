//
//  ViewController.swift
//  Project13
//
//  Created by Saurabh Deshpande on 10/3/20.
//

import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    @IBOutlet var radius: UISlider!
    @IBOutlet var scale: UISlider!
    @IBOutlet var center: UISlider!
    
    var currentImage: UIImage!
    
    var context: CIContext!
    @IBOutlet var currentFilterLabel: UIButton!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPictures))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    @objc func importPictures() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing(tag: nil)
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
        
    }
    
    func setFilter(action: UIAlertAction) {
        //read the title
        guard let actionTitle = action.title else { return }
        
        //valid image check
        guard currentImage != nil else { return }
        //challenge 2
        currentFilterLabel.setTitle(actionTitle, for: .normal)
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing(tag: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            //challenge 1
            let ac = UIAlertController(title: "No image found", message: "Pick a image from photos to save", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contectInfo:)), nil)
    }
    
    @IBAction func intensityChanged(_ sender: UISlider) {
        applyProcessing(tag: sender.tag)
    }
    
    func applyProcessing(tag: Int?) {
        let inputKeys = currentFilter.inputKeys
        
        //challenge three
        switch  tag {
        case 0:
            if inputKeys.contains(kCIInputCenterKey) {
                currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
            }
        case 1:
            if inputKeys.contains(kCIInputScaleKey) {
                currentFilter.setValue(scale.value * 10, forKey: kCIInputScaleKey)
            }
        case 2:
            if inputKeys.contains(kCIInputRadiusKey) {
                currentFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey)
            }
        case 3:
            if inputKeys.contains(kCIInputIntensityKey) {
                currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
            }
        default:
            print("default case- do nothing")
        }
        
        
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contectInfo: UnsafeRawPointer) {
        if let error = error {
            //we got an error
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

