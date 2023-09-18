//
//  CloudsViewController.swift
//  WeatherForecast
//
//  Created by Windy on 15/09/2023.
//

import UIKit
import DGCharts

class CloudsViewController: UIViewController {

    @IBOutlet var barChartView: BarChartView!
    
    var dateList: [String] = []
    var temperatureData: [String: [Double]] = [:]
    var weatherInfomation : [WeatherInformationModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarChartView()
        customizeAxisLabels()
    }
    
    func setupBarChartView() {
        guard let dataWeatherInfo = weatherInfomation else {
            return
        }
        
        var entries: [BarChartDataEntry] = []
        for (_, weatherInfo) in dataWeatherInfo.enumerated() {
            let clouds = weatherInfo.clouds.all
            let dt_txt = String(weatherInfo.dt_txt.prefix(10))
            
            let startIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 5)
            let endIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 10)
            let dtText = dt_txt[startIndex..<endIndex]
            if temperatureData["\(dtText)"] == nil {
                temperatureData["\(dtText)"] = []
            }
            temperatureData["\(dtText)"]!.append(Double(clouds))

        }
        let sortedTemperatureData = temperatureData.sorted(by: { $0.0 < $1.0 })
        
        for (day, temperatures) in sortedTemperatureData {
            let averageTemperature = temperatures.reduce(0, +) / Double(temperatures.count)
            dateList.append(String(day))
            let entry = BarChartDataEntry(x: Double(dateList.count - 1), y: averageTemperature)
            // Step 3: Use the updated count for x-axis index
            entries.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "Clouds Average")
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueTextColor = UIColor.black
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateList)
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.enabled = false
        
        barChartView.animate(yAxisDuration: 1.5)
    }
    
    func customizeAxisLabels() {
        // Font chữ đậm và size lớn
        let axisLabelFont = UIFont.boldSystemFont(ofSize: 14)
        
        // Màu chữ đen
        let axisLabelColor = UIColor.black
        
        // Customize trục OX
        barChartView.xAxis.labelFont = axisLabelFont
        barChartView.xAxis.labelTextColor = axisLabelColor
        
        // Customize trục OY
        barChartView.leftAxis.labelFont = axisLabelFont
        barChartView.leftAxis.labelTextColor = axisLabelColor
    }
}
