//
//  PlayerViewController.swift
//  Gabayo
//
//  Created by SC on 4/18/23.
//

import UIKit
import AVFoundation


class PlayerViewController: UIViewController, AVAudioPlayerDelegate {
    

    
    var position: Int = 0
    var dataModel: datamodel!
    var timer: Timer?
   @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    var playing = false
    
    
    //imageView
    var albumCoverImage: UIImageView!
    
    // Labels
    var gabayLabel: UILabel!
    var gabyaaLabel: UILabel!
    

    
    //buttons
    var playPauseButton: UIButton!
    var forwardButton: UIButton!
    var backwardButton: UIButton!
    var repeatButton: UIButton!
    
    //sliders
    var volumeSlider: UISlider!
    var seekSlider: UISlider!
    
    
    
    
    
    //MARK: - viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.loadAudioFiles()
        styleUI()
        dataModel.player?.delegate = self

        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSeekSlider), userInfo: nil, repeats: true)
        
        //gesture recognizer
   
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //fill in if we needed
    }
    
 
      
        
    override func viewDidLayoutSubviews() {
        if holder.subviews.count == 0 {
        }
    }
        
     
    //
    func styleUI() {

        player = dataModel.player
        guard let player = player else{return}
        player.delegate = self
        let gabayPosition = dataModel.gabayArray[dataModel.position]
        
        //imageView
        albumCoverImage = UIImageView()
        albumCoverImage.translatesAutoresizingMaskIntoConstraints = false
        albumCoverImage.image = UIImage(named: gabayPosition.imageName)
        albumCoverImage.contentMode = .scaleAspectFit
        holder.addSubview(albumCoverImage)
        
        //Labels
        gabayLabel = UILabel()
        gabayLabel.text = gabayPosition.gabayName
        gabayLabel.translatesAutoresizingMaskIntoConstraints = false
        gabayLabel.backgroundColor = .systemGreen
        gabayLabel.numberOfLines = 0
        gabayLabel.font = UIFont(name: "helvetica-bold", size: 18)
        gabayLabel.textAlignment = .center
        holder.addSubview(gabayLabel)
        
        gabyaaLabel = UILabel()
        gabyaaLabel.translatesAutoresizingMaskIntoConstraints = false
        gabyaaLabel.backgroundColor = .systemGreen
        gabyaaLabel.text = gabayPosition.gabyaaName
        gabyaaLabel.numberOfLines = 0
        gabyaaLabel.textAlignment = .center
        gabyaaLabel.font = UIFont(name: "helvetica-bold", size: 15)
        holder.addSubview(gabyaaLabel)
        
        
        //volume slider
        volumeSlider = UISlider()
//        volumeSlider.maximumValue = Float(player?.duration ?? 0.0)
        volumeSlider.value = 0.1
        volumeSlider.isUserInteractionEnabled = true
        volumeSlider.isOpaque = true
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        volumeSlider.addTarget(self, action: #selector(volumeSliderChanged), for: .valueChanged)
        holder.addSubview(volumeSlider)
        
        seekSlider = UISlider()
        seekSlider.isOpaque = true
        seekSlider.isUserInteractionEnabled = true
        seekSlider.translatesAutoresizingMaskIntoConstraints = false
        seekSlider.minimumValue = 0
        seekSlider.maximumValue = Float(player.duration)
        seekSlider.addTarget(self, action: #selector(seekSliderChanged), for: .valueChanged)
        holder.addSubview(seekSlider)
        
        
        //buttons
        playPauseButton = UIButton()
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        holder.addSubview(playPauseButton)
        
        backwardButton = UIButton()
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.setBackgroundImage(UIImage(systemName: "backward.circle"), for: .normal)
        backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        
        

        holder.addSubview(backwardButton)
        
        forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.setBackgroundImage(UIImage(systemName: "forward.circle"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        
        holder.addSubview(forwardButton)
        
        
    
        
        
        
        
        NSLayoutConstraint.activate([
           //cover image
            albumCoverImage.topAnchor.constraint(equalTo: holder.layoutMarginsGuide.topAnchor, constant: 20),
            albumCoverImage.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 0),
            albumCoverImage.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: 0),
            
            //labels
            gabayLabel.topAnchor.constraint(equalTo: albumCoverImage.bottomAnchor, constant: 30),
            gabayLabel.leadingAnchor.constraint(equalTo: holder.layoutMarginsGuide.leadingAnchor, constant: 0),
            gabayLabel.trailingAnchor.constraint(equalTo: holder.layoutMarginsGuide.trailingAnchor, constant: 0),
            gabyaaLabel.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            
            gabyaaLabel.topAnchor.constraint(equalTo: gabayLabel.bottomAnchor, constant: 10),
            gabyaaLabel.leadingAnchor.constraint(equalTo: holder.layoutMarginsGuide.leadingAnchor, constant: 0),
            gabyaaLabel.trailingAnchor.constraint(equalTo: holder.layoutMarginsGuide.trailingAnchor, constant: 0),
            gabyaaLabel.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            
            
            
            //volume slider
            volumeSlider.topAnchor.constraint(equalTo: gabyaaLabel.bottomAnchor, constant: 45),
            volumeSlider.leadingAnchor.constraint(equalTo: holder.layoutMarginsGuide.leadingAnchor, constant: 15),
            volumeSlider.trailingAnchor.constraint(equalTo: holder.layoutMarginsGuide.trailingAnchor, constant: -15),
            

            
            //buttons
            playPauseButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 45),
            playPauseButton.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            backwardButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 45),
            backwardButton.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 15),
            backwardButton.widthAnchor.constraint(equalToConstant: 50),
            backwardButton.heightAnchor.constraint(equalToConstant: 50),
           
            
            forwardButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 45),
            forwardButton.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -15),
            forwardButton.widthAnchor.constraint(equalToConstant: 50),
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            //seek slider
            seekSlider.topAnchor.constraint(equalTo: forwardButton.bottomAnchor, constant: 45),
            seekSlider.leadingAnchor.constraint(equalTo: holder.layoutMarginsGuide.leadingAnchor, constant: 15),
            seekSlider.trailingAnchor.constraint(equalTo: holder.layoutMarginsGuide.trailingAnchor, constant: -15),
            
  
           
           
        
        ])
        
    }
       

    
    

    //button actions
    
    @objc func playPauseButtonTapped(){
        player = dataModel.player
        guard let player = player else{return}
        if player.isPlaying{
                    player.stop()
                    playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                }
        else{
            player.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
       
        print("inside the playpause button")
    }
    
    @objc func forwardButtonTapped(){
        if dataModel.position < dataModel.gabayArray.count - 1 {
            dataModel.position = dataModel.position + 1
            player?.stop()
            
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            styleUI()
            dataModel.loadAudioFiles()

        }
    }
    
    @objc func backwardButtonTapped(){
        if dataModel.position > 0 {
            dataModel.position = dataModel.position - 1
            player?.stop()
            
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            dataModel.loadAudioFiles()
            styleUI()
        }
    }
    
    //sliders actions
    
    @objc func volumeSliderChanged(_ slider: UISlider){
        
        player = dataModel.player
        guard let player = player else{return}
        player.prepareToPlay()
        player.volume = slider.value
    }
    
    @objc func seekSliderChanged(_ slider: UISlider){
        player = dataModel.player
        
        guard let player = player else{return}
        player.prepareToPlay()
        player.currentTime = TimeInterval(slider.value)
    }
    
    @objc func updateSeekSlider(){
        player = dataModel.player
        guard let player = player else{return}
        
        seekSlider.value = Float(player.currentTime)
    }
    
    //avaudioplayer delegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

        
        if flag, dataModel.position < dataModel.gabayArray.count - 1 {
            dataModel.position += 1
           
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            
            dataModel.loadAudioFiles()
            styleUI()
        }
        else{
            dataModel.position = 0
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            dataModel.loadAudioFiles()
            styleUI()
        }
    }
    

    
}
