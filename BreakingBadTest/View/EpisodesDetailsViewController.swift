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
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var episodeidlLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        service.fetchEpisodesWithId(id: ID ?? 1).subscribe(onNext:{ model in
            DispatchQueue.main.async {
                self.charactersLabel.text = model[0].characters!.joined(separator: ",")
//                self.episodeidlLabel.text = "\(model[0].episodeID!)"
                self.seasonLabel.text = model[0].season
                self.titleLabel.text = model[0].title
                self.episodeLabel.text = model[0].airDate
                    
                
                
            }
           
     
        }).disposed(by: disposeBag)
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
