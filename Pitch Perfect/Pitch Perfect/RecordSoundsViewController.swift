//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Long Wang on 2015-04-05.
//  Copyright (c) 2015 Long Wang. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordButton.enabled = true
        stopButton.hidden = true
        recordingLabel.text = "Tap to Record"
    }

    @IBAction func recordAudio(sender: UIButton) {

        recordingLabel.text = "Recording in process..."
        stopButton.hidden = false
        recordButton.enabled = false
        
        //TODO: Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        // Setup Audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Initialize and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            //TODO: Step 1 - Save the recorded audio
            recordedAudio = RecordedAudio( filePathUrl:recorder.url!, title:recorder.url.lastPathComponent!)
            
            //TODO: Step 2 - Move to the next scene aka perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }

    @IBAction func stopAudio(sender: UIButton) {
        
        //TODO: Stop recording the user's voice
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
}

