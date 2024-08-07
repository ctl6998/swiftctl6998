//
//  ViewController.swift
//  DemoUI
//
//  Created by Chí Thành on 5/8/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleDuplicateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        setupViews()
        
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftViewTapped))
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped))
        leftView.addGestureRecognizer(leftTapGesture)
        rightView.addGestureRecognizer(rightTapGesture)
        
        // allow Interaction
        leftView.isUserInteractionEnabled = true
        rightView.isUserInteractionEnabled = true
    }
    
    private func setupViews() {
        // Set up the background colors and initial labels
        leftView.backgroundColor = .green
        rightView.backgroundColor = .red
        
        // Add labels to the views
        let leftLabel = UILabel()
        leftLabel.text = "Left View"
        leftLabel.textAlignment = .center
        leftLabel.frame = leftView.bounds
        leftLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        leftView.addSubview(leftLabel)
        
        let rightLabel = UILabel()
        rightLabel.text = "Right View"
        rightLabel.textAlignment = .center
        rightLabel.frame = rightView.bounds
        rightLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rightView.addSubview(rightLabel)
    }
    
    @objc private func leftViewTapped() {
        updateMiddleDuplicateView(with: leftView)
    }
    
    @objc private func rightViewTapped() {
        updateMiddleDuplicateView(with: rightView)
    }
    
    private func updateMiddleDuplicateView(with view: UIView) {
        middleDuplicateView.backgroundColor = view.backgroundColor
        if let label = middleDuplicateView.subviews.first(where: { $0 is UILabel }) as? UILabel {
            label.text = (view.subviews.first(where: { $0 is UILabel }) as? UILabel)?.text
        } else {
            let label = UILabel()
            label.frame = middleDuplicateView.bounds
            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            label.textAlignment = .center
            label.text = (view.subviews.first(where: { $0 is UILabel }) as? UILabel)?.text
            middleDuplicateView.addSubview(label)
        }
    }
}
