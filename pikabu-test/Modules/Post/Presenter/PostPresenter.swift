//
//  PostPresenter.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostPresenter implementation
final class PostPresenter {
    
    // MARK: Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: Injection properties
    var postId: Int?
    weak var view: PostViewProtocol?
    var interactor: PostInteractorProtocol?
    var router: PostRouterProtocol?
    var textManager: PostTextManagerProtocol?
    
}

// MARK: - PostPresenterProtocol implementation
extension PostPresenter: PostPresenterProtocol {
    func viewDidLoad() {
        guard let postId = self.postId else {
            // TODO: postId doesn't injected! show error?
            return
        }
        self.view?.showLoader()
        self.interactor?.obtainPost(postId: postId)?
            // Mapping obtained PostDetailData list to PostDetailDataViewModel
            // works on interactor's thread (before dispatching the main thread)
            .map { postDetailData in
                PostDetailDataViewModel(postDetailData: postDetailData)
            }
            // Dispatching to main thread
            .observeOn(MainScheduler.instance)
            // Observing success (and possible error) event on main thread
            // Here we have PostDetailDataViewModel as input argument
            .subscribe(onSuccess: { [weak self] postDetailViewModel in
                self?.view?.hideLoader()
                self?.view?.showPost(viewModel: postDetailViewModel)
            }, onError: { [weak self] serviceError in
                self?.view?.hideLoader()
                self?.router?.openPostsList()
            })
            .disposed(by: self.disposeBag)
    }
}
