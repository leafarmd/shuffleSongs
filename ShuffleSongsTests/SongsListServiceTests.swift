import XCTest
@testable import ShuffleSongs

class SongsListServiceTests: XCTestCase {
    
    var api: APIStub!
    var sut: SongsListService!
    fileprivate var output: SongListServiceOutputSpy!
    

    func testFetchSucceeded() {
        output = SongListServiceOutputSpy()
        api = APIStub(status: .success(SongsOutput.mock()))
        sut = SongsListService(api: api)
        sut.output = output
        sut.fetchSongsList(id: "1234")
        
        XCTAssertEqual(api.url, "https://us-central1-tw-exercicio-mobile.cloudfunctions.net/lookup")
        XCTAssertEqual(api.method, .GET)
        XCTAssertEqual(api.params, ["limit": "5", "id": "1234"])
        XCTAssertEqual(output.fetchSongsListSucceededCalled, true)
        XCTAssertEqual(output.songOutputPassed?.results.count, 10)
    }
    
    func testFetchDecodeError() {
        output = SongListServiceOutputSpy()
        sut = SongsListService(api: APIStub(status: .failure(.decodingFailed)))
        sut.output = output
        sut.fetchSongsList(id: "1234")
        
        XCTAssertEqual(output.fetchSongsListFailedCalled, true)
        XCTAssertEqual(output.messsagePassed, "data decode failed")
    }
    
    func testInvalidDataError() {
        output = SongListServiceOutputSpy()
        sut = SongsListService(api: APIStub(status: .failure(.invalidData)))
        sut.output = output
        sut.fetchSongsList(id: "1234")
        
        XCTAssertEqual(output.fetchSongsListFailedCalled, true)
        XCTAssertEqual(output.messsagePassed, "invalid data")
    }
    
    func testMalformedUrlError() {
        output = SongListServiceOutputSpy()
        sut = SongsListService(api: APIStub(status: .failure(.malformedURL)))
        sut.output = output
        sut.fetchSongsList(id: "1234")
        
        XCTAssertEqual(output.fetchSongsListFailedCalled, true)
        XCTAssertEqual(output.messsagePassed, "error with URL requested")
    }
    
    func testRequestError() {
        output = SongListServiceOutputSpy()
        sut = SongsListService(api: APIStub(status: .failure(.requestFailed)))
        sut.output = output
        sut.fetchSongsList(id: "1234")
        
        XCTAssertEqual(output.fetchSongsListFailedCalled, true)
        XCTAssertEqual(output.messsagePassed, "error with request")
    }

}

fileprivate class SongListServiceOutputSpy :SongsListServiceOutput {
    var fetchSongsListSucceededCalled: Bool?
    var fetchSongsListFailedCalled: Bool?
    var songOutputPassed: SongsOutput?
    var messsagePassed: String?
    
    func fetchSongsListSucceeded(output: SongsOutput) {
        fetchSongsListSucceededCalled = true
        songOutputPassed = output
    }
    
    func fetchSongsListFailed(error message: String) {
        fetchSongsListFailedCalled = true
        messsagePassed = message
    }
}
