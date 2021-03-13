//
//  FavoritesViewController.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import UIKit
import CryptoKit
import CommonCrypto
class FavoritesViewController: UIViewController {

    @IBOutlet weak var noFavoriteLabel: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    private let encryptedAndDecryptedData = EncryptAndDecrypt()
   private var favList = [String]()
   
    let filledStar = UIImage(named: "stardeep.png")
   
    
    override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
        favList.removeAll()
       favList = []
        print(favList)
        if  let result = UserDefaults.standard.object(forKey: "encryptedData") as? [String] {
            print("result is \(result)")
            for i in 0..<result.count {
                self.favList.append(result[i])
            let messageData   = Array(result[i].utf8)
            let keyData       = Array("12345678901234567890123456789012".utf8)
            let ivData        = Array("abcdefghijklmnop".utf8)
            let encryptedData = encryptedAndDecryptedData.testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)!
            let decryptedData = encryptedAndDecryptedData.testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)!
            print("decrypted:     \(String(bytes:decryptedData,encoding:String.Encoding.utf8)!)")

            print(favList.count)
                self.favoriteTableView.reloadData()
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    

   

}
extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if favList.count < 0 {
            self.noFavoriteLabel.isHidden = false
            self.favoriteTableView.isHidden = true
            return 0
        } else if favList.count > 0 {
            self.noFavoriteLabel.isHidden = true
            self.favoriteTableView.isHidden = false
        return favList.count
        }
        
        return favList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell",for: indexPath)

        cell.textLabel?.text = favList[indexPath.row]
        
        cell.accessoryView = UIImageView(image: filledStar)

        return cell
    }

}
