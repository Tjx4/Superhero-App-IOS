import UIKit

@IBDesignable class PaddedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
 
        let padding: CGFloat = 10.0
        let uIEdgeInsets = UIEdgeInsets(top: padding, left: 0.0, bottom: 0.0, right: padding)
      
        self.image = self.image?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
}
