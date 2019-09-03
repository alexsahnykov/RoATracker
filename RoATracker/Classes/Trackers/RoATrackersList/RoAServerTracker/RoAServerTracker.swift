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
    
    public func getServerId(_ type: DeeplinkType) {
        guard serverId == nil else {
            testingPrint("already have ID")
            return
        }
        
        let url = urlConfigurator.getInstallUrl(type)
        
        getIdFromRoAServer(url: url) { (result: Result<String, Error>) in
            switch result {
            case .success(let id):
                self.serverId = id
                testingPrint(id)
            case .failure(let error):
                testingPrint(error.localizedDescription)
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
            testingPrint(data.base64EncodedString())
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
    
    public func customEvent(_ event: Eventable) {
        
    }
    
    public func purchase(_ purchase: Purchase) {
        let id = serverId ?? ""
//GET /application/purchase?id=168654&original_transaction_id=GPA.3328-4847-0183-20450&bundle_id=com.spirit.astrologer
    }
    
    public func install() {
  
    }
    
}
