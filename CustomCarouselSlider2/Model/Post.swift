//
//  Post.swift
//  CustomCarouselSlider2
//
//  Created by Sopnil Sohan on 22/9/21.
//

import SwiftUI

//Post Model and Sample Data...
struct Post: Identifiable {
    var id = UUID().uuidString
    var postImage: String
    var titel: String
    var discription: String
    var starRating: Int
}

var posts = [
    
    Post(postImage: "post1", titel: "Black Widow", discription: "Natasha Romenoff, aka Black Widow, confronts the darker parts of her ledger when a dengerous conspiracy with lies to her past arises.", starRating: 4),
    Post(postImage: "post2", titel: "Loki", discription: "Loki, the God of Mischief, Steps out of his brother's shadow to embark on an adventure that place after the events of Avengers: Endgame.", starRating: 5),
    Post(postImage: "post3", titel: "Falcon & the Winter Soldier", discription: "Falcon and the winter soldier are a mismatched duo who team up for a global adventure that will test their survival skills -- as well their patience.", starRating: 4),
    Post(postImage: "post4", titel: "Mulan", discription: "A girl disguises as a male warrior and joins the imperial army in order to prevent her sick father from being forced to enlist as he has no male heir.", starRating: 3),
    Post(postImage: "post5", titel: "Avenger EndGame", discription: "After Thanos, an intergalactic warload, disintegrates half of the universe, the Avenger must reunited and assemble again to reinvigorate their trounced allies and restore blance.", starRating: 5)

]
