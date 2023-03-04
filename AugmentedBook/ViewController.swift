//
//  ViewController.swift
//  AugmentedBook
//
//  Created by andres nowak on 04/03/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var diamondNode: SCNNode?
    private var heartNode: SCNNode?
    private var fishNode: SCNNode?
    
    var timerChangeView: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        //let scene = SCNScene()
        
        let heartScene = SCNScene(named: "art.scnassets/ship.scn")
        let diamondScene = SCNScene(named: "fish.dae")
        let fishScene = SCNScene(named: "fish.dae")
        
        heartNode = heartScene?.rootNode
        diamondNode = diamondScene?.rootNode
        fishNode = fishScene?.rootNode
        
        timerChangeView = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeView), userInfo: nil, repeats: false)
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load reference images to look for from "AR Resources" folder
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
            
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        // configuration.planeDetection = .horizontal // you can setup needed config here
            
        // Add previously loaded images to ARScene configuration as detectionImages
        configuration.trackingImages = referenceImages
            
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()

        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize

            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            plane.cornerRadius = 0.005
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            var shapeNode: SCNNode?
            
            if imageAnchor.referenceImage.name == "portada_libro" {
                shapeNode = heartNode
            } else {
                shapeNode = fishNode
            }
            
            guard let shape = shapeNode else { return nil }
            
            shape.scale = SCNVector3(0.1, 0.1, 0.1)
            // shape.eulerAngles.y = 4
            
            let shapeSpin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 10)
            let repeatSpin = SCNAction.repeatForever(shapeSpin)
            shape.runAction(repeatSpin)
            
            node.addChildNode(shape)
        }
        
        return node
    }
    
    // Function to change the view
    @objc func changeView() {
        // Perform your view changing logic here
        // For example, you could push a new view controller onto the navigation stack
        self.performSegue(withIdentifier: "ARtoFinal", sender: self)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
