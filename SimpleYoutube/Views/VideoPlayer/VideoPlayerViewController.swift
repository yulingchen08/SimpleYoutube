//
//  VideoPlayerViewController.swift
//  SimpleYoutube
//
//  Created by 陳鈺翎 on 2023/3/11.
//

import UIKit
import YouTubeiOSPlayerHelper
import SnapKit


class VideoPlayerViewController: UIViewController {
    private let playerView: YTPlayerView = YTPlayerView()
    weak var delegate: VideoPlayerViewControllerDelegate?
    
    let viewModel: VideoPlayerViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(VideoTitleTableViewCell.self, forCellReuseIdentifier: VideoTitleTableViewCell.identifier)
        tableView.register(VideoCommentTableViewCell.self, forCellReuseIdentifier: VideoCommentTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.contentInset = .init(top: 0, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    init(viewModel: VideoPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        setupSwipeGesture()
        setupDataSource()
    }
    
    
}

extension VideoPlayerViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        [playerView, tableView].forEach {
            view.addSubview($0)
        }
        
        
        playerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
            make.height.equalTo(350)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
            
        }
    }
    
    private func setupDataSource() {
        playerView.load(withVideoId: viewModel.dataSource.contentDetails.videoId)
    }
    
    private func setupSwipeGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc
    private func handleSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        let translation = gestureRecognizer.translation(in: view)

        switch gestureRecognizer.state {
        case .changed:
            handleChanged(translation: translation, view: view)
        case .ended:
            handleEnded(translation: translation, view: view)
        default:
            break
        }
    }

    private func handleChanged(translation: CGPoint, view: UIView) {
        guard translation.y > 0 else {
            return
        }
        let transform = CGAffineTransform(translationX: 0, y: translation.y)
        view.transform = transform
    }

    private func handleEnded(translation: CGPoint, view: UIView) {
        let isSwipeDown = translation.y > view.frame.size.height / 3
        if isSwipeDown {
            dismiss(animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
                view.layoutIfNeeded()
            }
        }
    }
    
}

extension VideoPlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.dataSource.items.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTitleTableViewCell.identifier, for: indexPath) as? VideoTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.updateFrame(object: viewModel.dataSource)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCommentTableViewCell.identifier, for: indexPath) as? VideoCommentTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
       
        //cell.delegate = self
        //let object = viewModel.dataSource.items[indexPath.row]
        //cell.updateFrame(object: object)
        //return cell
        return UITableViewCell()
    }
    
    
}

extension VideoPlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //delegate?.didClickPlayVideoButton()
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row >= viewModel.dataSource.items.count - 1 {
//            viewModel.inputs.scrollToBottom()
//        }
//    }
}
