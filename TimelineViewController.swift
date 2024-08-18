//
//  Time_lineViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/18.
//

import UIKit

class TimelineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    private func setupView(){
        self.title="タイムライン"
        view.backgroundColor =  UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
#Preview(){
    TimelineViewController()
}
