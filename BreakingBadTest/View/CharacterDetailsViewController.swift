//
//  CharacterDetailsViewController.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
class CharacterDetailsViewController: UIViewController {
    var charID : Int?
    private let service = ModelService()
    private let disposeBag = DisposeBag()
    private var model = [CharactersModel]()
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var portrayedLabel: UILabel!
    @IBOutlet weak var occupationlabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
// display characters by id with rxswift
        service.fetchCharactersWithId(id: charID ?? 1, query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
//            self.model.append(contentsOf: model)
            DispatchQueue.main.async {
                self.birthdayLabel.text = "Birthday: \(model[0].birthday ?? "")"
                self.nicknameLabel.text = "NickName: \(model[0].nickname ?? "")"
                self.nameLabel.text = "Name: \(model[0].name ?? "")"
                self.portrayedLabel.text = "Actor: \(model[0].portrayed ?? "")"
                self.occupationlabel.text = "Occupation: \(model[0].occupation?.joined(separator: ",") ?? "")"
                    
                
                self.imageView.sd_setImage(with: URL(string: model[0].img!), placeholderImage: UIImage(named: ""))
                
                // storing data in keychains
                let data = Data(from: model[0].name)
                let status = KeyChain.save(key: "Name", data: data)
                print("status: ", status)
                    // retrieving data from keychain 
                if let receivedData = KeyChain.load(key: "Name") {
                    let result = receivedData.to(type: String.self)
                    print("result: ", result)
                }
            }
           
     
        }).disposed(by: disposeBag)

       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
