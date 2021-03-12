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
//    private let apiClient = ModelService()
    private let disposeBag = DisposeBag()
   private let service = ModelService()
    private var viewModel : CharacterViewModel!
  
    @IBOutlet weak var tableView: UITableView!
    var model = [CharactersModel]()
    
//    static func instanstiate(viewmodel : CharacterViewModel) -> CharacterViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let viewController = storyboard.instantiateInitialViewController() as! CharacterViewController
//        return viewController
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = viewModel.title
//        viewModel.fetchCharacterviewModel().observe(on: MainScheduler.instance).bind(to : tableView.rx.items(cellIdentifier: "characterCell")) { index , viewModel, cell in
//            cell.textLabel?.text = ""
//            print(viewModel.displayBirthday)
//            print(viewModel.displayName)
//            print(viewModel.displayOccupation)
//            print(viewModel.displayNickname)
//            print(viewModel.displayBirthday)
//            print(viewModel.displayBirthday)
//            print(viewModel.displayBirthday)
//            print(viewModel.displayImage)
//
//
//        }.disposed(by: disposeBag)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
               service.fetchCharacters().subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
                print("mycount is \(self.model.count)")
                print(self.model)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
//                self.tableView.reloadData()
               }).disposed(by: disposeBag)
//        self.tableView.reloadData()
      
    }
    

    


}
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
