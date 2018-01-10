//
//  ViewController.swift
//  VideoApp
//
//  Created by Cesare de Cal on 1/10/18.
//  Copyright © 2018 cesare.io. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer! // shows content to view
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")! // must be HTTPS
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
        player.isMuted = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds // for device rotation
    }
}

