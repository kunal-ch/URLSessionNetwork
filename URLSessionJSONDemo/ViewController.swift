//
//  ViewController.swift
//  URLSessionJSONDemo
//
//  Created by Kunal Chauhan on 18/02/20.
//  Copyright © 2020 Kunal Chauhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getButton(_ sender: Any) {
        
        print("Button Pressed")
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users")  {
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(data)
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
            }
            }.resume()
        }
    }
    
    @IBAction func postButton(_ sender: Any) {
        
        let parameters = ["username": "@kunal", "tweet": "HelloWorld"]
        guard let paramsJson = try? JSONSerialization.data(withJSONObject: parameters, options: [])else { return }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramsJson
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

