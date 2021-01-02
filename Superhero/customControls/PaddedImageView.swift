import UIKit

@IBDesignable class PaddedImageView: UIImageView {
    override var alignmentRectInsets: UIEdgeInsets {
        
        return UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
}
