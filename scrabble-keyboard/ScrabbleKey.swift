import Foundation
import UIKit

@IBDesignable class ScrabbleKey: UIView {
    // The component's model.
    var currentTouch: UITouch? = nil
    
    // We will manipulate a drawing layer as the component's "view."
    var scrabbleLayer = CALayer()
    var textLayer = DynamicTextLayer()
    
    @IBInspectable var height: CGFloat = 35

     override var intrinsicContentSize: CGSize {
         return CGSize(width: height, height: height)
     }

     override func prepareForInterfaceBuilder() {
          invalidateIntrinsicContentSize()
     }

    // The "inspectable" properties of the view will allow editing via Xcode!
    @IBInspectable var scrabbleKeyBorderColor: UIColor = .black {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable var scrabbleKeyBorderWidth: Int = 1 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var scrabbleKeyLetter: String = "A" {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable var scrabbleKeyBackgroundColor: UIColor = .white {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var scrabbleKeyLetterColor: UIColor = .black {
        didSet {
            layoutSubviews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        layoutSubviews()
    }

    override func layoutSubviews() {
        textLayer.string = scrabbleKeyLetter
        textLayer.foregroundColor = scrabbleKeyLetterColor.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.fontSize = 22
        textLayer.frame = bounds
        scrabbleLayer.removeFromSuperlayer()
        scrabbleLayer.backgroundColor = scrabbleKeyBackgroundColor.cgColor
        scrabbleLayer.borderColor = scrabbleKeyBorderColor.cgColor
        scrabbleLayer.borderWidth = CGFloat(scrabbleKeyBorderWidth)
        scrabbleLayer.frame = bounds
        layer.addSublayer(scrabbleLayer)
        layer.addSublayer(textLayer)
    }
}

// Credit to this Stack Overflow thread for vertically align the letter in the key:
// https://stackoverflow.com/questions/4765461/vertically-align-text-in-a-catextlayer
class DynamicTextLayer : CATextLayer {
    // REF: http://lists.apple.com/archives/quartz-dev/2008/Aug/msg00016.html
    // CREDIT: David Hoerl - https://github.com/dhoerl
    // USAGE: To fix the vertical alignment issue that currently exists within the CATextLayer class. Change made to the yDiff calculation.
    override func draw(in context: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height-fontSize)/2 - fontSize/10

        context.saveGState()
        context.translateBy(x: 0, y: yDiff) // Use -yDiff when in non-flipped coordinates (like macOS's default)
        super.draw(in: context)
        context.restoreGState()
    }
}
