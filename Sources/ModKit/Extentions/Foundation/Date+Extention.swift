//
//  Date+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Foundation

extension Date {

    /// Checks if the date is today.
    /// - Returns: `true` if the date is today, else `false`.
    public var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Formats the date to a string using the given format.
    /// - Parameter format: The date format string (e.g., "yyyy-MM-dd").
    /// - Returns: A formatted date string.
    public func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    /// The day component of the date.
    /// - Returns: The day as an integer (1...31).
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    /// The month component of the date.
    /// - Returns: The month as an integer (1...12).
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    /// The year component of the date.
    /// - Returns: The year as an integer.
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    // Calculate time difference as readable string
    public func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [
            .second, .minute, .hour, .day, .weekOfYear, .month, .year,
        ]
        let components = (calendar as NSCalendar).components(
            unitFlags,
            from: self,
            to: now,
            options: []
        )

        if let year = components.year, year >= 1 {
            return year == 1 ? "1 year ago" : "\(year) years ago"
        }

        if let month = components.month, month >= 1 {
            return month == 1 ? "1 month ago" : "\(month) months ago"
        }

        if let week = components.weekOfYear, week >= 1 {
            return week == 1 ? "1 week ago" : "\(week) weeks ago"
        }

        if let day = components.day, day >= 1 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        }

        if let hour = components.hour, hour >= 1 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        }

        if let minute = components.minute, minute >= 1 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        }

        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }

        return "Just now"
    }
}
