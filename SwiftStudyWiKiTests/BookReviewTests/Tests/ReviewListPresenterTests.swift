//
//  ReviewListPresenterTests.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/10.
//

import XCTest
@testable import SwiftStudyWiKi

class ReviewListPresenterTests: XCTestCase {
    var sut: ReviewListPresenter!
    var viewController: MockReviewListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        sut = ReviewListPresenter(viewController: viewController, userDefaultsManager: userDefaultsManager)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_didTapRightBarButtonItem이_호출될_때() {
        sut.didTapRightBarButton()
        
        XCTAssertTrue(viewController.isCalledPresentToReviewWriteViewController)
    }
    
    func test_viewWillAppear가_호출될_때() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
        
    }
}



