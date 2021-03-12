//
//  EpisodesDetailsViewController.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
class EpisodesDetailsViewController: UIViewController {
    var ID : Int?
    private let service = ModelService()
    private let disposeBag = DisposeBag()
    private var model = [EpisodesModel]()
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var episodeidlLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display episodes by id with rxswift
        service.fetchEpisodesWithId(id: ID ?? 1, query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
            self.model.append(contentsOf: model)
            DispatchQueue.main.async {
                self.charactersLabel.text = model[0].characters!.joined(separator: ",")

                self.seasonLabel.text = model[0].season
                self.titleLabel.text = model[0].title
                self.episodeLabel.text = model[0].airDate
                  
                
                // store data to keychain..example 
                let data = Data(from: model[0].season)
                let status = KeyChain.save(key: "Season", data: data)
                print("status: ", status)
                    // retrieving data from keychain an example
                if let receivedData = KeyChain.load(key: "Season") {
                    let result = receivedData.to(type: String.self)
                    print("result: ", result)
                }
                
            }
           
     
        }).disposed(by: disposeBag)
        
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
