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
            testingPrint("[RoA Tracker server]: already have id")
            return
        }
        
        let url = urlConfigurator.getInstallUrl(type)
        
        getIdFromRoAServer(url: url) { (result: Result<(String,String), Error>) in
            switch result {
            case .success(let responce):
                testingPrint("[RoA Tracker server]: Get id responce \((responce.0, responce.1))")
                self.serverId = responce.0
            case .failure(let error):
                testingPrint("[RoA Tracker server]: Get  id error \(error.localizedDescription)")
            }
        }
    }
    
    private func getIdFromRoAServer(url: URL?, completion: @escaping (Result<(String,String), Error>) -> Void) {
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
            
            do {
                //let result = try JSONDecoder().decode(RoAServerResponse.Self, from: data)
                let str = String(decoding: data, as: UTF8.self)
                let responce = (str,response.debugDescription)
                completion(.success(responce))
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
    
    public func event(_ event: EventList) {
        
    }
    
    public func trial(_ event: Eventable) {
        
    }
    
    public func customEvent(_ event: Eventable) {
        
    }
    
    public func purchase(_ purchase: Purchase) {
        let url = urlConfigurator.getPurchaseUrl(serverId ?? "", transactionID: purchase.transactionId)
        self.getIdFromRoAServer(url: url) { (result: Result<(String,String), Error>) in
            switch result {
            case .success(let success):
                testingPrint("[RoA Tracker server]: Sent purchase responce \(success.1)")
            case .failure(let err):
                testingPrint("[RoA Tracker server]: Sent purchase error \(err.localizedDescription)")
            }
        }
    }
    
    public func install() {
        
    }
    
}
