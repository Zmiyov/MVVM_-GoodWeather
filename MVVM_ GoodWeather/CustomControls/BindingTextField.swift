//
//  BindingTextField.swift
//  MVVM_ GoodWeather
//
//  Created by Vladimir Pisarenko on 05.11.2022.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeClosure: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            self.textChangeClosure(text)
        }
        
    }
}
