//
//  OnboardingPageViewController.swift
//  Camera Simulator
//
//  Created by Rasyid Ridla on 13/05/22.
//

import UIKit

protocol onboardingPageViewControllerDelegate: AnyObject {
    func setupPageController(numberOfPage: Int)
    func turnPageController(to index: Int)
}

class OnboardingPageViewController: UIPageViewController {
    
    weak var pageViewControllerDelegate: onboardingPageViewControllerDelegate?
    
    var pageTitle = ["Understand Exposure and Focus", "Discover Frames and Compositional Grids", "Hone Your Shot"]
    var pageDescriptionText = ["Discover how to manipulate light and your camera to craft the best pictures",  "Position your object to the best aesthetics", "Perfect your photography skills through the live camera"]
    var pageImage: [UIImage] = [UIImage(named: "pdftest")!, UIImage(named: "SecondPage")!, UIImage(named: "LastPage")!]
    var backgroundColor: [UIColor] = [.black, .black, .black]
    
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        if let firstViewController = contentViewController(at: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func turnPage(index: Int, type: Int) {
        currentIndex = index
        if let currentController = contentViewController(at: index) {
            switch type {
            case 1:
                setViewControllers([currentController], direction: .forward, animated: true)
            case 2:
                setViewControllers([currentController], direction: .reverse, animated: true)
            default:
                setViewControllers([currentController], direction: .forward, animated: true)
            }
            self.pageViewControllerDelegate?.turnPageController(to: currentIndex)
        }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index -= 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingContentViewController)?.index {
            index += 1
            return contentViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let pageContentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
            currentIndex = pageContentViewController.index
            self.pageViewControllerDelegate?.turnPageController(to: currentIndex)
        }
    }
    
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageTitle.count {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        if let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: onBoardContentVCId) as? OnboardingContentViewController {
            pageContentViewController.subheading = pageDescriptionText[index]
            pageContentViewController.heading = pageTitle[index]
            pageContentViewController.bgColor = backgroundColor[index]
            pageContentViewController.index = index
            pageContentViewController.image = pageImage[index]
            self.pageViewControllerDelegate?.setupPageController(numberOfPage: 3)
            return pageContentViewController
        }
        return nil
    }
}
