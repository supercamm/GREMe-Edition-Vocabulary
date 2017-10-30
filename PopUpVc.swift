//  PopUpVc.swift

import UIKit

class PopUpVc: UIViewController {
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    var labelText0 = String()
    var labelText1 = String()
    var labelText2 = String()
    var labelText3 = String()
    var labelText4 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assign label text
        label0.text = labelText0
        label1.text = labelText1
        label2.text = labelText2
        label3.text = labelText3
        label4.text = labelText4
    }
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
