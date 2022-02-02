//
//  CircularProgressView.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 28/01/2022.
//

import UIKit

class CircularProgressView: UIView {


  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)

    createCircularPath()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    createCircularPath()
  }

  func createCircularPath() {
    let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
    circleLayer.path = circularPath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineCap = .round
    circleLayer.lineWidth = 10.0
    circleLayer.strokeColor = UIColor(named: "tableRow")?.cgColor
    progressLayer.path = circularPath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.lineWidth = 10.0
    progressLayer.strokeEnd = 0
    progressLayer.strokeColor = UIColor.green.cgColor
    layer.addSublayer(circleLayer)
    layer.addSublayer(progressLayer)
  }

  func progressAnimation(duration: TimeInterval, toValue: Double) {
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = toValue
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
  }

}
