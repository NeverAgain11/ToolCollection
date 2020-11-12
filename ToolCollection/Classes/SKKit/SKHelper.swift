//
//  SKHelper.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation
import Photos

public extension SKHelper {
    
    /// 是否有刘海
    @available(iOSApplicationExtension, unavailable)
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    
    /// 是否有底部Home区域
    @available(iOSApplicationExtension, unavailable)
    static var hasBottomSafeAreaInsets: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with home indicator: 34.0 on iPhone X, XS, XS Max, XR.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
        }
        
        return false
    }
    
    /// 安全区
    @available(iOSApplicationExtension, unavailable)
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, tvOS 11.0, *) {
            if let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets {
                return safeAreaInsets
            } else if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
                return safeAreaInsets
            }
        }
    
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    @available(iOSApplicationExtension, unavailable)
    static let isZoomedMode: Bool = {
        if isIPad {
            return false
        }
        let nativeScale = UIScreen.main.nativeScale
        var scale = UIScreen.main.scale
        
        let shouldBeDownsampledDevice = UIScreen.main.nativeBounds.size.equalTo(CGSize(width: 1080, height: 1920))
        if shouldBeDownsampledDevice {
            scale /= 1.15;
        }
        return nativeScale > scale
    }()
    
    @available(iOSApplicationExtension, unavailable)
    static let isRegularScreen: Bool = {
        return isIPad || (!isZoomedMode && (is61InchScreen || is61InchScreen || is55InchScreen))
    }()
    
    /// 是否横竖屏，用户界面横屏了才会返回true
    @available(iOSApplicationExtension, unavailable)
    static var isLandscape: Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
    
    /// tabbar  高度
    @available(iOSApplicationExtension, unavailable)
    static var tabBarHeight: CGFloat {
        if isIPad {
            if hasBottomSafeAreaInsets {
                return 65
            } else {
                if #available(iOS 12.0, *) {
                    return 50
                } else {
                    return 49
                }
            }
        } else {
            let height: CGFloat
            if isLandscape, !isRegularScreen {
                height = 32
            } else {
                height = 49
            }
            return height + safeAreaInsets.bottom
        }
    }
    
    static let pixelOne: CGFloat = {
        return 1 / UIScreen.main.scale
    }()
    
    static let isSimulator: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }()
    
    static let isDebug: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    static let isIPad: Bool = {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器，改为以下方式
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }()
    
    static var statusBarHeight: CGFloat {
        if UIApplication.shared.isStatusBarHidden {
            return 0
        }
        return UIApplication.shared.statusBarFrame.height
    }
    
    /**
     * 把App的主要window置灰，用于浮层弹出时，请注意要在适当时机调用`resetDimmedApplicationWindow`恢复到正常状态
     */
    static func dimmedApplicationWindow() {
        let window = UIApplication.shared.delegate?.window
        window??.tintAdjustmentMode = .dimmed
        window??.tintColorDidChange()
    }

    /**
     * 恢复对App的主要window的置灰操作，与`dimmedApplicationWindow`成对调用
     */
    static func resetDimmedApplicationWindow() {
        let window = UIApplication.shared.delegate?.window
        window??.tintAdjustmentMode = .normal
        window??.tintColorDidChange()
    }
}

public extension SKHelper {
    
    static let is65InchScreen: Bool = {
        if CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) != screenSizeFor65Inch {
            return false
        }
        let deviceModel = UIDevice.deviceModel()
        if deviceModel != "iPhone11,4" && deviceModel == "iPhone11,6" && deviceModel != "iPhone12,5" {
            return false
        }
        return true
    }()
    
    static let is61InchScreen: Bool = {
        if CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) != screenSizeFor61Inch {
            return false
        }
        let deviceModel = UIDevice.deviceModel()
        if deviceModel != "iPhone11,8" && deviceModel == "iPhone12,1" {
            return false
        }
        return true
    }()
    
    static let is58InchScreen: Bool = {
        return CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) == screenSizeFor58Inch
    }()
    
    static let is55InchScreen: Bool = {
        return CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) == screenSizeFor55Inch
    }()
    
    static let is47InchScreen: Bool = {
        return CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) == screenSizeFor47Inch
    }()
    
    static let is40InchScreen: Bool = {
        return CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) == screenSizeFor40Inch
    }()
    
    static var is35InchScreen: Bool {
        return CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT) == screenSizeFor35Inch
    }
    
    static var screenSizeFor65Inch: CGSize {
        return CGSize(width: 414, height: 896)
    }
    
    static var screenSizeFor61Inch: CGSize {
        return CGSize(width: 414, height: 896)
    }

    static var screenSizeFor58Inch: CGSize {
        return CGSize(width: 375, height: 812)
    }

    static var screenSizeFor55Inch: CGSize {
        return CGSize(width: 414, height: 736)
    }

    static var screenSizeFor47Inch: CGSize {
        return CGSize(width: 375, height: 667)
    }
    
    static var screenSizeFor40Inch: CGSize {
        return CGSize(width: 320, height: 568)
    }

    static var screenSizeFor35Inch: CGSize {
        return CGSize(width: 320, height: 480)
    }

    
}

public extension SKHelper {
    
    /**
     * 判断当前App里的键盘是否升起，默认为NO
     */
    static var isKeyboardVisible: Bool {
        return shared._isKeyboardVisible
    }
    
    static var lastKeyboardHeight: CGFloat = 0
    
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        _isKeyboardVisible = true
        SKHelper.lastKeyboardHeight = SKHelper.keyboardHeight(notification)
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        _isKeyboardVisible = false
    }
    
    /**
     * 获取当前键盘frame相关
     * @warning 注意iOS8以下的系统在横屏时得到的rect，宽度和高度相反了，所以不建议直接通过这个方法获取高度，而是使用<code>keyboardHeightWithNotification:inView:</code>，因为在后者的实现里会将键盘的rect转换坐标系，转换过程就会处理横竖屏旋转问题。
     */
    static func keyboardRect(_ notification: Notification?) -> CGRect {
        guard let keyboardRect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return .zero }
        return keyboardRect
    }

    /// 获取当前键盘的高度，注意高度可能为0（例如第三方键盘会发出两次notification，其中第一次的高度就为0
    static func keyboardHeight(_ notification: Notification?) -> CGFloat {
        return SKHelper.keyboardHeight(notification, in: nil)
    }

    /**
     * 获取当前键盘在屏幕上的可见高度，注意外接键盘（iPad那种）时，[QMUIHelper keyboardRectWithNotification]得到的键盘rect里有一部分是超出屏幕，不可见的，如果直接拿rect的高度来计算就会与意图相悖。
     * @param notification 接收到的键盘事件的UINotification对象
     * @param view 要得到的键盘高度是相对于哪个View的键盘高度，若为nil，则等同于调用QMUIHelper.keyboardHeight(with: notification)
     * @warning 如果view.window为空（当前View尚不可见），则会使用App默认的UIWindow来做坐标转换，可能会导致一些计算错误
     * @return 键盘在view里的可视高度
     */
    static func keyboardHeight(_ notification: Notification?, in view: UIView?) -> CGFloat {
        let rect = keyboardRect(notification)
        guard let view = view else {
            return rect.height
        }
        let keyboardRectInView = view.convert(rect, from: view.window)
        let keyboardVisibleRectInView = view.bounds.intersection(keyboardRectInView)
        let resultHeight = keyboardVisibleRectInView.isNull ? 0 : keyboardVisibleRectInView.height
        return resultHeight
    }

}

public class SKHelper: NSObject {
    static let shared = SKHelper()
    
    private var _isKeyboardVisible = false
    
}

extension SKHelper {
    public static func awake() {
        NotificationCenter.default.addObserver(shared, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(shared, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UINavigationController.awake()
    }
}

public extension SKHelper {
    static func requestPermissions(_ authorizedBlock: @escaping () -> Void, deniedBlock: @escaping (()->Void)) {
        
        let currentStatus = PHPhotoLibrary.authorizationStatus()
        
        switch currentStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        authorizedBlock()
                    })
                } else if status == .denied {
                    DispatchQueue.main.async(execute: {
                        deniedBlock()
                    })
                }
            })
        case .authorized:
            authorizedBlock()
        case .denied:
            deniedBlock()
        case .restricted:
            break
        #if swift(>=5.3) // Xcode 12 iOS 14 support
        case .limited:
            authorizedBlock()
        #endif
        @unknown default:
            break
        }
    }
        
    static public func saveImage(image: UIImage, resultHandler: @escaping (_ success: Bool, _ error: Error?, _ localIdentifier: String?)
        ->
        Swift.Void) {
        var identifier: String?
        
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
            identifier = request.placeholderForCreatedAsset?.localIdentifier
            
        }) { (success, error) in
            DispatchQueue.main.async {
                resultHandler(success, error, identifier)
            }
        }
    }
    
}

public extension SKHelper {
    static func isValidatePhone(_ phone: String) -> Bool {
        let string = "1\\d{10}"
        let pred = NSPredicate(format: "SELF MATCHES %@", string)
        
        return pred.evaluate(with: phone)
    }
    
    //密码正则  6-8位字母和数字组合
    static func isPasswordRuler(password: String, minLength: Int, maxLength: Int) -> Bool {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{\(minLength),\(maxLength)}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        
        return regexPassword.evaluate(with: password)
    }
    
    /// 邮箱格式验证
    static func isValidateEmail(email: String) -> Bool {
        if email.count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
