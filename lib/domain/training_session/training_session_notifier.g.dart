// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$duePositionsHash() => r'0e627a8902299887f046aa232b4499cacc736a2a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [duePositions].
@ProviderFor(duePositions)
const duePositionsProvider = DuePositionsFamily();

/// See also [duePositions].
class DuePositionsFamily extends Family<List<ChessPosition>> {
  /// See also [duePositions].
  const DuePositionsFamily();

  /// See also [duePositions].
  DuePositionsProvider call({
    required int numberOfPositions,
    required bool forWhite,
  }) {
    return DuePositionsProvider(
      numberOfPositions: numberOfPositions,
      forWhite: forWhite,
    );
  }

  @override
  DuePositionsProvider getProviderOverride(
    covariant DuePositionsProvider provider,
  ) {
    return call(
      numberOfPositions: provider.numberOfPositions,
      forWhite: provider.forWhite,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'duePositionsProvider';
}

/// See also [duePositions].
class DuePositionsProvider extends AutoDisposeProvider<List<ChessPosition>> {
  /// See also [duePositions].
  DuePositionsProvider({
    required int numberOfPositions,
    required bool forWhite,
  }) : this._internal(
          (ref) => duePositions(
            ref as DuePositionsRef,
            numberOfPositions: numberOfPositions,
            forWhite: forWhite,
          ),
          from: duePositionsProvider,
          name: r'duePositionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$duePositionsHash,
          dependencies: DuePositionsFamily._dependencies,
          allTransitiveDependencies:
              DuePositionsFamily._allTransitiveDependencies,
          numberOfPositions: numberOfPositions,
          forWhite: forWhite,
        );

  DuePositionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.numberOfPositions,
    required this.forWhite,
  }) : super.internal();

  final int numberOfPositions;
  final bool forWhite;

  @override
  Override overrideWith(
    List<ChessPosition> Function(DuePositionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DuePositionsProvider._internal(
        (ref) => create(ref as DuePositionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        numberOfPositions: numberOfPositions,
        forWhite: forWhite,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<ChessPosition>> createElement() {
    return _DuePositionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DuePositionsProvider &&
        other.numberOfPositions == numberOfPositions &&
        other.forWhite == forWhite;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, numberOfPositions.hashCode);
    hash = _SystemHash.combine(hash, forWhite.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DuePositionsRef on AutoDisposeProviderRef<List<ChessPosition>> {
  /// The parameter `numberOfPositions` of this provider.
  int get numberOfPositions;

  /// The parameter `forWhite` of this provider.
  bool get forWhite;
}

class _DuePositionsProviderElement
    extends AutoDisposeProviderElement<List<ChessPosition>>
    with DuePositionsRef {
  _DuePositionsProviderElement(super.provider);

  @override
  int get numberOfPositions =>
      (origin as DuePositionsProvider).numberOfPositions;
  @override
  bool get forWhite => (origin as DuePositionsProvider).forWhite;
}

String _$savedMovesHash() => r'70892dc9e50a2926c0b096b693acab767cfaad89';

/// See also [savedMoves].
@ProviderFor(savedMoves)
const savedMovesProvider = SavedMovesFamily();

/// See also [savedMoves].
class SavedMovesFamily extends Family<List<PositionMove>> {
  /// See also [savedMoves].
  const SavedMovesFamily();

  /// See also [savedMoves].
  SavedMovesProvider call({
    required String fen,
  }) {
    return SavedMovesProvider(
      fen: fen,
    );
  }

  @override
  SavedMovesProvider getProviderOverride(
    covariant SavedMovesProvider provider,
  ) {
    return call(
      fen: provider.fen,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'savedMovesProvider';
}

/// See also [savedMoves].
class SavedMovesProvider extends AutoDisposeProvider<List<PositionMove>> {
  /// See also [savedMoves].
  SavedMovesProvider({
    required String fen,
  }) : this._internal(
          (ref) => savedMoves(
            ref as SavedMovesRef,
            fen: fen,
          ),
          from: savedMovesProvider,
          name: r'savedMovesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$savedMovesHash,
          dependencies: SavedMovesFamily._dependencies,
          allTransitiveDependencies:
              SavedMovesFamily._allTransitiveDependencies,
          fen: fen,
        );

  SavedMovesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fen,
  }) : super.internal();

  final String fen;

  @override
  Override overrideWith(
    List<PositionMove> Function(SavedMovesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SavedMovesProvider._internal(
        (ref) => create(ref as SavedMovesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fen: fen,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PositionMove>> createElement() {
    return _SavedMovesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavedMovesProvider && other.fen == fen;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fen.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SavedMovesRef on AutoDisposeProviderRef<List<PositionMove>> {
  /// The parameter `fen` of this provider.
  String get fen;
}

class _SavedMovesProviderElement
    extends AutoDisposeProviderElement<List<PositionMove>> with SavedMovesRef {
  _SavedMovesProviderElement(super.provider);

  @override
  String get fen => (origin as SavedMovesProvider).fen;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
