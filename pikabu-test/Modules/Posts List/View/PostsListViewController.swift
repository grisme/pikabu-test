//
//  PostsListViewController.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - PostsListViewController implementation
final class PostsListViewController: BaseViewController {
    
    // MARK: Injection properties
    var presenter: PostsListPresenterProtocol?

    // MARK: Private properties
    private var posts = [PostDataViewModel]()
    private let disposeBag = DisposeBag()
    
    // MARK: UI properties
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: self.presenter?.textManager?.sortButton, style: .plain, target: nil, action: nil)
        button.rx.tap
            .bind { [weak self] in
                self?.presenter?.sortButtonPressed()
            }
            .disposed(by: self.disposeBag)
        return button
    }()
    
//    private var cellHeights = [IndexPath: CGFloat]()
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: Private methods
    private func setupUI() {
        self.title = presenter?.textManager?.title
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.navigationItem.rightBarButtonItem = self.sortButton
        self.view.addSubview(self.postsTableView)
    }
    
    private func makeConstraints() {
        self.postsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - PostsListViewProtocol implementation
extension PostsListViewController: PostsListViewProtocol {
    func showLoader() {
        self.showLoadingIndicator()
    }
    
    func hideLoader() {
        self.hideLoadingIndicator()
    }
    
    func showButtonError(text: String, buttonTitle: String, buttonHandler: @escaping () -> ()) {
        let alertController = UIAlertController(title: self.presenter?.textManager?.errorTitle,
                                                message: text,
                                                preferredStyle: .alert)
        
        let buttonAction = UIAlertAction(title: buttonTitle,
                                         style: .cancel, handler: { _ in
                                            buttonHandler()
        })
        alertController.addAction(buttonAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // FIXME: Shoult not be here!!!
    func showError(text: String) {
        let alertController = UIAlertController(title: self.presenter?.textManager?.errorTitle,
                                                message: text,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: self.presenter?.textManager?.cancelButton,
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // FIXME: Shoult not be here!!!
    func showSortSelector() {
        let alertController = UIAlertController(title: self.presenter?.textManager?.sortSelectorTitle,
                                                message: self.presenter?.textManager?.sortSelectorMessage,
                                                preferredStyle: .actionSheet)
        
        let sortByLikesAction = UIAlertAction(title: self.presenter?.textManager?.sortByLikes,
                                              style: .default) { [weak self] _ in
                                                self?.presenter?.sortByLikesPressed()
        }
        
        let sortByDateAction = UIAlertAction(title: self.presenter?.textManager?.sortByDate,
                                             style: .default) { [weak self] _ in
                                                self?.presenter?.sortByDatePressed()
        }
        
        let cancelAction = UIAlertAction(title: self.presenter?.textManager?.cancelButton,
                                         style: .cancel, handler: nil)
        
        alertController.addAction(sortByLikesAction)
        alertController.addAction(sortByDateAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showPosts(posts: [PostDataViewModel]) {
        self.posts = posts
        self.postsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource impelementation
extension PostsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.posts[indexPath.row]
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { fatalError("PostTableViewCell is not registered") }
        postCell.setupViewModel(viewModel: post) { [weak self] in
            self?.postsTableView.beginUpdates()
            self?.postsTableView.reloadRows(at: [indexPath], with: .none)
            self?.postsTableView.endUpdates()
        }
        return postCell
    }
}

// MARK: - UITableViewDelegate implementation
extension PostsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = self.posts[indexPath.row]
        self.presenter?.postSelected(post: post)
    }
}
