//
//  QuoteViewController.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
class QuoteViewController: UIViewController {
    private var viewModel : QuoteViewModel!
    @IBOutlet weak var tableView: UITableView!
    var model = [QuotesModel]()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = viewModel.title
//        viewModel.fetchQuoteviewModel().observe(on: MainScheduler.instance).bind(to : tableView.rx.items(cellIdentifier: "quoteCell")) { index , viewModel, cell in
//
//            print(viewModel.displayId)
//            print(viewModel.displayQuote)
//            print(viewModel.displayAuthor)
//
//        }
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        let service = ModelService()
               service.fetchQuotes().subscribe(onNext:{ model in
                self.model.append(contentsOf: model)
                print(model)
//
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               }).disposed(by: disposeBag)
    }
    

}
extension QuoteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell") as! QuoteTableViewCell
        cell.textLabel!.text = model[indexPath.row].author
        cell.detailTextLabel!.text =  model[indexPath.row].quote
        
        return cell
    }
    
    
}
