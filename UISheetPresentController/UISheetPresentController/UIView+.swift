//
//  UIView+.swift
//  UISheetPresentController
//
//  Created by Devanand Chauhan on 29/03/23.
//

import UIKit

// MARK: - Designable Extension

extension UIView {
    
    /// Should the view corner be as circle
    @IBInspectable
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    /// Corner radius of view
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
        }
    }
    
    /// Border color of view
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    /// Border width of view
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Shadow color of view
    @IBInspectable
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// Shadow offset of view
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// Shadow opacity of view
    @IBInspectable
    public var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    /// Shadow radius of view
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Shadow path of view
    public var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    /// Should shadow rasterize for view; cache the rendered shadow so that it doesn't need to be redrawn.
    @IBInspectable
    public var shadowShouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    /// Shadow rasterization scale
    @IBInspectable
    public var shadowRasterizationScale: CGFloat {
        get {
            return layer.rasterizationScale
        }
        set {
            layer.rasterizationScale = newValue
        }
    }
    
    /// Clip the subview layers
    @IBInspectable
    public var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /// Rotate view
    @IBInspectable
    var rotation: CGFloat {
        get {
            return 0
        } set {
            transform = CGAffineTransform.identity.rotated(by: newValue.toRadians())
        }
    }
}

// MARK: - Animation Extension

extension UIView {
    
    /// Fade In animation
    ///
    /// - Parameters:
    ///   - duration: duration of animation.
    ///   - delay: delay in animation.
    ///   - completion: optional completion handler to run after animation finishes (default is nil)
    @discardableResult
    func fadeIn(_ duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) -> UIView {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1
        }, completion: completion)
        
        return self
    }
    
    /// Fade Out animation
    ///
    /// - Parameters:
    ///   - duration: duration of animation.
    ///   - delay: delay in animation.
    ///   - completion: optional completion handler to run after animation finishes (default is nil)
    @discardableResult
    func fadeOut(_ duration: TimeInterval = 0.25, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil)  -> UIView {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0
        }, completion: completion)
        
        return self
    }
    
    /// Heart Beat animation
    ///
    /// - Parameters:
    ///   - duration: duration of animation.
    ///   - delay: delay in animation.
    ///   - completion: optional completion handler to run after animation finishes (default is nil)
    @discardableResult
    func heartBeat(_ duration: TimeInterval = 1.8, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil)  -> UIView {
        transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: completion)
        
        return self
    }
    
    /// Shake animation.
    ///
    /// - Parameters:
    ///   - duration: duration of animation.
    ///   - count: number of shakes.
    ///   - distance: displacement of x-axis.
    @discardableResult
    func shake(_ duration: TimeInterval = 0.08, count: Float = 2, distance: CGFloat = 10.0) -> UIView  {
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.autoreverses = true
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.repeatCount = count
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - distance, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + distance, y: center.y))
        
        layer.add(animation, forKey: animation.keyPath)
        
        return self
    }
    
}

// MARK: - Methods

extension UIView {
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// Set some or all corners radiuses of view with shadow.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    ///   - color: shadow color (default is #000000).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat, shadowColor: UIColor = .black, shadowRadius: CGFloat, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
    }
    
    /// Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #000000).
    ///   - radius: shadow radius (default is 16).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.2).
    @objc public func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 16, offset: CGSize = .zero, opacity: Float = 0.2) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    @objc public func addShadowToBottomOnly(ofColor color: UIColor = .black, opacity: Float = 0.1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0 , height: 8)
    }
    
    @objc public func addShadowObjC() {
       self.addShadow()
    }
    
    /// Remove shadow to view.
    @objc public func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.0
    }
}

// MARK: - Constraints

extension UIView {
    
    /// Pin edges to superview.
    ///
    /// - Parameters:
    ///   - subview: view to be pinned
    func pinToSuperview(_ subview: UIView, _ insets: UIEdgeInsets = .zero) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
            ])
    }
    
    /// Pin edges to superview with height.
    ///
    /// - Parameters:
    ///   - subview: view to be pinned
    func pinToSuperview(_ subview: UIView, withHeight height: CGFloat) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    /// Pin edges to superview.
    ///
    /// - Parameters:
    ///   - subview: view to be pinned
    func pinToSuperview(_ insets: UIEdgeInsets = .zero) {
        
        guard let superView = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            superView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -insets.left),
            superView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            superView.topAnchor.constraint(equalTo: topAnchor, constant: -insets.top),
            superView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
            ])
    }
    
    /// Center to superview.
    ///
    /// - Parameters:
    ///   - subview: view to be centered
    func centerInSuperview() {
        
        guard let superView = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            superView.centerXAnchor.constraint(equalTo: centerXAnchor),
            superView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

extension CALayer {
    
    func addShadow(radius: CGFloat = 6.0, shadowColor: UIColor = .black, shadowRadius: CGFloat, offset: CGSize = .zero, opacity: Float = 0.5) {
        cornerRadius = radius
        self.shadowColor = shadowColor.cgColor
        self.shadowOffset = offset
        self.shadowOpacity = opacity
        self.shadowRadius = shadowRadius
        self.masksToBounds = false
    }
}

// MARK: - Get All Subviews of type in view

extension UIView {
    
    func getSubviewsOfView<T : UIView>(recursive: Bool = false) -> [T] {
        return self.getSubviewsInner(view: self, recursive: recursive)
    }

    private func getSubviewsInner<T : UIView>(view: UIView, recursive: Bool = false) -> [T] {
        var subviewArray = [T]()
        guard view.subviews.count>0 else { return subviewArray }
        view.subviews.forEach {
            if recursive {
                subviewArray += self.getSubviewsInner(view: $0, recursive: recursive) as [T]
            }
            if let subview = $0 as? T{
                subviewArray.append(subview)
            }
        }
        return subviewArray
    }
}
