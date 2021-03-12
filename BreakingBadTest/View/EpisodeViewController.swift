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
   var model = [EpisodesModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // get the episodes with rxswift
       
               service.fetchEpisodes(query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               }).disposed(by: disposeBag)
    }
    



}

// table view delegates and datasource
extension EpisodeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell")
        cell?.textLabel?.text = model[indexPath.row].title
        cell?.detailTextLabel?.text =  model[indexPath.row].season
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "episdoedetailsVC") as! EpisodesDetailsViewController
      
        vc.ID = model[indexPath.row].episodeID
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
