//
//  HoursHistogramView.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

let MARGIN: CGFloat = 5

class HoursHistogramView: UIView {
    var data: [Double]? { didSet { setNeedsDisplay() } }
    var numRows: Int = 1 { didSet {setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        if let data = data {
            let maxVal = data.reduce(0, { max($0, $1) })
            let numPerRow = data.count / numRows
            let widthPerRect = frame.width / CGFloat(numPerRow)
            let heightPerRect = frame.height / CGFloat(numRows)
            for row in 0..<numRows {
                for col in 0..<numPerRow {
                    let index = col + row * numPerRow
                    if index < data.count {
                        let val = data[index]
                        var height = CGFloat(val / maxVal) * heightPerRect - MARGIN
                        if height < 2 {
                            height = 2
                        }
                        let histo = CGRect(
                            x: widthPerRect * CGFloat(col) + MARGIN / 2,
                            y: heightPerRect * CGFloat(row + 1) - height + MARGIN / 2,
                            width: widthPerRect - MARGIN,
                            height: height
                        )
                        let histoView = UIView(frame: histo)
                        histoView.backgroundColor = UIColor.blueColor()
                        addSubview(histoView)
                    }
                }
            }
        }
    }
}
