//
//  RoAServerTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoAServerTracker: NSObject {
    
    private var serverId: String?
    
    private var urlConfigurator = RoAServerTackerURLConfigurator()
    

    
    private func getServerId() {
        guard serverId == nil else {
            print("already have ID")
            return
        }
        getIdFromRoAServer(url: self.urlConfigurator.getUrl()) { (result: Result<String, Error>) in
            switch result {
            case .success(let id):
                self.serverId = id
                UserDefaults.standard.set(id, forKey: "id")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

    
    private func getIdFromRoAServer(url: URL?, completion: @escaping (Result<String, Error>)-> ()) {
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
                //let result = try JSONDecoder().decode(Responce.self, from: data)
                let str = String(decoding: data, as: UTF8.self)
                completion(.success(str))
            } //catch let error {
            //  completion(.failure(error))
            //   return
            // }
        }
        task.resume()
    }
    
}

extension RoAServerTracker: RoATracker {
   
    public func createEvent(_ eventNmae: String) {
        
    }
    
    public func purchase() {
        
    }
    
    public func install() {
    }
    
    public func registerTracker(_ deeplink: NSURL? = nil) {
        self.urlConfigurator.deeplink = deeplink
    }
    
  

    
}
