//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let Signbutton = UIButton()
    let Createaccount = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "ホーム"
        view.backgroundColor = .white
        Signbutton.setTitle("ログイン", for: UIControl.State.normal)
        Createaccount.setTitle("アカウント作成", for: UIControl.State.normal)
    }




}

