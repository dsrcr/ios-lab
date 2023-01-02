class AlbumViewController: UIPageViewController {
    var image: Image!

    override func viewDidLoad() {
        super.viewDidLoad()
        let startingVC = self.viewController(at: 0)!
        setViewControllers([startingVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        dataSource = self
    }

    private func viewController(at index: Int) -> ImageViewController? {
        guard index < self.image.subImages!.count + 1 && index >= 0 else {
            return null
        }
    }

    let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
    let image: UIImage
    if index == 0 {
        image = image.image
    } else {
        image = image.subImages![index - 1]
    }
    imageVC?.image = image
    imageVC?.index= index
}

extension AlbumViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let previousImageVC = viewController as? ImageViewController,
        let index = previousImageVC.index else {
            return nil
        }
        return self.viewController(at: index - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let previousImageVC = viewController as? ImageViewController,
        let index = previousImageVC.index else {
            return nil
        }
        return self.viewController(at: index + 1)
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return image.subImages!.count + 1
    }
}

