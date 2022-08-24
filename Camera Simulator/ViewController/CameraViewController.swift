//
//  CameraViewController.swift
//  Camera Simulator
//
//  Created by Rasyid Ridla on 11/05/22.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate & UIPickerViewDelegate & UIPickerViewDataSource {
    
    
    @IBOutlet weak var trianglePicker: UIPickerView!
    @IBOutlet weak var apertureSlider: UISlider!
    
    @IBOutlet weak var shutterButton: UIButton!
    @IBOutlet weak var apertureButton: UIButton!
    @IBOutlet weak var isoButton: UIButton!

    @IBOutlet weak var shutterControl: UISegmentedControl!
    @IBOutlet weak var isoControl: UISegmentedControl!
    @IBOutlet weak var apertureControl: UISegmentedControl!
    
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var apertureLabel: UILabel!
    @IBOutlet weak var shutterLabel: UILabel!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var sizeScreen: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var frontCameraButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var heightPreview: NSLayoutConstraint!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var dropUp: UIButton!
    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var dropDown: UIButton!
    
    @IBOutlet weak var shutterSlider: UISlider!
    @IBOutlet weak var isoSlider: UISlider!
    @IBOutlet weak var isoLabelText: UILabel!
    @IBOutlet weak var shutterLabelText: UILabel!
    @IBOutlet weak var focusLabelText: UILabel!
    @IBOutlet weak var iso: UILabel!
    @IBOutlet weak var shutter: UILabel!
    @IBOutlet weak var focus: UILabel!
    @IBOutlet weak var gridSecond: UIButton!
    @IBOutlet weak var gridThird: UIButton!
    @IBOutlet weak var gridFirst: UIButton!
    @IBOutlet weak var toggleManual: UISwitch!
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var switchManual: UISwitch!
    @IBOutlet weak var zoom: UILabel!
    @IBOutlet weak var zoomSlider: UISlider!
    @IBOutlet weak var zoomValue: UILabel!
    @IBOutlet weak var labelMode: UILabel!
    @IBOutlet weak var gridLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var gridGoldenRatio: UIButton!
    @IBOutlet weak var frame1: UIButton!
    @IBOutlet weak var frame4: UIButton!
    @IBOutlet weak var frame16: UIButton!
    @IBOutlet weak var topSpacePreview: NSLayoutConstraint!
    @IBOutlet weak var gridDiagonal: UIImageView!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var compositionButton: UIButton!
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var popOverButton: UIButton!
    
    
    
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    var camera: ManualCamera!
    var guideRulerLayer: CAShapeLayer!
    var focusLayer: CAShapeLayer!
    var authorized: Bool!
    var isShowGuideRuller = false
    var isHiddenShutteer = true
    var isHiddenIso = true
    var isHiddenAperture = true
    var isFlash = false
    var timer = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    var isCaseAuto = false
    var isTimerOn = false
    var timerSecond = 0.0
    var imageButtonFlash = ["bolt.slash.fill", "bolt.fill", "bolt.badge.a.fill", "flashlight.on.fill"]
    var size = ["3:4", "1:1"]
    var numb = 1
    var sizeNumb = 1
    var isoData: [Float] = [Float]()
    var shutterData: [CMTime] = [CMTime]()
    var flashMode: AVCaptureDevice.FlashMode = .off
    var timerTime = 0.0
    var isTorchOn = false
    var isHideMode = true
    var isHideExposure = true
    var isHideFocus = true
    var isHideComposition = true
    var count = 0.0
    var timerTest: Timer?
    
    //MARK: - MODIFIED FOR FRONT CAMERA
    @objc dynamic var videoDevice: AVCaptureDevice?

    //MARK: - END MODIFIED
    
   
    
    private func authorizeCameraUsage(_ completionHandler: @escaping((_ success: Bool) -> Void)) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                completionHandler(granted)
            }
        }
    }

    @IBAction func dropUp(_ sender: UIButton) {
       setupExposure()
    }
    
    func setupExposure() {
        if !isHideMode {
            setupMode()
        } else if !isHideFocus {
            setupFocus()
        } else if !isHideComposition {
            setupComposition()
        }
        
        isHideExposure.toggle()
        setView.isHidden = isHideExposure
        
//        setView.isHidden = false
        focus.isHidden = true
        apertureSlider.isHidden = true
        focusLabelText.isHidden = true
        isoSlider.isHidden = false
        isoLabelText.isHidden = false
        shutterSlider.isHidden = false
        shutterLabelText.isHidden = false
        iso.isHidden = false
        shutter.isHidden = false
        gridFirst.isHidden = true
        gridSecond.isHidden = true
        gridThird.isHidden = true
        dropDown.isHidden = false
        toggleManual.isHidden = true
        zoom.isHidden = true
        zoomSlider.isHidden = true
        zoomValue.isHidden = true
        labelMode.isHidden = true
        gridLabel.isHidden = true
        gridGoldenRatio.isHidden = true
        frameLabel.isHidden = true
        frame1.isHidden = true
        frame4.isHidden = true
        frame16.isHidden = true
        setUp()
        
        dropUp.tintColor = isHideExposure ? .white : .yellow

        if dropUp.tintColor == .yellow {
            focusButton.tintColor = .white
            modeButton.tintColor = .white
            compositionButton.tintColor = .white
        }
    }
    
    
    @IBAction func dropDown(_ sender: UIButton) {
        dropUp.isHidden = false
        setView.isHidden = true
        dropDown.isHidden = true
        modeButton.tintColor = .white
        focusButton.tintColor = .white
        dropUp.tintColor = .white
        compositionButton.tintColor = .white
        setUp()
    }
    
    @IBAction func modeButton(_ sender: UIButton) {
            setupMode()
    }
    
    func setupMode() {
        if !isHideExposure {
            setupExposure()
        } else if !isHideFocus {
            setupFocus()
        } else if !isHideComposition {
            setupComposition()
        }
        
        isHideMode.toggle()
        setView.isHidden = isHideMode
        
//        setView.isHidden = false
        dropDown.isHidden = false
        isoSlider.isHidden = true
        isoLabelText.isHidden = true
        shutterSlider.isHidden = true
        shutterLabelText.isHidden = true
        iso.isHidden = true
        shutter.isHidden = true
        focus.isHidden = true
        apertureSlider.isHidden = true
        focusLabelText.isHidden = true
        gridFirst.isHidden = true
        gridSecond.isHidden = true
        gridThird.isHidden = true
        toggleManual.isHidden = false
        zoom.isHidden = true
        zoomSlider.isHidden = true
        zoomValue.isHidden = true
        labelMode.isHidden = false
        gridLabel.isHidden = true
        gridGoldenRatio.isHidden = true
        frameLabel.isHidden = true
        frame1.isHidden = true
        frame4.isHidden = true
        frame16.isHidden = true
        setUp()
        
        modeButton.tintColor = isHideMode ? .white : .yellow

        if modeButton.tintColor == .yellow {
            focusButton.tintColor = .white
            dropUp.tintColor = .white
            compositionButton.tintColor = .white
        }
        
        
        switchManual.addTarget(self, action: #selector(manualMode), for: UIControl.Event.valueChanged)
    }
    
    @objc func manualMode(switchManual: UISwitch) {
        if switchManual.isOn {
//            camera.focusMode = CameraFocusMode(rawValue: apertureControl.selectedSegmentIndex)!
            labelMode.text = "Manual Mode"
            focusButton.isEnabled = true
            dropUp.isEnabled = true
            
            focusButton.tintColor = .white
            dropUp.tintColor = .white
            
            apertureSlider.isEnabled = true
            camera.focusMode = .manual
            apertureSlider.thumbTintColor = apertureSlider.isEnabled ? UIColor.white : UIColor.gray
            apertureSlider.value = camera.lensPosition()
            
            camera.isoMode = .manual
            trianglePicker.isUserInteractionEnabled = true
            isoSlider.isEnabled = true
            isoSlider.thumbTintColor = UIColor.white
            
            camera.shutterMode = .manual
            trianglePicker.isUserInteractionEnabled = true
            shutterSlider.isEnabled = true
            shutterSlider.thumbTintColor = UIColor.white
        } else if !switchManual.isOn {
            labelMode.text = "Automatic Mode"
            focusButton.isEnabled = false
            dropUp.isEnabled = false
            
            focus.tintColor = .gray
            dropUp.tintColor = .gray
            
            doAutoFocus(at: CGPoint(x: 0.5, y: 0.5))
            apertureSlider.isEnabled = false
            
            camera.isoMode = .auto
            trianglePicker.isUserInteractionEnabled = false
            isoSlider.isEnabled = false
            isoSlider.thumbTintColor = UIColor.gray
            isoSlider.value = camera.isoValue
            isoLabelText.text = "\(camera.isoValue!)"
            
            camera.shutterMode = .auto
            trianglePicker.isUserInteractionEnabled = false
            shutterSlider.isEnabled = false
            shutterSlider.thumbTintColor = UIColor.gray
        }
    }
    
    @IBAction func focusButton(_ sender: UIButton) {
        setupFocus()
    }
    
    
    
    func setupFocus() {
        if !isHideMode {
            setupMode()
        } else if !isHideExposure {
            setupExposure()
        } else if !isHideComposition {
            setupComposition()
        }
        
        isHideFocus.toggle()
        setView.isHidden = isHideFocus
        
//        setView.isHidden = false
        dropDown.isHidden = false
        isoSlider.isHidden = true
        isoLabelText.isHidden = true
        shutterSlider.isHidden = true
        shutterLabelText.isHidden = true
        iso.isHidden = true
        shutter.isHidden = true
        focus.isHidden = false
        apertureSlider.isHidden = false
        focusLabelText.isHidden = false
        gridFirst.isHidden = true
        gridSecond.isHidden = true
        gridThird.isHidden = true
        toggleManual.isHidden = true
        zoom.isHidden = false
        zoomSlider.isHidden = false
        zoomValue.isHidden = false
        labelMode.isHidden = true
        gridLabel.isHidden = true
        gridGoldenRatio.isHidden = true
        frameLabel.isHidden = true
        frame1.isHidden = true
        frame4.isHidden = true
        frame16.isHidden = true
        setUp()
        
        focusButton.tintColor = isHideFocus ? .white : .yellow

        if focusButton.tintColor == .yellow {
            dropUp.tintColor = .white
            modeButton.tintColor = .white
            compositionButton.tintColor = .white
        }
        
        self.focusLabelText.text = "".appendingFormat("f %.2f", self.apertureSlider.value)
        

    }
    
    @IBAction func gridButton(_ sender: UIButton) {
        setupComposition()

    }
    
    func setupComposition() {
        if !isHideMode {
            setupMode()
        } else if !isHideFocus {
            setupFocus()
        } else if !isHideExposure {
            setupExposure()
        }
        
        isHideComposition.toggle()
        setView.isHidden = isHideComposition
        
//        setView.isHidden = false
        dropDown.isHidden = false
        isoSlider.isHidden = true
        isoLabelText.isHidden = true
        shutterSlider.isHidden = true
        shutterLabelText.isHidden = true
        iso.isHidden = true
        shutter.isHidden = true
        focus.isHidden = true
        apertureSlider.isHidden = true
        focusLabelText.isHidden = true
        gridFirst.isHidden = false
        gridSecond.isHidden = false
        gridThird.isHidden = false
        toggleManual.isHidden = true
        zoom.isHidden = true
        zoomSlider.isHidden = true
        zoomValue.isHidden = true
        labelMode.isHidden = true
        gridLabel.isHidden = true
        gridGoldenRatio.isHidden = false
        frameLabel.isHidden = true
        frame1.isHidden = true
        frame4.isHidden = true
        frame16.isHidden = true
        setUp()
        
        compositionButton.tintColor = isHideComposition ? .white : .yellow

        if compositionButton.tintColor == .yellow {
            dropUp.tintColor = .white
            modeButton.tintColor = .white
            focusButton.tintColor = .white
        }
        
        gridSecond.tintColor = .yellow
        gridFirst.tintColor = .white
        gridThird.tintColor = .white
        gridGoldenRatio.tintColor = .white
    }
    
    @IBAction func frameSecond(_ sender: UIButton) {
//        topSpacePreview.constant = 100
//        heightPreview.constant = 100
//        previewView.layoutIfNeeded()
//        showPreview()
//        UIView.animate(withDuration: 0.3, animations: {
//           self.view.layoutIfNeeded()
//        })
//        print(heightPreview.constant)
    }
    
    
    @IBAction func infoButton(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "toInfo", sender: self)
    }
    
    @IBAction func isoSlider(_ sender: UISlider) {
        hapticButton(type: 4)
        
        camera.isoValue = CameraConstants.IsoValues[Int(isoSlider.value)]
        
        isoLabelText.text = "".appendingFormat("%.0f", CameraConstants.IsoValues[Int(isoSlider.value)])
        
    }
    
    @IBAction func shutterSlider(_ sender: UISlider) {
        hapticButton(type: 4)
        
        

        camera.shutterSpeedValue = CameraConstants.ExposureDurationValues[Int(shutterSlider.value)]

        shutterLabelText.text = "\(camera.shutterSpeedValue.value)/\(camera.shutterSpeedValue.timescale)"
//        print(camera.shutterSpeedValue)

        
    }
    
    @IBAction func zoomSlider(_ sender: UISlider) {
        hapticButton(type: 4)
        
//        if zoomSlider.value == zoomSlider.value + 0.5 {
//            camera.zo
//        }
        
        camera.zoom(CGFloat(zoomSlider.value), end: zoomSlider.value == 0.5) { (zoomFactor) -> (Void) in
            self.zoomValue.text = "x".appendingFormat("%.1f", Float(self.camera.zoomFactor()))
        }
        print(camera.zoomFactor())
        
    }
    
    @IBAction func timerAction(_ sender: UIButton) {
       
            
                        
            let alert = UIAlertController(title: "Timer", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "3 Second", style: .default, handler: { action in
                self.timerTime = 3.0
                self.count = self.timerTime
                self.timerButton.tintColor = UIColor.yellow
                self.countDownLabel.text = "3"
                self.isTimerOn = true
            }))
            alert.addAction(UIAlertAction(title: "5 Second", style: .default, handler: { action in
                self.timerTime = 5.0
                self.count = self.timerTime
                self.timerButton.tintColor = UIColor.yellow
                self.countDownLabel.text = "5"
                self.isTimerOn = true
            }))
            alert.addAction(UIAlertAction(title: "10 Second", style: .default, handler: { action in
                self.timerTime = 10.0
                self.count = self.timerTime
                self.timerButton.tintColor = UIColor.yellow
                self.countDownLabel.text = "10"
                self.isTimerOn = true
            }))
            alert.addAction(UIAlertAction(title: "Off", style: .default, handler: { action in
                self.isTimerOn = false
                self.timerTime = 0.0
                print("timer off")
                self.timerButton.tintColor = UIColor.white
                self.countDownLabel.text = ""
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                self.isTimerOn = false
                self.timerButton.tintColor = UIColor.white
                self.countDownLabel.text = ""
                self.isTimerOn = true
            }))
            
            

            
//            // Create the action buttons for the alert.
//            let defaultAction = UIAlertAction(title: "Agree",
//                                              style: .default) { (action) in
//                // Respond to user selection of the action.
//            }
//            let cancelAction = UIAlertAction(title: "Disagree",
//                                             style: .cancel) { (action) in
//                // Respond to user selection of the action.
//            }
//
//
//
//
//
//
//            // Create and configure the alert controller.
//            let alert = UIAlertController(title: "Terms and Conditions",
//                                          message: "Click Agree to accept the terms and conditions.",
//                                          preferredStyle: .alert)
//            alert.addAction(defaultAction)
//            alert.addAction(cancelAction)
//
//
//
            self.present(alert, animated: true)
                // The alert was presented
            
            
                                          
        
    }
    
    @IBAction func gridSymmetry(_ sender: UIButton) {
//        isShowGuideRuller.toggle()
        isShowGuideRuller = true
        if isShowGuideRuller == true {
            showGuideRuler(isShow: !isShowGuideRuller, previewLayer: previewLayer)
            gridGoldenTriangels(isShow: !isShowGuideRuller, previewLayer: previewLayer)
            gridSymmetry(isShow: isShowGuideRuller, previewLayer: previewLayer)
            gridDiagonal.isHidden = true
            
            
        }
        
        gridThird.tintColor = .yellow
        
        if gridThird.tintColor == .yellow {
            gridGoldenRatio.tintColor = .white
            gridFirst.tintColor = .white
            gridSecond.tintColor = .white
        }
        

    }
    
    @IBAction func gridNone(_ sender: UIButton) {
        isShowGuideRuller = false
        if isShowGuideRuller == false {
            gridSymmetry(isShow: isShowGuideRuller, previewLayer: previewLayer)
            showGuideRuler(isShow: isShowGuideRuller, previewLayer: previewLayer)
            gridGoldenTriangels(isShow: isShowGuideRuller, previewLayer: previewLayer)
            gridDiagonal.isHidden = true
        }
        
        gridSecond.tintColor = .yellow
        
        if gridSecond.tintColor == .yellow {
            gridThird.tintColor = .white
            gridFirst.tintColor = .white
            gridGoldenRatio.tintColor = .white
        }
    }
    
    @IBAction func gridTriangels(_ sender: UIButton) {
        isShowGuideRuller = true
        if isShowGuideRuller == true {
            showGuideRuler(isShow: !isShowGuideRuller, previewLayer: previewLayer)
            gridSymmetry(isShow: !isShowGuideRuller, previewLayer: previewLayer)
//            gridGoldenTriangels(isShow: isShowGuideRuller, previewLayer: previewLayer)
            gridDiagonal.isHidden = false
        }
        
        gridGoldenRatio.tintColor = .yellow
        
        if gridGoldenRatio.tintColor == .yellow {
            gridThird.tintColor = .white
            gridFirst.tintColor = .white
            gridSecond.tintColor = .white
        }
    }
    
    
    
    @IBAction func flashButton(_ sender: UIButton) {
        
        
        
        
//        if numb == 0 {
//            flashMode = .off
//            print("off")
//            isTorchOn = false
//            torchOn()
//        } else if numb == 1 {
//            flashMode = .on
//            print("on")
//            isTorchOn = false
//            torchOn()
//        } else if numb == 2 {
//            flashMode = .auto
//            print("auto")
//            isTorchOn = false
//            torchOn()
//        } else if == 3 {
//            isTorchOn = true
//            torchOn()
//
//        }
        
        switch numb {
        case 0 :
            flashMode = .off
            print("off")
            isTorchOn = false
            torchOn()
        case 1 :
            flashMode = .on
            print("on")
            isTorchOn = false
            torchOn()
        case 2 :
            flashMode = .auto
            print("auto")
            isTorchOn = false
            torchOn()
        case 3 :
            isTorchOn = true
            torchOn()
        default:
            print("default value")
        }
        
        flashButton.setImage(UIImage(systemName: imageButtonFlash[numb]), for: .normal)
        
        if numb == 3 {
            numb = 0
        } else {
            numb += 1
        }
        
        
        

    }
    
    func torchOn() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        if isTorchOn {
            
            do {
                try device.lockForConfiguration()
                
                device.torchMode = AVCaptureDevice.TorchMode.on
                
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        } else {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = AVCaptureDevice.TorchMode.off
                
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func setUp() {
        setView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        
    }
    
    func hiddenAll() {
        shutterButton.isHidden = true
        isoButton.isHidden = true
        apertureButton.isHidden = true
        
        shutterLabel.isHidden = true
        apertureLabel.isHidden = true
        isoLabel.isHidden = true
        
        modeButton.tintColor = .white
        compositionButton.tintColor = .white
        

        
        
    }
    
    @IBAction func sizeButton(_ sender: UIButton) {
        
        sizeScreen.setTitle(size[sizeNumb], for: .normal)
        
        if sizeNumb == 1 {
            
        } else {
//            heightPreview.constant = 482
        }
        
        if sizeNumb == 1 {
            sizeNumb = 0
        } else {
            sizeNumb += 1
        }
    }
   
    
    
    
    
//    func flashLight() {
//        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
//        guard device.hasTorch else { return }
////        let orientation = previewLayer.connection?.videoOrientation
////        camera.takePhoto(orientation: orientation!)
//        if isFlash {
//
//
//            do {
//                try device.lockForConfiguration()
//
//                device.torchMode = AVCaptureDevice.TorchMode.on
//
//                device.unlockForConfiguration()
//            } catch {
//                print(error)
//            }
//        } else {
//            do {
//                try device.lockForConfiguration()
//
//                device.torchMode = AVCaptureDevice.TorchMode.off
//
//                device.unlockForConfiguration()
//            } catch {
//                print(error)
//            }
//        }
//    }

    
    private func authorizePhotoLibraryUsage(_ completionHandler: @escaping((_ success: Bool) -> Void)) {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                completionHandler(status == .authorized)
            }
        }
    }
    private func failAndExit(message: String) {
        let alert = UIAlertController(title: "Initialization Error!", message: message, preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(exitAction)
        present(alert, animated: true, completion: nil)
    }
}


//ovveride function
extension CameraViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.isHidden = true
        hiddenAll()
        initCamera()
        settingView.backgroundColor = UIColor(white: 0, alpha: 0)
        apertureSlider.isEnabled = false
        isoSlider.isEnabled = false
        shutterSlider.isEnabled = false
        gridDiagonal.isHidden = true
        dropUp.isEnabled = false
        focusButton.isEnabled = false
        
        popOverButton.isHidden = true
        flashButton.imageView?.contentMode = .scaleAspectFill
        
//        flashButton.setImage(UIImage(systemName: imageButtonFlash[0]), for: .normal)
        
        timerButton.setImage(UIImage(systemName: "timer"), for: .normal)
        timerButton.tintColor = UIColor.white
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let showOnboarding = UserDefaults.standard.bool(forKey: showOnBoard)
        if !showOnboarding {
            let onBoardingVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: onBoardVCId) as! OnBoardingViewController

            onBoardingVC.modalPresentationStyle = .overCurrentContext
            present(onBoardingVC, animated: true)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if camera != nil {
            camera.start()
            
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if camera != nil {
            camera.stop()
//            previewView.removeFromSuperview()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//Custom Function
extension CameraViewController: UIGestureRecognizerDelegate {
    
    private func initCamera() {
        authorized = (AVCaptureDevice.authorizationStatus(for: .video) == .authorized) && (PHPhotoLibrary.authorizationStatus() == .authorized)
        
        if !authorized {
            authorizeCameraUsage { (success) in
                if success {
                    self.authorizePhotoLibraryUsage({ (success) in
                        if success {
                            self.authorized = true
                            self.showPreview()
                        } else {
                            self.authorized = false
                            self.failAndExit(message: "Failed to authorize photo library usage.\nPlease quit application.")
                        }
                    })
                } else {
                    self.authorized = false
                    self.failAndExit(message: "Failed to authorize camera usage.\nPlease quit application.")
                }
            }
        } else {
            showPreview()
        }
    }
    
    
    
    private func showPreview() {
        self.camera = ManualCamera()
        self.camera.setDelegate(self)
        self.setupSubViews()
        self.setupPreviewLayer()
        self.camera.start()
        
        
        camera.isoMode = .auto
        camera.focusMode = .auto
        camera.shutterMode = .auto
        
        if camera.isoValue != nil {
            camera.isoMode = .manual
        }
        
//        camera.isoMode = .manual
//        camera.focusMode = .manual
//        camera.shutterMode = .manual
    }
    
    private func setupSubViews() {
        apertureSlider.isHidden = false
        
//        apertureControl.isHidden = false
        isoControl.isHidden = true
        shutterControl.isHidden = true
        
        trianglePicker.isHidden = true
        trianglePicker.isUserInteractionEnabled = false
//        flashegmentedControl.isHidden = true
        
        if previewLayer != nil {
            layoutPreviewLayer()
        }
        
        zoomValue.text = "x".appendingFormat("%.1f", camera.zoomFactor())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doFocus(_:)))
        tapGesture.delegate = self
        previewView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(doZoom(_:)))
        pinchGesture.delegate = self
        previewView.addGestureRecognizer(pinchGesture)
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: camera.captureSession)
        previewLayer.backgroundColor = UIColor.black.cgColor
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer)
    }
    
    private func layoutPreviewLayer() {
        previewLayer.frame = previewView.bounds

        if let conn = previewLayer.connection {
            switch UIDevice.current.orientation {
            case .landscapeLeft:
                conn.videoOrientation = .landscapeRight
                break
            case .landscapeRight:
                conn.videoOrientation = .landscapeLeft
                break
            case .portrait:
                conn.videoOrientation = .portrait
                break
            case .portraitUpsideDown:
                conn.videoOrientation = .portraitUpsideDown
                break
            default: break
            }
        }
    }
    
    private func showGuideRuler(isShow: Bool, previewLayer: AVCaptureVideoPreviewLayer) {
        if !isShow {
            if guideRulerLayer != nil {
                guideRulerLayer.removeFromSuperlayer()
                guideRulerLayer = nil
                
                gridSecond.tintColor = .white
                gridFirst.tintColor = .gray
                gridThird.tintColor = .gray
                gridGoldenRatio.tintColor = .gray
            }
        } else {
            
            guideRulerLayer = CAShapeLayer()
            guideRulerLayer.frame = previewLayer.superlayer!.bounds
            previewLayer.superlayer!.insertSublayer(guideRulerLayer, above: previewLayer)
            let rect = previewLayer.frame
            let linePath = UIBezierPath()
            linePath.lineWidth = 1.0
            
            linePath.move(to: CGPoint(x: 0, y: rect.height / 3))
            linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 3))
            
            linePath.move(to: CGPoint(x: 0, y: rect.height / 1.5))
            linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 1.5))
            
            linePath.move(to: CGPoint(x: rect.width / 3.5, y: 1.5))
            linePath.addLine(to: CGPoint(x: rect.width / 3.5, y: rect.height))
            
            linePath.move(to: CGPoint(x: rect.width / 1.6, y: 1.5))
            linePath.addLine(to: CGPoint(x: rect.width / 1.6, y: rect.height))
            
            guideRulerLayer.path = linePath.cgPath
            guideRulerLayer.strokeColor = UIColor.white.cgColor
            
            gridSecond.tintColor = .gray
            gridFirst.tintColor = .white
            gridThird.tintColor = .gray
            gridGoldenRatio.tintColor = .gray
        }
    }
    
    private func gridSymmetry(isShow: Bool, previewLayer: AVCaptureVideoPreviewLayer) {
        if !isShow {
            if guideRulerLayer != nil {
                guideRulerLayer.removeFromSuperlayer()
                guideRulerLayer = nil
                
                gridSecond.tintColor = .white
                gridFirst.tintColor = .gray
                gridThird.tintColor = .gray
                gridGoldenRatio.tintColor = .gray
            }
        } else {

            guideRulerLayer = CAShapeLayer()
            guideRulerLayer.frame = previewLayer.superlayer!.bounds
            previewLayer.superlayer!.insertSublayer(guideRulerLayer, above: previewLayer)
            let rect = previewLayer.frame
            let linePath = UIBezierPath()
            linePath.lineWidth = 1.0

            linePath.move(to: CGPoint(x: 0, y: rect.height / 1.8))
            linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 1.8))

            linePath.move(to: CGPoint(x: 0, y: rect.height / 1.8))
            linePath.addLine(to: CGPoint(x: rect.width, y: rect.height / 1.8))

            linePath.move(to: CGPoint(x: rect.width / 2.1, y: 2.1))
            linePath.addLine(to: CGPoint(x: rect.width / 2.1, y: rect.height))

            linePath.move(to: CGPoint(x: rect.width / 2.1, y: 2.1))
            linePath.addLine(to: CGPoint(x: rect.width / 2.1, y: rect.height))


            guideRulerLayer.path = linePath.cgPath
            guideRulerLayer.strokeColor = UIColor.white.cgColor
            
            gridSecond.tintColor = .gray
            gridFirst.tintColor = .gray
            gridThird.tintColor = .white
            gridGoldenRatio.tintColor = .gray
        }
    }
    
    private func gridGoldenTriangels(isShow: Bool, previewLayer: AVCaptureVideoPreviewLayer) {
        if !isShow {
            if guideRulerLayer != nil {
                guideRulerLayer.removeFromSuperlayer()
                guideRulerLayer = nil
                
                gridSecond.tintColor = .white
                gridFirst.tintColor = .gray
                gridThird.tintColor = .gray
                gridGoldenRatio.tintColor = .gray
            }
        } else {
            
            guideRulerLayer = CAShapeLayer()
            guideRulerLayer.frame = previewLayer.superlayer!.bounds
            previewLayer.superlayer!.insertSublayer(guideRulerLayer, above: previewLayer)
            let rect = previewLayer.frame
            let linePath = UIBezierPath()
            linePath.lineWidth = 1.0
            
            linePath.move(to: CGPoint(x: 0, y: rect.height / 2.3))
            linePath.addLine(to: CGPoint(x: 143, y: rect.height / 3))
            
            linePath.move(to: CGPoint(x: 267, y: rect.height / 1.5))
            linePath.addLine(to: CGPoint(x: 530, y: rect.height / 2))
            
            linePath.move(to: CGPoint(x: rect.width / 20, y: 1))
            linePath.addLine(to: CGPoint(x: rect.width / 1.06, y: rect.height))
            
//            linePath.move(to: CGPoint(x: rect.width / 1.6, y: 1.5))
//            linePath.addLine(to: CGPoint(x: rect.width / 1.6, y: rect.height))
            
            guideRulerLayer.path = linePath.cgPath
            guideRulerLayer.strokeColor = UIColor.white.cgColor
            
            
        }
    }
    
    private func photosLib() {
    //        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//             imagePicker.delegate = self
//             imagePicker.sourceType = .photoLibrary;
//             imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//         }
        if let url = URL(string: "photos-redirect://"),
                UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:]) { (opened) in
                    if(opened){
                        print("App Store Opened")
                    }
                }
            } else {
                print("Can't Open URL on Simulator")
            }
    }
    
    private func showFocus(at point: CGPoint) {
        if focusLayer == nil {
            focusLayer = CAShapeLayer()
            focusLayer.frame = previewLayer.bounds
            focusLayer.strokeColor = UIColor(named: "blue")?.cgColor
            
            let rectPath = UIBezierPath()
            rectPath.lineWidth = 1.0
            rectPath.move(to: CGPoint(x: point.x - 30, y: point.y - 30))
            rectPath.addLine(to: CGPoint(x: point.x + 30, y: point.y - 30))
            rectPath.move(to: CGPoint(x: point.x + 30, y: point.y - 30))
            rectPath.addLine(to: CGPoint(x: point.x + 30, y: point.y + 30))
            rectPath.move(to: CGPoint(x: point.x + 30, y: point.y + 30))
            rectPath.addLine(to: CGPoint(x: point.x - 30, y: point.y + 30))
            rectPath.move(to: CGPoint(x: point.x - 30, y: point.y + 30))
            rectPath.addLine(to: CGPoint(x: point.x - 30, y: point.y - 30))
            focusLayer.path = rectPath.cgPath
            
            let baseLayer = guideRulerLayer == nil ? previewLayer : guideRulerLayer
            baseLayer?.superlayer!.insertSublayer(focusLayer, above: baseLayer)
        }
    }
    
    private func doAutoFocus(at point: CGPoint) {
        camera.autoFocus(at: point)
    }
    
    private func hideFocus() {
        if focusLayer != nil {
            focusLayer.removeFromSuperlayer()
            focusLayer = nil
        }
    }
    
    @objc func doFocus(_ gestureRecognizer: UITapGestureRecognizer) {
        if camera.focusMode == .auto {
            let touchPoint = gestureRecognizer.location(ofTouch: 0, in: previewView)
            if touchPoint.x < 30 || touchPoint.x > (previewView.frame.size.width - 30) || touchPoint.y < 30 || touchPoint.y > (previewView.frame.size.height - 30) {
                return
            }
            let point = CGPoint(x: touchPoint.x / previewView.frame.size.width, y: touchPoint.y / previewView.frame.size.width)
            showFocus(at: touchPoint)
            doAutoFocus(at: point)
        }
    }
    
    @objc func doZoom(_ gestureRecognizer: UIPinchGestureRecognizer) {
        let pinchZoomScale = gestureRecognizer.scale
        camera.zoom(pinchZoomScale, end: gestureRecognizer.state == .ended) { (zoomFactor) -> (Void) in
            self.zoomValue.text = "x".appendingFormat("%.1f", Float(zoomFactor))
            
        }
    }
    
    private func setupIsoPicker() {
        if !isHiddenShutteer {
            setupShutterPicker()
        }else if (!isHiddenAperture) {
            setupApertureSlider()
        }
        
        shutterData.removeAll()
        self.trianglePicker.delegate = self
        self.trianglePicker.dataSource = self
        isoData = (CameraConstants.IsoValues)
        
        isHiddenIso.toggle()
        trianglePicker.isHidden = isHiddenIso
        isoControl.isHidden = isHiddenIso
        isoButton.setImage(UIImage(named: isHiddenIso ? "ic_iso" : "ic_iso_selected"), for: .normal)
    }
    
    private func setupApertureSlider() {
        if !isHiddenIso {
            setupIsoPicker()
        }else if (!isHiddenShutteer) {
            setupShutterPicker()
        }
        
        isHiddenAperture.toggle()
        apertureSlider.isHidden = isHiddenAperture
//        apertureControl.isHidden = isHiddenAperture
        apertureButton.setImage(UIImage(named: isHiddenAperture ? "ic_aperture" : "ic_aperture_selected"), for: .normal)
        
        apertureSlider.isEnabled = camera.focusMode == .manual
        apertureSlider.minimumTrackTintColor = apertureSlider.isEnabled ? UIColor(named: "blue") : UIColor.gray
        apertureSlider.maximumTrackTintColor = apertureSlider.isEnabled ? UIColor(named: "blue") : UIColor.gray
        apertureSlider.thumbTintColor = apertureSlider.isEnabled ? UIColor(named: "blue") : UIColor.gray
        apertureSlider.value = camera.lensPosition()
    }
    
    private func setupShutterPicker() {
        if !isHiddenIso {
            setupIsoPicker()
        }else if (!isHiddenAperture) {
            setupApertureSlider()
        }
        
        isoData.removeAll()
        self.trianglePicker.delegate = self
        self.trianglePicker.dataSource = self
        shutterData = CameraConstants.ExposureDurationValues
        
        isHiddenShutteer.toggle()
        trianglePicker.isHidden = isHiddenShutteer
        shutterControl.isHidden = isHiddenShutteer
        shutterButton.setImage(UIImage(named: isHiddenShutteer ? "ic_shutter" : "ic_shutter_selected"), for: .normal)
    }
}


//view Click
extension CameraViewController {
    @IBAction func btnLearning(_ sender: Any) {
        let destinationVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: learningVcId) as! LearningViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
    @IBAction func takeButton(_ sender: Any) {
//        capturePhoto()
//        blink()
        if timerTime != 0 {
            starterTimer()
        } else {
            capturePhoto()
        }
        

        

//        let settings = getSettings(camera: camera, flashMode: flashMode)
//            camera.tak(with: settings, delegate: self)
        
        
}
    
    func starterTimer() {
        guard timerTest == nil else { return }
        
        timerTest =  Timer.scheduledTimer(
              timeInterval: TimeInterval(0.9),
              target      : self,
              selector    : #selector(withTimer),
              userInfo    : nil,
              repeats     : true)
    }
    
    func stopTimer() {
        timerTest?.invalidate()
        timerTest = nil
    }

    @objc func withTimer() {
        
        if(timerTime > 0) {
            timerTime -= 1
            countDownLabel.text = String(Int(timerTime))
        } else if timerTime == 0 {
            let orientation = previewLayer.connection?.videoOrientation
           
            camera.takePhoto(flashMode: flashMode, orientation: orientation!)
            blink()
            stopTimer()
            
            timerTime = count
            countDownLabel.text = "\(Int(timerTime))"
            timerButton.tintColor = .white
            
        }

    }
    

    
   

    
    @objc func capturePhoto() {
        let orientation = previewLayer.connection?.videoOrientation
       
        camera.takePhoto(flashMode: flashMode, orientation: orientation!)
        blink()

    }
    
//    @objc func printTime() {
//        capturePhoto()
//        isFlash = true
//        flashLight()
//       }
//    @objc func printTime2() {
//        isFlash = false
//        flashLight()
//
//       }
//
//    @objc func printTime3() {
//        isFlash = true
//        flashLight()
//
//       }
//
    @IBAction func showGuideRuller(_ sender: Any) {
//        isShowGuideRuller.toggle()
//        showGuideRuler(isShow: isShowGuideRuller, previewLayer: previewLayer)
        isShowGuideRuller = true
        if isShowGuideRuller == true {
            gridSymmetry(isShow: !isShowGuideRuller, previewLayer: previewLayer)
            gridGoldenTriangels(isShow: !isShowGuideRuller, previewLayer: previewLayer)
            showGuideRuler(isShow: isShowGuideRuller, previewLayer: previewLayer)
            gridDiagonal.isHidden = true
            
        }
        
        gridFirst.tintColor = .yellow
        
        if gridFirst.tintColor == .yellow {
            gridThird.tintColor = .white
            gridGoldenRatio.tintColor = .white
            gridSecond.tintColor = .white
        }
    }
    
    @IBAction func photosLibButton(_ sender: Any) {
        photosLib()
    }
    
    
    @IBAction func shutterButton(_ sender: Any) {
        setupShutterPicker()
    }
    
    @IBAction func isoButton(_ sender: Any) {
        setupIsoPicker()
    }
    
    @IBAction func apertureButton(_ sender: Any) {
        setupApertureSlider()
        
    }
    
    
    @IBAction func apertureSlider(_ sender: Any) {
        hapticButton(type: 4)

        camera.manualFocus(lensPosition: apertureSlider.value) { () -> (Void) in
            self.focusLabelText.text = "".appendingFormat("f %.2f", self.camera.lensPosition())
            
        }
//        print(camera.lensPosition())
    }
    
    
    @IBAction func apertureControl(_ sender: Any) {
        hapticButton(type: 5)
        
        camera.focusMode = CameraFocusMode(rawValue: apertureControl.selectedSegmentIndex)!
        apertureSlider.isEnabled = camera.focusMode == .manual
//        apertureSlider.thumbTintColor = apertureSlider.isEnabled ? UIColor(named: "blue") : UIColor.gray
        apertureSlider.value = camera.lensPosition()
        if camera.focusMode == .auto {
            doAutoFocus(at: CGPoint(x: 0.5, y: 0.5))
        }
        
        if apertureControl.selectedSegmentIndex == 0 {
            camera.isoMode = .auto
            trianglePicker.isUserInteractionEnabled = false
            isoSlider.isEnabled = false
            isoSlider.thumbTintColor = UIColor.gray
            isoSlider.value = camera.isoValue
            isoLabelText.text = "x".appendingFormat("%.0f", camera.isoValue)
            
            camera.shutterMode = .auto
            trianglePicker.isUserInteractionEnabled = false
            shutterSlider.isEnabled = false
            shutterSlider.thumbTintColor = UIColor.gray
        }else {
            camera.isoMode = .manual
            trianglePicker.isUserInteractionEnabled = true
            isoSlider.isEnabled = true
            isoSlider.thumbTintColor = UIColor(named: "blue")
            
            camera.shutterMode = .manual
            trianglePicker.isUserInteractionEnabled = true
            shutterSlider.isEnabled = true
            shutterSlider.thumbTintColor = UIColor(named: "blue")
        }
        
        
        
        isoLabel.text = "".appendingFormat("%.0f", camera.iso())
        
        shutterLabel.text = camera.exposureDurationLabel()
    }

    
    @IBAction func isoControl(_ sender: Any) {
        hapticButton(type: 5)
        
//        if isoControl.selectedSegmentIndex == 0 {
//            camera.isoMode = .auto
//            trianglePicker.isUserInteractionEnabled = false
//        }else {
//            camera.isoMode = .manual
//            trianglePicker.isUserInteractionEnabled = true
//        }
//
//        isoLabel.text = "".appendingFormat("%.0f", camera.iso())
    }
    
    @IBAction func shutterControl(_ sender: Any) {
        hapticButton(type: 5)
        
//        if shutterControl.selectedSegmentIndex == 0 {
//            camera.shutterMode = .auto
//            trianglePicker.isUserInteractionEnabled = false
//        }else {
//            camera.shutterMode = .manual
//            trianglePicker.isUserInteractionEnabled = true
//        }
//
//        shutterLabel.text = camera.exposureDurationLabel()
    }
}


//camera
extension CameraViewController: CameraDelegate {
    
    func cameraDidFinishFocusing(_ camera: Camera, device: AVCaptureDevice) {
        hideFocus()
        apertureSlider.value = device.lensPosition
        apertureLabel.text = "".appendingFormat("f %.2f", device.lensPosition)
    }
    
    func cameraDidFinishExposing(_ camera: Camera, device: AVCaptureDevice) {
        if self.camera.shutterMode == .auto {
            shutterLabel.text = self.camera.exposureDurationLabel()
            self.camera.shutterSpeedValue = self.camera.exposureDuration()
        }
        if self.camera.isoMode == .auto {
            isoLabel.text = "".appendingFormat("%.0f", self.camera.iso())
            self.camera.isoValue = self.camera.iso()
        }
        
        if !isoData.isEmpty {
            let selecIndex = isoData.firstIndex(of: camera.iso())
            trianglePicker.selectRow(selecIndex ?? 4, inComponent: 0, animated: true)
        } else if !shutterData.isEmpty {
            let selecIndex = shutterData.firstIndex(of: self.camera.exposureDuration())
            trianglePicker.selectRow(selecIndex ?? 4, inComponent: 0, animated: true)
        }
    }
    
    func cameraWillSavePhoto(_ camera: Camera, photo: AVCapturePhoto) -> Data? {
        return photo.fileDataRepresentation()
    }
}


//uipickerview
extension CameraViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return !isoData.isEmpty ? isoData.count : shutterData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return !isoData.isEmpty ? isoData[row].clean : CameraConstants.ExposureDurationLabels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !isoData.isEmpty {
            camera.isoValue = isoData[row]
            print(camera.isoValue)
        } else if !shutterData.isEmpty {
            camera.shutterSpeedValue = shutterData[row]
            print(camera.shutterSpeedValue)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "", size: 6)
            pickerLabel?.textAlignment = .center
        }
        
        if !isoData.isEmpty {
            pickerLabel?.text = isoData[row].clean
        } else if !shutterData.isEmpty {
            pickerLabel?.text = CameraConstants.ExposureDurationLabels[row]
        }
        
        pickerLabel?.textColor = UIColor.white

        return pickerLabel!
    }
    
    func blink() {
        if let wnd = self.previewView{

            let v = UIView(frame: wnd.bounds)
            v.backgroundColor = UIColor.white
            v.alpha = 1

            wnd.addSubview(v)
            UIView.animate(withDuration: 0.5, animations: {
                v.alpha = 0.0
                }, completion: {(finished:Bool) in
                    print("inside")
                    v.removeFromSuperview()
            })
        }
    }
    
    
    
}
