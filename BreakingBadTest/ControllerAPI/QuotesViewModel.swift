//
//  QuotesViewModel.swift
//  BreakingBadTest
//
//  Created by Brian Gomes on 18/04/2021.
//

import Foundation

struct QuotesViewModel{
    
    let quote_id: Int?
    let quote: String?
    let author: String?
    
    init(Quotes: QuotesModel){
        self.quote_id = Quotes.quote_id
        self.quote = Quotes.quote
        self.author = Quotes.author
    }
}
