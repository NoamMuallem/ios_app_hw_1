//
//  ViewController.swift
//  cardGame
//
//  Created by noam muallem on 10/05/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var player1CardImage: UIImageView!
    @IBOutlet weak var player2CardImage: UIImageView!
    @IBOutlet weak var utilityLabel: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    var playerOne: Player = Player();
    var playerTwo: Player = Player();
    var cardsRemainning: Int = 0;
    var timer:Timer = Timer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view//initialize deck
        var deck: [Card] = [];
        let shapes: [String] = ["a", "b", "c", "d"];
        let values: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
        for shape in shapes {
            for value in values{
                let card:Card = Card(value: value, shape: shape);
                deck.append(card);
            }
        }
        deck.shuffle();
        //splite deck to 2 equal parts
        let ct = deck.count;
        let half = ct / 2;
        let leftSplit = deck[0 ..< half];
        let rightSplit = deck[half ..< ct];
        //assign deck helfs to players
        self.playerOne.setName(name: "player1")
        self.playerOne.setCards(cards: Array(leftSplit));
        self.playerTwo.setName(name: "player2")
        self.playerTwo.setCards(cards: Array(rightSplit));
        self.cardsRemainning = deck.count;
        self.timer = Timer();
        self.startGame();
        print("card game init done");
    }
    
    func startGame(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1,repeats: true , block: {_ in
            self.playTurn()
        })
    }
    func playTurn(){
        //chack if there are enagh cards in players hands:
        if(self.cardsRemainning == 0){
            self.gameOver()
        }else{
            //handle score
            let playerOneCard: Card = playerOne.draw();
            let playerTwoCard: Card = playerTwo.draw();
            player1CardImage.image = UIImage(named: "\(playerOneCard.shape)\(playerOneCard.value + 1)");
            player2CardImage.image = UIImage(named: "\(playerTwoCard.shape)\(playerTwoCard.value + 1)");
            if(playerOneCard.value > playerTwoCard.value){
                playerOne.score = playerOne.score + 1;
                player1Score.text = "Score: \(playerOne.score)";
            } else if(playerOneCard.value < playerTwoCard.value){
                playerTwo.score = playerTwo.score + 1;
                player2Score.text = "Score: \(playerTwo.score)";
            }else{
                playerOne.score = playerOne.score + 1;
                playerTwo.score = playerTwo.score + 1;
                player1Score.text = "Score: \(playerOne.score)";
                player2Score.text = "Score: \(playerTwo.score)";
            }
            //update cards remainning
            self.cardsRemainning = self.cardsRemainning - 2;
            utilityLabel.text = "Round Remainning: \(self.cardsRemainning/2)"
        }
    }
    
    func gameOver(){
        self.timer.invalidate();
        if(self.playerOne.score > self.playerTwo.score){
            utilityLabel.text = "Player 1 Won!"
        }else{
            utilityLabel.text = "Player 2 Won!"
        }
    }
}

