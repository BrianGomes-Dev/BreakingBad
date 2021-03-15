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
    private var model = [QuotesModel]()
   
    @IBOutlet weak var quoteidLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // display quotes by id with rxswift
        service.fetchQuoteswithID(id : quoteID ?? 2, query: "", false, dataTask: URLSession.shared.dataTask(with:completionHandler:)).subscribe(onNext:{ model in
            self.model.append(contentsOf: model)
            DispatchQueue.main.async {
               

                self.quoteLabel.text = model[0].quote
                self.authorLabel.text = model[0].author

                // store data to keychain
                let data = Data(from: model[0].author)
                let status = KeyChain.save(key: "Author", data: data)
                print("status: ", status)
                    // retrieving data from keychain
                if let receivedData = KeyChain.load(key: "Author") {
                    let result = receivedData.to(type: String.self)
                    print("result: ", result)
                }
                
                
            }
           
     
        }).disposed(by: disposeBag)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
 
    @IBAction func backBtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
