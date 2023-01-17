//
//  SnapsViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import UIKit

class SnapsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var viewModel:SnapsViewModel!
    var imagePicker:UIImagePickerController!
    var infoImage:SnapModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.viewModel = SnapsViewModel()
        self.imagePicker.delegate = self
        self.EnableButton(value: false)
        
        // Do any additional setup after loading the view.
    }
    func EnableButton(value:Bool){
        if value{
            self.btnNext.isEnabled = true
            self.btnNext.backgroundColor = UIColor(named: "verdeLima")
            self.btnNext.setTitle("next", for: .normal)

        }else{
            self.btnNext.isEnabled = false
            self.btnNext.backgroundColor = UIColor.gray
        }
    }
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBAction func btnNext(_ sender: Any) {
        self.EnableButton(value: false)
        self.btnNext.setTitle("loading...", for: .normal)
        self.viewModel.saveImage(selectedImage: imageView,controller: self, descriprion: self.descricao.text!) { UIAlertController,infoImage in
            self.infoImage = infoImage
            self.present( UIAlertController,animated: true )
        
            
        }
        
    }
    @IBAction func btngaleria( _ sender: Any ) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true)
    }
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ) {
        let imageRecover = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = imageRecover
        imagePicker.dismiss(animated: true)
        self.EnableButton(value: true)

    }
    override func prepare( for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "optionsForSend"{
            let userViewController = segue.destination as! UsersTableViewController
            userViewController.infoImage = self.infoImage
        }
    }
}
