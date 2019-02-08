//
//  NoteController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://one-line-36d4f.firebaseio.com/")!

enum httpMethod: String {
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class LineController {
    
    func fetchLines(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("unable to decode: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
               // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let linesDictionary = try jsonDecoder.decode([String : Line].self, from: data)
                    let lines = linesDictionary.map({ $0.value }).sorted(by: {$0.date > $1.date })
                    self.lines = lines
                    completion(nil)
                } catch {
                    NSLog("could not decode data.")
                    completion(error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    // Create Note
    func createLine(lineString: String, completion: @escaping (Error?) -> Void) {
        let line = Line(line: lineString)
        put(line: line, completion: completion)
    }
    
    // Update line and server
    func updateLine(line: Line, lineString: String, completion: @escaping (Error?) -> Void) {
        guard let index = lines.index(of: line) else { return }
        lines[index].line = lineString
        put(line: lines[index], completion: completion)
    }
    
    // PUT to server
    
    func put(line: Line, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(line.identifier!).appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.put.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(line)
        } catch {
            NSLog("error encoding line")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("error trying to PUT data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    // DELETE from server
    
    func delete(line: Line, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(line.identifier!).appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.delete.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("error trying to delete data: \(error)")
                completion(error)
                return
            }
            
            guard let index = self.lines.index(of: line) else { return }
            self.lines.remove(at: index)
            completion(nil)
        }
        dataTask.resume()
    }
    
    // MARK: - Properties
    
    private(set) var lines: [Line] = []
    
}
