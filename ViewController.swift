//  ViewController.swift

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value0: UIButton!
    @IBOutlet weak var value1: UIButton!
    @IBOutlet weak var value2: UIButton!
    @IBOutlet weak var value3: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    var index = 0; var correct = Int(); var incorrect = Int()
    var statusBarArray = [UIImageView](); var displayedValuesArray = [String]()
    let dict:[String:String] = [
        "providential":"occurring at a favorable time; opportune",
        "dispassionate":"not influenced by strong emotion",
        "eminence":"fame or recognized superiority",
        "fastidious":"very attentive to and concerned about accuracy and detail",
        "didactic":"intended to teach",
        "iconoclasm":"the action of attacking or assertively rejecting cherished beliefs",
        "disseminate":"spread or disperse "
    ]
    
    //to reset if index >= dict.count
    override func viewWillAppear(_ animated: Bool) { viewDidLoad() }

    override func viewDidLoad() { super.viewDidLoad(); generateCard(); layoutStatusBar() }
    
    func layoutStatusBar() {
        let xMultiplier = 50; let xConstant = 52; let yConstant = 35; var x = 0; var i = 0
        
        while i < dict.count
        {
            let image = UIImage(named: "dot"); let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: Int(x + xConstant), y: Int(self.view.frame.height - CGFloat(yConstant)), width: 10, height: 10)
            statusBarArray.append(imageView); let circleView = statusBarArray[i];
            self.view.addSubview(circleView)
            x += xMultiplier; i += 1
        }
    }
    
    func generateCard() {
        while index >= dict.count { restartGame() }
        
        displayedValuesArray.removeAll()
        var keys = Array(dict.keys); var values = Array(dict.values)
        key.text = keys[index]; displayedValuesArray.append(values[index])
        
        if index + 1 < values.count { displayedValuesArray.append(values[index + 1])}
        else { displayedValuesArray.append(values[index - 1]) }
        
        if index + 2 < values.count { displayedValuesArray.append(values[index + 2]) }
        else { displayedValuesArray.append(values[index - 2]) }
        
        if index + 3 < values.count { displayedValuesArray.append(values[index + 3]) }
        else { displayedValuesArray.append(values[index - 3]) }
        
        //look into new way to do this -- right now 0 is the correct answer
        value0.setTitle(displayedValuesArray[2],for: .normal)
        value1.setTitle(displayedValuesArray[1],for: .normal)
        value2.setTitle(displayedValuesArray[0],for: .normal)
        value3.setTitle(displayedValuesArray[3],for: .normal)
    }

    @IBAction func ButtonPressAction(_ sender: UIButton) {
        while index >= dict.count { restartGame() }
        
        //need a special case for 6 to wait for user interaction
        if index == 6 {
            //look into new way to do this -- right now 0 is the correct answer
            if sender.currentTitle == displayedValuesArray[0] { correct += 1; statusBarArray[index].image = UIImage(named: "green") }
            else { incorrect += 1; statusBarArray[index].image = UIImage(named: "red") }
            index += 1; print("--------------------------"); print("\(index)/\(dict.count) total")

        } else {
            //look into new way to do this -- right now 0 is the correct answer
            if sender.currentTitle == displayedValuesArray[0] { correct += 1; statusBarArray[index].image = UIImage(named: "green") }
            else { incorrect += 1; statusBarArray[index].image = UIImage(named: "red") }
            index += 1; print("--------------------------"); print("\(index)/\(dict.count) total")
            generateCard()
        }
    }
    
    func restartGame() {
        index -= 7; correct = 0; incorrect = 0; var j = 0
        while j < dict.count { statusBarArray[j].image = UIImage(named: "dot"); j += 1 }
        generateCard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let score : Int = Int(round((Double(correct) / Double(dict.count)) * 100)); let destVC : PopUpVc = segue.destination as! PopUpVc
        if score <= 50 {
            destVC.labelText0 = "Uh oh!"
        }
        if score > 50 && score <= 75 {
            destVC.labelText0 = "Keep Working!"
        }
        if score >= 76 {
            destVC.labelText0 = "Great Job!"
        }
        destVC.labelText1 = "\(correct)/\(dict.count) correct"; destVC.labelText2 = "\(incorrect)/\(dict.count) incorrect"
        destVC.labelText3 = "\(incorrect + correct)/\(dict.count) total"; destVC.labelText4 =  "\(score)%"
    }
    
}

