//
//  ViewController.swift
//  MyMusic
//
//  Created by User on 17/07/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    private var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Memastikan bahwa url dari asset tidak null.
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            
            // MARK: Kode ini untuk iOS 11 ke atas
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // MARK: Kode ini untuk iOS 10 ke bawah
            // player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)

        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isPlaying(state: false)
    }

    @IBAction func stopMusic(_ sender: UIButton) {
        guard let audioPlayer = player else { return }
        audioPlayer.stop()
        isPlaying(state: false)
    }
    
    @IBAction func playMusic(_ sender: UIButton) {
        guard let audioPlayer = player else { return }
        audioPlayer.play()
        isPlaying(state: true)
    }
    
    private func isPlaying(state: Bool) {
        btnStop.isEnabled = state
        btnPlay.isEnabled = !state
    }
    
}

