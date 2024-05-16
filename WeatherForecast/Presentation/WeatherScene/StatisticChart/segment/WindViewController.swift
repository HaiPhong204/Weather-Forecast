//
//  WindViewController.swift
//  WeatherForecast
//
//  Created by Windy on 15/09/2023.
//

import UIKit
import DGCharts

class WindViewController: UIViewController {

    @IBOutlet var barChart: BarChartView!
    
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
            let wind = weatherInfo.wind.speed
            let dt_txt = String(weatherInfo.dt_txt.prefix(10))
            
            let startIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 5)
            let endIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 10)
            let dtText = dt_txt[startIndex..<endIndex]
            if temperatureData["\(dtText)"] == nil {
                temperatureData["\(dtText)"] = []
            }
            temperatureData["\(dtText)"]!.append(Double(wind))

        }
        let sortedTemperatureData = temperatureData.sorted(by: { $0.0 < $1.0 })
        
        for (day, temperatures) in sortedTemperatureData {
            let averageTemperature = temperatures.reduce(0, +) / Double(temperatures.count)
            dateList.append(String(day))
            let entry = BarChartDataEntry(x: Double(dateList.count - 1), y: averageTemperature)
            // Step 3: Use the updated count for x-axis index
            entries.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "Wind Speed Average")
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueTextColor = UIColor.black
        
        let data = BarChartData(dataSet: dataSet)
        barChart.data = data
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateList)
        barChart.xAxis.granularity = 1
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.enabled = false
        
        barChart.animate(yAxisDuration: 1.5)
    }
    
    func customizeAxisLabels() {
        // Font chữ đậm và size lớn
        let axisLabelFont = UIFont.boldSystemFont(ofSize: 14)
        
        // Màu chữ đen
        let axisLabelColor = UIColor.black
        
        // Customize trục OX
        barChart.xAxis.labelFont = axisLabelFont
        barChart.xAxis.labelTextColor = axisLabelColor
        
        // Customize trục OY
        barChart.leftAxis.labelFont = axisLabelFont
        barChart.leftAxis.labelTextColor = axisLabelColor
    }
}
