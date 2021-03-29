//
//  Util.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 24/03/21.
//

import UIKit
import Lottie

class Util {
    
    static func getLottieLoadingAnimation(center: CGPoint, size: CGFloat) -> AnimationView {
        
        let animationView = AnimationView(name: "MortyDance") // ./Application/Files
        animationView.frame = CGRect(origin: center, size: CGSize(width: size, height: size))
        animationView.loopMode = .loop
        animationView.play()
        
        return animationView
    }
}
