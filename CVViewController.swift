import UIKit
import PDFKit

class CVViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "example", withExtension: "pdf")!
        let document = PDFDocument(url: url)
        pdfView.document = document
    }
}
