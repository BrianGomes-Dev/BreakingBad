//
//  FavoritesViewController.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import UIKit
import CryptoKit
import CommonCrypto
import RxSwift
import RxCocoa
import Security
class FavoritesViewController: UIViewController {
private let favService = ModelService()
    @IBOutlet weak var noFavoriteLabel: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    private let encryptedAndDecryptedData = EncryptAndDecrypt()
   private var favList = [String]()
    private let disposeBag = DisposeBag()
   private var favModel = [QuotesModel]()
    let filledStar = UIImage(named: "stardeep.png")
   
    
    override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
        favModel.removeAll()
       favModel = []
        print(favList)
        if let receivedData = KeyChain.load(key: "quoteids") {
            
            do {
               
                let result = try NSKeyedUnarchiver.unarchiveObject(with :receivedData) as? [Int]
                print("results are \(result?.count)")
                for i in 0..<result!.count {
                   
                    
                    favService.fetchQuoteswithID(id : result![i] , query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
                        self.favModel.append(contentsOf: model)
                        DispatchQueue.main.async {
                            self.favoriteTableView.reloadData()
                        }
                       
                 
                    }).disposed(by: disposeBag)
 
                    let messageData   = Array("\(result![i])".utf8)
                let keyData       = Array("12345678901234567890123456789012".utf8)
                let ivData        = Array("abcdefghijklmnop".utf8)
                let encryptedData = encryptedAndDecryptedData.testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)!
                let decryptedData = encryptedAndDecryptedData.testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)!
                print("decrypted:     \(String(bytes:decryptedData,encoding:String.Encoding.utf8)!)")

               
                   
                }
            print("result: ", result)
            } catch let error {
                print(error)
            }
        }
//        if  let result = UserDefaults.standard.object(forKey: "encryptedData") as? [Int] {
//            print("result is \(result)")
//
//        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    

   

}
extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if favModel.count == 0 {
            self.noFavoriteLabel.isHidden = false
            self.favoriteTableView.isHidden = true
            return 0
        } else  {
            self.noFavoriteLabel.isHidden = true
            self.favoriteTableView.isHidden = false
        return favModel.count
        }
        


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell",for: indexPath) as! FavoriteTableViewCell
        if indexPath.row < favModel.count {
            print("")
        cell.favAuthorLabel.text = favModel[indexPath.row].author
        cell.favQuoteLabel.text = favModel[indexPath.row].quote
       
        }
        
       

        return cell
    }

}
