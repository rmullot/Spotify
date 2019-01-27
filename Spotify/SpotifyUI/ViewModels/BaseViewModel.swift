//
//  BaseViewModel.swift
//  SpotifyUI
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public typealias PropertyChangedClosure = (_ name: String) -> Void

public protocol BaseViewModelProtocol: class {
    func validate()
    var propertyChanged: PropertyChangedClosure? {get set}
}

open class BaseViewModel: BaseViewModelProtocol {

  required public init() { }

  // MARK: - public Properties

  public enum PropertyNames: String {
      case errorMessage
      case isValid
  }

  open var isValid: Bool {
    return false
  }

  open var propertyChanged: PropertyChangedClosure?

  open var errorMessage: String = "" {
    didSet {
        propertyChanged?(PropertyNames.errorMessage.rawValue)
    }
  }

  open func validate() {
    if isValid { propertyChanged?(PropertyNames.isValid.rawValue) }
  }
}
