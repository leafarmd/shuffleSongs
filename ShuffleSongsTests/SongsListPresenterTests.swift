import XCTest
@testable import ShuffleSongs

class SongsListPresenterTests: XCTestCase {
    
    var sut: SongsListPresenter!
    fileprivate var view: SongsListViewSpy!
    fileprivate var input: SongsListServiceInputSpy!
    
    override func setUp() {
        super.setUp()
        input = SongsListServiceInputSpy()
        view = SongsListViewSpy()
        sut = SongsListPresenter(service: input, router: SongsListRouter(navigator: UINavigationController()))
        sut.attachView(view)
    }
    
    func testAttachView() {
        XCTAssertEqual(view.showLoadingFeedbackCalled, true)
        XCTAssertEqual(input.fetchSongsListCalled, true)
    }
    
    func testShuffle() {
        sut.shuffle()
        
        XCTAssertEqual(view.reloadDataCalled, true)
    }
    
    func testOutputSucceeded() {
        sut.fetchSongsListSucceeded(output: SongsOutput.mock())
        XCTAssertEqual(view.hideLoadingFeedbackCalled, true)
        XCTAssertEqual(view.reloadDataCalled, true)
    }
    
    func testOutputFailed() {
        sut.fetchSongsListFailed(error: "error value")
        XCTAssertEqual(view.hideLoadingFeedbackCalled, true)
        XCTAssertEqual(view.titlePassed, "Error")
        XCTAssertEqual(view.messagePassed, "error value")
        
    }
}

fileprivate class SongsListViewSpy: SongsListView {
    var showLoadingFeedbackCalled: Bool?
    var hideLoadingFeedbackCalled:Bool?
    var reloadDataCalled: Bool?
    var showMessageCalled: Bool?
    var titlePassed: String?
    var messagePassed: String?
    
    func showLoadingFeedback() {
        showLoadingFeedbackCalled = true
    }
    
    func hideLoadingFeedback() {
        hideLoadingFeedbackCalled = true
    }
    
    func reloadData(with model: [SongModel]) {
        reloadDataCalled = true
    }
    
    func showMessage(title: String, message: String) {
        showMessageCalled = true
        titlePassed = title
        messagePassed = message
    }
}

fileprivate class SongsListServiceInputSpy: SongsListServiceInput {
    var output: SongsListServiceOutput?
    
    var fetchSongsListCalled: Bool?
    
    func fetchSongsList(id: String, limit: Int) {
        fetchSongsListCalled = true
    }
}
