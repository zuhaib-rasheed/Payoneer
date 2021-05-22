//
//  UIState.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 16.05.21.
//

enum UIState<T> {
    case created
    case loading
    case ready(T)

    var canLoad: Bool {
        switch self {
        case .created:
            return true
        case .loading, .ready:
            return false
        }
    }
}
