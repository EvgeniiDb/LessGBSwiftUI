//
//  NewsController.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit

// Протокол Делегат для обновления высоты ячейки текста
protocol ShowMoreDelegate: AnyObject {
    func updateTextHeight(indexPath: IndexPath)
}

// Контроллер новостей пользователя
final class NewsController: MyCustomUIViewController {
    
    // Типы ячеек, из которых состоит секция новости
    enum NewsCells {
        case author
        case text
        case collection
        case footer
        case link
    }
    

    private var newsView: NewsView {
        guard let view = self.view as? NewsView else { return NewsView() }
        return view
    }
    
    
    var isLoading = false
    
    
    private let cellsCount: Int = 4
    
    
    private let cellsWithLink: Int = 5
    
    
    private var viewModel: NewsViewModelType
    
    init(model: NewsViewModelType) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - View controller life cycle
    
    override func loadView() {
        super.loadView()
        self.view = NewsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
        newsView.tableView.reloadData()
        newsView.tableView.separatorStyle = .none
        
        newsView.spinner.startAnimating()
        
        viewModel.fetchNews { [weak self] in
            self?.newsView.spinner.stopAnimating()
            self?.newsView.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        newsView.tableView.frame = newsView.bounds
    }
    
//MARK: - Pull to refresh
    
    // Настраивает RefreshControl для контроллера
    private func setupRefreshControl() {
        newsView.tableView.refreshControl = UIRefreshControl()
        newsView.tableView.refreshControl?.tintColor = .black
        newsView.tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    // Запрашивает обновление новостей, инициируется RefreshControl-ом
    @objc func refreshNews() {
        viewModel.fetchFreshNews { [weak self] indexSet in
            guard let indexSet = indexSet else { return }
            
            self?.newsView.tableView.insertSections(indexSet, with: .automatic)
            self?.newsView.tableView.refreshControl?.endRefreshing()
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkLink(for: section) {
            return cellsWithLink
        } else {
            return cellsCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        guard let type = getCellType(for: indexPath) else { return UITableViewCell () }
        
        switch type {
        case .author:
            let authorCell: NewsAuthorCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell = authorCell
        case .text:
            let textCell: NewsTextCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell = textCell
            textCell.delegate = self
            textCell.indexPath = indexPath
        case .collection:
            let collectionCell: NewsCollectionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell = collectionCell
        case .footer:
            let footerCell: NewsFooterCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell = footerCell
        case .link:
            let linkCell: NewsLinkCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell = linkCell
        }
        
        viewModel.configureCell(cell: cell, index: indexPath.section, type: type)
        return cell
    }
    
    // добавляем заголовок, чтобы визуально разграничить новости
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Создаём кастомную вьюху заголовка
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        header.backgroundColor = .gray
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 2 {
            if let height = viewModel.news[indexPath.section].newsImageModels.first?.height,
               let width = viewModel.news[indexPath.section].newsImageModels.first?.width {
                let aspectRatio = Double(height) / Double(width)
                return tableView.bounds.width * CGFloat(aspectRatio)
            } else {
                return UITableView.automaticDimension
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newsView.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private methods
private extension NewsController {
    
    // Конфигурируем TableView
    func setupTableView() {
        let tableView = newsView.tableView
        
        tableView.register(registerClass: NewsAuthorCell.self)
        tableView.register(registerClass: NewsTextCell.self)
        tableView.register(registerClass: NewsCollectionCell.self)
        tableView.register(registerClass: NewsFooterCell.self)
        tableView.register(registerClass: NewsLinkCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }

    
    // Проверяет наличие ссылки в новости
    func checkLink(for section: Int) -> Bool {
        return (viewModel.news[section].link) != nil
    }
    
    func getCellType(for item: IndexPath) -> NewsCells? {
        switch item.item {
        case 0:
            return .author
        case 1:
            return .text
        case 2:
            return .collection
        case 3:
            if checkLink(for: item.section) {
                return .link
            } else {
                return .footer
            }
        case 4:
            return .footer
        default:
            print("Some News Table view issue")
            return nil
        }
    }
}

// MARK: - ShowMoreDelegate
extension NewsController: ShowMoreDelegate {
    func updateTextHeight(indexPath: IndexPath) {
        newsView.tableView.beginUpdates()
        newsView.tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension NewsController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > ( viewModel.news.count - 3 ),
           isLoading == false {
            isLoading = true
            
            viewModel.prefetchNews { [weak self] indexSet in
                guard let indexSet = indexSet else { return }
                
                self?.newsView.tableView.insertSections(indexSet, with: .automatic)
                self?.isLoading = false
            }
        }
    }
}

