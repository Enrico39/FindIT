import SwiftUI
import AVFoundation
import Vision
import CoreLocation




class CameraViewModel: ObservableObject {
    @EnvironmentObject private var vm: LocationsViewModel

    
    @Published var lastRecognizedLabel: String?
    @Published var isShowingInfoView = false
    @Published var isShowingLabel = false
    @Published var labelText = ""
    @Published var isUnlockButtonEnabled = false
    @Published var isUnlockButtonRed = false
    @Published var progress: Float = 0.0
  //  @Published var infoViewCount: Int = 0
    @Published var isImageClassificationEnabled = true
    @Published var isShowingProgress = true
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var isProgressBarEnabled = true

    
  //  private let maxInfoViewCount = 1
    let maxDistance: CLLocationDistance = 300.0
    
    private func calculateDistance(from userLocation: CLLocationCoordinate2D, to placeLocation: CLLocationCoordinate2D) -> CLLocationDistance {
        let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let placeLocation = CLLocation(latitude: placeLocation.latitude, longitude: placeLocation.longitude)
        return userLocation.distance(from: placeLocation)
    }

    
    
    
    func findNearestLocation(userLocation: CLLocationCoordinate2D, locations: [Location]) -> Location? {
        var nearestLocation: Location?
        var shortestDistance: CLLocationDistance = Double.infinity
        
        for location in locations {
            let locationCoordinates = location.coordinates
            let locationCoordinate = CLLocation(latitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude)
            let userCoordinate = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            
            let distance = locationCoordinate.distance(from: userCoordinate)
            if distance < shortestDistance {
                shortestDistance = distance
                nearestLocation = location
            }
        }
        
        return nearestLocation
    }

    // Utilizzo dell'example

 


  

    //MARK: ContaInfoView
    /*
    func incrementInfoViewCount() {
        infoViewCount += 1
        if infoViewCount >= maxInfoViewCount {
            showMaxInfoViewAlert()
            infoViewCount = 0
        }
    }
    */
    
    private func showMaxInfoViewAlert() {
        self.isImageClassificationEnabled = false
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "Ritorno sui proprio passi...",
                message: "Luogo già sbloccato.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.progress = 0.0
                self.isImageClassificationEnabled = true
                self.isShowingProgress = true
                self.isImageClassificationEnabled = true
            })
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkUserLocation(for placeLocation: CLLocationCoordinate2D) {
        guard let userLocation = userLocation else {
            return
        }

        
        
        if let nearestLocation = findNearestLocation(userLocation: userLocation, locations: vm.locations) {
            print("La location più vicina è___________ \(nearestLocation.name)")
        } else {
            print("Nessuna location trovata____________")
        }
        
        
        
        let distance = calculateDistance(from: userLocation, to: placeLocation)
        if distance <= maxDistance {
            isShowingLabel = true
            isUnlockButtonEnabled = true
            isUnlockButtonRed = false
            isProgressBarEnabled = true  // Abilita la barra di avanzamento
            

            if let nearestLocation = findNearestLocation(userLocation: userLocation, locations: vm.locations) {
                print("La location più vicina è___________ \(nearestLocation.name)")
            } else {
                print("Nessuna location trovata____________")
            }
            
        } else {
            isShowingLabel = true
            isUnlockButtonEnabled = false
            isUnlockButtonRed = true
            isProgressBarEnabled = false  // Disabilita la barra di avanzamento
        }
    }
}



struct CameraView: View {
    @StateObject private var viewModel = CameraViewModel()
    @State private var isLocationAuthorized = false
    
    
    
    var body: some View {
        ZStack {
            CameraPreview(viewModel: viewModel)
                .ignoresSafeArea(.all)
            VStack {
                //NOME LABEL
               // Text("\(viewModel.labelText)")
                Spacer()
                if viewModel.isProgressBarEnabled {
                    ProgressBar(viewModel: viewModel, progress: $viewModel.progress)
                        .frame(width: 60.0, height:  60.0)
                        .padding(20.0)
                }
            }
        }
        .onAppear {
            CameraBufferDelegate.shared.startCapture(with: viewModel)
            viewModel.isShowingLabel = false
            viewModel.isUnlockButtonEnabled = false
            viewModel.isUnlockButtonRed = true
            checkLocationAuthorizationStatus()
        }
        .onDisappear {
            CameraBufferDelegate.shared.stopCapture()
        }
        .sheet(isPresented: $viewModel.isShowingInfoView) {
            Text("Pagoda Cinese")
                .padding(.top,10)
                .font(.largeTitle)
            Text("Scopri di più su \"Pagoda Cinese\" nella sezione Secret Places!")
                .font(.title3)
                .padding(.top,10)

            Spacer()
            Image("pagoda")
                .resizable()
                .imageScale(.small)
                .onAppear {
                   // viewModel.incrementInfoViewCount()
                    viewModel.isShowingProgress = false
                }
                .onDisappear {
                    viewModel.isShowingProgress = true
                }
        }
        .onReceive(viewModel.$isShowingInfoView) { isShowingInfoView in
            if isShowingInfoView {
                //viewModel.incrementInfoViewCount()
                viewModel.isShowingProgress = false
            }
        }
    }
    
    
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            viewModel.isShowingLabel = true
            viewModel.isUnlockButtonEnabled = true
            viewModel.isUnlockButtonRed = false
            isLocationAuthorized = true
        } else {
            viewModel.isShowingLabel = false
            viewModel.isUnlockButtonEnabled = false
            viewModel.isUnlockButtonRed = true
            isLocationAuthorized = false
        }
    }
}


class CameraBufferDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, CLLocationManagerDelegate {
    static let shared = CameraBufferDelegate()
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    var viewModel: CameraViewModel?
    var lastRecognizedLabel: String?
    var progressTimer: Timer?
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        setupCamera()
        setupLocationManager()
    }
    
    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraQueue"))
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func startCapture(with viewModel: CameraViewModel) {
        self.viewModel = viewModel
        captureSession.startRunning()
        locationManager.startUpdatingLocation()
    }
    
    func stopCapture() {
        captureSession.stopRunning()
        viewModel = nil
        stopProgressTimer()
        lastRecognizedLabel = nil
        locationManager.stopUpdatingLocation()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let userLocation = viewModel?.userLocation else {
            return
        }
        
        if let closestLocation = findClosestLocation(userLocation: userLocation) {
            let distance = calculateDistance(from: userLocation, to: closestLocation.coordinates)
            if distance <= viewModel?.maxDistance ?? 0 {
                classifyImage(pixelBuffer: pixelBuffer)
            } else {
                DispatchQueue.main.async {
                    if distance > self.viewModel?.maxDistance ?? 0 {
                        self.viewModel?.labelText = "Fuori dal raggio"
                    } else {
                        self.viewModel?.labelText = "Luogo non riconosciuto"
                    }
                    self.viewModel?.isShowingLabel = true
                    self.viewModel?.isUnlockButtonEnabled = false
                    self.viewModel?.isUnlockButtonRed = true
                    self.stopProgressTimer()
                    self.lastRecognizedLabel = nil
                }
            }
        }
    }
    
    private func classifyImage(pixelBuffer: CVPixelBuffer) {
        let request = VNCoreMLRequest(model: YourCoreMLModel().model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let firstResult = results.first {
                let confidenceThreshold: Float = 0.8
                if firstResult.confidence >= confidenceThreshold {
                    DispatchQueue.main.async {
                        self.viewModel?.labelText = "Ciao \(firstResult.identifier)"
                        self.viewModel?.isShowingLabel = true
                        self.viewModel?.isUnlockButtonEnabled = true
                        self.viewModel?.isUnlockButtonRed = false
                        if firstResult.identifier != self.lastRecognizedLabel {
                            self.startProgressTimer()
                            self.lastRecognizedLabel = firstResult.identifier
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.viewModel?.labelText = "Luogo non riconosciuto"
                        self.viewModel?.isShowingLabel = true
                        self.viewModel?.isUnlockButtonEnabled = false
                        self.viewModel?.isUnlockButtonRed = true
                        self.stopProgressTimer()
                        self.lastRecognizedLabel = nil
                    }
                }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    private func findClosestLocation(userLocation: CLLocationCoordinate2D) -> Location? {
        let locations = LocationsDataService.locations.filter { !$0.isUnlocked }
        guard let closestLocation = locations.min(by: { calculateDistance(from: userLocation, to: $0.coordinates) < calculateDistance(from: userLocation, to: $1.coordinates) }) else {
            return nil
        }
        return closestLocation
    }

    private func calculateDistance(from userLocation: CLLocationCoordinate2D, to placeLocation: CLLocationCoordinate2D) -> CLLocationDistance {
        let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let placeLocation = CLLocation(latitude: placeLocation.latitude, longitude: placeLocation.longitude)
        return userLocation.distance(from: placeLocation)
    }

    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        viewModel?.userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    
    
    
    func startProgressTimer() {
        stopProgressTimer()
        viewModel?.progress = 0.0
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            guard let progress = self.viewModel?.progress else { return }
            if progress >= 1.0 {
                self.stopProgressTimer()
            } else {
                self.viewModel?.progress += 0.01
            }
        }
    }
    
    
    
    func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
}



struct CameraPreview: UIViewRepresentable {
    @ObservedObject var viewModel: CameraViewModel
    
    
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: CameraBufferDelegate.shared.captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let cameraView = uiView as? UIView else {
            return
        }
        guard let previewLayer = cameraView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer else {
            return
        }
        previewLayer.frame = cameraView.bounds
    }
}



struct InfoView: View {
    var labelText: String
    
    
    
    var body: some View {
        ZStack {
            Text(labelText)
                .font(.title)
                .foregroundColor(.black)
                .padding()
        }
    }
}



struct ProgressBar: View {
    @ObservedObject var viewModel: CameraViewModel
    @Binding var progress: Float
    
    
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(self.progress >= 1.0 ? Color.blue : Color.blue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 4.0))
                .onChange(of: progress) { newValue in
                    if newValue >= 1.0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.progress = 0
                            self.viewModel.isShowingLabel = false
                            self.viewModel.isUnlockButtonEnabled = false
                            self.viewModel.isUnlockButtonRed = true
                            self.viewModel.labelText = ""
                            self.viewModel.progress = 0.0
                            self.viewModel.isShowingInfoView = true
                        }
                    }
                }
            //PERCENTUALE
             Text("\(Int(progress * 100))%")
             .font(.system(size: 14))
             .foregroundColor(.white)
             .font(.largeTitle)
             .bold()
             
        }
    }
}



struct YourCoreMLModel {
    let model = try! VNCoreMLModel(for: Findit_ImageClassifier().model)
}


 
