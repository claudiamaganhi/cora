import UIKit

extension UISegmentedControl {
    func addUnderlineForSelectedSegment() {
        let underlineFrame = calculateUnderlineFrame()
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = Colors.primary
        underline.tag = 1
        addSubview(underline)
    }
    
    func changeUnderlinePosition() {
        guard let underline = viewWithTag(1) else { return }
        underline.frame = calculateUnderlineFrame()
    }
    
   private func calculateUnderlineFrame() -> CGRect {
        let selectedWidth = bounds.size.width / CGFloat(numberOfSegments)
        let textWidth: CGFloat = titleForSegment(at: selectedSegmentIndex)?.size(withAttributes:[.font: Fonts.primaryBold(size: 14)]).width ?? 0.0
        let underlineTrailing = (selectedWidth - textWidth) / 2
        let underlineHeight: CGFloat = 1.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(selectedWidth)) + underlineTrailing
        let underLineYPosition = bounds.size.height - 10.0
        
        return CGRect(x: underlineXPosition, y: underLineYPosition, width: textWidth, height: underlineHeight)
    }
}
