//
//  BaseViewController.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

extension BaseViewController {
    struct Appearance {
        let backgroundColor: UIColor = .autoBackground
        let loaderSize: CGFloat = 30.0
        let loaderColor: UIColor = .white
    }
}

class BaseViewController: UIViewController {
    
    // MARK: Private properties
    private let appearance = Appearance()
    
    // MARK: UI properties
    private lazy var blurBackgroundView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.isHidden = true
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.hidesWhenStopped = true
        view.color = self.appearance.loaderColor
        return view
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private methods
    private func setupUI() {
        self.view.backgroundColor = self.appearance.backgroundColor
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(blurBackgroundView)
        self.blurBackgroundView.contentView.addSubview(loadingIndicator)
    }
    
    private func makeConstraints() {
        blurBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(self.appearance.loaderSize)
        }
    }
    
    func showLoadingIndicator() {
        self.loadingIndicator.startAnimating()
        self.blurBackgroundView.isHidden = false
        self.view.bringSubviewToFront(self.blurBackgroundView)
    }
    
    func hideLoadingIndicator() {
        self.blurBackgroundView.isHidden = true
        self.loadingIndicator.stopAnimating()
    }
    
}
