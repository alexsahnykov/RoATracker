//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoATrackerManager: NSObject {
    
   public static let shared = RoATrackerManager()
    
    var deepLink: RoADeeplinkManager?
    
    private override init() {}
    
    private(set) var serverID: String?
    
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
    
    public func getID() -> String? {
        let defaultSession = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url!)
        print(url!)
        urlRequest.httpMethod = "GET"
        let task = defaultSession.dataTask(with: url!) { (data, response, error) in
            print(data, response, error)
            if let error = error  {
            print(error.localizedDescription)
                return
            }
            guard let data = data else { return}
            do {
                            print("2")
                print(data)
           //     let result = try JSONDecoder().decode(Model.self, from: data)
                  return
            } catch let error {
                  return
                    print("3")
                print("Decoder Error \(error.localizedDescription)")
            }
            
            
        
        }
        
        task.resume()
        return nil
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

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trk.questmedia.ru"
        components.path = "/application/install"
       // components.percentEncodedQuery = "%3D%7B={"
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: "myapp://trk.questmedia.ru/deeplink/3477?campaign={campaign}"),
            URLQueryItem(name: "adset", value: "{adset}"),
            URLQueryItem(name: "mobile_cookie", value: "beacf1b1-1161-42d4-94fb-25929f4c7727"),
            URLQueryItem(name: "extinfo", value: "a2,com.grand.horoscope,9,1.0.9,9,Android%20SDK%20built%20for%20x86,en_US,GMT+02:00,Android,1080,1794,2.63,2,6,4,Europe/Zaporozhye&bundle_id=com.grand.horoscope&fb_bundle_version=1.0.9"),
            URLQueryItem(name: "fb_bundle_short_version", value: "9")
        ]
        return components.url
    }
}
