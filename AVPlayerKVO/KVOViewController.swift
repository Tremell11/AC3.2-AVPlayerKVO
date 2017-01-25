//
//  KVOViewController.swift
//  AVPlayerKVO
//
//  Created by Tyler Newton on 1/25/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import AVFoundation

private var kvoContext = 0

class KVOViewController: UIViewController {
    
    //MARK: Properties
    var player: AVPlayer!
<<<<<<< HEAD:AVPlayerKVO/KVOViewController.swift
    let maxValue = 2
    let minValue = 0.25
    var userPlaying: Bool
=======
    var userPlayRate: Float = 1.0
    var userPlaying: Bool = false
>>>>>>> f53410a6f19d8519dff5d73c43c4c8cae40b99e2:AVPlayerKVO/ViewController.swift
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var positionSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var pauseButton: UIButton!
    
    //MARK: Labels
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionSlider.value = 0
        positionSlider.maximumValue = Float(maxValue)
        rateSlider.value = 0
        rateSlider.maximumValue = Float(maxValue)
        rateSlider.minimumValue = Float(minValue)
        
        
        positionLabel.text = "Set Position:"
        rateLabel.text = "Set Rate:"
        
        
        if let url = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8") {
            let playerItem = AVPlayerItem(url: url)
            
            playerItem.addObserver(self, forKeyPath: "status", options: .new, context: &kvoContext)
            
            player = AVPlayer(playerItem: playerItem)
            
            let playerLayer = AVPlayerLayer(player: player)
            //playerLayer.frame = self.videoContainer.bounds
            self.videoContainer.layer.addSublayer(playerLayer)
            
            let timeInterval = CMTime(value: 1, timescale: 2)
            player.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main, using: { (time: CMTime) in
                print(time)
                self.updatePositionSlider()
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        guard let sublayers = self.videoContainer.layer.sublayers
            else {
                return
        }
        
        for layer in sublayers {
            layer.frame = self.videoContainer.bounds
        }
    }
    
    // MARK: - Utility
    func updatePositionSlider() {
        guard let item = player.currentItem else { return }
        
        let currentPlace = Float(item.currentTime().seconds / item.duration.seconds)
        self.positionSlider.value = currentPlace
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &kvoContext {
            if keyPath == "status",
                let item = object as? AVPlayerItem {
                if item.status == .readyToPlay {
                    playPauseButton.isEnabled = true
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func positionSliderChanged(_ sender: UISlider) {
        guard let item = player.currentItem else { return }
        
        let newPosition = Double(sender.value) * item.duration.seconds
        
        player.seek(to: CMTime(seconds: newPosition, preferredTimescale: 1000))
    }
    
<<<<<<< HEAD:AVPlayerKVO/KVOViewController.swift
    @IBAction func rateChanged(_ sender: UISlider) {
        
        player.playImmediately(atRate: rateSlider.value)
        
        guard let item = player.currentItem else { return }
        if item.canPlayFastForward {
            print("I can fast forward.rate requested: \(sender.value).")
        }
        if item.canPlaySlowForward {
            print("I can slow forward.")
        }
    }
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        
        if userPlaying?><m {
            player.play()
            player.playImmediately(atRate: rateSlider.value)
            sender.setTitle("Pause", for: .normal)
=======
    @IBAction func rateChange(_ sender: UISlider) {
        guard let item = player.currentItem else { return }
        
        userPlayRate = sender.value
        
        if item.canPlayFastForward {
            print("I can fast forward. Rate requested: \(sender.value).")
        }
        if item.canPlaySlowForward {
            print("I can slow forward")
        }
        
        if userPlaying {
            player.rate = userPlayRate
        }
        //print("NEW rate: \(player.rate).")

    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        if !userPlaying {
            player.playImmediately(atRate: userPlayRate)
            sender.setTitle("Pause", for: .normal)
            //userPlaying = false
>>>>>>> f53410a6f19d8519dff5d73c43c4c8cae40b99e2:AVPlayerKVO/ViewController.swift
        }
        else {
            player.pause()
            sender.setTitle("Play", for: .normal)
<<<<<<< HEAD:AVPlayerKVO/KVOViewController.swift
        }
        
=======
            //userPlaying = true
        }
        userPlaying = !userPlaying
>>>>>>> f53410a6f19d8519dff5d73c43c4c8cae40b99e2:AVPlayerKVO/ViewController.swift
    }
}
