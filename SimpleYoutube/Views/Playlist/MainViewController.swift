//
//  MainViewController.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit
import SnapKit

protocol MainViewControllerDelegate: AnyObject {
    func didClickPlayVideoButton(object: PlaylistDomainObject.Item)
}


class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    private let viewModel: MainViewModel = .init()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.contentInset = .init(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindViewModel()
        viewModel.inputs.loadData()
    }
}


extension MainViewController {
    private func setupLayout() {
        
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.presentPlaylistCell = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier, for: indexPath) as? MainViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let object = viewModel.dataSource.items[indexPath.row]
        cell.updateFrame(object: object)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didClickPlayVideoButton(object: viewModel.dataSource.items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.dataSource.items.count - 1 {
            viewModel.inputs.scrollToBottom()
        }
    }
}


extension MainViewController: MainTableViewCellDelegate {
    func updateCell(channelId: String) {
        viewModel.inputs.loadData()
    }
    
    
}

