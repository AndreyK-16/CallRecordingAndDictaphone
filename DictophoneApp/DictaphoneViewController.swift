//
//  DictaphoneViewController.swift
//  DictophoneApp
//
//  Created by Андрей К on 21.01.2020.
//  Copyright © 2020 Андрей Кальдяев. All rights reserved.
//

import UIKit
import AVFoundation

class DictaphoneViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    let recordBtn = UIButton()
    let playBtn = UIButton()
    let saveBtn = UIButton()
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    var fileName: String = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        setupButton(button: playBtn, imageNamed: "play")
        playBtnAnchor()
        
        setupButton(button: recordBtn, imageNamed: "record-red")
        recordBtnAnchor()
        
        setupButton(button: saveBtn, imageNamed: "saveBtn")
        saveBtnAnchor()
        
        playBtn.addTarget(self, action: #selector(playBtnClicked(_: )), for: .touchUpInside)
        recordBtn.addTarget(self, action: #selector(recordBtnClicked(_: )), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnClicked(_: )), for: .touchUpInside)
    }
    
    func getDocumentDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentDirector().appendingPathComponent(fileName)
        let recordSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey: 32000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey: 44100.2] as [String: Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            print("error!")
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentDirector().appendingPathComponent(fileName)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print("error!")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.isEnabled = true
//        playBtn.setTitle(UIImage(named: "play"), for: .normal)
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Dictaphone"
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupButton(button: UIButton, imageNamed: String) {
        button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        button.layer.cornerRadius = CGFloat(15)
        button.setImage(UIImage(named: imageNamed), for: .normal)
        button.titleLabel?.textColor = .black
        self.view.addSubview(button)
    }
    
//    MARK: - anchor button
    
    private func playBtnAnchor() {
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        playBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func recordBtnAnchor() {
        recordBtn.translatesAutoresizingMaskIntoConstraints = false
        recordBtn.trailingAnchor.constraint(equalTo: playBtn.leadingAnchor, constant: -40).isActive = true
        recordBtn.centerYAnchor.constraint(equalTo: playBtn.centerYAnchor).isActive = true
        recordBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        recordBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func saveBtnAnchor() {
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor, constant: 40).isActive = true
        saveBtn.centerYAnchor.constraint(equalTo: playBtn.centerYAnchor).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
//    MARK: - action button
    
    @objc func playBtnClicked(_: UIButton) {
        print("test - play button clicked")
        if recordBtn.isEnabled == true {
            recordBtn.isEnabled = false
            recordBtn.alpha = 0.3
        } else {
            recordBtn.isEnabled = true
            recordBtn.alpha = 1
        }
        
    }
    
    @objc func recordBtnClicked(_: UIButton) {
        print("test - record button clicked")
        if playBtn.isEnabled == true {
            playBtn.isEnabled = false
            playBtn.alpha = 0.3
        } else {
            playBtn.isEnabled = true
            playBtn.alpha = 1
        }
        if saveBtn.isEnabled == true {
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.3
        } else {
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
        }

    }
    
    @objc func saveBtnClicked(_: UIButton) {
        print("test - save button clicked")

    }
    
}
