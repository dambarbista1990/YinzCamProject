//
//  ViewController.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/12/20.
//

import UIKit

class ScheduleVC: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var dataManager = APIdataManager()
    var scheduleData: ScheduleData?
    static var imageCache: [URL: UIImage] = [:] // This will chache the logoImage

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.showSpinner(on: self.view)
        dataManager.apiErrorHandler = self
        dataManager.fetchData(completionOn: APIdataHandler())
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.58, green:0.85, blue:0.79, alpha:1.0)
    }
    
    
    func APIdataHandler() -> (ScheduleData) -> Void  { // getting json data using closure
        
        let handler = {(data: ScheduleData) in
            
            DispatchQueue.main.async {
                
                self.scheduleData = data
                self.tableView.reloadData()
            }
        }
        return handler
    }
}

extension ScheduleVC: APIerrorHandler {
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension ScheduleVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var displaySection = Int()
        
        if let data = scheduleData {
            let gameSection = data.gameList.gameSection[1].game
            
            switch gameSection {
            
            case let .gameArray(opponetGroup):
                displaySection = opponetGroup.count
    
            case .gameDict(_):
                 displaySection += 1
            }
        }
        return displaySection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weekCell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath) as! WeekCell
        weekCell.backgroundColor = UIColor(red:0.75, green:0.92, blue:0.96, alpha:1.0)
        weekCell.layer.cornerRadius = 15
        
        weekCell.teamLogoImage.image = LogoModel.getTeamLogo()
        weekCell.opponentLogoImage.image = LogoModel.getOpponentLogo(for: indexPath.row)
        
        guard let weekData = scheduleData else {return weekCell}
        weekCell.teamLabel.text = weekData.gameList.team.name
        
        switch  weekData.gameList.gameSection[1].game {
        
        case let .gameArray(game):
            
            if  let date = game[indexPath.row].date?.timeStamp { // Formated Date
            weekCell.dateLabel.text =   DateFormat.convertDateFormater(from: date)
            }
            
            let opponentName = game[indexPath.row].opponent?.name ?? "Name not available"
            let time = game[indexPath.row].date?.time ?? "Time not available"
            let week = game[indexPath.row].week ?? "Week not available"
            
            weekCell.opponentLabel.text = opponentName
            weekCell.timeLabel.text = time
            weekCell.seasonLabel.text = week
            weekCell.typeLabel.text = ""
            weekCell.teamScoreLabel.text = "0-0"
            weekCell.opponentScoreLabel.text = "0-0"
            weekCell.vsLabel.text = "VS"
            weekCell.channelButton.setTitle("ESPN", for: .normal)
          
            if game[indexPath.row].type == "B" {
                
                weekCell.typeLabel.text = "BYE"
                weekCell.opponentLogoImage.image = .none
                weekCell.teamLogoImage.image = .none
                weekCell.opponentLabel.text = ""
                weekCell.timeLabel.text = ""
                weekCell.seasonLabel.text = week
                weekCell.teamScoreLabel.text = ""
                weekCell.opponentScoreLabel.text = ""
                weekCell.teamLabel.text = ""
                weekCell.dateLabel.text = ""
                weekCell.vsLabel.text = ""
                weekCell.channelButton.setTitle("", for: .normal)
            }
            
        case let .gameDict(game):
            
            let opponentName = game.opponent?.name ?? "Name not available"
            let time = game.date?.time ?? "Time not available"
            let week = game.week ?? "Week not available"
            
            weekCell.opponentLabel.text = opponentName
            weekCell.timeLabel.text = time
            weekCell.seasonLabel.text = week
            weekCell.typeLabel.text = ""
            weekCell.teamScoreLabel.text = "0-0"
            weekCell.opponentScoreLabel.text = "0-0"
            
        }
        
        return weekCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 10, width: 310, height:50)
        headerView.backgroundColor =  UIColor(red:0.58, green:0.85, blue:0.79, alpha:1.0)
        headerView.layer.cornerRadius = 15
        headerView.addSubview(createTitleForHeader())
        
        return headerView
        
    }
    
    
    func createTitleForHeader() -> UILabel  {
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 10, y: 10, width: 300, height: 40)
        headerLabel.text = "2021 \(scheduleData?.gameList.gameSection[1].heading ?? "")"
        headerLabel.font = .boldSystemFont(ofSize: 20)
        headerLabel.textAlignment = .right
        
        return headerLabel
    }
    
}



