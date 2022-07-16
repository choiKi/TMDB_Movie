//
//  File.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/08.
//
import Foundation


struct MoviesData: Decodable {
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let id: Int?
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

struct SMoviesData: Decodable {
    
    let movies: [SMovie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct SMovie: Decodable {
    
    let title: String?
    let rate: Double?
    // let genre: [Int]?
    let posterImage: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case title
        // case genre = "genre_ids"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}
