//Title: barcodeViewController

//Current Version: 1.0

//Purpose/Functions:

//To do list:

//Improvements (since previous):

//Noted Errors:


import UIKit
import AVFoundation

class barcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var Add: UIButton!
    @IBOutlet weak var exit: UIButton!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var lbl: UILabel!
    var captureSession: AVCaptureSession?
var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var lbldata: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession()
}

func setupCaptureSession() {
    captureSession = AVCaptureSession()
    guard let captureSession = captureSession else { return }

    AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
        guard let self = self else { return }

        if granted {
            DispatchQueue.main.async {
                captureSession.beginConfiguration()

                if let videoCaptureDevice = AVCaptureDevice.default(for: .video) {
                    do {
                        let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                        if captureSession.canAddInput(videoInput) {
                            captureSession.addInput(videoInput)
                        } else {
                            print("Could not add video input to capture session")
                            return
                        }
                    } catch {
                        print("Error creating video input: \\(error)")
                        return
                    }
                } else {
                    print("No video capture device available")
                    return
                }

                let metadataOutput = AVCaptureMetadataOutput()
                if captureSession.canAddOutput(metadataOutput) {
                    captureSession.addOutput(metadataOutput)

                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.qr, .ean13, .ean8, .code128]
                } else {
                    print("Could not add metadata output to capture session")
                    return
                }

                captureSession.commitConfiguration()

                self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                self.videoPreviewLayer?.frame = self.cameraView.bounds
                self.videoPreviewLayer?.videoGravity = .resizeAspectFill
                if let videoPreviewLayer = self.videoPreviewLayer {
                    self.cameraView.layer.addSublayer(videoPreviewLayer)
                }

                captureSession.startRunning()
            }
        } else {
            print("Camera access denied")
        }
    }
}

func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    if let metadataObject = metadataObjects.first {
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        guard let stringValue = readableObject.stringValue else { return }

        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        found(code: stringValue)
    }
}

func found(code: String) {
    self.lbl.text = "Barcode found"
    self.lbldata.text = "\(code)"
    Add.isEnabled = true
    }
}
