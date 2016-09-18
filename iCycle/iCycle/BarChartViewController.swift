//
//  BarChartViewController.swift
//  iCycle
//
//  Created by David Gu on 9/18/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    var interval: [String]!
    var viewType: Int!
    var unitsSold: [Double]!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if (viewType == 0) {
//            interval = ["0000-0259", "0300-0559", "0600-0859", "0900-1159", "1200-1459", "1500-1759", "1800-2059", "2100-2359"]
//            unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0]
//        } else if (viewType == 1) {
            interval = ["Day - 6", "Day - 5", "Day - 4", "Day - 3", "Day - 2", "Day - 1", "Today"]
            unitsSold = [
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -6).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -5).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -4).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -3).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -2).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: -1).count),
                Double(DataService.getRecyclingFromNDaysAgo(UserID, daysAgo: 0).count)
            ]
//        } else {
//            interval = ["3 Wks Ago", "2 Wks Ago", "Last Week", "This Week"]
//            unitsSold = [20.0, 4.0, 6.0, 3.0]
//        }
        setChart(interval, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: interval, dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
    
}