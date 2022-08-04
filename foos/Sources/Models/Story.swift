//
//  Story.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import Foundation

public struct Story: Codable, Hashable {
    public let id: Int
    public let imageUrl: String
    public let isWatched: Bool
}
