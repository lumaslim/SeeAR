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
    var spheres = [SCNVector3]()
    
    // - MARK: - Interactions

    @IBOutlet var sceneView: ARSCNView!
    
    // - MARK: - App life cycle hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        self.sceneView.delegate = self
        // Show statistics such as fps and timing information
        self.sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        
        // Set up information label to add to the main view
        self.measurementLabel = getMeasurementLabel()
        self.view.addSubview(self.measurementLabel)
        
        // Set up interactions to add to scene
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(isTap))
        self.sceneView.addGestureRecognizer(tapRecogniser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        self.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        self.sceneView.session.pause()
    }

    // MARK: - Setup
    
    func getMeasurementLabel() -> UILabel {
        let measurementLabel = UILabel()
        // Label background and formatting to show measurements
        measurementLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        measurementLabel.backgroundColor = .white
        measurementLabel.text = "0 inches"
        measurementLabel.textAlignment = .center
        
        return measurementLabel
    }
    
    // MARK: - Utilities
    func getSphereNode(at position: SCNVector3) -> SCNNode {
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
        let skyBlue = UIColor(red: 0, green: 0.87, blue: 0.90, alpha: 1)
        material.diffuse.contents = skyBlue
        
        material.lightingModel = .blinn
        
        return material
    }
    
    // - MARK: - Interaction handlers
    
    @objc func isTap(sender: UITapGestureRecognizer) {
        // Interaction #selector requires obj-C-exposure.
        print("ViewController:: isTap())", sender)
        
        let tapLocation = sender.location(in: sceneView)
        let hitTestResults: [ARHitTestResult] = sceneView.hitTest(tapLocation, types: [ARHitTestResult.ResultType.featurePoint])
        // Feature point nearest to the hit ray AR from real world space.
        guard let tapPoint: ARHitTestResult = hitTestResults.last else { return }
        print(tapPoint.anchor, tapPoint.distance, tapPoint.accessibilityActivationPoint)
        
        // Matrix converted for scene kit use
        let transform = SCNMatrix4(tapPoint.worldTransform)
        let vector: SCNVector3 = SCNVector3Make(transform.m41, transform.m42, transform.m43)
        let sphere: SCNNode = self.getSphereNode(at: vector)
        self.sceneView.scene.rootNode.addChildNode(sphere) 
        guard let sphereExist = self.spheres.first else { return }
        
        print("spheres already exist", sphereExist)
        

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
