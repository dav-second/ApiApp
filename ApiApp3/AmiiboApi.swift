//
//  AmiiboApi.swift
//  ApiApp3
//
//  Created by David Taddese on 22/11/2022.
//

import Foundation

final class AmiiboApi{
    
    static let shared = AmiiboApi()
    
    func fetchAmiiboList( onCompletion : @escaping ([Amiibo]) -> ()) {
        
        let urlString = "https://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            // handling data
            guard let data = data else {
                print("data was nil")
                return
            }
            
            // decoding amibo
            guard let amiibolist = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("could not decode json")
                return
            }
            
            onCompletion(amiibolist.amiibo)
        }
        task.resume()       
    }

}

struct AmiiboList : Codable{
    let amiibo : [Amiibo]
}
// amiibo represented in swift
struct Amiibo : Codable {
    
    let amiiboSeries: String
    let character : String
    let gameSeries : String
    let head : String
    let image: String
    let name : String
    let release : AmiiboRelease
    let tail : String
    let type : String
}

struct AmiiboRelease : Codable {
    let au : String?
    let eu : String?
    let jp : String?
    let na : String?
    
}

/*
 
 // amiibo represented in JSON
 {
"amiiboSeries": "Super Smash Bros.",
            "character": "Mario",
             "gameSeries": "Super Mario",
             "head": "00000000",
             "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png",
             "name": "Mario",
             "release": {
                 "au": "2014-11-29",
                 "eu": "2014-11-28",
                 "jp": "2014-12-06",
                 "na": "2014-11-21"
             },
             "tail": "00000002",
             "type": "Figure"
         },
 
 */
