//
//  MainFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import ComposableArchitecture

public struct MainState: Equatable {
    var newsState: NewsState = .init()
    var section: MainAction.Section = .news
    
    public init() {}
}

public enum MainAction: Equatable {
    case didInit
    
    case newsAction(NewsAction)
    case tabBar(TabBarView.Action)
    
    enum Section: Int, CaseIterable {
        case news
        case myLooks
        case shop
        case profile
        case test
    }
}

public struct MainEnvironment {
}

public let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
    .init { state, action, env in
        switch action {
        default:
            break
        }

        return .none
    },
    newsReducer.pullback(
        state: \.newsState,
        action: /MainAction.newsAction,
        environment: { _ in .init() }
    )
)
