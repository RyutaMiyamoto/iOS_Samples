//
//  ViewController.swift
//  AVSpeechSynthesizerSample
//
//  Created by R.miyamoto on 2019/09/16.
//  Copyright © 2019 R.Miyamoto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer.delegate = self
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func tapPlayButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.5
        utterance.volume = 0.5
        synthesizer.speak(utterance)
    }
    
    @IBAction func tapStopButton(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Speech Start")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Speech End")
    }
}

