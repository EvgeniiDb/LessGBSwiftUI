//
//  NewsView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit

// Вью для News Controller
final class NewsView: UIView {
    
    // MARK: Subviews
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .black
        return spinner
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    

    private func configureUI() {
        addSubviews()
        setupSpinner()
    }
    
   
    func addSubviews() {
        self.addSubview(tableView)
        self.addSubview(spinner)
    }
    
 
    func setupSpinner() {
        spinner.center = self.center
    }
}

