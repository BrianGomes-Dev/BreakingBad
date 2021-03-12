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
    @IBOutlet weak var quoteidLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // display quotes by id with rxswift
        service.fetchQuoteswithID(id : quoteID ?? 1).subscribe(onNext:{ model in
            DispatchQueue.main.async {
               

                self.quoteLabel.text = model[0].quote
                self.authorLabel.text = model[0].author

                    
                
                
            }
           
     
        }).disposed(by: disposeBag)
    }
    

 
    @IBAction func backBtnpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
