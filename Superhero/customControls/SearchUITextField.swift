import UIKit

@IBDesignable class SearchUITextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = hexStringToUIColor(hex: "#E9E9E9")
        updateCornerRadius()
        setBorder()
    }
    

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? 5 : 0
    }
    
    
    func setBorder() {
        layer.borderWidth = 2
        layer.borderColor = hexStringToUIColor(hex:"#E5E5E5").cgColor
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
         return CGRect(
             x: bounds.origin.x + 46,
             y: bounds.origin.y + 0,
             width: bounds.size.width - 15 * 2,
             height: bounds.size.height
         )
     }
    
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return self.textRect(forBounds: bounds)
     }
    
}
