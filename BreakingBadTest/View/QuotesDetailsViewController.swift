//
//  QuotesDetailsViewController.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import UIKit
import RxCocoa
import RxSwift
class QuotesDetailsViewController: UIViewController {
    var quoteID : Int?
    private let service = ModelService()
    private let disposeBag = DisposeBag()
   // private var model = [QuotesModel]()
    private var quotesViewModel = [QuotesViewModel]()
    @IBOutlet weak var quoteidLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // display quotes by id with rxswift
        service.fetchQuoteswithID(id : quoteID ?? 2, query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
            
            self.quotesViewModel = model.map({return QuotesViewModel(Quotes: $0)})
            
           // self.model.append(contentsOf: model)
            DispatchQueue.main.async {
               

           //     self.quoteLabel.text = self.quotesViewModel[0].quote
                self.authorLabel.text = self.quotesViewModel[0].author

                // store data to keychain ..example
                let data = Data(from: model[0].author)
                let status = KeyChain.save(key: "Author", data: data)
                print("status: ", status)
                    // retrieving data from keychain an example
                if let receivedData = KeyChain.load(key: "Author") {
                    let result = receivedData.to(type: String.self)
                    print("result: ", result)
                }
                
                
            }
           
     
        }).disposed(by: disposeBag)
        
    }
    

 
    @IBAction func backBtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
