//
//  QuoteListViewModel.swift
//  TheBreakingBad
//
//  Created by 100 on 12.03.2021.
//

import Foundation
struct QuoteListViewModel {
    
    private let quote : QuotesModel
   
    var displayAuthor : String {
        return quote.author!
    }
    
    var displayQuote : String {
        return quote.quote!
    }
    var displayId : Int {
        return quote.quote_id!
    }
    
//    func numberOfRowsInSection() -> Int {
//        return character.
//       }
    init (quote : QuotesModel) {
        self.quote = quote
        
    }
}
