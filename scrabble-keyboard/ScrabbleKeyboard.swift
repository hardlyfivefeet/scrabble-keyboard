import UIKit
import Foundation

@IBDesignable class ScrabbleKeyboard: UIView {

    var keys: [ScrabbleKey] = []
    var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        setupTextField()
        setupLabel()
        setupKeys()
        setupStackView()
    }

    private func setupLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        label.text = "Drag a key from the keyboard and\ndrop it in the text field to enter text"
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 75).isActive = true
    }

    private func setupKeys() {
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            let newKey = ScrabbleKey()
            newKey.scrabbleKeyLetter = String(char)
            newKey.accessibilityIdentifier = String(char)
            self.keys.append(newKey)
        }
    }

    private func setupStackView() {
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
        commaKey.accessibilityIdentifier = "Comma"

        let deleteKey = ScrabbleKey()
        deleteKey.scrabbleKeyLetter = "Delete"
        deleteKey.accessibilityIdentifier = "Delete"

        let spaceKey = ScrabbleKey()
        spaceKey.scrabbleKeyLetter = "Space"
        spaceKey.accessibilityIdentifier = "Space"
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

    private func setupTextField() {
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250.0, height: 40))
        textField.placeholder = "Drag and drop a key here"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = NSTextAlignment.justified
        textField.inputView = UIView() // this disables the keyboard pop up!
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .clear
        textField.accessibilityIdentifier = "textField"

         // this disables the default drop interaction
        if let defaultDrop = textField.textDropInteraction {
            textField.removeInteraction(defaultDrop)
        }

        let dropInteraction = UIDropInteraction(delegate: self)
        textField.addInteraction(dropInteraction)

        addSubview(textField)
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
    }
}

extension ScrabbleKeyboard: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // Ensure the drop session has an object of the appropriate type
        return session.canLoadObjects(ofClass: String.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        // Propose to the system to copy the item from the source app
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        self.textField.becomeFirstResponder()
        session.loadObjects(ofClass: String.self) { strings in
            if strings.first != nil {
                switch strings.first {
                case "Delete":
                    let currentString = self.textField.text!
                    self.textField.text = String(currentString[..<currentString.index(before: currentString.endIndex)])
                case "Space":
                    self.textField.text = self.textField.text! + " "
                default:
                    self.textField.text = self.textField.text! + strings.first!
                }
            }
        }
    }
}
