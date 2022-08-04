//
//  NewsConstants.swift
//  foos
//
//  Created by Ujin Artuhovich on 2.08.22.
//

import Foundation
import UIKit

struct NewsConstants {
    static let newsCellReuseId = "newsCell"
    static let storyCellReuseId = "storyCell"
    static let countOfStories: CGFloat = 4
    static let newsMockup: [News] = [.init(title: "Fashion",
                                        text: "Okay! you got how it works right? try to change the numbers and options to get used to it. btw, have you noticed that there’s another method provided usingSpringWithDamping?",
                                        id: 1,
                                        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/92/Etalage_van_modewinkel_-_Window_of_a_fashion_boutique_%286808272877%29.jpg",
                                        type: "fasion")]
    static let storyMockup: [Story] = [
        .init(id: 0,
              imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/92/Etalage_van_modewinkel_-_Window_of_a_fashion_boutique_%286808272877%29.jpg",
              isWatched: false),
        .init(id: 1,
              imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/92/Etalage_van_modewinkel_-_Window_of_a_fashion_boutique_%286808272877%29.jpg",
              isWatched: true)
    ]
}
