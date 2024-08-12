//
//  ViewController.swift
//  ElectricPricingCaculator
//
//  Created by Chí Thành on 12/8/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceInput: UITextField!
    
    @IBOutlet weak var priceButton: UIButton!
    
    @IBOutlet weak var priceTable: UIView!
    
    @IBOutlet weak var priceContainer: UIView!
    
    @IBOutlet weak var priceResult: UILabel!
    
    let electricityPrices = [
        (0...50, 1678),
        (51...100, 1734),
        (101...200, 2014),
        (201...300, 2536),
        (301...400, 2834),
        (401...Int.max, 2927)
    ]
    
    var calculationResults: [(String, Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        priceButton.addTarget(self, action: #selector(calculatePrice), for: .touchUpInside)
        priceInput.keyboardType = .numberPad
        priceContainer.isHidden = true
    }
    
    // format price number
    func formatNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: number)) ?? String(format: "%.2f", number)
    }
    
    
    @objc func calculatePrice() {
        guard let consumptionText = priceInput.text,
              let consumption = Int(consumptionText) else {
            priceResult.text = "Vui lòng nhập số điện hợp lệ"
            return
        }
        
        var totalPrice = 0.0
        var calculationDetails: [(String, Int, Double)] = []
        var remainingConsumption = consumption
        
        for (range, price) in electricityPrices {
            let units = min(remainingConsumption, range.upperBound - range.lowerBound + 1)
            let cost = Double(units) * Double(price)
            totalPrice += cost
            
            if units > 0 {
                calculationDetails.append(("Bậc \(range.lowerBound + 1)-\(range.upperBound)", units, cost))
                remainingConsumption -= units
            }
            
            if remainingConsumption <= 0 {
                break
            }
        }
        
        displayCalculationDetails(calculationDetails)
        priceContainer.isHidden = false
        priceResult.text = String(format: "\(formatNumber(totalPrice))", totalPrice)
    }
    
    func displayCalculationDetails(_ details: [(String, Int, Double)]) {
        // Clear existing subviews
        priceTable.subviews.forEach { $0.removeFromSuperview() }
        
        let headerLabels = ["Bậc", "Số kWh", "Thành tiền"]
        let columnWidths: [CGFloat] = [priceTable.bounds.width * 0.4, priceTable.bounds.width * 0.3, priceTable.bounds.width * 0.3]
        var yOffset: CGFloat = 0
        
        // Add header row
        for (index, title) in headerLabels.enumerated() {
            let label = UILabel(frame: CGRect(x: columnWidths[0..<index].reduce(0, +), y: yOffset, width: columnWidths[index], height: 30))
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 14)
            priceTable.addSubview(label)
        }
        yOffset += 30
        
        // Add detail rows
        for (tier, units, cost) in details {
            let tierLabel = UILabel(frame: CGRect(x: 0, y: yOffset, width: columnWidths[0], height: 30))
            tierLabel.text = tier
            tierLabel.textAlignment = .left
            priceTable.addSubview(tierLabel)
            
            let unitsLabel = UILabel(frame: CGRect(x: columnWidths[0], y: yOffset, width: columnWidths[1], height: 30))
            unitsLabel.text = "\(units)"
            unitsLabel.textAlignment = .center
            priceTable.addSubview(unitsLabel)
            
            let costLabel = UILabel(frame: CGRect(x: columnWidths[0] + columnWidths[1], y: yOffset, width: columnWidths[2], height: 30))
            costLabel.text = String(format: "%.2f", cost)
            costLabel.textAlignment = .right
            priceTable.addSubview(costLabel)
            
            yOffset += 30
        }
    }
}



