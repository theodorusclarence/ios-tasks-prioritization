//
//  OnboardingViewController.swift
//  mc1-team-10
//
//  Created by Clarence on 07/04/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            // Update page control
            pageControl.currentPage = currentPage
            
            if (currentPage == 2) {
                continueButton.isHidden = false
                skipButton.isHidden = true
            } else {
                continueButton.isHidden = true
                skipButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Hide continue button initially
        continueButton.isHidden = true

        slides = [
            OnboardingSlide(title: "Welcome to AppName", description: "App Name is an app designed for programmers to stay productive.", image: #imageLiteral(resourceName: "onboarding-1")) ,
            OnboardingSlide(title: "List your tasks", description: "You can write as many tasks as you want and provide its details like difficulty and deadlines.", image: #imageLiteral(resourceName: "onboarding-2")),
            OnboardingSlide(title: "Work with 1-3-5 Rule", description: "We recommend for you to complete 1 hard task, 3 medium task, and 5 easy tasks per day to stay productive without feeling burned out.", image: #imageLiteral(resourceName: "onboarding-3"))
        ]
        
        collectionView.reloadData()
        pageControl.numberOfPages = slides.count
    }
    
    @IBAction func endOnboarding(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DashboardTabController") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        present(controller, animated: true, completion: nil)
    
    }

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slide", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
