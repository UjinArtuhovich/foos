//
//  NewsFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import ComposableArchitecture

public struct NewsState: Equatable {
    public init() {}
}

public enum NewsAction: Equatable {
    case didInit
}

public struct NewsEnvironment {
    
}

public let newsReducer = Reducer<NewsState, NewsAction, NewsEnvironment>.combine(
    .init { state, action, env in
        switch action {
        default:
            break
        }

        return .none
    }
)
