//
//  TeamsLogoModel.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/19/20.
//

import Foundation
import UIKit

struct LogoModel {
    
    static var loadedImage = UIImage()
    
    static var opponentLogo = [
        
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_was_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_atl_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_det_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_gb_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_nyj_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_min_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_dal_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_buf_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_chi_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_bye_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_ne_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_sea_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_mia_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_nyg_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_was_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_dal_light.png")!),
        LogoUrl(url: URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_nyg_light.png")!),
        
    ]
    
    static func getOpponentLogo(for row: Int) -> UIImage {
        
        if let image = ScheduleVC.imageCache[opponentLogo[row].url] {
            return image
        }
        
        if let imageData = try? Data(contentsOf: opponentLogo[row].url) {
            loadedImage = UIImage(data: imageData)!
            ScheduleVC.imageCache[opponentLogo[row].url] = loadedImage
        }
        
        return loadedImage
    }
    
    
    static func getTeamLogo() -> UIImage {
        
        if  let imageUrl = URL(string: "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_phi_light.png") {
            
            if let image = ScheduleVC.imageCache[imageUrl] {
                return image
            }
            
            if  let imageData =  try? Data(contentsOf: imageUrl)   {
                loadedImage = UIImage(data: imageData)!
                
                ScheduleVC.imageCache[imageUrl] = loadedImage
            }
        }
        
        return loadedImage
    }
}


