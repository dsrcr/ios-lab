class ImageViewController: UIViewController {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
}
