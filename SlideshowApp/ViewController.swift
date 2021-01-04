//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 西方健太郎 on 2021/01/03.
//  Copyright © 2021 idea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
 
    @IBOutlet weak var imageView: UIImageView!
    // タイマー
    var timer: Timer!

    // カウント(経過時間)の変数を作成
    var count = 0
    // 設定値を扱うキーを設定
    let settingKey = "timer_value"
    
    // スライドショーさせる画像の配列を宣言
    var imageArray:[UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!
    ]
    
    let imageSample = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        // UserDefaultsに初期値を登録
        settings.register(defaults: [settingKey:3])
        
        // スクリーンサイズの取得
        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        // 画像を読み込んで、準備しておいたimageSampleに設定
        imageSample.image = imageArray[count]
        // 画像のフレームを設定
        imageSample.frame = CGRect(x:0, y:0, width:256, height:256)
        
        // 画像を中央に設定
        imageSample.center = CGPoint(x:screenW/2, y:screenH/2)
        

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のZoomViewControllerを取得する
        let zoomViewController:ZoomViewController = segue.destination as! ZoomViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        zoomViewController.count2 = count + 1
    }
    
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 2.0, repeats: true で指定された通り、2秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        if self.count != 2 {
            self.count += 1
 
           // 画像を読み込んで、準備しておいたimageSampleに設定
                  imageSample.image = imageArray[count]
            // 設定した画像をスクリーンに表示する
                  self.view.addSubview(imageSample)
            
        } else {
            self.count = 0

            // 画像を読み込んで、準備しておいたimageSampleに設定
                   imageSample.image = imageArray[count]
            // 設定した画像をスクリーンに表示する
                   self.view.addSubview(imageSample)
        }
    }
    

    @IBOutlet weak var startButton: UIButton!
    // 再生ボタン IBAction

    @IBAction func startTimer(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            
            // ボタンの名前を停止に変える
            startButton.setTitle("停止", for: .normal)
            
        }else {
            // 停止時の処理を実装
            // タイマーを停止する
            timer.invalidate()

            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil

            // ボタンの名前を再生に直しておく
            startButton.setTitle("再生", for: .normal)
        }
      }

      // 進むボタン IBAction
    @IBAction func susumu(_ sender: Any) {

        if self.count != 2 {
            //self.timer_sec += 1  // タイマーを1つ進める
            self.count += 1
 
            // 画像を読み込んで、準備しておいたimageSampleに設定
                   imageSample.image = imageArray[count]
            // 設定した画像をスクリーンに表示する
                   self.view.addSubview(imageSample)
        } else {
            self.count = 0
 
            // 画像を読み込んで、準備しておいたimageSampleに設定
                   imageSample.image = imageArray[count]
            // 設定した画像をスクリーンに表示する
                   self.view.addSubview(imageSample)
        }
    }

      // 戻るボタン IBAction
    @IBAction func modoru(_ sender: Any) {

            if self.count != 0 {
                //self.timer_sec += 1  // タイマーを1つ進める
                self.count -= 1
  
                // 画像を読み込んで、準備しておいたimageSampleに設定
                       imageSample.image = imageArray[count]
                // 設定した画像をスクリーンに表示する
                       self.view.addSubview(imageSample)
            } else {
                self.count = 2

                // 画像を読み込んで、準備しておいたimageSampleに設定
                       imageSample.image = imageArray[count]
                // 設定した画像をスクリーンに表示する
                       self.view.addSubview(imageSample)
            }
        }

}

