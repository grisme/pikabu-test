//
//  PostTableViewCell.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - PostTableViewCell implementation
extension PostTableViewCell {
    
    // TODO: Text constants must be injected from externaly (text manager, presenter or something like that)
    struct Texts {
        static let expandButtonTitle = "Читать далее"
        static let collapseButtonTitle = "Свернуть"
        static let likesFormat = "♡ %d"
    }
    
    struct Appearance {
        
        let sideMargin: CGFloat = 16.0
        let topMargin: CGFloat = 16.0
        let bottomMargin: CGFloat = 16.0
        let verticalSpacing: CGFloat = 8.0
        let horizontalSpacing: CGFloat = 8.0
        
        let backgroundColor = UIColor.autoBackground
        let titleColor = UIColor.autoLabel
        let titleFont = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        let titleLines = 0
        let subtitleColor = UIColor.autoLabel
        let subtitleFont = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        let previewLinesCollapsed = 2
        
        let dateFont: UIFont = .systemFont(ofSize: 13.0, weight: .bold)
        let dateColor: UIColor = .autoSecondaryLabel
        
        let likesFont: UIFont = .systemFont(ofSize: 13.0, weight: .bold)
        let likesColor: UIColor = .autoSecondaryLabel
    }
}

final class PostTableViewCell: UITableViewCell {
    
    // MARK: Private properties
    private let appearance = Appearance()
    private let disposeBag = DisposeBag()
    private var viewModel: PostDataViewModel?
    private var expandHandler: (() -> ())?
    
    // MARK: UI properties
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
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = self.appearance.subtitleFont
        label.textColor = self.appearance.subtitleColor
        label.numberOfLines = self.appearance.previewLinesCollapsed
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.rx.tap
            .bind { [weak self] in
                guard let viewModel = self?.viewModel else { return }
                viewModel.expanded = !viewModel.expanded
                self?.updateAppearance(with: viewModel)
                if let expandHandler = self?.expandHandler {
                    expandHandler()
                }
            }
            .disposed(by: self.disposeBag)
        return button
    }()
    
    func updateAppearance(with viewModel: PostDataViewModel) {
        self.titleLabel.text = viewModel.title
        self.subtitleLabel.text = viewModel.previewText
        self.dateLabel.text = viewModel.dateString
        self.likesLabel.text = String(format: Texts.likesFormat, viewModel.likes)
    
        let previewLines = viewModel.expanded ? 0 : self.appearance.previewLinesCollapsed
        let readMoreTitle = viewModel.expanded ? Texts.collapseButtonTitle : Texts.expandButtonTitle
        
        self.subtitleLabel.numberOfLines = previewLines
        self.readMoreButton.setTitle(readMoreTitle, for: .normal)
        
    }
    
    // MARK: Public methods
    func setupViewModel(viewModel: PostDataViewModel, expandHandler: (() -> ())?) {
        self.viewModel = viewModel
        self.expandHandler = expandHandler
        updateAppearance(with: viewModel)
    }
    
    // MARK: Lifecycle
    override func prepareForReuse() {
        // NOTE: not required, but it is logically to clean cell before reusing
        super.prepareForReuse()
        self.viewModel = nil
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
        self.dateLabel.text = ""
        self.likesLabel.text = ""
        self.dateLabel.text = ""
        self.expandHandler = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Private methods
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.likesLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.subtitleLabel)
        self.contentView.addSubview(self.readMoreButton)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(self.appearance.topMargin)
            make.leading.trailing.equalToSuperview().inset(self.appearance.sideMargin)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.equalTo(self.titleLabel)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.dateLabel.snp.trailing).offset(self.appearance.horizontalSpacing)
            make.centerY.equalTo(self.dateLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(self.appearance.sideMargin)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(self.appearance.sideMargin)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(self.appearance.verticalSpacing)
            make.leading.equalToSuperview().offset(self.appearance.sideMargin)
            make.trailing.lessThanOrEqualToSuperview().inset(self.appearance.sideMargin)
            make.bottomMargin.equalToSuperview().inset(self.appearance.bottomMargin)
        }
        
    }
}
