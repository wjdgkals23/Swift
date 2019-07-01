//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by 정하민 on 26/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import UIKit

// 뷰 그리는 과정

// 1. 부모 오버라이드 함수
// 1-1. draw 호출 -> UIBezierPath를 통한 테두리 생성 -> isFaceUp 변수에 따라 중앙 그림 생성
// 1-2. layoutSubviews 호출 -> 좌상 우하 라벨 생성 -> 라벨 스타일, 텍스트 생성 -> 배치
// 2. 제스쳐인식 추가
// 2-1. tap, pinch, swipe

@IBDesignable // IB 에서 해당 뷰를 볼 수 있음
class PlayingCardView: UIView {
    @IBInspectable // IB 에서 해당 변수를 설정할 수 있음
    var rank: Int = 11 { didSet { setNeedsDisplay(); setNeedsLayout() } } // 스스로 Redraw 요청하는 함수 // 뷰의 서브뷰들의 재조정이나 그리는 기능이 필요할 때
    @IBInspectable
    var suit: String = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @objc func adjustFaceCardScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed,.ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1.0
        default: break
        }
    }

    private func centeredArributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString { // 카드의 글자를 만드는 과정 라벨안에 들어갈 문자열을 셋팅하는 방법
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize) // 시스템 폰트 설정
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font) // 폰트 스타일(스타일, 크기) 설정
        let paragraphStyle = NSMutableParagraphStyle() // 문단 모양
        paragraphStyle.alignment = .center // 가운데 정렬
        return NSAttributedString.init(string: string, attributes: [.paragraphStyle:paragraphStyle, .font:font])
    }
    
    private var cornerString: NSAttributedString { // 글자 생성
        return centeredArributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    
    private func createCornerLabel() -> UILabel { // 라벨 생성
        let label = UILabel()
        label.numberOfLines = 0 // 원하는 만큼 줄수를 제공하는 옵션
        addSubview(label)
        return label
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel() // 왼쪽 위
    private lazy var lowerRightCornerLabel = createCornerLabel() // 오른쪽 아래
    
    private func configureCornerLabel(_ label: UILabel) { // 라벨 데이터 설정
        label.attributedText = cornerString // 라벨 문자열 설정
        label.frame.size = CGSize.zero // 라벨의 사이즈를 문자열에 맞게 조정하기 위해서 너비를 제거해주는 작업이 필요하다.
        label.sizeToFit() // 세로,가로 길이를 문자열에 맞춘다.
        label.isHidden = !isFaceUp
    }
    
    override func draw(_ rect: CGRect) { // setNeedsDisplay 이 호출하는 시스템 함수
        let roundedRect = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip() // 잘모르겟어
        UIColor.white.setFill()
        roundedRect.fill()
        
        if isFaceUp { // 뒤집어졌는지 아닌지 판단
            if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
            } else {
                drawPips()
            }
        } else {
            if let backCardImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                backCardImage.draw(in: bounds)
            } else {
                print("Got an load cardbackImage error")
            }
//            do {
//                let backImage = try UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection)
//                backImage?.draw(in: bounds)
//            } catch{
//                print("Got an load cardbackImage \(error)")
//            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { // ios 디바이스 인터페이스 환경이 변형되었을 때 불려지는 함수
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func layoutSubviews() { // setNeedsLayout 이 호출하는 시스템 함수
        super.layoutSubviews() // 라벨추가 로직
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi) // frame의 원점을 기준으로 회전시킨다. 따라서 평행이동을 진행하여 뒤집기를 진행해야한다.
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }
    
    private func drawPips()
    {
        let pipsPerRowForRank = [[0],[1],[1,1],[1,1,1],[2,2],[2,1,2],[2,2,2],[2,1,2,2],[2,2,2,2],[2,2,1,2,2],[2,2,2,2,2]]
        
        func createPipString(thatFits pipRect: CGRect) -> NSAttributedString {
            let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.count, $0) })
            let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.max() ?? 0, $0) })
            let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
            let attemptedPipString = centeredArributedString(suit, fontSize: verticalPipRowSpacing)
            let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
            let probablyOkayPipString = centeredArributedString(suit, fontSize: probablyOkayPipStringFontSize)
            if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
                return centeredArributedString(suit, fontSize: probablyOkayPipStringFontSize / (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
            } else {
                return probablyOkayPipString
            }
        }
        
        if pipsPerRowForRank.indices.contains(rank) {
            let pipsPerRow = pipsPerRowForRank[rank]
            var pipRect = bounds.insetBy(dx: cornerOffset, dy: cornerOffset).insetBy(dx: cornerString.size().width, dy: cornerString.size().height / 2)
            let pipString = createPipString(thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2
            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
        }
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

