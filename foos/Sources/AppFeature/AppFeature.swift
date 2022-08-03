//
//  AppFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import ComposableArchitecture

public struct AppState: Equatable {
    var mainLoadingState: MainLoadingState?
    var mainState: MainState?
    
    var route: AppAction.Route?
    
    public init() {}
}

public enum AppAction: Equatable {
    case didInit
    
    case mainLoading(MainLoadingAction)
    case main(MainAction)
    
    enum Route {
        case mainLoading
        case main
    }
}

public struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.mainQueue = mainQueue
    }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    .init { state, action, env in
        switch action {
        case .didInit:
            state.mainLoadingState = .init()
            state.route = .mainLoading
            
        case .mainLoading(.didFinishLoading):
            state.mainState = .init()
            state.route = .main
            
        default:
            break
        }

        return .none
    },
    mainLoadingReducer.optional().pullback(
        state: \.mainLoadingState,
        action: /AppAction.mainLoading,
        environment: { .init(mainQueue: $0.mainQueue) }
    ),
    mainReducer.optional().pullback(
        state: \.mainState,
        action: /AppAction.main,
        environment: { _ in .init() }
    )
)
