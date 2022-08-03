//
//  News.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import Foundation

public struct News: Codable {
    public let title: String
    public let text: String
    public let id: Int
    public let imageUrl: String
    public let type: String 
}
