//
//  ScheduleDataManager.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/12/20.
//

import Foundation

protocol APIerrorHandler {
    
    func didFailWithError(error: Error)
}

struct APIdataManager {
    
    var apiErrorHandler: APIerrorHandler?
    
    func fetchData(completionOn: @escaping (ScheduleData) -> ()) {
        
        let url = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json"
        let urlString = URL(string: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            
            if error != nil {
                apiErrorHandler?.didFailWithError(error: error!)
            }
            
            if let safeData = data {
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decodedData =  try decoder.decode(ScheduleData.self, from: safeData)
                    ScheduleVC.removeSpinner()
                    completionOn(decodedData)
                    
                } catch {
                    apiErrorHandler?.didFailWithError(error: error)
                }
            }
        }
        dataTask.resume()
    }
}





