//
//  CharacterViewController.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import CryptoKit
import CommonCrypto
class CharacterViewController: UIViewController {

    private let disposeBag = DisposeBag()
   private let service = ModelService()
    
    private let encryptedAndDecryptedData = EncryptAndDecrypt()
    
    @IBOutlet weak var tableView: UITableView!
    var model = [CharactersModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "encryptedData")
        tableView.delegate = self
        tableView.dataSource = self

        service.fetchCharacters(query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
            self.model.append(contentsOf: model)
            print("mycount is \(self.model.count)")
            print(self.model)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           

           }).disposed(by: disposeBag)

        let message       = "Don´t try to read this text. Top Secret Stuff"
        let messageData   = Array(message.utf8)
        let keyData       = Array("12345678901234567890123456789012".utf8)
        let ivData        = Array("abcdefghijklmnop".utf8)
//        let encryptedData = EncryptAndDecrypt.testCrypt(<#T##self: EncryptAndDecrypt##EncryptAndDecrypt#>)
        let encryptedData = encryptedAndDecryptedData.testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)!
        let decryptedData = encryptedAndDecryptedData.testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)!
        _     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!

        print("message:       \(message)");
        print("messageData:   \(NSData(bytes:messageData,   length:messageData.count))");
        print("keyData:       \(NSData(bytes:keyData,       length:keyData.count))");
        print("ivData:        \(NSData(bytes:ivData,        length:ivData.count))");
        print("encryptedData: \(NSData(bytes:encryptedData, length:encryptedData.count))");
        print("decryptedData: \(NSData(bytes:decryptedData, length:decryptedData.count))");
        print("decrypted:     \(String(bytes:decryptedData,encoding:String.Encoding.utf8)!)")
      
    }
    

    


}

// table view data source and delegates
extension CharacterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell",for: indexPath) as! CharacterTableViewCell
        cell.characterpotrayLabel.text = model[indexPath.row].portrayed
       
        cell.characterNameLabel.text = model[indexPath.row].name
        cell.characterImageView.sd_setImage(with: URL(string: model[indexPath.row].img!), placeholderImage: UIImage(named: ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "characterDetailsVC") as! CharacterDetailsViewController
      
        vc.charID = model[indexPath.row].charID
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
