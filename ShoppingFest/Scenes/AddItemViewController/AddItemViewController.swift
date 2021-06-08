//
//  AddItemViewController.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView


class AddItemViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    var viewModel: AddItemViewModel
    var gallery: GalleryController!
    var hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2 - 30, y: self.view.frame.height / 2-30, width: 60, height: 60),
                                                    type: .ballPulse, color: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
                                                    padding: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AddItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AddItemViewController", bundle: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        showImageGallery()
        viewModel.itemImages = []
    }
    
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    private func fieldsAreCompleted() -> Bool {
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionText.text != "")
    }
    
    private func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self , action: #selector(rightButtonAction))
    }
    
    @objc func rightButtonAction() {
        if fieldsAreCompleted() {
            saveToFireBase()
        } else {
            
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    private func popToView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func saveToFireBase() {
        
        showLoadingIndicator()
        
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text ?? ""
        item.categoryId = viewModel.category.id
        item.description = descriptionText.text
        item.price = Double(priceTextField.text ?? "")
        
        if !viewModel.itemImages.isEmpty {
            uploadImages(images: viewModel.itemImages, itemId: item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                saveItemToFirestore(item: item)
                
                self.hideloadingIndicator()
                self.popToView()
            }
        } else {
            saveItemToFirestore(item: item)
            popToView()
        }
    }
    
    private func showLoadingIndicator() {
        if activityIndicator != nil{
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    private func hideloadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    private func showImageGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        self.present(self.gallery, animated: true, completion: nil)
    }
}

extension AddItemViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.viewModel.itemImages = resolvedImages
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
