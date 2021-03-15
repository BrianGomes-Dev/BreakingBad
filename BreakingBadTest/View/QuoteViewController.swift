//
//  QuoteViewController.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
import CryptoKit
import CommonCrypto
import Security
class QuoteViewController: UIViewController {
   private  let service = ModelService()
    @IBOutlet weak var tableView: UITableView!
    var model = [QuotesModel]()
    
    private let encryptedAndDecryptedData = EncryptAndDecrypt()
    
   private var favListArray = [Int]()
    private let disposeBag = DisposeBag()
   
    
    let filledStar = UIImage(named: "stardeep.png")
    let unfilledStar = UIImage(named: "savedmsg.png")
    func getFavFromKeychain() {
        if let receivedData = KeyChain.load(key: "quoteids") {
            
            do {
               
                let result = try NSKeyedUnarchiver.unarchiveObject(with :receivedData) as? [Int]
                for i in 0..<result!.count {
                    self.favListArray.append(result![i])
                }
                    let data = try NSKeyedArchiver.archivedData(withRootObject: self.favListArray, requiringSecureCoding: true)
                let status = KeyChain.save(key: "quoteids", data: data)
                    print("status is \(status)")
            
            } catch {
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        model.removeAll()
        favListArray.removeAll()
        getFavFromKeychain()
        // get the quotes with rxswift
               service.fetchQuotes(query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
                print(model)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
      

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // add tp favorite clicked
   @objc  func addToFav(_ sender: UIButton) {

    
    
    if sender.currentImage == filledStar  {
        sender.isSelected = false

       
        if let receivedData = KeyChain.load(key: "quoteids") {
            let result = NSKeyedUnarchiver.unarchiveObject(with :receivedData) as? [Int]
            if result!.contains(model[sender.tag].quote_id!) {

                    let alert = UIAlertController(title: "", message: "Added already to your favorites! ", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))


            }
        }


    } else {
        sender.isSelected = true
        // alert action
        let alert = UIAlertController(title: "", message: "Do you really want to add to favorites? ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ОK", style: .default, handler: { (action : UIAlertAction) in
            sender.setImage(self.filledStar,for: .normal)
   
           
          
            
            
            
            
            
            if let receivedData = KeyChain.load(key: "quoteids") {
                
                do {
                   
                    let result = try NSKeyedUnarchiver.unarchiveObject(with :receivedData) as? [Int]
                    if !result!.contains(self.model[sender.tag].quote_id!) {
                        self.favListArray.append((self.model[sender.tag].quote_id)!)
                        let data = try NSKeyedArchiver.archivedData(withRootObject: self.favListArray, requiringSecureCoding: true)
                    let status = KeyChain.save(key: "quoteids", data: data)
                        print("status is \(status)")
                    }
                    
                } catch {
                    
                }
            } else {

            }
           
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        
        }))
        self.present(alert, animated: true, completion: nil)
        

        
       
    }

        tableView.reloadData()



    }

}

// table view data source and delegtes
extension QuoteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTableViewCell
        //crash fix
        if indexPath.row < model.count {
        cell.titleLabel!.text = model[indexPath.row].author
        cell.subtitleLabel!.text =  model[indexPath.row].quote
        
        if let receivedData = KeyChain.load(key: "quoteids") {
            
            do {
               
                let result = try NSKeyedUnarchiver.unarchiveObject(with :receivedData) as? [Int]
                if result!.contains(model[indexPath.row].quote_id!) {
                    cell.favoriteButton.setImage(filledStar,for: .normal)
                } else {
                    cell.favoriteButton.setImage(unfilledStar,for: .normal)
                }
            } catch {
                print(error)
            }
        }
        }
        cell.favoriteButton.tag = indexPath.row
       
        cell.favoriteButton.addTarget(self, action: #selector(addToFav(_:)), for: .touchUpInside)
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "quotedetailsVC") as! QuotesDetailsViewController
      
        vc.quoteID = model[indexPath.row].quote_id
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
