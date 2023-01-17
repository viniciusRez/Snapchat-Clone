//
//  ListMensageViewController.swift
//  Snapchat Clone
//
//  Created by Vinicius Rezende on 16/01/23.
//

import UIKit

class MainScreenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var viewModel: MainScreenViewModel!
    var listOfSnaps:[SnapModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = MainScreenViewModel(controller: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSair(_ sender: Any) {
        self.viewModel.singOut()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getSnaps(completion:  { result in
            self.listOfSnaps = result
            
            self.tableview.reloadData()
        })
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    

    }
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.getSnapsAffterDelete(completion:  { result in
            var indice = 0
            for snap in self.listOfSnaps{
                
                if snap.identifier! == result {
                    self.listOfSnaps.remove(at: indice)
                }
                indice = indice + 1
            }
            print(self.listOfSnaps.count)
            self.tableview.reloadData()
            
        })
    }
    @IBOutlet weak var tableview: UITableView!
    
   
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalSnaps = listOfSnaps.count
           if totalSnaps == 0 {
               return 1
           }
           return totalSnaps
  
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalSnaps = listOfSnaps.count
        if totalSnaps > 0 {
            self.viewModel.router(identifier: "detalhes", sender: self.listOfSnaps[indexPath.row])
        }
          
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhes"{
            let receivedSnapViewController = segue.destination as! ReceivedSnapViewController
            receivedSnapViewController.snap = (sender as! SnapModel)
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForSnaps", for: indexPath)
         let totalSnaps = listOfSnaps.count
         if totalSnaps == 0{
             cell.textLabel?.text = "nenhum snap para você"
             cell.detailTextLabel?.text = " " 

         }else{
             cell.textLabel?.text = listOfSnaps[indexPath.row].de
             cell.detailTextLabel?.text = listOfSnaps[indexPath.row].nome
         }

        return cell
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
