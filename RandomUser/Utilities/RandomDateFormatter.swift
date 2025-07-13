import Foundation

final class RandomDateFormatter: ObservableObject {

    func formattedDate(from iso8601DateString: String) -> String {
        guard let date = iso8601Date(from: iso8601DateString) else {
            return ""
        }

        return stringDate(from: date)
    }

    private func iso8601Date(from string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = formatter.date(from: string) else {
            return nil
        }

        return date
    }

    private func stringDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

}
