//
//  ReviewWritePresenterTests.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/10.
//

import XCTest
@testable import SwiftStudyWiKi

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!
    var viewController: MockReviewWriteViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewWriteViewController()
        userDefaultsManager = MockUserDefaultsManager()
        
        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultsMangaer: userDefaultsManager
        )
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        userDefaultsManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_didTapLeftBarButton이_호출될_때() {
        sut.didTapLeftBarButton()
        
        XCTAssertTrue(viewController.isCalledShowCloseAlertContoller)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하지않으면() {
        sut.book = nil
        sut.didTapRightBarButton(contentsText: "참 좋은 책이다.")
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentText가_존재하지않으면() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: nil)
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentText가_placeholder와_같으면() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: "내용을 입력해주세요.")
        
        XCTAssertFalse(userDefaultsManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton이_호출될_때_book이_존재하고_contentText가_placeholder와_같지않게_존재하면() {
        sut.book = Book(title: "Swift", imageURL: "")
        sut.didTapRightBarButton(contentsText: "참 좋은 책이다.")
        
        XCTAssertTrue(userDefaultsManager.isCalledSetReview)
        XCTAssertTrue(viewController.isCalledClose)
    }
    
    func test_didTapBookTitleButton이_호출될_때() {
        sut.didTapBookTitleButton()
        
        XCTAssertTrue(viewController.isCalledPresentToSearchBookViewContoller)
    }
  

}
