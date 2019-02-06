//
//  NoteController.swift
//  One Line a Day
//
//  Created by Moses Robinson on 2/4/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://one-line-a-day-backend.herokuapp.com/api")!

enum httpMethod: String {
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class LineController {
    
    func fetchLines(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("lines").appendingPathComponent("testcalls").appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("unable to decode: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let linesDictionary = try jsonDecoder.decode([Line].self, from: data)
                    
                    self.lines = linesDictionary
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
    func createLine(lineString: String, date: String, completion: @escaping (Error?) -> Void) {
        let line = Line(line: lineString, date: date)
        put(line: line, completion: completion)
    }
    
    // Delete Note
    
    func delete(line: Line, completion: @escaping (Error?) -> Void) {
        
        
        
    }
    
    // Update line and server
    func updateLine(line: Line, lineString: String, completion: @escaping (Error?) -> Void) {
        guard let index = lines.index(of: line) else { return }
        
        lines[index].line = lineString
        
        put(line: lines[index], completion: completion)
    }
    
    // FETCH from server
    // PUT to server
    
    func put(line: Line, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("lines").appendingPathComponent("testcall")
            .appendingPathExtension("json")
        
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
    
    
    // MARK: - Properties
    
    private(set) var lines: [Line] = []
    
}
