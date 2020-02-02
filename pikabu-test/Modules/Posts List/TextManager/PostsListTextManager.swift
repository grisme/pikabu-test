//
//  PostsListTextManager.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

final class PostsListTextManager: PostsListTextManagerProtocol {
    let title: String = "Посты"
    let sortButton: String = "Сортировка"
    let sortSelectorTitle: String = "Способ сортировки"
    let sortSelectorMessage: String = "Выберите способ сортировки"
    let sortByLikes: String = "По рейтингу"
    let sortByDate: String = "По дате"
    let errorTitle: String = "Ошибка"
    let cancelButton: String = "Отмена"
    let obtainErrorText: String = "Не удалось получить посты, возможно какие-то проблемы с интернетом"
    let obtainRepeat: String = "Повторить попытку"
}
