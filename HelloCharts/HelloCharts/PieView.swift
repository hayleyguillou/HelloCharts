//
//  PieView.swift
//  HelloCharts
//
//  Created by Hayley Guillou on 2014-11-17.
//  Copyright (c) 2014 hayleyguillou. All rights reserved.
//

class PieView: UIView {
    
    // current vals
    var stepsToday:Float = 0
    var stepsPast:Float = 0
    var stepsRequired:Float = 1
    
    let stepsTodayColor: UIColor = UIColor.blackColor()
    let stepsPastColor: UIColor = UIColor.grayColor()
    let stepsReqdColor: UIColor = UIColor.redColor()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    override class func layerClass() -> AnyClass {
        return PieLayer.self
    }
    
    func pieLayer() -> PieLayer {
        return self.layer as PieLayer
    }
    
    func setup() {
        self.pieLayer().maxRadius = 120;
        self.pieLayer().minRadius = 100;
        self.pieLayer().setStartAngle(90, endAngle: 450, animated: true)
    }
    
    func loadInitialData(today: Int, completed: Int, required: Int) {
        stepsPast = Float(completed)
        stepsToday = Float(today)
        stepsRequired = Float(required)
        
        var pieElemPast = PieElement(value: stepsPast, color: stepsPastColor)
        var pieElemToday = PieElement(value: stepsToday, color: stepsTodayColor)
        var pieElemReqd = PieElement(value: stepsRequired, color: stepsReqdColor)
        self.pieLayer().addValues([pieElemPast, pieElemToday, pieElemReqd], animated: true)

    }
    
    func updateGraph(today: Int, completed: Int, required: Int) {
        stepsPast = Float(completed)
        stepsToday = Float(today)
        stepsRequired = Float(required)
        
        let pi = pieLayer().values
        PieElement.animateChanges { () -> Void in
            for pieElem: PieElement in self.pieLayer().values as [PieElement] {
                if pieElem.color == self.stepsPastColor {
                    pieElem.val = self.stepsPast
                } else if pieElem.color == self.stepsTodayColor {
                    pieElem.val = self.stepsToday
                } else {
                    pieElem.val = self.stepsRequired
                }
            }
        }
    }
    
}
