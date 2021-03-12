//
//  ModelService.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
import RxSwift

protocol ModelServiceProtocol {
    func fetchCharacters() -> Observable<[CharactersModel]>
    func fetchEpisodes() -> Observable<[EpisodesModel]>
    func fetchQuotes() -> Observable<[QuotesModel]>
}
class ModelService : ModelServiceProtocol {
   
    
    // create a method for calling api which is return a Observable
    func fetchCharacters() -> Observable<[CharactersModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = URLSession.shared.dataTask(with: URL(string :Constants.BASE_URL + Constants.GET_CHARACTERS )!) { data, _, _ in
            
                    guard let data = data else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return
                    }
            
                    do {
                        let character = try JSONDecoder().decode([CharactersModel].self, from: data)
                        observer.onNext(character)
                    } catch {
                        print("error is : \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
                task.resume()
                return Disposables.create{
                    task.cancel()
                }
            }
        }
    func fetchCharactersWithId(id: Int) -> Observable<[CharactersModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = URLSession.shared.dataTask(with: URL(string :Constants.BASE_URL + Constants.GET_CHARACTERS + "/\(id)")!) { data, _, _ in
            
                    guard let data = data else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return
                    }
            
                    do {
                        let character = try JSONDecoder().decode([CharactersModel].self, from: data)
                        observer.onNext(character)
                    } catch {
                        print("error is : \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
                task.resume()
                return Disposables.create{
                    task.cancel()
                }
            }
        }
   
    func fetchEpisodes() -> Observable<[EpisodesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = URLSession.shared.dataTask(with: URL(string :Constants.BASE_URL + Constants.GET_EPISODES )!) { data, _, _ in
            
                    guard let data = data else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return
                    }
            
                    do {
                        let character = try JSONDecoder().decode([EpisodesModel].self, from: data)
                        observer.onNext(character)
                    } catch {
                        print("error is : \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
                task.resume()
                return Disposables.create{
                    task.cancel()
                }
            }
        }
   
    func fetchQuotes() -> Observable<[QuotesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = URLSession.shared.dataTask(with: URL(string :Constants.BASE_URL + Constants.GET_QUOTES )!) { data, _, _ in
            
                    guard let data = data else {
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                        return
                    }
            
                    do {
                        let character = try JSONDecoder().decode([QuotesModel].self, from: data)
                        observer.onNext(character)
                    } catch {
                        print("error is : \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
                task.resume()
                return Disposables.create{
                    task.cancel()
                }
            }
        }
}
