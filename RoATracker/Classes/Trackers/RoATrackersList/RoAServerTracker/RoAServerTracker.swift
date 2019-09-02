//
//  RoAServerTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoAServerTracker: NSObject {
    
    public weak var delegate: RoATrackerManagerDelegate? 
    
    public var serverId: String?
    
    private var urlConfigurator: RoAServerTrackerURLConfigurator
    
    public func getServerId() {
        guard serverId == nil else {
            print("already have ID")
            return
        }
        getIdFromRoAServer(url: self.urlConfigurator.getUrl()) { (result: Result<String, Error>) in
            switch result {
            case .success(let id):
                self.serverId = id
                print(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getIdFromRoAServer(url: URL?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = url else {return}
        let defaultSession = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url)
        print(url)
        urlRequest.httpMethod = "GET"
        let task = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error  {
                completion(.failure(error))
                return
            }
            guard let data = data else { return}
            print(data.base64EncodedString())
            do {
                //let result = try JSONDecoder().decode(RoAServerResponse.Self, from: data)
                let str = String(decoding: data, as: UTF8.self)
                completion(.success(str))
            } //catch let error {
            //  completion(.failure(error))
            //   return
            // }
        }
        task.resume()
    }
    public init(urlConfigurator: RoAServerTrackerURLConfigurator) {
        self.urlConfigurator = urlConfigurator
    }
    
}

extension RoAServerTracker: RoATracker {
 
    
  
    public func trial(_ event: Eventable) {
        
    }
    
    
    public func purchaseByPrice(_ price: Double) {
    }
    
    
    public func customEvent(_ event: Eventable) {
        
    }
    
    public func purchase(_ purchase: Purchase) {
        
    }
    
    public func install() {
  
    }
    
}
