//
//  ViewController.swift
//  SeeAR
//
//  Created by SLim on 5/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    var measurementLabel = UILabel()
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        // Label background and formatting to show measurements
        measurementLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        measurementLabel.backgroundColor = .white
        measurementLabel.text = "0 inches"
        measurementLabel.textAlignment = .center
        
        view.addSubview(measurementLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - Utilities
    func createSphere(at position: SCNVector3) -> SCNNode {
        // Create geometry object
        let sphereGeo = getThemedSphere()
        // Establish SCNNode coordinate with attached geometry object
        let sphereNode = SCNNode(geometry: sphereGeo)
        // Set the node position...
        sphereNode.position = position
        
        return sphereNode
    }
    
    func getThemedSphere() -> SCNSphere {
        let sphereGeometry = SCNSphere(radius: 0.01)
        let sphereThemeMaterial = getMaterialVisuals()
        
        sphereGeometry.firstMaterial = sphereThemeMaterial
        
        return sphereGeometry
    }
    
    func getMaterialVisuals() -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.orange
        material.lightingModel = .blinn
        
        return material
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
