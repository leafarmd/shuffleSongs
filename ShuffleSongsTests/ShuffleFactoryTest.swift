import XCTest
@testable import ShuffleSongs

class ShuffleFactoryTest: XCTestCase {
    
    var models: [SongModel]!
    
    func testSongShuffle() {
        models = []
        let output = SongsOutput.mock()
        
        output.results.forEach {
            models.append(SongModel(output: $0))
        }
        
        let shuffledModels = ShuffleFactory.ShuffeSongs(songs: models)
        var isEqual = true
        print(shuffledModels)
        var index = 0
        while isEqual && index < models.count {
            isEqual = models[index].artistName == shuffledModels[index].artistName
            index += 1
        }
        
        XCTAssertEqual(isEqual, false)
    }
}
