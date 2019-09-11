//
//  ViewController.swift
//  AudioPlayer
//
//  Created by UDLAP19 on 9/4/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var player: AVAudioPlayer?
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    let dondeEstaLaLuz = UIImage(named: "dondeEstaLaLuz")
    let playImage = UIImage(named: "play")
    let pauseImage = UIImage(named: "pause")
    
    let songPaths = [
        Bundle.main.path(forResource: "elanticristo", ofType: "mp3"),
        Bundle.main.path(forResource: "fourinthemorning", ofType: "mp3"),
        Bundle.main.path(forResource: "diaryofjane", ofType: "mp3")
    ]
    
    let albums = [
        UIImage(named: "dondeEstaLaLuz"),
        UIImage(named: "welcomeToTheFamily"),
        UIImage(named: "phobia")
    ]

    
    
    var currentSong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadSong(0)
        
        /*let path = Bundle.main.path(forResource: "elanticristo", ofType: "mp3")
        
        let url = NSURL(fileURLWithPath: path!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url as URL)
            player?.prepareToPlay()
            player?.delegate = self
        }
        catch {
            print("Error while loading the song")
        }*/
    }

    
    @IBAction func playPause(_ sender: Any) {
        if player!.isPlaying {
            player?.stop()
            playButton.setImage(playImage, for: .normal)
            //button.setTitle("Play", for: .normal)
        }
        else {
            player?.play()
            playButton.setImage(pauseImage, for: .normal)
            //playButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func nextSong(_ sender: Any) {
        currentSong = currentSong + 1 == songPaths.count ? 0 : currentSong + 1
        
        loadSong(currentSong)
        setAlbumImage(currentSong)
        
    }
    
    @IBAction func previousSong(_ sender: Any) {
        currentSong = currentSong - 1 < 0 ? songPaths.count - 1 : currentSong - 1
        
        loadSong(currentSong)
        setAlbumImage(currentSong)
        
        
    }
    
    func setAlbumImage(_ index: Int) {
        let nextAlbum = albums[index]
        
        imageView.image = nextAlbum
    }
    
    func loadSong(_ index: Int) {
        let songPath = songPaths[index]
        
        let url = NSURL(fileURLWithPath: songPath!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url as URL)
            player?.prepareToPlay()
            player?.delegate = self
        }
        catch {
            print("Error while loading the song")
        }
    }
    
}

