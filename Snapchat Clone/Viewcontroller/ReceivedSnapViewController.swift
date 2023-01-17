//
//  ReceivedSnapViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 17/01/23.
//

import UIKit
import Kingfisher
class ReceivedSnapViewController: UIViewController {
    var snap:SnapModel!
    var viewmodel:ReceivedSnapViewModel!
    var timer:Int = 11
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewmodel = ReceivedSnapViewModel()
        self.lblDescription.text = "carregando.."
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let url = URL(string: snap.urlImage)
        self.imageView.kf.setImage(with: url){result in
            switch result {
            case .success:
                self.lblDescription.text = self.snap.description
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block : { (timer) in
            self.timer = self.timer - 1
            self.lblTimer.text = String(self.timer)
            if self.timer == 0{
                
                timer.invalidate()
                self.dismiss(animated: true,completion: nil)
            }
        })
    }
    override func viewDidDisappear(_ animated: Bool) {
        let identifier = snap.identifier!
        let identifierImage = snap.idImage
        print(identifier)
        self.viewmodel.deleteSnap(idSnap: identifier) {
            self.viewmodel.deleteimage(idImage: identifierImage)
        }
    }
    
}
