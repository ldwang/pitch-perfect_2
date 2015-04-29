//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Long Wang on 2015-04-07.
//  Copyright (c) 2015 Long Wang. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //Pla audio slooowly here ...
        resetAudio()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }

    @IBAction func playFastAudio(sender: UIButton) {
        //Play Audio fast here ...
        resetAudio()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }

    @IBAction func stopAudio(sender: UIButton) {
        audioEngine.stop()
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func resetAudio() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        resetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
