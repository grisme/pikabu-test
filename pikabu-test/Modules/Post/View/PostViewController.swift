//
//  PostViewController.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - PostViewController implementation
extension PostViewController {
    struct PostAppearance {
        
        let topMargin: CGFloat = 16.0
        let sideMargin: CGFloat = 16.0
        let bottomMargin: CGFloat = 16.0
        let horizontalSpacing: CGFloat = 8.0
        let verticalSpacing: CGFloat = 8.0
        
        let titleFont: UIFont = .systemFont(ofSize: 20.0, weight: .semibold)
        let titleColor: UIColor = .autoLabel
        let titleLines: Int = 0
        
        let textFont: UIFont = .systemFont(ofSize: 16.0, weight: .regular)
        let textColor: UIColor = .autoLabel
        
        let likesFont: UIFont = .systemFont(ofSize: 13.0, weight: .bold)
        let likesColor: UIColor = .autoSecondaryLabel
        
        let dateFont: UIFont = .systemFont(ofSize: 13.0, weight: .bold)
        let dateColor: UIColor = .autoSecondaryLabel
        
        let imagesSpacing: CGFloat = 16.0
    }
}

final class PostViewController: BaseViewController {
    
    // MARK: Private properties
    private let appearance = PostAppearance()
    
    // MARK: Injection properties
    var presenter: PostPresenterProtocol?
    
    // MARK: UI properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.titleFont
        label.textColor = self.appearance.titleColor
        label.numberOfLines = self.appearance.titleLines
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.dateFont
        label.textColor = self.appearance.dateColor
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.likesFont
        label.textColor = self.appearance.likesColor
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.textColor = self.appearance.textColor
        textView.font = self.appearance.textFont
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0.0
        
        return textView
    }()
    
    private lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = self.appearance.imagesSpacing
        return stackView
    }()
    
    private func makeImageView(url: URL) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.kf.setImage(with: url) { image in
            DispatchQueue.main.async {
                // Making proportional imageView's height constraint after image was loaded
                imageView.snp.makeConstraints { [weak self] make in
                    guard let strongSelf = self else { return }
                    guard let image = imageView.image else { return }
                    guard image.size.width > 0.0 else { return }
                    make.height.equalTo(strongSelf.view.snp.width).multipliedBy(image.size.height / image.size.width)
                }
            }
        }
        
        return imageView
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = self.presenter?.textManager?.title
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(likesLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(textView)
        scrollView.addSubview(imagesStackView)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.appearance.topMargin)
            make.leading.trailing.equalTo(self.view).inset(self.appearance.sideMargin)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.equalTo(self.titleLabel)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.dateLabel.snp.trailing).offset(self.appearance.horizontalSpacing)
            make.centerY.equalTo(self.dateLabel)
            make.trailing.lessThanOrEqualTo(self.view).inset(self.appearance.sideMargin)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.trailing.equalTo(self.view).inset(self.appearance.sideMargin)
        }
        
        imagesStackView.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.trailing.equalTo(self.view).inset(self.appearance.sideMargin)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

// MARK: - PostViewProtocol implementation
extension PostViewController: PostViewProtocol {
    func showLoader() {
        self.showLoadingIndicator()
    }
    
    func hideLoader() {
        self.hideLoadingIndicator()
    }
    
    func showPost(viewModel: PostDetailDataViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateString
        likesLabel.text = String(format: self.presenter?.textManager?.likesFormat ?? "%d", viewModel.likes)
        
        // Filling up stackview with obtained images
        viewModel.imageURLs.forEach { [weak self] url in
            // Skipping nil URLs
            guard let url = url else { return }
            self?.imagesStackView.addArrangedSubview(makeImageView(url: url))
        }
        
        // Building attributed string from HTML'ed string, on error setting up plain text from view model
        guard
            let textData = viewModel.htmlText.data(using: .unicode),
            let attributedText = try? NSMutableAttributedString(data: textData,
                                                                options: [.documentType: NSAttributedString.DocumentType.html],
                                                                documentAttributes: nil)
            else {
                textView.text = viewModel.plainText
                return
        }
        
        // Appending attributes from our view's appearance
        let fullRange = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.font, value: self.appearance.textFont, range: fullRange)
        attributedText.addAttribute(.foregroundColor, value: self.appearance.textColor, range: fullRange)

        textView.attributedText = attributedText
    }
}
