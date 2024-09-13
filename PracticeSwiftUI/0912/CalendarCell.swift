//
//  CalendarCell.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/11/24.
//

import UIKit
import FSCalendar
import SnapKit

final class CalendarCell: FSCalendarCell {
    static let identifier = "CalendarCell"
    
    let thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    let frontView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
//        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhchy()
        setupConstraints()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
        frontView.backgroundColor = .clear
    }
    
    private func setupHierarhchy() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(frontView)
    }
    
    private func setupConstraints() {
        thumbImageView.snp.makeConstraints { make in
            make.center.equalTo(titleLabel)
            make.size.equalTo(getMinSize())
        }
        
        frontView.snp.makeConstraints { make in
            make.edges.equalTo(thumbImageView)
        }
    }
    
    private func setupUI() {
        thumbImageView.layer.cornerRadius = getMinSize() / 2
        frontView.layer.cornerRadius = getMinSize() / 2
    }
    
    private func getMinSize() -> CGFloat {
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        let result = width < height ? width : height
        return result - 8
    }
    
    func configureCell(_ isToday: Bool) {
        thumbImageView.layer.opacity = isToday ? 0.05 : 0.2
        thumbImageView.image = UIImage(named: "05")
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
}
