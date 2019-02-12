//
//  BaseTest.swift
//  SpotifyTests
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import XCTest
import SpotifyCore
@testable import Spotify

class EnvironmentMock: XCTestCase {

  var webService: WebServiceMock!
  var errorService: ErrorServiceMock!
  var userDefaultsService: UserDefaultsServiceMock!

  override func setUp() {
    super.setUp()

    self.initializeMocks()

    webService = (CentralService.sharedInstance.resolve() as WebServiceProtocol) as? WebServiceMock
    errorService = (CentralService.sharedInstance.resolve() as ErrorServiceProtocol) as? ErrorServiceMock
    userDefaultsService = (CentralService.sharedInstance.resolve() as UserDefaultsServiceProtocol) as? UserDefaultsServiceMock
  }

  override func tearDown() {
    CentralService.sharedInstance.reboot()
    super.tearDown()
  }

  private func initializeMocks() {
    CentralService.sharedInstance.register { WebServiceMock() as WebServiceProtocol }
    CentralService.sharedInstance.register { ErrorServiceMock() as ErrorServiceProtocol }
    CentralService.sharedInstance.register { UserDefaultsServiceMock() as UserDefaultsServiceProtocol }
  }

}
