//
//  dataModel.swift
//  Gabayo
//
//  Created by SC 4/18/23.
//

import Foundation
import AVFoundation
class datamodel: NSObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    static let shared = datamodel()
    var gabayArray = [myGabayo]()
    var position: Int = 0
    
    
    
    
    
    
     
    func initialize() {
        gabayArray.append(myGabayo(gabayName: "jiinleey", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))

        gabayArray.append(myGabayo(gabayName: "ilig-daldala", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))
        gabayArray.append(myGabayo(gabayName: "minaale", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))
        gabayArray.append(myGabayo(gabayName: "dardaaran", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))
        gabayArray.append(myGabayo(gabayName: "daboolane", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))
        gabayArray.append(myGabayo(gabayName: "saha-kacay", gabyaaName: "Sayid Mohamed", imageName: "Sayidka"))
        gabayArray.append(myGabayo(gabayName: "casiisoow", gabyaaName: "Abdullahi Timacade", imageName: "Timacade"))
        gabayArray.append(myGabayo(gabayName: "gubaabo", gabyaaName: "Ahmed Heelaale", imageName: "heelaale"))
        gabayArray.append(myGabayo(gabayName: "garnaqsi", gabyaaName: "Abdullahi Dhodaan", imageName: "Dhodan"))



    }
    
    func loadAudioFiles(){
       
        let gabayPosition = gabayArray[position]
         let urlString = Bundle.main.path(forResource: gabayPosition.gabayName, ofType: "mp3")

        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            player = try AVAudioPlayer(contentsOf: URL(string: urlString!)!)
            player?.volume = 0.1
            player?.play()
            player?.delegate = self


        }
        catch{
            print("Error loading music: \(error.localizedDescription)")
        }
        

    }

    
}
