//  Created by Cesare de Cal on 1/10/18.
//  Copyright © 2018 cesare.io. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer! // shows content to view
    var isVideoPlaying = false
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")! // must be HTTPS
        player = AVPlayer(url: url)
        player.isMuted = true
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        videoView.layer.addSublayer(playerLayer)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds // for device rotation
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if isVideoPlaying {
            player.pause()
            sender.setTitle("Play", for: .normal)
        } else {
            player.play()
            sender.setTitle("Pause", for: .normal)
        }
        
        isVideoPlaying = !isVideoPlaying
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        guard let duration = player.currentItem?.duration else { return }
        
        // skip 5 seconds
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5.0
        
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time = CMTimeMake(Int64(newTime)*1000, 1000) // time we're going to jump into
            player.seek(to: time)
        }
    }
    
    @IBAction func backwardsButtonPressed(_ sender: UIButton) {
        // minus 5 seconds
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime + 5.0

        if newTime < 0 {
            newTime = 0
        }
        
        let time = CMTimeMake(Int64(newTime)*1000, 1000) // time we're going to jump into
        player.seek(to: time)
    }
}
