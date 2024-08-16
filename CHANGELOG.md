# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0] - 2024-08-16

### Changed

- Upgrade flext to version 1.1.0.

## [3.0.0] - 2024-08-05

### Changed

- Generalize `SuperBlocState` to `SuperBlocState<Error>` (#24).

## [2.5.1] - 2024-07-30

### Changed

- Downgrade `rxdart` to version `^0.27.5`.

## [2.5.0] - 2024-07-16

### Changed

- Add `shortenIfNotAlready` and `toUuidIfNotAlready` to `UuidShortener` (#22).

## [2.4.0] - 2024-07-15

### Added

- `NoTransitionsBuilder` (#20).
- Export `path` package.

## [2.3.0] - 2024-07-07

### Added

- `UuidShortener` utility class.
- some web stuff from wayt_web_biz.

## [2.2.1] - 2024-07-06

### Changed

- repositories (#17).

## [2.2.0] - 2024-07-05

### Changed

- ref: simplify repo and data source into mixins and abstract classes (#16)

## [2.1.0] - 2024-07-01

### Added

- `Entity`- a common parent for entities (#12).

## [2.0.1] - 2024-06-29

### Changed

- Updated the_umpteenth_logger to version 1.0.0.

## [2.0.0] - 2024-06-29

### Removed

- ISAR dependency and files related to it (#10).
