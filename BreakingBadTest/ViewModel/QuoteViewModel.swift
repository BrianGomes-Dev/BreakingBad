//
//  QuoteViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
import RxSwift
final class QuoteViewModel {
    let title = "Quotes"
    private let modelservice : ModelServiceProtocol
    
    init(modelservice : ModelServiceProtocol = ModelService()) {
        self.modelservice = modelservice
    }
    
    func fetchQuoteviewModel() -> Observable<[QuoteListViewModel]> {
        modelservice.fetchQuotes().map { $0.map {QuoteListViewModel(quote: $0)}
            
        }
    }
}
