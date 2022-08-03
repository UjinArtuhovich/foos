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
    var settingsState: SettingsState?
    
    var route: MainAction.Route?
    var section: MainAction.Section = .news
    
    public init() {}
}

public enum MainAction: Equatable {
    case didInit
    case didTapSettingsBarButton
    
    case news(NewsAction)
    case settings(SettingsAction)
    case tabBar(TabBarView.Action)
    
    enum Route: Equatable {
        case settings
    }
    
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
        case .didTapSettingsBarButton:
            state.settingsState = .init()
            state.route = .settings
            
        case .settings(.didTapBackButton):
            state.route = .none
            
        default:
            break
        }

        return .none
    },
    newsReducer.pullback(
        state: \.newsState,
        action: /MainAction.news,
        environment: { _ in .init() }
    ),
    settingsReducer.optional().pullback(
        state: \.settingsState,
        action: /MainAction.settings,
        environment: { _ in .init() }
    )
)
