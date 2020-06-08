//
//  ViewController.swift
//  miniBattleShip
//
//  Created by Sebastian Matyszewski on 05/06/2020.
//  Copyright © 2020 Sebastian Matyszewski. All rights reserved.
//

import UIKit
var a = 0
var countShipShootedByMe = 0
var mycountShipShootedByMe = String(countShipShootedByMe)
var countShipShootedByEnemy = 0
var countShipShooted = 0
var mycountShipShooted = String(countShipShooted)
var percentageShipShooted:Float = 0
var mypercentageShipShooted = String(percentageShipShooted)

class ViewController: UIViewController {
    
    

    @IBOutlet weak var buttonPutShips: UIButton!
    
    @IBOutlet weak var textPutShips: UITextView!
    @IBOutlet weak var boardEnemy: UIImageView!
    @IBOutlet weak var boardOwn: UIImageView!
    var status = 0
    var ships = 0
    var ownBoard = [0,0,0,0,0,0,0,0,0,0]
    var enemyBoard = [0,0,0,0,0,0,0,0,0,0]
    var numbers = [1,2,3,4,5,6,7,8,9]
    
    
    
    
    func losujRozstawienieStatkow(n:Int,max:Int){
        
        var wylosowane = [Int]()
        while wylosowane.count<n{
            var liczba:Int?
            repeat{ liczba = Int(arc4random()) % max + 1
                
            }while wylosowane.contains(liczba!)
            wylosowane.append(liczba!)
        }
        for liczba in wylosowane{
            //print (liczba)
            enemyBoard[liczba] = 1;
        }
    }
    
    @IBAction func buttonPutShips(_ sender: Any) {
        status = 1
        losujRozstawienieStatkow(n:3, max:9)
        buttonPutShips.isHidden = true
        textPutShips.isHidden = true
        boardEnemy.isHidden = false
        
        for n in 10...19{
            let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
            tempButton?.isHidden = false
        }
        
        for n in 1...9{
            if ownBoard[n] == 1{
                let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                tempButton?.isEnabled = false
            }
            
        }
        //wypisanie wartości tablic
        for n in 1...9{
            print(ownBoard[n])
        }
        print(" ")
        for n in 1...9{
            print(enemyBoard[n])
        }
        
        
    }
    
    @IBAction func battle(_ sender: AnyObject) {
        //let ship = Int.random(in: 1 ... 9)
        
        if status == 0{
            
                a = sender.tag
                if ownBoard[a] == 1{
                    let tempButton = self.view.viewWithTag(Int(a)) as? UIButton
                    tempButton?.backgroundColor = UIColor.white.withAlphaComponent(1)
                    ownBoard[a] = 0
                    ships = ships - 1
                    
                    for n in 1...9{
                        if ownBoard[n] == 0{
                            let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                            tempButton?.isEnabled = true
                        }
                        
                    }
                    buttonPutShips.isEnabled = false
                    
                }else{
                    ownBoard[a] = 1
                    let tempButton = self.view.viewWithTag(Int(a)) as? UIButton
                    tempButton?.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
                    ships = ships + 1
                    
                    if ships == 3{
                        for n in 1...9{
                            if ownBoard[n] == 0{
                                let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                                tempButton?.isEnabled = false
                            }
                            
                        }
                        buttonPutShips.isEnabled = true
                    }
                }
                
            
        }else if status == 1{
            
            let temp = Int(arc4random_uniform(UInt32(numbers.count)))
            
            let number = numbers[temp]
            numbers.remove(at: temp)
            //let max = UInt32(9)
            //let min = UInt32(1)
                        ////////////////////
            
            
            
           // repeat{
               // let index = arc4random_uniform(9)
                
                
                    //if numbers.contains(Int(index)){
                      //  temp = 0
                    //}else{
                       // if Int(index) != 0{
                            //numbers.append(Int(index))
                           // liczba = Int(index)
                            //temp = 1
                        //}
                        
                    //}
                
            //}while (temp == 1)
            
            //let index = arc4random_uniform(max)
                //var index2 = Int(index)
            //while (numbers.contains(Int(index))){
            //    var index = arc4random_uniform(max)
            //}
            
           // if numbers.isEmpty {
             //  numbers = Array(1 ... 9)
           // }
            //let index = Int(arc4random_uniform(UInt32(numbers.count)))
            //numbers.remove(at: index)
            //print("wylosowana:", index)
            
            
            
            
            ////////////////////
            
            a = sender.tag
            let aa = a - 10
            print(a)
            print(" ")
            //let getRandom = losujPolozenieStatkow(min: 1, max: 9)
            print("Rand", number)
            //let tmp = Int(getRandom)
            if enemyBoard[aa] == 1{
                let tempButton = self.view.viewWithTag(Int(a)) as? UIButton
                tempButton?.backgroundColor = UIColor.red.withAlphaComponent(0.6)
                countShipShootedByMe = countShipShootedByMe + 1
                tempButton?.isEnabled = false
                countShipShooted = countShipShooted + 1
                if countShipShootedByMe == 3{
                    
                    for n in 1...19{
                        let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                        tempButton?.isEnabled = false
                        
                    }
                    percentageShipShooted = ((Float(countShipShootedByMe)/Float(countShipShooted))*100)
                    //percentageShipShooted = (4/6)*100
                    print("Oddane strzały:", countShipShooted)
                    print("Celne strzały:", countShipShootedByMe)
                    print("% celności strzałów:", percentageShipShooted)
                    
                }
                
            }else{
                let tempButton = self.view.viewWithTag(Int(a)) as? UIButton
                tempButton?.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
                tempButton?.isEnabled = false
                countShipShooted = countShipShooted + 1
            }
            sleep(1)
            if ownBoard[number] == 1{
                let tempButton = self.view.viewWithTag(number) as? UIButton
                tempButton?.backgroundColor = UIColor.red.withAlphaComponent(0.6)
                countShipShootedByEnemy = countShipShootedByEnemy + 1
                tempButton?.isEnabled = false
                if countShipShootedByEnemy == 3{
                    for n in 1...19{
                        let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                        tempButton?.isEnabled = false
                        
                    }
                    //percentageShipShooted = (Float((countShipShootedByMe/countShipShooted)*100))
                    percentageShipShooted = ((Float(countShipShootedByMe)/Float(countShipShooted))*100)
                    //percentageShipShooted = (4/6)*100
                    print("Oddane strzały:", countShipShooted)
                    print("Celne strzały:", countShipShootedByMe)
                    print("% celności strzałów:", percentageShipShooted)
                }
            }else{
                let tempButton = self.view.viewWithTag(number) as? UIButton
                tempButton?.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
                tempButton?.isEnabled = false
            }
            
            
        }
        
        //let number = Int(arc4random_uniform(9))
       // let tempButton = self.view.viewWithTag(Int(number)) as? UIButton
       // tempButton?.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        //tempButton?.isHidden = true
        //a = sender.tag
       // print(a)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        boardEnemy.isHidden = true
        if color == "Black"{
            boardEnemy.image = UIImage(named: "imagesBlack")
            boardOwn.image = UIImage(named: "imagesBlack")
        }
        else if color == "Green"{
            boardEnemy.image = UIImage(named: "imagesGreen")
            boardOwn.image = UIImage(named: "imagesGreen")
        }
        else if color == "Yellow"{
            boardEnemy.image = UIImage(named: "imagesYellow")
            boardOwn.image = UIImage(named: "imagesYellow")
        }
        else if color == "Red"{
            boardEnemy.image = UIImage(named: "imagesRed")
            boardOwn.image = UIImage(named: "imagesRed")
        }
        else{
            boardEnemy.image = UIImage(named: "images")
            boardOwn.image = UIImage(named: "images")
        }
        if status == 0{
            for n in 10...19{
                let tempButton = self.view.viewWithTag(Int(n)) as? UIButton
                tempButton?.isHidden = true
            }
        }
        buttonPutShips.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

