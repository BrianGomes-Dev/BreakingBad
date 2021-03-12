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
class CharacterViewController: UIViewController {

    private let disposeBag = DisposeBag()
   private let service = ModelService()
    
  
    @IBOutlet weak var tableView: UITableView!
    var model = [CharactersModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        
               service.fetchCharacters().subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
                print("mycount is \(self.model.count)")
                print(self.model)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               

               }).disposed(by: disposeBag)

      
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
