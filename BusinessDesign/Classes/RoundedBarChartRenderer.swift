//
//  Created by Backbase R&D B.V. on 02/10/2019.
//

import UIKit
import Charts

// swiftlint:disable cyclomatic_complexity file_length line_length type_body_length force_cast function_body_length
public class RoundedBarChartRenderer: BarChartRenderer {

    private class Buffer {
        var rects = [CGRect]()
    }

    private var _buffers = [Buffer]()

    private var _barShadowRectBuffer: CGRect = CGRect()

    public override func initBuffers() {
        if let barData = dataProvider?.barData {
            // Matche buffers count to dataset count
            if _buffers.count != barData.dataSetCount {
                while _buffers.count < barData.dataSetCount {
                    _buffers.append(Buffer())
                }
                while _buffers.count > barData.dataSetCount {
                    _buffers.removeLast()
                }
            }

            for i in stride(from: 0, to: barData.dataSetCount, by: 1) {
                let set = barData.dataSets[i] as! IBarChartDataSet
                let size = set.entryCount * (set.isStacked ? set.stackSize : 1)
                if _buffers[i].rects.count != size {
                    _buffers[i].rects = [CGRect](repeating: CGRect(), count: size)
                }
            }
        } else {
            _buffers.removeAll()
        }
    }

    //To make it simple, I ignored Shadows and borders
    public override func drawDataSet(context: CGContext, dataSet: IBarChartDataSet, index: Int) {
        guard let dataProvider = dataProvider else { return }

        let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)

        prepareBuffer(dataSet: dataSet, index: index)
        trans.rectValuesToPixel(&_buffers[index].rects)

        context.saveGState()
        let buffer = _buffers[index]
        let isSingleColor = dataSet.colors.count == 1

        if isSingleColor {
            context.setFillColor(dataSet.color(atIndex: 0).cgColor)
        }

        for j in stride(from: 0, to: buffer.rects.count, by: 1) {
            let yValue = dataSet.entryForIndex(j)!.y

            let barRect = buffer.rects[j]

            if !viewPortHandler.isInBoundsLeft(barRect.origin.x + barRect.size.width) {
                continue
            }

            if !viewPortHandler.isInBoundsRight(barRect.origin.x) {
                break
            }

            if !isSingleColor {
                // Set the color for the currently drawn value. If the index is out of bounds, reuse colors.
                context.setFillColor(dataSet.color(atIndex: j).cgColor)
            }
            if yValue < 0 {
                let bezierPath = UIBezierPath(roundedRect: barRect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 4, height: 4))
                context.addPath(bezierPath.cgPath)

                context.drawPath(using: .fill)
            } else {
                let bezierPath = UIBezierPath(roundedRect: barRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4))
                context.addPath(bezierPath.cgPath)

                context.drawPath(using: .fill)
            }
            //            context.fill(barRect)
        }

        context.restoreGState()
    }

    public override func drawHighlighted(context: CGContext, indices: [Highlight]) {

    }

    private func prepareBuffer(dataSet: IBarChartDataSet, index: Int) {
        guard
            let dataProvider = dataProvider,
            let barData = dataProvider.barData
        else { return }

        let barWidthHalf = barData.barWidth / 2.0

        let buffer = _buffers[index]
        var bufferIndex = 0
        let containsStacks = dataSet.isStacked

        let isInverted = dataProvider.isInverted(axis: dataSet.axisDependency)
        let phaseY = animator.phaseY
        var barRect = CGRect()
        var x: Double
        var y: Double

        for i in stride(from: 0, to: min(Int(ceil(Double(dataSet.entryCount) * animator.phaseX)), dataSet.entryCount), by: 1) {
            guard let e = dataSet.entryForIndex(i) as? BarChartDataEntry else { continue }

            let vals = e.yValues

            x = e.x
            y = e.y

            if !containsStacks || vals == nil {
                let left = CGFloat(x - barWidthHalf)
                let right = CGFloat(x + barWidthHalf)
                var top = isInverted
                    ? (y <= 0.0 ? CGFloat(y) : 0)
                    : (y >= 0.0 ? CGFloat(y) : 0)
                var bottom = isInverted
                    ? (y >= 0.0 ? CGFloat(y) : 0)
                    : (y <= 0.0 ? CGFloat(y) : 0)

                /* When drawing each bar, the renderer actually draws each bar from 0 to the required value.
                 * This drawn bar is then clipped to the visible chart rect in BarLineChartViewBase's draw(rect:) using clipDataToContent.
                 * While this works fine when calculating the bar rects for drawing, it causes the accessibilityFrames to be oversized in some cases.
                 * This offset attempts to undo that unnecessary drawing when calculating barRects
                 *
                 * +---------------------------------------------------------------+---------------------------------------------------------------+
                 * |      Situation 1:  (!inverted && y >= 0)                      |      Situation 3:  (inverted && y >= 0)                       |
                 * |                                                               |                                                               |
                 * |        y ->           +--+       <- top                       |        0 -> ---+--+---+--+------   <- top                     |
                 * |                       |//|        } topOffset = y - max       |                |  |   |//|          } topOffset = min         |
                 * |      max -> +---------+--+----+  <- top - topOffset           |      min -> +--+--+---+--+----+    <- top + topOffset         |
                 * |             |  +--+   |//|    |                               |             |  |  |   |//|    |                               |
                 * |             |  |  |   |//|    |                               |             |  +--+   |//|    |                               |
                 * |             |  |  |   |//|    |                               |             |         |//|    |                               |
                 * |      min -> +--+--+---+--+----+  <- bottom + bottomOffset     |      max -> +---------+--+----+    <- bottom - bottomOffset   |
                 * |                |  |   |//|        } bottomOffset = min        |                       |//|          } bottomOffset = y - max  |
                 * |        0 -> ---+--+---+--+-----  <- bottom                    |        y ->           +--+         <- bottom                  |
                 * |                                                               |                                                               |
                 * +---------------------------------------------------------------+---------------------------------------------------------------+
                 * |      Situation 2:  (!inverted && y < 0)                       |      Situation 4:  (inverted && y < 0)                        |
                 * |                                                               |                                                               |
                 * |        0 -> ---+--+---+--+-----   <- top                      |        y ->           +--+         <- top                     |
                 * |                |  |   |//|         } topOffset = -max         |                       |//|          } topOffset = min - y     |
                 * |      max -> +--+--+---+--+----+   <- top - topOffset          |      min -> +---------+--+----+    <- top + topOffset         |
                 * |             |  |  |   |//|    |                               |             |  +--+   |//|    |                               |
                 * |             |  +--+   |//|    |                               |             |  |  |   |//|    |                               |
                 * |             |         |//|    |                               |             |  |  |   |//|    |                               |
                 * |      min -> +---------+--+----+   <- bottom + bottomOffset    |      max -> +--+--+---+--+----+    <- bottom - bottomOffset   |
                 * |                       |//|         } bottomOffset = min - y   |                |  |   |//|          } bottomOffset = -max     |
                 * |        y ->           +--+        <- bottom                   |        0 -> ---+--+---+--+-------  <- bottom                  |
                 * |                                                               |                                                               |
                 * +---------------------------------------------------------------+---------------------------------------------------------------+
                 */
                var topOffset: CGFloat = 0.0
                var bottomOffset: CGFloat = 0.0
                if let offsetView = dataProvider as? BarChartView {
                    let offsetAxis = offsetView.getAxis(dataSet.axisDependency)
                    if y >= 0 {
                        // situation 1
                        if offsetAxis.axisMaximum < y {
                            topOffset = CGFloat(y - offsetAxis.axisMaximum)
                        }
                        if offsetAxis.axisMinimum > 0 {
                            bottomOffset = CGFloat(offsetAxis.axisMinimum)
                        }
                    } else // y < 0
                    {
                        //situation 2
                        if offsetAxis.axisMaximum < 0 {
                            topOffset = CGFloat(offsetAxis.axisMaximum * -1)
                        }
                        if offsetAxis.axisMinimum > y {
                            bottomOffset = CGFloat(offsetAxis.axisMinimum - y)
                        }
                    }
                    if isInverted {
                        // situation 3 and 4
                        // exchange topOffset/bottomOffset based on 1 and 2
                        // see diagram above
                        (topOffset, bottomOffset) = (bottomOffset, topOffset)
                    }
                }
                //apply offset
                top = isInverted ? top + topOffset : top - topOffset
                bottom = isInverted ? bottom - bottomOffset : bottom + bottomOffset

                // multiply the height of the rect with the phase
                // explicitly add 0 + topOffset to indicate this is changed after adding accessibility support (#3650, #3520)
                if top > 0 + topOffset {
                    top *= CGFloat(phaseY)
                } else {
                    bottom *= CGFloat(phaseY)
                }

                barRect.origin.x = left
                barRect.origin.y = top
                barRect.size.width = right - left
                barRect.size.height = bottom - top
                buffer.rects[bufferIndex] = barRect
                bufferIndex += 1
            } else {
                var posY = 0.0
                var negY = -e.negativeSum
                var yStart = 0.0

                // fill the stack
                for k in 0 ..< vals!.count {
                    let value = vals![k]

                    if value == 0.0 && (posY == 0.0 || negY == 0.0) {
                        // Take care of the situation of a 0.0 value, which overlaps a non-zero bar
                        y = value
                        yStart = y
                    } else if value >= 0.0 {
                        y = posY
                        yStart = posY + value
                        posY = yStart
                    } else {
                        y = negY
                        yStart = negY + abs(value)
                        negY += abs(value)
                    }

                    let left = CGFloat(x - barWidthHalf)
                    let right = CGFloat(x + barWidthHalf)
                    var top = isInverted
                        ? (y <= yStart ? CGFloat(y) : CGFloat(yStart))
                        : (y >= yStart ? CGFloat(y) : CGFloat(yStart))
                    var bottom = isInverted
                        ? (y >= yStart ? CGFloat(y) : CGFloat(yStart))
                        : (y <= yStart ? CGFloat(y) : CGFloat(yStart))

                    // multiply the height of the rect with the phase
                    top *= CGFloat(phaseY)
                    bottom *= CGFloat(phaseY)

                    barRect.origin.x = left
                    barRect.size.width = right - left
                    barRect.origin.y = top
                    barRect.size.height = bottom - top

                    buffer.rects[bufferIndex] = barRect
                    bufferIndex += 1
                }
            }
        }
    }

    func shouldDrawValues(forDataSet set: IChartDataSet) -> Bool {
        return set.isVisible && (set.isDrawValuesEnabled || set.isDrawIconsEnabled)
    }
    public override func drawValues(context: CGContext) {
        // if values are drawn
        if isDrawingValuesAllowed(dataProvider: dataProvider) {
            guard
                let dataProvider = dataProvider,
                let barData = dataProvider.barData
            else { return }

            let dataSets = barData.dataSets

            let valueOffsetPlus: CGFloat = 4.5
            var posOffset: CGFloat
            var negOffset: CGFloat
            let drawValueAboveBar = dataProvider.isDrawValueAboveBarEnabled

            for dataSetIndex in 0 ..< barData.dataSetCount {
                guard let
                        dataSet = dataSets[dataSetIndex] as? IBarChartDataSet,
                      shouldDrawValues(forDataSet: dataSet)
                else { continue }

                let isInverted = dataProvider.isInverted(axis: dataSet.axisDependency)

                // calculate the correct offset depending on the draw position of the value
                let valueFont = dataSet.valueFont
                let valueTextHeight = valueFont.lineHeight
                posOffset = (drawValueAboveBar ? -(valueTextHeight + valueOffsetPlus) : valueOffsetPlus)
                negOffset = (drawValueAboveBar ? valueOffsetPlus : -(valueTextHeight + valueOffsetPlus))

                if isInverted {
                    posOffset = -posOffset - valueTextHeight
                    negOffset = -negOffset - valueTextHeight
                }

                let buffer = _buffers[dataSetIndex]

                guard let formatter = dataSet.valueFormatter else { continue }

                let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)

                let phaseY = animator.phaseY

                let iconsOffset = dataSet.iconsOffset

                // if only single values are drawn (sum)
                if !dataSet.isStacked {
                    for j in 0 ..< Int(ceil(Double(dataSet.entryCount) * animator.phaseX)) {
                        guard let e = dataSet.entryForIndex(j) as? BarChartDataEntry else { continue }

                        let rect = buffer.rects[j]

                        let x = rect.origin.x + rect.size.width / 2.0

                        if !viewPortHandler.isInBoundsRight(x) {
                            break
                        }

                        if !viewPortHandler.isInBoundsY(rect.origin.y)
                            || !viewPortHandler.isInBoundsLeft(x) {
                            continue
                        }

                        let val = e.y

                        if dataSet.isDrawValuesEnabled {
                            drawValue(
                                context: context,
                                value: formatter.stringForValue(
                                    val,
                                    entry: e,
                                    dataSetIndex: dataSetIndex,
                                    viewPortHandler: viewPortHandler),
                                xPos: x,
                                yPos: val >= 0.0
                                    ? (rect.origin.y + posOffset)
                                    : (rect.origin.y + rect.size.height + negOffset),
                                font: valueFont,
                                align: .center,
                                color: dataSet.valueTextColorAt(j))
                        }

                        if let icon = e.icon, dataSet.isDrawIconsEnabled {
                            var px = x
                            var py = val >= 0.0
                                ? (rect.origin.y + posOffset)
                                : (rect.origin.y + rect.size.height + negOffset)

                            px += iconsOffset.x
                            py += iconsOffset.y

                            ChartUtils.drawImage(
                                context: context,
                                image: icon,
                                x: px,
                                y: py,
                                size: icon.size)
                        }
                    }
                } else {
                    // if we have stacks

                    var bufferIndex = 0

                    for index in 0 ..< Int(ceil(Double(dataSet.entryCount) * animator.phaseX)) {
                        guard let e = dataSet.entryForIndex(index) as? BarChartDataEntry else { continue }

                        let vals = e.yValues

                        let rect = buffer.rects[bufferIndex]

                        let x = rect.origin.x + rect.size.width / 2.0

                        // we still draw stacked bars, but there is one non-stacked in between
                        if vals == nil {
                            if !viewPortHandler.isInBoundsRight(x) {
                                break
                            }

                            if !viewPortHandler.isInBoundsY(rect.origin.y)
                                || !viewPortHandler.isInBoundsLeft(x) {
                                continue
                            }

                            if dataSet.isDrawValuesEnabled {
                                drawValue(
                                    context: context,
                                    value: formatter.stringForValue(
                                        e.y,
                                        entry: e,
                                        dataSetIndex: dataSetIndex,
                                        viewPortHandler: viewPortHandler),
                                    xPos: x,
                                    yPos: rect.origin.y +
                                        (e.y >= 0 ? posOffset : negOffset),
                                    font: valueFont,
                                    align: .center,
                                    color: dataSet.valueTextColorAt(index))
                            }

                            if let icon = e.icon, dataSet.isDrawIconsEnabled {
                                var px = x
                                var py = rect.origin.y +
                                    (e.y >= 0 ? posOffset : negOffset)

                                px += iconsOffset.x
                                py += iconsOffset.y

                                ChartUtils.drawImage(
                                    context: context,
                                    image: icon,
                                    x: px,
                                    y: py,
                                    size: icon.size)
                            }
                        } else {
                            // draw stack values

                            let vals = vals!
                            var transformed = [CGPoint]()

                            var posY = 0.0
                            var negY = -e.negativeSum

                            for k in 0 ..< vals.count {
                                let value = vals[k]
                                var y: Double

                                if value == 0.0 && (posY == 0.0 || negY == 0.0) {
                                    // Take care of the situation of a 0.0 value, which overlaps a non-zero bar
                                    y = value
                                } else if value >= 0.0 {
                                    posY += value
                                    y = posY
                                } else {
                                    y = negY
                                    negY -= value
                                }

                                transformed.append(CGPoint(x: 0.0, y: CGFloat(y * phaseY)))
                            }

                            trans.pointValuesToPixel(&transformed)

                            for k in 0 ..< transformed.count {
                                let val = vals[k]
                                let drawBelow = (val == 0.0 && negY == 0.0 && posY > 0.0) || val < 0.0
                                let y = transformed[k].y + (drawBelow ? negOffset : posOffset)

                                if !viewPortHandler.isInBoundsRight(x) {
                                    break
                                }

                                if !viewPortHandler.isInBoundsY(y) || !viewPortHandler.isInBoundsLeft(x) {
                                    continue
                                }

                                if dataSet.isDrawValuesEnabled {
                                    drawValue(
                                        context: context,
                                        value: formatter.stringForValue(
                                            vals[k],
                                            entry: e,
                                            dataSetIndex: dataSetIndex,
                                            viewPortHandler: viewPortHandler),
                                        xPos: x,
                                        yPos: y,
                                        font: valueFont,
                                        align: .center,
                                        color: dataSet.valueTextColorAt(index))
                                }

                                if let icon = e.icon, dataSet.isDrawIconsEnabled {
                                    ChartUtils.drawImage(
                                        context: context,
                                        image: icon,
                                        x: x + iconsOffset.x,
                                        y: y + iconsOffset.y,
                                        size: icon.size)
                                }
                            }
                        }

                        bufferIndex = vals == nil ? (bufferIndex + 1) : (bufferIndex + vals!.count)
                    }
                }
            }
        }
    }
}
