//  extCommentCommand.swift
//  ExtXcode8
//

import Foundation
import XcodeKit

class extCommentsCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        var lines      = invocation.buffer.lines
        let selections = invocation.buffer.selections

        for selection in selections {
            if let textRange = selection as? XCSourceTextRange, textRange.start.line != lines.count {
                if textRange.start.line == textRange.end.line {
                    let lineIndex = textRange.start.line
                    let line      = lines[lineIndex] as! String
                    lines.replaceObject(at: lineIndex, with: select(aLine: line))
                }else {
                    lines = select(lines: lines, inRange: textRange.start.line...textRange.end.line)
                }
            }
        }

        completionHandler(nil)
    }

    /// 选中了多行要注释的字符串
    ///
    /// - parameter lines: 多行字符串范围
    /// - parameter inRange: 要注释的字符串所在的数组
    ///
    /// - returns: 注释后的字符串所在的数组
    func select(lines:NSMutableArray, inRange range:ClosedRange<Int>) -> NSMutableArray {
        let startComment = "/*"
        let endComment = "*/"
        
        let count = lines.count
        let lowBound = range.lowerBound
        let upBound = range.upperBound + 1
        if lowBound >= 0 && lowBound < count && upBound <= count {
            var line = lines[lowBound] as! String
            var charIndex = line.startIndex
            while line[charIndex] == " " {
                charIndex = line.index(after: charIndex)
            }
            var spacesStr  = line.substring(to: charIndex)
            let preStr = spacesStr + startComment
            
            line = lines[upBound - 1] as! String
            charIndex = line.startIndex
            while line[charIndex] == " " {
                charIndex = line.index(after: charIndex)
            }
            spacesStr  = line.substring(to: charIndex)
            let endStr = spacesStr + endComment
            
            lines.insert(endStr, at: upBound)
            lines.insert(preStr, at: lowBound)
        }
        return lines
    }

    /// 选中了一行要注释的字符串
    ///
    /// - parameter aLine: 要注释的字符串
    ///
    /// - returns: 注释后的字符串
    func select(aLine string:String) -> String {
        var line = string
        let startComment = "/* "
        let endComment = " */"
        let newLineStr: Character = "\n"
        let spaceStr: Character = " "
        var charIndex = line.startIndex

        while line[charIndex] == spaceStr {
            charIndex = line.index(after: charIndex)
        }
        
        let currentChar = line[charIndex]
        let spacesStr  = line.substring(to: charIndex)
        
        var newLine = line.substring(from: charIndex)
        var endIndex = newLine.endIndex
        var endChar = newLine[newLine.index(before: endIndex)]
        while endChar == spaceStr || endChar == newLineStr {
            endIndex = newLine.index(before: endIndex)
            endChar = newLine[newLine.index(before: endIndex)]
        }
        newLine = newLine.substring(to: endIndex)
        
        if currentChar == newLineStr {
            line = spacesStr + startComment + newLine + endComment
        } else {
            let isPreComment = newLine.hasPrefix(startComment)
            let isEndComment = newLine.hasSuffix(endComment)
            if isPreComment && isEndComment {
                newLine = line
                newLine = newLine.replacingOccurrences(of: startComment, with: "")
                newLine = newLine.replacingOccurrences(of: endComment, with: "")
                line = newLine
            } else if !isPreComment && !isEndComment {
                line = spacesStr + startComment + newLine + endComment
            }
        }

        return line
    }

}


