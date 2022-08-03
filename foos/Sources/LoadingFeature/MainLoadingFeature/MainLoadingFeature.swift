//
//  MainLoadingFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import ComposableArchitecture

public struct MainLoadingState: Equatable {
    public init() {}
}

public enum MainLoadingAction: Equatable {
    case didInit
    case didFinishLoading
}

public struct MainLoadingEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.mainQueue = mainQueue
    }
}

public let mainLoadingReducer = Reducer<MainLoadingState, MainLoadingAction, MainLoadingEnvironment>.combine(
    .init { state, action, env in
        switch action {
        case .didInit:
            return .init(value: .didFinishLoading)
                .delay(for: .seconds(MainLoadingConstants.loadingDuration), scheduler: env.mainQueue)
                .eraseToEffect()
            
        default:
            break
        }

        return .none
    }
)
