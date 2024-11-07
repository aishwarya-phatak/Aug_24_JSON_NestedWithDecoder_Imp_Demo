//
//  ViewController.swift
//  Aug_24_JSON_NestedWithDecoder_Imp_Demo
//
//  Created by Vishal Jagtap on 07/11/24.
//

import UIKit

class ViewController: UIViewController {

    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: Constants.urlString)
        parseJSON(url: url!)
    }
    
    func parseJSON(url : URL){
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, res, error in
            
          let apiResponse = try! JSONDecoder().decode(APIResponse.self, from: data!)
            self.books = apiResponse.books
            print(self.books)
        })
        dataTask?.resume()
    }
}
