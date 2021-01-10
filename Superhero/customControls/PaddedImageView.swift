import UIKit

@IBDesignable class PaddedImageView: UIImageView {
    var padding: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if padding != 0 {
            return
        }
        
        padding = 13.0
        self.image = self.image?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
}
