import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func test(_ sender: UIButton) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "test") as! TestViewController
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true)
    }
}

