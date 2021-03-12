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
            DispatchQueue.main.async {
                self.birthdayLabel.text = model[0].birthday
                self.nicknameLabel.text = model[0].nickname
                self.nameLabel.text = model[0].name
                self.portrayedLabel.text = model[0].portrayed
                self.occupationlabel.text = model[0].occupation?.joined(separator: ",")
                    
                
                self.imageView.sd_setImage(with: URL(string: model[0].img!), placeholderImage: UIImage(named: ""))
            }
           
     
        }).disposed(by: disposeBag)

    }

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
