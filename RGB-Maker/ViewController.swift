//
//  ViewController.swift
//  RGB-Maker
//
//  Created by SaiManasa on 10/27/23.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    @IBOutlet weak var UserColor: UIView!
    @IBOutlet weak var RanColor: UIView!
    
    var redVal:CGFloat  = 0
    var greenVal:CGFloat = 0
    var blueVal:CGFloat = 0
    var ranRed: CGFloat = 0
    var ranGreen:CGFloat = 0
    var ranBlue:CGFloat = 0
    var time = 10
    var timer = Timer()
    var timer2 = Timer()
    var timerActivated = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        RedSlider.value = 0
        BlueSlider.value = 0
        GreenSlider.value = 0
        UserColor.layer.masksToBounds = true
        UserColor.layer.borderWidth = 1
        UserColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        RanColor.layer.masksToBounds = true
        RanColor.layer.borderWidth = 1
        ranRed = CGFloat.random(in:0..<1)
        ranGreen = CGFloat.random(in:0..<1)
        ranBlue = CGFloat.random(in:0..<1)
        RanColor.backgroundColor = UIColor(red: ranRed, green: ranGreen, blue: ranBlue, alpha: 1.0)
        time = 15
        timerActivated = false;
        TimeLabel.text = "Time left: " + String(time)
        setTimer()
    }
    
    func setTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(time), target: self, selector: #selector(timerHit), userInfo: nil, repeats: false)
    }
    
    @objc func timerHit2() {
        time = time - 1
        TimeLabel.text = "Time left: " + String(time)
    }
    
    @objc func timerHit() {
        let score = sqrt(pow(redVal - ranRed, 2) + pow(blueVal - ranBlue, 2) + pow(greenVal - ranGreen, 2))
        let finScore = Int((1 - score) * 100)
        timer2.invalidate()
        let alert = UIAlertController(title: "Game over!", message: "Score: " + String(finScore), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Click to restart", comment: "close"), style: .default, handler: { _ in
            self.viewDidLoad()}))
        
        self.present(alert, animated: true, completion: nil)
    }
        
    @IBAction func redSliderChanged(_ sender: UISlider) {
        if (timerActivated == false) {
            timerActivated = true;
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHit2), userInfo: nil, repeats: true)
            setTimer()
        }
        redVal = CGFloat(sender.value)
        updateColor(red: redVal,  green: greenVal, blue: blueVal)
    }

    @IBAction func greenSliderChanged(_ sender: UISlider) {
        if (timerActivated == false) {
            timerActivated = true;
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHit2), userInfo: nil, repeats: true)
            setTimer()
        }
        greenVal = CGFloat(sender.value)
        updateColor(red: redVal,  green: greenVal, blue: blueVal)
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        if (timerActivated == false) {
            timerActivated = true;
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHit2), userInfo: nil, repeats: true)
            setTimer()
        }
        blueVal = CGFloat(sender.value)
        updateColor(red: redVal,  green: greenVal, blue: blueVal)
    }

    func updateColor(red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0) {
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        UserColor.backgroundColor = color
    }
}

