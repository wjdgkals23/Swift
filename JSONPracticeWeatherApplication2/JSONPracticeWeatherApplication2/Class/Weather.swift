//
//  Weather.swift
//  JSONPracticeWeatherApplication2
//
//  Created by 정하민 on 02/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//


//"city_name":"요코하마",
//"state":11,
//"celsius":22.4,
//"rainfall_probability":90

import Foundation

struct Weather: Decodable {
    var city_name: String
    var state: Int
    var celsius: Float
    var rainfall_probability: Float
}

