//
//  ProfileFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 4.08.22.
//

import Foundation
import ComposableArchitecture

public struct ProfileState: Equatable {
    public init() {}
}

public enum ProfileAction: Equatable {
    case didInit
}

public struct ProfileEnvironment {
}

public let profileReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment>.combine(
    .init { state, action, env in
        switch action {

        default:
            break
        }

        return .none
    }
)
