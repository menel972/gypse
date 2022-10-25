/// Different login status of the [User]
enum LoginState { uninitialized, loading, unauthenticated, authenticated }

/// Supported languages
enum Locales { fr, en, es }

/// Defines the number of choice to answer
enum Level { easy, medium, hard }

/// Defines the time to answer
enum Time { easy, medium, hard }

/// Defines wich changes to apply
enum UserChangeCode { settings, questions, status }

/// Defines the type on an error
enum ErrorCode { routing, network, exception, email, questions }
