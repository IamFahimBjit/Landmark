//
//  JsonHandler.swift
//  Landmarks
//
//  Created by Md Fahim Faez Abir-00127 on 28/6/24.
//

import Foundation

class JsonHandler {
    
    static let shared = JsonHandler()
    
    private init() {}
    
    func getData() async -> Result<[Landmarks], Error>? {
        let filePath = Bundle.main.path(forResource: "landmarkData", ofType: "json")
        guard let filePath = filePath else { return nil }
        let fileUrl = URL(fileURLWithPath: filePath)
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: fileUrl, completionHandler: { [weak self] data, _, error in
                guard let data = data, self != nil else {
                    continuation.resume(returning: .failure(NSError(domain: "JsonHandlerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Data not available or JsonHandler deallocated"])))
                    return
                }
                do {
                    let landmarks = try JSONDecoder().decode([Landmarks].self, from: data)
                    continuation.resume(returning: .success(landmarks))
                } catch {
                    continuation.resume(returning: .failure(error))
                }
                
            }).resume()
        }
    }
}
