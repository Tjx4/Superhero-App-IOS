
import UIKit

@IBDesignable
public class SplashUIView: UIView {

    @IBInspectable public var startColor: UIColor = hexStringToUIColor(hex:"#0f0a0f")
    @IBInspectable public var endColor:   UIColor =  hexStringToUIColor(hex:"#0f0f1c")

    override open class var layerClass: AnyClass { return CAGradientLayer.self }

    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        config()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }

    private func config() {
        updateColors()
    }

    private func updateColors() {
        let gradientLayer = layer as! CAGradientLayer

        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

}
