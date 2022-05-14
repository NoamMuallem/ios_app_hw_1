//
//  Player.swift
//  cardGame
//
//  Created by noam muallem on 10/05/2022.
//

import Foundation
class Player{
    var score:Int;
    var cards:[Card];
    var name:String;
    
    init(){
        self.score = 0;
        self.name = "";
        self.cards = [];
    }
    
    func draw() -> Card {
        return cards.popLast()!;
    }
    
    func setName(name:String)->Void{
        self.name = name;
    }
    
    func setCards(cards:[Card])->Void{
        self.cards = cards
    }
}
