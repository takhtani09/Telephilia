//
//  apiCall.swift
//  Telephilia
//
//  Created by IPS-108 on 28/03/23.
//

import Foundation

class apiCall{

    let apiKey = "c6a74af52d29a3a63724c06389823119"
    func latestMovies(completion: @escaping (MovieResults?) -> ()){
        if let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data{
                        
                        let str = String(decoding: safeData, as: UTF8.self)
                        print(str)
                        do{
                            let results =   try  decoder.decode(MovieResults.self , from: safeData)
                            
                            completion(results)
                        } catch{
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    func popularMovies(completion: @escaping (TopMovies?) -> ()){
        if let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=c6a74af52d29a3a63724c06389823119&language=en-US&page=1"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data{
                        
                        let str = String(decoding: safeData, as: UTF8.self)
                        print(str)
                        do{
                            let results =   try  decoder.decode(TopMovies.self , from: safeData)
                            
                            completion(results)
                        } catch{
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    func movieGenre(completion: @escaping (MovieGenre?) -> ()){
        if let url = URL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data{
                        
                        let str = String(decoding: safeData, as: UTF8.self)
                        print(str)
                        do{
                            let results =   try  decoder.decode(MovieGenre.self , from: safeData)
                            
                            completion(results)
                        } catch{
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
}
