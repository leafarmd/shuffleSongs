//
//  GenresOutput.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

struct SongsOutput: Output {
    let resultCount: Int
    let results: [ResultOutput]
    
    static func mock() -> SongsOutput {
        let results = [ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(),
                       ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(), ResultOutput.mock(),]
        return SongsOutput(resultCount: 0, results: results)
    }
}

struct ResultOutput: Output {
    let primaryGenreName: String
    let artistName: String
    let id: Int
    let wrapperType: String
    let artistType: String?
    let collectionID: Int?
    let trackName: String?
    let country: String?
    let artworkUrl: String?
    let releaseDate: String?
    let artistID: Int?
    let trackTimeMillis: Int?
    let collectionName: String?
    let trackExplicitness: String?
    let trackCensoredName: String?
    
    static func mock() -> ResultOutput {
        return ResultOutput(primaryGenreName: "primary genre name",
                            artistName: "artist name\(Int.random(in: 0...3))",
                            id: 0,
                            wrapperType: "wrapper typer",
                            artistType: "artist type",
                            collectionID: 0,
                            trackName: "track name",
                            country: "county",
                            artworkUrl: "artwork url",
                            releaseDate: "date",
                            artistID: 0,
                            trackTimeMillis: 0,
                            collectionName: "colletcionName",
                            trackExplicitness: "track explicitness",
                            trackCensoredName: "track censored name")
    }
}
