import Foundation

struct SongModel {
    let trackName: String?
    let artistName: String
    let artworkURL: String?
    let primaryGenreName: String?
    
    init(output: ResultOutput) {
        trackName = output.trackName
        artistName = output.artistName
        artworkURL = output.artworkUrl
        primaryGenreName = output.primaryGenreName
    }
}
