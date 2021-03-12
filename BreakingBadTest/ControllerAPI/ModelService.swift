//
//  ModelService.swift
//  TheBreakingBad
//
//  Created by 100 on 11.03.2021.
//

import Foundation
import RxSwift
import RxCocoa
protocol ModelServiceProtocol {
    func fetchCharacters() -> Observable<[CharactersModel]>
    func fetchEpisodes() -> Observable<[EpisodesModel]>
    func fetchQuotes() -> Observable<[QuotesModel]>
}
class ModelService  {
    
    // create a method for calling api which is return a Observable
    
    func fetchCharacters(query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[CharactersModel]> {
            
            return Observable.create { observer -> Disposable in

                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_CHARACTERS )!)
                { data, _, _ in
            
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
    
    
    
    // fetching the characters from the API
//    func fetchCharacters() -> Observable<[CharactersModel]> {
//
//            return Observable.create { observer -> Disposable in
//
//                let task = URLSession.shared.dataTask(with: URL(string :Constants.BASE_URL + Constants.GET_CHARACTERS )!)
//                { data, _, _ in
//
//                    guard let data = data else {
//                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
//                        return
//                    }
//
//                    do {
//
//                        let character = try JSONDecoder().decode([CharactersModel].self, from: data)
//                        observer.onNext(character)
//
//                    } catch {
//                        print("error is : \(error.localizedDescription)")
//                        observer.onError(error)
//                    }
//                }
//                task.resume()
//                return Disposables.create{
//                    task.cancel()
//                }
//            }
//        }
    
    // fetch a single character with its id
    func fetchCharactersWithId(id: Int, query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[CharactersModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_CHARACTERS + "/\(id)")!) { data, _, _ in
            
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
    
    // fetch a single episode with its id
    func fetchEpisodesWithId(id : Int, query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[EpisodesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_EPISODES + "/\(id)")!) { data, _, _ in
            
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
// fetch episodes from api
    func fetchEpisodes(query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[EpisodesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_EPISODES )!) { data, _, _ in
            
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
    
   // fetch quotes with its id
    func fetchQuoteswithID(id : Int, query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[QuotesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_QUOTES + "/\(id)" )!) { data, _, _ in
            
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
    
    // fetch quotes from api
    func fetchQuotes(query: String, _ needsMoreData: Bool, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[QuotesModel]> {
            
            return Observable.create { observer -> Disposable in
                
                let task = dataTask(URL(string :Constants.BASE_URL + Constants.GET_QUOTES )!) { data, _, _ in
            
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
