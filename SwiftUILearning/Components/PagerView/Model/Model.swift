//
//  Model.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 23/05/24.
//

import Foundation
struct Story: Hashable {
    let title: String
    let description: String
    let bgImge: String
    let textColor: String
}

let jarStories: [Story] = [
    Story(
        title: "SAVINGS\nMADE SIMPLE\nFOR YOU",
        description: "Save in a 100% safe and easy\nway with Jar",
        bgImge: "https://cdn.myjar.app/Onboarding/Variant2.2.1.webp",
        textColor: "#272239"
    ),
    Story(
        title: "START\nWITH ₹10",
        description: "Save small now to save big in\nthe future",
        bgImge: "https://cdn.myjar.app/Onboarding/Variant2.2.2.webp",
        textColor: "#272239"
    ),
    Story(
        title: "WITHDRAW\nANYTIME",
        description: "Withdraw savings to get \nmoney in your bank account",
        bgImge: "https://cdn.myjar.app/Onboarding/Variant2.2.3.webp",
        textColor: "#272239"
    ),
    Story(
        title: "JOIN 1 CRORE+\nINDIANS",
        description: "People from all over India trust us\nas their savings partner",
        bgImge: "https://cdn.myjar.app/Onboarding/Variant2.1.4.webp",
        textColor: "#FFFFFF"
    )
]

