import UIKit

@IBDesignable class PaddedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
 
        let padding: CGFloat = 13.0
        self.image = self.image?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
}
