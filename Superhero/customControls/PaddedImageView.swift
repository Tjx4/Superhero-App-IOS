import UIKit

@IBDesignable class PaddedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
 
        let padding: CGFloat = 10.0
        let uIEdgeInsets = UIEdgeInsets(top: padding, left: 0.0, bottom: 0.0, right: padding)
        
//self.image = self.image?.resizableImage(withCapInsets: uIEdgeInsets)
        
        self.image = self.image?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        
let imageView = UIImageView(image: self.image?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)))

        /*
        frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.size.width,
            height: bounds.size.height
        )
        */
    }
    
    
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
