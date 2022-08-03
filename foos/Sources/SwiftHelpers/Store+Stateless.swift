//
//  Store+Stateless.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import ComposableArchitecture

public extension Store {
    func scope<LocalAction>(action fromLocalAction: @escaping (LocalAction) -> Action) -> Store<Void, LocalAction> {
        stateless.scope(state: {}, action: fromLocalAction)
    }
}

