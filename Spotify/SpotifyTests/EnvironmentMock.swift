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

  var webServiceService: WebServiceServiceMock!
  var errorService: ErrorServiceMock!
  var userDefaultsService: UserDefaultsServiceMock!
  var navigationService: NavigationServiceMock!

  override func setUp() {
    super.setUp()

    self.initializeMocks()

    webServiceService = (CentralService.sharedInstance.resolve() as WebServiceServiceProtocol) as? WebServiceServiceMock
    errorService = (CentralService.sharedInstance.resolve() as ErrorServiceProtocol) as? ErrorServiceMock
    userDefaultsService = (CentralService.sharedInstance.resolve() as UserDefaultsServiceProtocol) as? UserDefaultsServiceMock
    navigationService = (CentralService.sharedInstance.resolve() as NavigationServiceProtocol) as? NavigationServiceMock
  }

  override func tearDown() {
    CentralService.sharedInstance.reboot()
    super.tearDown()
  }

  private func initializeMocks() {
    CentralService.sharedInstance.register { WebServiceServiceMock() as WebServiceServiceProtocol }
    CentralService.sharedInstance.register { ErrorServiceMock() as ErrorServiceProtocol }
    CentralService.sharedInstance.register { UserDefaultsServiceMock() as UserDefaultsServiceProtocol }
    CentralService.sharedInstance.register { NavigationServiceMock() as NavigationServiceProtocol }
  }

}
