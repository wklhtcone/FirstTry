//
//  ViewController.swift
//  FirstTry
//
//  Created by 王凯霖 on 2019/11/6.
//  Copyright © 2019 王凯霖. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var slider_ctl: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue = 50
    var targetValue = 0
    var totalScore = 0
    var round = 0
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()   // Do any additional setup after loading the view.
        
        //设置滑动条的外观

        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider_ctl.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider_ctl.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider_ctl.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider_ctl.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        currentValue=lroundf(slider_ctl.value)
        startNewGame()
//        playBGM() 
    }
    
    @IBAction func showAlert(){
        let difference = abs(currentValue-targetValue)
        var score = 100 - difference
        
        let showTitle: String
        if difference == 0{
            showTitle = "运气逆天，赶紧去买彩票吧！\n奖励100分"
            score += 100
        }else if difference < 5{
            showTitle = "只差一点儿了就到了！\n奖励50分"
            score += 50
        }else if difference < 10{
            showTitle = "干得不错，继续加油鸭～"
        }else {
            showTitle = "差太远了，别泄气啊～"
        }
        
        totalScore += score
//        round += 1
//        let message = "目标数值是：\(targetValue)" + "\n你滑动的数值是：\(currentValue)" + "\n两者差值是：\(abs(currentValue-targetValue))" + "\n本轮得分是\(score)"
        let showMessage = "本轮得分是：\(score)"
        let alert=UIAlertController(title:showTitle,
                                    message:showMessage,
                                    preferredStyle: .alert)
        let action=UIAlertAction(title:"行8⃣️",
                                 style:.default,
                                 handler:{_ in self.startNewRound()})//handler表示按下按钮时的动作
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
//        startNewRound()
    }
    
    @IBAction func whenSliderMove(_ slider:UISlider){
        print("滑动条的数值是：\(slider.value)")
        currentValue=lroundf(slider.value)
    }
    
    @IBAction func reStart(){
        startNewGame()
    }
    
    func startNewRound(){
        round += 1
        targetValue = Int.random(in: 1...100)
        updateLabels()
    }
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(totalScore)
        roundLabel.text = String(round)
    }

    func startNewGame(){
        round = -1
        totalScore = 0
        startNewRound()
        let animation = CATransition()
        animation.type = CATransitionType.reveal
        animation.duration = 0.5
//        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        view.layer.add(animation,forKey: nil)
    }
    
    func playBGM(){
        let bgmPath = Bundle.main.path(forResource: "bgmusic", ofType: "mp3")
        let link = URL.init(fileURLWithPath: bgmPath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: link)
        }catch _{
            audioPlayer = nil
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
}




