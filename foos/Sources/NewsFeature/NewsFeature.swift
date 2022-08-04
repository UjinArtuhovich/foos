//
//  NewsFeature.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import ComposableArchitecture

public struct NewsState: Equatable {
    var dataSource: NewsState.Model?
    
    struct Model: Hashable {
        let news: [News]
        let stories: [Story]
    }
    
    enum Section: Hashable {
        case news
        case stories
    }
    
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
        case .didInit:
            // FIX: - Mockup
            state.dataSource = .init(news: NewsConstants.newsMockup,
                                     stories: NewsConstants.storyMockup)
            
        default:
            break
        }

        return .none
    }
)
