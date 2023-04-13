//
//  GenreModel.swift
//  Telephilia
//
//  Created by IPS-108 on 29/03/23.
//

import Foundation

// MARK: - MovieGenre
struct MovieGenre: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
//https://api.themoviedb.org/3/genre/movie/list?api_key=c6a74af52d29a3a63724c06389823119&language=en-US
