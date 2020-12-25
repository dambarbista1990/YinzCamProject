//
//  ScheduleData.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/12/20.
//

import Foundation

struct ScheduleData: Codable {
    var gameList: GameList
    
    enum CodingKeys: String, CodingKey {
        case gameList = "GameList"
    }
}

struct GameList: Codable {
    
    var team: Team
    var gameSection: [GameSection]
    
    enum CodingKeys: String, CodingKey {
        case  team = "Team"
        case gameSection = "GameSection"
    }
}


struct Team: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name  = "-Name"
    }
}


struct GameSection: Codable {
    var heading: String
    var game: GameUnion
    
    enum CodingKeys: String, CodingKey {
        case heading = "-Heading"
        case game = "Game"
    }
}


enum GameUnion: Codable {
    
    case gameDict(Game)
    case gameArray([Game])
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let gameArrayContainer = try? container.decode([Game].self) {
            self = .gameArray(gameArrayContainer)
            return
        }
        if let gameContainer = try? container.decode(Game.self) {
            self = .gameDict(gameContainer)
            return
        }
        throw DecodingError.typeMismatch(GameUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GameUnion"))
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .gameDict(let dictData):
            try container.encode(dictData)
        case .gameArray(let arrayData):
            try container.encode(arrayData)
        }
    }
}


struct Game: Codable {
    
    var week: String?
    var gameState: String?
    var type: String?
    var date: gameDate?
    var opponent: Opponent?
    
    enum CodingKeys: String, CodingKey {
        case week  = "-Week"
        case gameState = "-GameState"
        case type = "-Type"
        case date = "Date"
        case opponent = "Opponent"
    }
}


struct gameDate: Codable {
    
    var timeStamp: Date?
    var time: String?
    
    enum CodingKeys: String, CodingKey {
        case timeStamp  = "-Timestamp"
        case time  = "-Time"
    }
}


struct Opponent: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name  = "-Name"
    }
}






