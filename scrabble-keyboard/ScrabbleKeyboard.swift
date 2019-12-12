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
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            let newKey = ScrabbleKey()
            newKey.scrabbleKeyLetter = String(char)
            self.keys.append(newKey)
        }
    }

    private func setupView() {
        self.keys.shuffle()
        let stackView1 = UIStackView(arrangedSubviews: Array(self.keys[0...8]))
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.spacing = 5

        let stackView2 = UIStackView(arrangedSubviews: Array(self.keys[9...17]))
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.spacing = 5
        
        let stackView3 = UIStackView(arrangedSubviews: Array(self.keys[18...26]))
        stackView3.axis = .horizontal
        stackView3.distribution = .fillEqually
        stackView3.spacing = 5
        
        let stackView4 = UIStackView(arrangedSubviews: Array(self.keys[27...35]))
        stackView4.axis = .horizontal
        stackView4.distribution = .fillEqually
        stackView4.spacing = 5
        
        let commaKey = ScrabbleKey()
        commaKey.scrabbleKeyLetter = ","
        
        let deleteKey = ScrabbleKey()
        deleteKey.scrabbleKeyLetter = "Delete"
        
        let spaceKey = ScrabbleKey()
        spaceKey.scrabbleKeyLetter = "Space"
        spaceKey.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let stackView5 = UIStackView(arrangedSubviews: [commaKey, spaceKey, deleteKey])
        stackView5.axis = .horizontal
        stackView5.distribution = .fillEqually
        stackView5.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [stackView1, stackView2, stackView3, stackView4, stackView5])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
}
