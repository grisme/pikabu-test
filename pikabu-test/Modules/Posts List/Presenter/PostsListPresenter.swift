//
//  PostsListPresenter.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostsListPresenter implementation
final class PostsListPresenter {
    
    // MARK: Private properties
    private let disposeBag = DisposeBag()
    private var postViewModels = [PostDataViewModel]()
    
    // MARK: Injection properties
    weak var view: PostsListViewProtocol?
    var interactor: PostsListInteractorProtocol?
    var router: PostsListRouterProtocol?
    var textManager: PostsListTextManagerProtocol?
}

// MARK: - PostsListPresenterProtocol implementation
extension PostsListPresenter: PostsListPresenterProtocol {
    func viewDidLoad() {
        self.view?.showLoader()
        self.interactor?.obtainPosts()?
            // Mapping obtained PostData list to PostDataViewModelList
            // works on interactor's thread (before dispatching the main thread)
            .map { posts in
                posts.map { postData in
                    PostDataViewModel(postData: postData)
                }
            }
            // Dispatching to main thread
            .observeOn(MainScheduler.instance)
            // Observing success (and possible error) event on main thread
            // Here we have post data view models collection as input argument
            .subscribe(onSuccess: { [weak self] postViewModels in
                self?.postViewModels = postViewModels
                self?.view?.hideLoader()
                self?.view?.showPosts(posts: postViewModels)
            }, onError: { [weak self] _ in
                self?.view?.hideLoader()
                self?.view?.showButtonError(text: self?.textManager?.obtainErrorText ?? "",
                                            buttonTitle: self?.textManager?.obtainRepeat ?? "",
                                            buttonHandler: {
                                                self?.viewDidLoad()
                })
                
            })
            .disposed(by: self.disposeBag)
    }
    
    func sortButtonPressed() {
        self.view?.showSortSelector()
    }
    
    func sortByLikesPressed() {
        let sortedPosts = self.postViewModels.sorted { postOne, postTwo -> Bool in
            postOne.likes > postTwo.likes
        }
        self.view?.showPosts(posts: sortedPosts)
    }
    
    func sortByDatePressed() {
        let sortedPosts = self.postViewModels.sorted { postOne, postTwo -> Bool in
            postOne.date > postTwo.date
        }
        self.view?.showPosts(posts: sortedPosts)
    }
    
    func postSelected(post: PostDataViewModel) {
        let postId = post.postId
        self.router?.openPost(postId: postId)
    }
}
