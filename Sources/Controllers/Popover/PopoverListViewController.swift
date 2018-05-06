//
//  PopoverListViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 4..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Then
import SnapKit

protocol TMPopoverDelegate {
    func popover(_ controller: UIViewController, didSelectIndexAt index: Int)
}

class PopoverListViewController: UIViewController {
    var tableView: UITableView!
    var delegate: TMPopoverDelegate?
    public var source: [String]?
    var rowHeight: CGFloat = 35
    // MARK: - Method

    func configureUI() {
        tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain).then {
            view.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            $0.delegate = self
            $0.dataSource = self
            $0.register(PopoverListTableViewCell.self, forCellReuseIdentifier: "PopoverListTableViewCell")
            $0.reloadData()
        }
        
    }
    
    public static func make(source: [String]) -> PopoverListViewController {
        let vc = PopoverListViewController()
        vc.source = source
        return vc
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension PopoverListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let source = source {
            return source.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopoverListTableViewCell.toString, for: indexPath) as! PopoverListTableViewCell
        cell.title = source![indexPath.row]
        return cell
    }

    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.popover(self, didSelectIndexAt: indexPath.row)
    }
}
