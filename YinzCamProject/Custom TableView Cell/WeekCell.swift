//
//  WeekCell.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/14/20.
//

import UIKit

class WeekCell: UITableViewCell {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var opponentLogoImage: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var opponentLabel: UILabel!
    @IBOutlet weak var teamScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var channelButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    
    // This for give space between row
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
   
}
