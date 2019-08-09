//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoATrackerManager: NSObject {
    
    public static let shared = RoATrackerManager()
    
    var deepLink: RoADeeplinkManager?
    
    private override init() {
        self.serverID = UserDefaults.standard.string(forKey: "id")
    }
    
    public private(set) var serverID: String?
    
    var trackers: [RoATracker] = []
    
}

extension RoATrackerManager: RoATrackerManagerProtocol {
    
    public func get(_ tracker: RoATracker.Type) -> RoATracker? {
        let obj = trackers.filter {type(of: $0) === tracker}
        return obj.first
    }
    
    public func add(_ tracker: RoATracker) {
        let isContain = trackers.contains {$0 === tracker }
        guard !isContain else {
            print("Tracker allready added")
            return}
        trackers.append(tracker)
    }
    
    public func remove(_ tracker: RoATracker) {
        trackers.remove(tracker as AnyObject)
    }
    
    public func checkSubInAll() {
        trackers.forEach() {$0.install()}
    }
    
    public func geRoATrackerI() {
        //        guard serverID == nil else {
        //            print("already have ID")
        //            return
        //        }
        getIdFromRoAServer(url: self.url) { (result: Result<String, Error>) in
            switch result {
            case .success(let id):
                self.serverID = id
                print(id)
                UserDefaults.standard.set(id, forKey: "id")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func getIdFromRoAServer(url: URL?, completion: @escaping (Result<String, Error>)-> ()) {
        let testUrl = URL(string: "https://trk.questmedia.ru/application/install?deeplink=deeptest%3A%2F%2Ftrack%2Fhteh%2F123%2Fghtht&mobile_cookie=99c4cab0-526b-47bc-b1b1-c34d27b62897&extinfo=a2%2Ccom.app.deeplinks%2C1%2C1.0%2C8.0.0%2CFIG-LX1%2Cen_GB%2CGMT%2B03%3A00%2C%2C1080%2C2032%2C3.0%2C8%2C23%2C18%2CEurope%2FMoscow&bundle_id=com.app.deeplinks")
        //             https://trk.questmedia.ru/application/install?deeplink=deeptest://track/hteh/123/ghtht&mobile_cookie=99c4cab0-526b-47bc-b1b1-c34d27b62897&extinfo=a2%252Ccom.app.deeplinks%252C1%252C1.0%252C8.0.0%252CFIG-LX1%252Cen_GB%252CGMT%252B03%253A00%252C%252C1080%252C2032%252C3.0%252C8%252C23%252C18%252CEurope%252FMoscow
        //
        
        
        let defaultSession = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url!)
        print(url!)
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

extension RoATrackerManager  {
    
    public  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // serverID = getID()
        for tracker in trackers {
            let _ = tracker.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
}

extension RoATrackerManager {
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trk.questmedia.ru"
        components.path = "/application/install"
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: "deeptest://track/hteh/123/ghtht"),
            //        URLQueryItem(name: "adset", value: "adset"),
            URLQueryItem(name: "mobile_cookie", value: "99c4cab0-526b-47bc-b1b1-c34d27b62897"),
            URLQueryItem(name: "extinfo", value: "a2%2Ccom.app.deeplinks%2C1%2C1.0%2C8.0.0%2CFIG-LX1%2Cen_GB%2CGMT%2B03%3A00%2C%2C1080%2C2032%2C3.0%2C8%2C23%2C18%2CEurope%2FMoscow"),
            URLQueryItem(name: "bundle_id", value: "com.app.deeplinks"),
            URLQueryItem(name: "fb_bundle_version", value: "1.0"),
            URLQueryItem(name: "fb_bundle_short_version", value: "1")
        ]
        return components.url
    }
}


