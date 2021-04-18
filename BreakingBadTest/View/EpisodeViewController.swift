//
//  EpisodeViewController.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit
import RxCocoa
import RxSwift

class EpisodeViewController: UIViewController {
    
    private let service = ModelService()
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    //var model = [EpisodesModel]()
    var episodesViewModel = [EpisodeViewModel]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        //model.removeAll()
       // model = []
        episodesViewModel.removeAll()
        // get the episodes with rxswift
        
        service.fetchEpisodes(query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
            //self.model.append(contentsOf: model)
            self.episodesViewModel = model.map({return EpisodeViewModel(Episodes: $0)})
            //print(model.count)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
    }
}
// table view delegates and datasource
extension EpisodeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell")
        if indexPath.row < episodesViewModel.count {
            cell?.textLabel?.text = episodesViewModel[indexPath.row].episodeTitle
            cell?.detailTextLabel?.text = episodesViewModel[indexPath.row].seasonNum
           // cell?.textLabel?.text = model[indexPath.row].title
           // cell?.detailTextLabel?.text =  model[indexPath.row].season
            
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "episdoedetailsVC") as! EpisodesDetailsViewController
        
        vc.ID = episodesViewModel[indexPath.row].episode_id
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
