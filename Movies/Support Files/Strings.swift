// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length
internal enum Localization {
  /// Add Movie
  internal static let addMovieTitle = Localization.tr("Localizable", "ADD_MOVIE_TITLE")
  /// Auto Play
  internal static let autoPlay = Localization.tr("Localizable", "AUTO_PLAY")
  /// Cancel
  internal static let cancel = Localization.tr("Localizable", "CANCEL")
  /// Categories
  internal static let categories = Localization.tr("Localizable", "CATEGORIES")
  /// Dark Mode
  internal static let darkMode = Localization.tr("Localizable", "DARK_MODE")
  /// Description
  internal static let description = Localization.tr("Localizable", "DESCRIPTION")
  /// Duration
  internal static let duration = Localization.tr("Localizable", "DURATION")
  /// Edit
  internal static let edit = Localization.tr("Localizable", "EDIT")
  /// Edit Movie
  internal static let editMovieTitle = Localization.tr("Localizable", "EDIT_MOVIE_TITLE")
  /// Genre
  internal static let genre = Localization.tr("Localizable", "GENRE")
  /// Genre already exists
  internal static let genreExists = Localization.tr("Localizable", "GENRE_EXISTS")
  /// Genres
  internal static let genresTitle = Localization.tr("Localizable", "GENRES_TITLE")
  /// Image
  internal static let image = Localization.tr("Localizable", "IMAGE")
  /// Movies
  internal static let moviesTitle = Localization.tr("Localizable", "MOVIES_TITLE")
  /// Name
  internal static let name = Localization.tr("Localizable", "NAME")
  /// Type in a new gender name
  internal static let newGenreText = Localization.tr("Localizable", "NEW_GENRE_TEXT")
  /// No movies found.
  internal static let noMovies = Localization.tr("Localizable", "NO_MOVIES")
  /// No trailer found
  internal static let noTrailer = Localization.tr("Localizable", "NO_TRAILER")
  /// Ok
  internal static let ok = Localization.tr("Localizable", "OK")
  /// Rating
  internal static let rating = Localization.tr("Localizable", "RATING")
  /// Save
  internal static let save = Localization.tr("Localizable", "SAVE")
  /// Select
  internal static let select = Localization.tr("Localizable", "SELECT")
  /// Select Image
  internal static let selectImage = Localization.tr("Localizable", "SELECT_IMAGE")
  /// Settings
  internal static let settingsTitle = Localization.tr("Localizable", "SETTINGS_TITLE")
  /// Title
  internal static let title = Localization.tr("Localizable", "TITLE")
  /// Warning
  internal static let warning = Localization.tr("Localizable", "WARNING")
}
// swiftlint:enable identifier_name line_length type_body_length

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
