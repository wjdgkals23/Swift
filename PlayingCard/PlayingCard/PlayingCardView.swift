//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by 정하민 on 26/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } } // 스스로 Redraw 요청하는 함수 // 뷰의 서브뷰들의 재조정이나 그리는 기능이 필요할 때
    var suit: String = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString { // 카드의 글자를 만드는 과정 라벨안에 들어갈 문자열을 셋팅하는 방법
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString.init(string: string, attributes: [.paragraphStyle:paragraphStyle, .font:font])
    }
    
    private var cornerString: NSAttributedString { // 글자 생성
        return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    
    private func createCornerLabel() -> UILabel { // 라벨 생성
        let label = UILabel()
        label.numberOfLines = 0 // 원하는 만큼 줄수를 제공하는 옵션
        addSubview(label)
        return label
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel() // 왼쪽 위
    private lazy var lowerRightCornerLabel = createCornerLabel() // 오른쪽 아래
    
    //    [C2-10]
    private func configureCornerLabel(_ label: UILabel) { // 라벨 데이터 설정
        label.attributedText = cornerString // 라벨 문자열 설정
        label.frame.size = CGSize.zero // 라벨의 사이즈를 문자열에 맞게 조정하기 위해서 너비를 제거해주는 작업이 필요하다.
        label.sizeToFit() // 세로,가로 길이를 문자열에 맞춘다.
        label.isHidden = !isFaceUp
    }
    
    override func draw(_ rect: CGRect) { // setNeedsDisplay 이 호출하는 시스템 함수
        let roundedRect = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        roundedRect.fill()
        roundedRect.addClip() // 잘모르겟어
    }
    
    override func layoutSubviews() { // setNeedsLayout 이 호출하는 시스템 함수
        super.layoutSubviews()
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }

}

// 뷰의 랜더링 속도를 높이기 위해 extension을 이용한다.
extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint { // 내가 만들 뷰에서 CGPoint 관련되서 자주 사용하게될 기능을 함수로 선언해놓자!
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

