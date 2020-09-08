import Foundation
import UIKit

class HttpRequestor {
    @discardableResult
    public static func Get<T: Decodable>(endpoint:String, headers: [String:String] = [:],  onComplete: @escaping (Int,(Result<T?, Error>)) -> Void)
        -> URLSessionDataTask {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "GET"
        for (key, val) in headers {
                request.setValue(val, forHTTPHeaderField: key)
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, err in
            let httpResponse = response as? HTTPURLResponse
            if let err = err {
                onComplete(500,.failure(err))
              return
            }
            if httpResponse == nil {
                onComplete(500,.failure(AppError(msg: "No data!")))
                return
            }
            guard let resp = data, let obj = try? JSONDecoder().decode(T.self, from: resp) else {
                do {
                   let _ = try JSONDecoder().decode(T.self, from: data!)
                    
                } catch {
                    var res = String(data: data!, encoding: .utf8)
                    print("*********")
                    print(res)
                    print("------> ", error)
                }
                onComplete(500,.failure(AppError(msg: "bad response")))
                return
            }
            onComplete(httpResponse!.statusCode,.success(obj))
        })
        task.resume()
        return task
    }
}
