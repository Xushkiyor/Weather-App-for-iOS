//
//  KelvinToCelciusConvertor.swift
//  Wheather App with Xib
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 09/12/22.
//

import Foundation

extension Float {
    func truncate(places: Int) -> Float {
        return Float(floor(pow(10.0, Float(places)) * self) / pow(10.0, Float(places)))
    }
    
    func kelvinToCelciusConvertor() -> Float {
        let constantVal: Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1)
    }
}
