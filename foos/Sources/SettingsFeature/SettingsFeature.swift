//
//  SettingsFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 3.08.22.
//

import Foundation
import ComposableArchitecture

public struct SettingsState: Equatable {
    public init() {}
}

public enum SettingsAction: Equatable {
    case didInit
    case didTapBackButton
}

public struct SettingsEnvironment {
    
}

public let settingsReducer = Reducer<SettingsState, SettingsAction, SettingsEnvironment>.combine(
    .init { state, action, env in
        switch action {
            
        default:
            break
        }

        return .none
    }
)

