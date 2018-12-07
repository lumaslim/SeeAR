//
//  SCNNode+Extension.swift
//  SeeAR
//
//  Created by SLim on 7/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//
import SceneKit

extension SCNNode: SCNNodeDistanceable {
    
    func distanceSquared(to destination: SCNNode) -> CGFloat {
        // - TODO: Try overloading operators for vector calculation practice.
        
        // Alias
        let pt1: SCNVector3 = self.position
        let pt2: SCNVector3 = destination.position
        print("Compare distance pt1 pt2", pt1, pt2)
        // For Cartesian distance in metres
        let dx: Float = pt2.x - pt1.x
        let dy: Float = pt2.y - pt1.y
        let dz: Float = pt2.z - pt1.z
        
        return CGFloat(dx * dx + dy * dy + dz * dz)
    }
    /// Expensive sqrt. 3d distance formula
    ///
    /// - Parameter destination: <#destination description#>
    /// - Returns: <#return value description#>
    func distance(to destination: SCNNode) -> CGFloat {
        // Pythag
        let metres: CGFloat = sqrt(self.distanceSquared(to: destination))
        print("Compare distance metres", metres)
        return metres
    }
    
    /// Distance formula for SCNNodes utility. Calculate the distance between
    /// this node in relation to the destination node referenced.
    ///
    /// - Parameter destination: The destination relative ref point to calculate
    /// - Returns: distance in centimetres
    func distanceInCentimetres(to destination: SCNNode) -> CGFloat {
        return self.distance(to: destination) * 100
    }
}
