//
//  PGCircularProgressBar.swift
//  PGCircularProgressBar
//
//  Created by Puneet Gurtoo on 11/23/17.
//  Copyright © 2017 Puneet Gurtoo. All rights reserved.
//

import UIKit

struct PieChart {
    var fillColor:UIColor!
    var fillValue:CGFloat!
    var strokeColor:UIColor!
    var strokeWidth:CGFloat!
}

enum PGCircularProgressBarType {
    case centerFilled
    case hollow
    case pathFilled
    case invalid
}

class PGCircularProgressBar: UIView {
    
    let DEFAULT_SCALE:CGFloat = 360.0
    
    //default values
    private var progressType:PGCircularProgressBarType = .hollow
    private var progressLabel:UILabel!
    private var strokeColor:UIColor = .green
    private var fillColor:UIColor = .black
    private var strokeWidth:CGFloat = 4
    private var scaleValue:CGFloat = 360
    private var drawValue:CGFloat = 360
    private var drawAngle:CGFloat = 0
    
    private var remainingValue:CGFloat = 0
    private var remainingAngle:CGFloat = 0
    private var remainingStrokeColor:UIColor = .red
    private var remainingFillColor:UIColor = .white
    
/** Set this property in case of multiple pie charts.Default value is 1*/
    private var numberOfCenterFilledArcs:Int = 1
    private var pieChartData:[PieChart]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpProgressLabel()
    }

    func setProgressText(_ t:String) {
        progressLabel.text = t
    }
    
    func setType(_ t:PGCircularProgressBarType) {
        progressType = t
    }
    
    func setStrokeColor(_ s:UIColor,fillColor f:UIColor,strokeWidth w:CGFloat) {
        strokeColor = s
        fillColor = f
        strokeWidth = w
    }
    
    /**Will work only in case of type PGCircularProgressBarType.hollow.No need to call in other cases*/
    func setRemainingStrokeColor(_ s:UIColor) {
        remainingStrokeColor = s
    }
    
    func setPieChartData(_ p:[PieChart]) {
        pieChartData = p
    }
    
    func setScaleValue(_ s:CGFloat,numberOfPieCharts n:Int,pieChartData p:[PieChart]) {
        if n != p.count {
            print("Error!!! 'NumberOfPieCharts' count and [PieChart].count do not match.")
            progressType = .invalid
            return
        }
        var sumOfPieChartValues:CGFloat = 0
        for (_,value) in p.enumerated() {
            sumOfPieChartValues += value.fillValue
        }
        if sumOfPieChartValues>s {
            print("Draw value can't be greater than scale value")
            progressType = .invalid
            return
        }
        scaleValue = s
        pieChartData = p
        numberOfCenterFilledArcs = n
    }
    /**This value will divide the default 360 angle values into the value provided to this varible.For example if 5 is provided to this value,each stroke will be of value 360/5 = 72.Default value is 360.Just provide the scale value and the draw value needed.DrawValue will be converted to angle based on this scale value and the corresponding arc is drawn.
     */
    func setScaleValue(_ s:CGFloat,drawValue d:CGFloat) {
        if d>s {
            print("Draw value can't be greater than scale value")
            progressType = .invalid
            return
        }
        drawValue = d
        scaleValue = s
        remainingValue = s-d
        
        let drawAngle = (DEFAULT_SCALE * d)/s
        setDrawAngle(drawAngle)
        setProgressText(String(describing:d))
        
        let remainingAngle = (DEFAULT_SCALE * remainingValue)/s
        setRemainingAngle(remainingAngle)
    }
    
    func setDrawAngle(_ a:CGFloat) {
        drawAngle = a
    }
    
    private func setRemainingAngle(_ r:CGFloat) {
        remainingAngle = r
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if progressType == .hollow {
            print("Hollow")
            progressLabel.alpha = 1
            let path1 = UIBezierPath.init(arcCenter: CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2), radius: self.bounds.width/2-2, startAngle: 0, endAngle: drawAngle * CGFloat(Double.pi)/180, clockwise: true)
            strokeColor.setStroke()
            path1.lineWidth = strokeWidth
            path1.stroke()
            
            //draw remaining angle
            let path2 = UIBezierPath.init(arcCenter: CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2), radius: self.bounds.width/2-2, startAngle: drawAngle * CGFloat(Double.pi)/180, endAngle: DEFAULT_SCALE * CGFloat(Double.pi)/180, clockwise: true)
            remainingStrokeColor.setStroke()
            path2.lineWidth = strokeWidth
            path2.stroke()
        }
        else if progressType == .centerFilled {
            print("CenterFilled")
            progressLabel.alpha = 0
            let circleCenter = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
            
            if numberOfCenterFilledArcs > 1 {
                var startAngle:CGFloat = 0
                var endAngle:CGFloat = 0
                for i in 0 ..< numberOfCenterFilledArcs {
                    if i == 0 {
                        startAngle = 0
                    }
                    else {
                        startAngle = endAngle//(DEFAULT_SCALE * pieChartData![i-1].fillValue)/scaleValue
                    }
                    endAngle = (DEFAULT_SCALE * pieChartData![i].fillValue)/scaleValue + startAngle
                    let path = UIBezierPath.init(arcCenter: circleCenter, radius: self.bounds.width/2-2, startAngle: startAngle * CGFloat(Double.pi)/180, endAngle: endAngle * CGFloat(Double.pi)/180, clockwise: true)
                    path.lineWidth = pieChartData![i].strokeWidth
                    path.addLine(to: circleCenter)
                    path.close()
                    pieChartData![i].fillColor.setFill()
                    path.fill()
                    pieChartData![i].strokeColor.setStroke()
                    path.stroke()
                }
            }
            else {
                let path = UIBezierPath.init(arcCenter: circleCenter, radius: self.bounds.width/2-2, startAngle: 0, endAngle: drawAngle * CGFloat(Double.pi)/180, clockwise: true)
                path.lineWidth = strokeWidth
                path.addLine(to: circleCenter)
                path.close()
                fillColor.setFill()
                path.fill()
                strokeColor.setStroke()
                path.stroke()
            }
        }
        else if progressType == .pathFilled {
            print("PathFilled")
            progressLabel.alpha = 0
            let circleCenter = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
            
            let path = UIBezierPath.init(arcCenter: circleCenter, radius: self.bounds.width/2-2, startAngle: 0, endAngle: drawAngle * CGFloat(Double.pi)/180, clockwise: true)
            path.lineWidth = strokeWidth
            fillColor.setFill()
            path.fill()
            strokeColor.setStroke()
            path.stroke()
        }
        else {
            print("Invalid")
        }
    }
    
    /**Sets up the progress value in the middle of the view.Works only in case of hollow.
     */
    func setUpProgressLabel() {
        progressLabel = UILabel(frame: self.bounds)
        progressLabel.textAlignment = .center
        progressLabel.numberOfLines = 0
        self.addSubview(progressLabel)
    }
}








