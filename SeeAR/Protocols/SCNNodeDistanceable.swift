//
//  3DDistanceable.swift
//  SeeAR
//
//  Created by SLim on 7/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import class SceneKit.SCNNode
import struct SceneKit.CGFloat

// lol name
protocol SCNNodeDistanceable {
    func distanceSquared(to destination: SCNNode) -> CGFloat
    func distance(to destination: SCNNode) -> CGFloat
    
}

