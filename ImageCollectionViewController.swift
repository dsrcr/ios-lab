class ImageCollectionViewController: UICollectionViewController {
    var images = [Image]()
    var index: Int?
    var image: UIImage!
    var selectedCell: PaintingCollectionViewCell?
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }

    func loadImages()
        // let jpegsFiles = Bundle.main.paths(                
        //     forResourcesOfType: "jpeg", 
        //     inDirectory: "paintings"
        // )
        //
        // let jpgFiles = Bundle.main.paths(
        //     forResourcesOfType: "jpg", 
        //     inDirectory: "paintings"
        // )
        //
        // let imagesPath = jpegsFiles + jpgFiles
        //
        // let images = imagesPath.map { 
        //     (path) -> UIImage? in 
        //     return UIImage(contentsOfFile: paths)
        // }.flatMap{$0}
        //
        // self.images = images
        let baseImages = loadIamgesFrom(album: "paintings")
        let imageArray = baseImages.map { 
            (img) -> Image in return Image(image: img, isAlbum: false, subImages: nil )
        }   
        images.append(contentsOf: imageArray)
        let subfolders = findSubfoldersPaths ()
        for subfolder in subfolders {
            let url = URL ( string : subfolder ) !
            let albumName = url . lastPathComponent
            let albumPath = " paintings /\( albumName ) "
            let albumImages = loadIamgesFrom ( album : albumPath )
            let subImages = Array ( albumImages [1...])
            let image = Image ( image : albumImages [0] , isAlbum :true , subImages : subImages )images.append(image)
        }
    }

    private func loadIamgesFrom ( album : String ) -> [ UIImage ] {
        let jpegsFiles = Bundle.main.paths(forResourcesOfType: "jpeg", inDirectory: album)
        let jpgFiles = Bundle.main.paths (forResourcesOfType: "jpg", inDirectory: album)
        let imagesPaths = jpegsFiles + jpgFiles
        let images = imagesPaths.map { 
            ( path ) -> UIImage ? in return UIImage (contentsOfFile: path)
        }.flatMap { $0 }
         return images
    }

    private func findSubfoldersPaths () -> [ String ] {
        let allFiles = Bundle.main.paths(forResourcesOfType : nil , inDirectory : " paintings " )
        let paths = allFiles.filter { 
            path -> Bool in return !path.contains("jpg") && !path.contains("jpeg")
        }
        return paths
    }
}

extension ImageCollectionViewController {
    override func numberOfSections ( in collectionView : UICollectionView ) -> Int {
        return 1
    }

    override func collectionView ( _ collectionView : UICollectionView , numberOfItemsInSection section : Int ) -> Int {
        return images.count
    }

    override func collectionView ( _ collectionView : UICollectionView , cellForItemAt indexPath : IndexPath ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaintingCell" , for : indexPath ) as !
        PaintingCollectionViewCell
        cell.imageView.image = images [indexPath.row]
        return cell
    }
}

extension ImageCollectionViewController {
    override func collectionView ( _ collectionView : UICollectionView , didSelectItemAt indexPath : IndexPath ) {
        let cell = collectionView.cellForItemAt(at: IndexPath) as ? PaintingCollectionViewCell
        selectedCell = cell
        let image = images [ indexPath.row ]
        let segueIdentifier = " showImageViewControllerSegue "
        performSegue ( withIdentifier: segueIdentifier , sender: image )
    }   
}

extension ImageCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "showImageViewControllerSegue" {
            let image = sender as! Image
            let destVC = segue.destination as! ImageCollectionViewController
            destVC.image = image
        }
    }
}

extension ImageCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let segueIdentifier: String

        if image.isAlbum {
            segueIdentifier = "presentAlbumViewController"
        } else {
            segueIdentifier = "showImageViewControllerSegue"    
        }
        performSegue(withIdentifier: segueIdentifier, sender: image)
    }
}

extension ImageCollectionViewController {
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        let image = sender as ! Image
        if segue.identifier == "showImageViewControllerSegue" {
            let destVC = segue.destination as ! ImageViewController destVC.image = image.image
        } else if segue.identifier == "presentAlbumViewController " {
            let destVC = segue.destination as !
            AlbumViewController
            destVC.image = image
        }
    }
}
