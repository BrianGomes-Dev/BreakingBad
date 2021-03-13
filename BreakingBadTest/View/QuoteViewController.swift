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
class QuoteViewController: UIViewController {
   private  let service = ModelService()
    @IBOutlet weak var tableView: UITableView!
    var model = [QuotesModel]()
    
    private let encryptedAndDecryptedData = EncryptAndDecrypt()
    
   private var favListArray = [String]()
    private let disposeBag = DisposeBag()
   
    
    let filledStar = UIImage(named: "stardeep.png")
    let unfilledStar = UIImage(named: "savedmsg.png")
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        // get the quotes with rxswift
               service.fetchQuotes(query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
                print(model)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               }).disposed(by: disposeBag)
//        UserDefaults.standard.removeObject(forKey: "encryptedData")
    }
    
    // add tp favorite clicked
   @objc  func addToFav(_ sender: UIButton) {

    
    let cell = self.tableView.cellForRow(at: NSIndexPath.init(row: sender.tag, section: 0) as IndexPath) as! QuoteTableViewCell
    
    
    if sender.isSelected == true {
        sender.setImage(unfilledStar,for: .normal)
        sender.isSelected = false
        if let index = favListArray.firstIndex(of: model[sender.tag].author!) {
            favListArray.remove(at: index)
    }
      


    } else {
        
        // alert action
        let alert = UIAlertController(title: "", message: "Do you really want to add to favorites? ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (action : UIAlertAction) in
            sender.setImage(self.filledStar,for: .normal)
   
           
            sender.isSelected = true
            self.favListArray.append((cell.titleLabel?.text)!)

            let message       = cell.titleLabel?.text
            let messageData   = Array(message!.utf8)
            let keyData       = Array("12345678901234567890123456789012".utf8)
            let ivData        = Array("abcdefghijklmnop".utf8)
 
            let encryptedData = self.encryptedAndDecryptedData.testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)!

           
            UserDefaults.standard.setValue(self.favListArray, forKey: "encryptedData")

            let decryptedData = self.encryptedAndDecryptedData.testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)!
            _  = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
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
        cell.titleLabel!.text = model[indexPath.row].author
        cell.subtitleLabel!.text =  model[indexPath.row].quote
        
        if favListArray.contains(cell.textLabel!.text!) {
            cell.favoriteButton.setImage(self.filledStar,for: .normal)
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
}
