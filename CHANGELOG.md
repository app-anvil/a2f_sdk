# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [7.3.1] - 2025-04-12

### Added

- Add `RepositoryV2Event` and `RepositoryV2State`.

## [7.3.0] - 2025-04-12

### Added

- Add `RepositoryV2`.

## [7.2.0] - 2025-03-23

### Changed

- Import only `flext_core` and not the whole `flext` package.

## [7.1.0] - 2025-03-23

### Removed

- Remove `flutter_bloc`, `path` and `path_provider` dependencies.

## [7.0.0] - 2024-12-30

### Added

- Added `Entity` interface.

### Changed

- [BREAKING!] `Model` now implements `Entity` interface.

## [6.0.0] - 2024-12-29

### Changed

- Upgrade the_umpteenth_logger to version 1.1.0.

## [5.3.0] - 2024-09-15

### Added

- Add `ResourceEntity` and `UniquelyIdentifiableEntity`.

## [5.2.1] - 2024-09-14

### Fixed

- `Model.toString` was returning the representation of `EquatableMixin` instead of the one of `ModelToStringMixin`.

## [5.2.0] - 2024-09-01

### Added

- Add `orElse` parameter to `Cache.get`.

## [5.1.0] - 2024-08-29

### Added

- Add `Json` typedef for `Map<String, dynamic>`.

## [5.0.0] - 2024-08-28

### Added

- Add `keys`, `values`, `entries`, and `immutable` getters to `Cache`.
- Add `deleteAll` and `replaceAll` methods to `Cache`.
- Add useful constructors to `Cache`.
- Add `ImmutableCache` class.

### Changed

- Change `items` getter to `values` in `Cache`.

## [4.0.1] - 2024-08-19

### Changed

- Set `one_member_abstracts: false` in `analysis_options.yaml`.

## [4.0.0] - 2024-08-17

### Removed

- Remove external package exports.

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
