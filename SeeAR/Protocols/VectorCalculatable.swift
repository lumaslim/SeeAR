//
//  VectorCalculatable.swift
//  SeeAR
//
//  Created by SLim on 7/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//


infix operator +-: AdditionPrecedence
infix operator ☺️: AdditionPrecedence // lol

protocol VectorCalculatable  {

    static func +(l: Self, r: Self) -> Self
    static func +-(l: Self, r: Self) -> Self
    static func -(l: Self, r: Self) -> Self
    static func *(l: Self, r: Self) -> Self
    static func /(l: Self, r: Self) -> Self

}

