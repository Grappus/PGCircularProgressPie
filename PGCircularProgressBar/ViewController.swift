//
//  ViewController.swift
//  PGCircularProgressBar
//
//  Created by Puneet Gurtoo on 11/23/17.
//  Copyright © 2017 Puneet Gurtoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view_circular: PGCircularProgressBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        view_circular.setType(.hollow)
     
//        view_circular.setScaleValue(100, numberOfPieCharts: 4, pieChartData:
//            [PieChart.init(fillColor: UIColor.red, fillValue: 25, strokeColor: UIColor.white, strokeWidth: 4),
//             PieChart.init(fillColor: UIColor.black, fillValue: 50, strokeColor: UIColor.white, strokeWidth: 4),
//             PieChart.init(fillColor: UIColor.brown, fillValue: 15, strokeColor: UIColor.white, strokeWidth: 4),
//             PieChart.init(fillColor: UIColor.cyan, fillValue: 10, strokeColor: UIColor.white, strokeWidth: 4)])
        
        
        view_circular.setStrokeColor(UIColor.blue, fillColor: UIColor.brown, strokeWidth: 4)
        view_circular.setRemainingStrokeColor(UIColor.brown)
        view_circular.setScaleValue(720, drawValue: 90)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

