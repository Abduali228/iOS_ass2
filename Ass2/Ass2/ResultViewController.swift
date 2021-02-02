import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var quizResult: UILabel!
    var result: Double = 0.0
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        quizResult.text = String(calculateResult(num: result))
    }

    func calculateResult(num: Double) -> Double {
        return (num*100)/4
    }

    @IBAction func StartAgainToTest(_ sender: UIButton) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "test") as! TestViewController
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true)
    }
    
    @IBAction func HomePage(_ sender: UIButton) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "home") as! ViewController
        
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true)
    }
    
    @IBAction func History(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(identifier: "history") as? HistoryViewController {
            viewcontroller.data = String(calculateResult(num: result))
            viewcontroller.modalPresentationStyle = .fullScreen
            present(viewcontroller, animated: true)
        }
    }
}
