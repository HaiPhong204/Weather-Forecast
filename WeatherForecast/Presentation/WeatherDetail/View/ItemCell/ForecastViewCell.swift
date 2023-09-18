//
//  ForecastViewCell.swift
//  WeatherForecast
//
//  Created by Windy on 14/09/2023.
//

import UIKit

class ForecastViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var viewUI: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewUI.layer.cornerRadius = 8
        viewUI.layer.borderColor = UIColor.gray.cgColor
        viewUI.layer.borderWidth = 1.0
    }
    
}
