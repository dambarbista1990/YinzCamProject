//
//  SpinerView.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/21/20.
//

import Foundation
import UIKit

var viewSpinner: UIView? // Making these global so i get this in both below methods
extension UIViewController {
    
    func showSpinner(on view: UIView)  {
        
        let spinnerView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        spinnerView.backgroundColor = UIColor(red:0.75, green:0.92, blue:0.96, alpha:1.0)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            view.addSubview(spinnerView)
        }
        
        viewSpinner = spinnerView
    }
    
    
    static func removeSpinner() {
        DispatchQueue.main.async {
            viewSpinner?.removeFromSuperview()
            viewSpinner = nil
        }
    }
    
}
