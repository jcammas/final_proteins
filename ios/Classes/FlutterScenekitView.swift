import UIKit
import SceneKit

class FlutterScenekitView: NSObject, FlutterPlatformView, SCNSceneRendererDelegate {
    var sceneView: SCNView
    // var otherView: SCNView
    var scnScene: SCNScene!
    let channel: FlutterMethodChannel
    var forceTapOnCenter: Bool = false
    var parentNode: SCNNode?
    var radius: Float = 1.15
    var type: String = ""
    

    var cameraNode: SCNNode!
    var dataset: [String.SubSequence]?
    var periodic: Periodic?
    var atoms = ProteinsModel()
    var Camera = CameraModel()
    var DataShow = MendeleievController()
    var ProtId:String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    @IBOutlet weak var TabBar: UITabBar!
    @IBOutlet weak var SceneView: UIView!
    @IBOutlet weak var DataView: UIView!
    
    @IBOutlet weak var AtomName: UILabel!
    @IBOutlet weak var AtomDiscover: UILabel!
    @IBOutlet weak var AtomDetails: UITextView!
    
    @IBOutlet weak var ProtName: UILabel!
    
    var dataRepresent:[String.SubSequence]? {
        didSet {
            dataset = dataRepresent
        }
    }
    
    var periodicValue:Periodic? {
        didSet {
            periodic = periodicValue
        }
    }
    
    var ProtIdValue:String? {
        didSet {
            ProtId = ProtIdValue
        }
    }
    
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, messenger msg: FlutterBinaryMessenger) {
        self.sceneView = SCNView(frame: frame)
        // self.otherView = SCNView(frame: frame)
        self.channel = FlutterMethodChannel(name: "scenekit_\(viewId)", binaryMessenger: msg)
        
        super.init()

        // otherView.delegate = self
        // self.channel.setMethodCallHandler(self.onMethodCalled)
        
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        // otherView.addGestureRecognizer(tapGesture)
        self.sceneView.delegate = self
        self.channel.setMethodCallHandler(self.onMethodCalled)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
    }




    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            
//            let sceneView = SceneView as! SCNView
            let p = gestureRecognize.location(in: self.sceneView)
            let hitResults = self.sceneView.hitTest(p, options: [:])

            if hitResults.count > 0 {
                
                let result: SCNHitTestResult = hitResults[0]
                if (((result.node.geometry as? SCNSphere)?.radius) != nil) {
                    self.channel.invokeMethod("widget_tap", arguments: "je suis une string")
                }
            }
        }
  

   
    
    func view() -> UIView { return sceneView }
      
    func createSphere(x: String, y: String, z: String, color: UIColor, name: String) {
        let sphere = SCNSphere(radius: CGFloat(atoms.GetRadius()))
        sphere.firstMaterial?.diffuse.contents = color 
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: Float(x)!, y: Float(y)!, z: Float(z)!)
        

        self.sceneView.scene?.rootNode.addChildNode(sphereNode)
    }
    

   
    func createAtoms(name: String) -> Periodic? {

        let urlPeriodic = URL(string: "https://raw.githubusercontent.com/Bowserinator/Periodic-Table-JSON/master/PeriodicTableJSON.json")!
        
        let semaphorePeriodic = DispatchSemaphore(value: 0)
        var resultPeriodic: Periodic?
        
        URLSession.shared.dataTask(with: urlPeriodic) {(data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: String.Encoding.utf8) {
                do {
                    let jsonData = dataString.data(using: .utf8)!
                    // print (jsonData)
                    resultPeriodic = try JSONDecoder().decode(Periodic.self, from: jsonData)
                    semaphorePeriodic.signal()
                    return
                } catch {
                    semaphorePeriodic.signal()
                    return
                }
            }
        }.resume()
        semaphorePeriodic.wait()

        let url = URL(string: "https://files.rcsb.org/ligands/view/" + name + "_ideal.pdb")!
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: [String.SubSequence]?
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            let response = String(data: data, encoding: .utf8)!
            let lines = response.split(whereSeparator: \.isNewline)
            if lines.count > 0 {
                
                result = lines
                semaphore.signal()
                return
            }
        }.resume()
        semaphore.wait()
    
        
        var i = 0;
        dataset = result!
        while i < dataset?.count ?? 0 {
            let infos = String(dataset![i]).condensed.split(separator: " ")
            
            if infos[0] == "ATOM" {

                createSphere(x: String(infos[6]), y: String(infos[7]), z: String(infos[8]), color: atoms.GetColor(atom: String(infos[11]), periodic: resultPeriodic), name: String(infos[11]))
            } else if infos[0] == "CONECT" {
                
                getConnections(data: infos, content: dataset!)
            }
            i += 1
        }
        print(name)
        self.type = name
        return resultPeriodic
    }
    
    func getConnections(data: [String.SubSequence], content: [String.SubSequence]) -> Periodic? {
        
        let urlPeriodic = URL(string: "https://raw.githubusercontent.com/Bowserinator/Periodic-Table-JSON/master/PeriodicTableJSON.json")!
        
        let semaphorePeriodic = DispatchSemaphore(value: 0)
        var resultPeriodic: Periodic?
        
        URLSession.shared.dataTask(with: urlPeriodic) {(data, response, error) in
            guard let data = data else {
                return
            }
            if let dataString = String(data: data, encoding: String.Encoding.utf8) {
                do {
                    let jsonData = dataString.data(using: .utf8)!
                    // print (jsonData)
                    resultPeriodic = try JSONDecoder().decode(Periodic.self, from: jsonData)
                    semaphorePeriodic.signal()
                    return
                } catch {
                    semaphorePeriodic.signal()
                    return
                }
            }
        }.resume()
        semaphorePeriodic.wait()
        
        var i = 1;
        let index_from = Int(data[1])! - 1
        while (i < data.count - 1) {
            
            let index_to = Int(data[i + 1])! - 1
            
            let searchfrom = String(content[index_from]).condensed.split(separator: " ")
            let searchto = String(content[index_to]).condensed.split(separator: " ")
            
            let from = SCNVector3(x: Float(searchfrom[6])!, y: Float(searchfrom[7])!, z: Float(searchfrom[8])!)
            let to = SCNVector3(x: Float(searchto[6])!, y: Float(searchto[7])!, z: Float(searchto[8])!)
            
            createCylindre(to: to, from: from,  color: atoms.GetColor(atom: String(searchto[11]), periodic: resultPeriodic))
            i += 1
        }
        
        return resultPeriodic
    }

     func createCylindre(to: SCNVector3, from: SCNVector3, color: UIColor) {
        
        let vector = to - from
        let length = vector.length()
        
        let cylinder = SCNCylinder(radius: CGFloat(atoms.GetCylinderRadius()), height: CGFloat(length))
        cylinder.radialSegmentCount = 6
        cylinder.firstMaterial?.diffuse.contents = color

        let node = SCNNode(geometry: cylinder)

        node.position = (to + from) / 2
        node.eulerAngles = SCNVector3Make(Float(CGFloat(Double.pi/2)), acos((to.z-from.z)/length), atan2((to.y-from.y), (to.x-from.x) ))
        self.sceneView.scene?.rootNode.addChildNode(node)
        
    }
  
    
    
    
    func onMethodCalled(_ call :FlutterMethodCall, _ result:FlutterResult) {
        let arguments = call.arguments as? Dictionary<String, Any>
        
        switch call.method {
        case "init":
            initalize(arguments!, result)
            result(nil)
            break
        case "create_atoms":
            if let initialScale = arguments!["initialScale"] as? Double {
                print("initialScale = \(initialScale)")
                sceneView.pointOfView?.camera?.orthographicScale = initialScale
            } else {
                sceneView.pointOfView?.camera?.orthographicScale = 4
            }
            if let backgroundHexColor = arguments!["backgroundColor"] as? Int {
                sceneView.scene!.background.contents = UIColor.init(rgb: backgroundHexColor)
            } else {
                sceneView.scene!.background.contents = UIColor.clear
            }
            
            var name: String
            name = (arguments!["name"] as? String)!
            createAtoms(name: name)
            result(nil)
            break
        case "checkConfiguration":
            result("Config ok")
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
  
    func initalize(_ arguments: Dictionary<String, Any>, _ result:FlutterResult) {
        let scene = SCNScene()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x:0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)
        sceneView.pointOfView = cameraNode

        

        let tapGesture = UITapGestureRecognizer(target: self, action:
                   #selector(handleTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture) 
        DataView?.isHidden = true
        
        self.type = ""
       
        

        if let showStatistics = arguments["showStatistics"] as? Bool {
            self.sceneView.showsStatistics = showStatistics
        }
        
        for reco in sceneView.gestureRecognizers! {
            if let panRecognizer = reco as? UIPanGestureRecognizer {
                panRecognizer.maximumNumberOfTouches = 1
            }
        }

        
       

        sceneView.scene = scene
        sceneView.defaultCameraController.maximumVerticalAngle = 45
        sceneView.defaultCameraController.minimumVerticalAngle = -45
        sceneView.allowsCameraControl = true
        sceneView.pointOfView?.camera?.usesOrthographicProjection = true
        sceneView.cameraControlConfiguration.rotationSensitivity = 0.4
    }
    

}
