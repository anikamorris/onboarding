//
//  ViewController.swift
//  onboarding2
//
//  Created by Anika Morris on 2/9/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var pages: [UIView] = []
    var currentPage: Int {
        get {
            let page = Int((scrollView.contentOffset.x / view.bounds.size.width))
            print("PAGE = \(page)")
            return page
        }
    }
    var numberOfPages: Int {
        get {
            return self.pages.count
        }
    }
        
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let page1View: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let page2View: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let page3View: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .blue
        return pageControl
    }()
    let continueButton: UIButton = {
        let continueButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action:#selector(continueButtonTapped), for: .touchUpInside)
        return continueButton
    }()

    override func loadView() {
        super.loadView()
        setUpScrollView()
        setUpPageViews()
        setUpPageControl()
        var pageCounter: Int = 0
        for page in pages { //populate page views
            populatePageViews(page: page, pageNum: pageCounter)
            pageCounter += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageControl.numberOfPages = self.numberOfPages
        pageControl.currentPage = 0
    }
    
    fileprivate func setUpScrollView() { //setup scrollView and contentView
        scrollView.delegate = self //optional
        view.insertSubview(scrollView, at: 0)
        scrollView.insertSubview(contentView, at: 1)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
    }
    
    fileprivate func setUpPageViews() {
        pages.append(contentsOf: [page1View, page2View, page3View])
        pages.enumerated().forEach { tuple in
            let index = tuple.offset
            let page = tuple.element
            contentView.addSubview(page)
            NSLayoutConstraint.activate([
                page.topAnchor.constraint(equalTo: scrollView.topAnchor),
                page.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                page.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
            if index == 0 { //if first page, then set page's leftAnchor to contentView's leftAnchor
                NSLayoutConstraint.activate([
                    page.leftAnchor.constraint(equalTo: contentView.leftAnchor)
                ])
            } else { //else set current page's leftAnchor to the previous page's rightAnchor
                NSLayoutConstraint.activate([
                    page.leftAnchor.constraint(equalTo: pages[index - 1].rightAnchor)
                ])
            }
            if index == pages.count - 1 { //if last page, then set that page's rightAnchor to contentView's rightAnchor
                contentView.addSubview(continueButton)
                NSLayoutConstraint.activate([
                    page.rightAnchor.constraint(equalTo: contentView.rightAnchor)
                    
                ])
            }
        }
    }
    
    fileprivate func setUpPageControl() {
        self.view.addSubview(pageControl) //must put to self.view so it won't disappear
        NSLayoutConstraint.activate([ //isActive = true a group of contraints
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            pageControl.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
        pageControl.addTarget(self, action: #selector(self.pageControlDidTouch), for: .touchUpInside)
    }
    
    fileprivate func populatePageViews(page: UIView, pageNum: Int) {
        let pageImageView: UIImageView
        let descriptionLabel = UILabel()
        
        if pageNum == 0 {
            pageImageView = UIImageView(image: UIImage(named: "personal_info"))
            descriptionLabel.text = "Tell us about your jewelry preferences"
        } else if pageNum == 1 {
            pageImageView = UIImageView(image: UIImage(named: "jewelry"))
            descriptionLabel.text = "Receive your box"
        } else {
            pageImageView = UIImageView(image: UIImage(named: "feedback"))
            descriptionLabel.text = "Give feedback"
        }
        
        pageImageView.contentMode = .scaleAspectFit
        pageImageView.translatesAutoresizingMaskIntoConstraints = false
        page.addSubview(pageImageView)
        pageImageView.widthAnchor.constraint(equalTo: page.widthAnchor, multiplier: 0.9).isActive = true
        pageImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pageImageView.topAnchor.constraint(equalTo: page.topAnchor, constant: 200).isActive = true
        pageImageView.centerXAnchor.constraint(equalTo: page.centerXAnchor).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .boldSystemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        page.addSubview(descriptionLabel)
        descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: pageImageView.bottomAnchor, constant: 50).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: pageImageView.centerXAnchor).isActive = true
    }
    
    @objc func continueButtonTapped() {
            let loginVC: LoginViewController = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}


//MARK: Helper Methods
extension ViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentPage
    }
    
    fileprivate func nextPage() {
        if currentPage + 1 < self.numberOfPages {
            navigateToPage(page: currentPage + 1)
        }
    }
    
    fileprivate func previousPage() {
        if currentPage > 0 {
            navigateToPage(page: currentPage - 1)
        }
    }
    
    @objc func pageControlDidTouch() {
        navigateToPage(page: pageControl.currentPage)
    }
    
    private func updateUI() {
        pageControl.currentPage = currentPage
    }
    
    private func navigateToPage(page: Int) {
        if page < self.numberOfPages {
            var frame = scrollView.frame
            frame.origin.x = CGFloat(page) * frame.size.width
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
}

