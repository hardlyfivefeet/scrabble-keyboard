import UIKit
import Foundation

@IBDesignable class ScrabbleKeyboard: UIView {
    
    var keys: [ScrabbleKey]
      
    override init(frame: CGRect) {
        self.keys = []
        super.init(frame: frame)
        setupKeys()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        self.keys = []
        super.init(coder: aDecoder)
        setupKeys()
        setupView()
    }
    
    private func setupKeys() {
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            let newKey = ScrabbleKey()
            newKey.heightAnchor.constraint(equalToConstant: newKey.height).isActive = true
            newKey.scrabbleKeyLetter = String(char)
            self.keys.append(newKey)
        }
    }

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: Array(self.keys.prefix(9)))
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
