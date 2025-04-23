// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$guessHash() => r'529166b6fe9d9ebbf3623581438bf785b57d50c7';

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

/// See also [guess].
@ProviderFor(guess)
const guessProvider = GuessFamily();

/// See also [guess].
class GuessFamily extends Family<GuessResult> {
  /// See also [guess].
  const GuessFamily();

  /// See also [guess].
  GuessProvider call({
    required String fen,
    required String algebraic,
    required String repoName,
  }) {
    return GuessProvider(
      fen: fen,
      algebraic: algebraic,
      repoName: repoName,
    );
  }

  @override
  GuessProvider getProviderOverride(
    covariant GuessProvider provider,
  ) {
    return call(
      fen: provider.fen,
      algebraic: provider.algebraic,
      repoName: provider.repoName,
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
  String? get name => r'guessProvider';
}

/// See also [guess].
class GuessProvider extends AutoDisposeProvider<GuessResult> {
  /// See also [guess].
  GuessProvider({
    required String fen,
    required String algebraic,
    required String repoName,
  }) : this._internal(
          (ref) => guess(
            ref as GuessRef,
            fen: fen,
            algebraic: algebraic,
            repoName: repoName,
          ),
          from: guessProvider,
          name: r'guessProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$guessHash,
          dependencies: GuessFamily._dependencies,
          allTransitiveDependencies: GuessFamily._allTransitiveDependencies,
          fen: fen,
          algebraic: algebraic,
          repoName: repoName,
        );

  GuessProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fen,
    required this.algebraic,
    required this.repoName,
  }) : super.internal();

  final String fen;
  final String algebraic;
  final String repoName;

  @override
  Override overrideWith(
    GuessResult Function(GuessRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GuessProvider._internal(
        (ref) => create(ref as GuessRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fen: fen,
        algebraic: algebraic,
        repoName: repoName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GuessResult> createElement() {
    return _GuessProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GuessProvider &&
        other.fen == fen &&
        other.algebraic == algebraic &&
        other.repoName == repoName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fen.hashCode);
    hash = _SystemHash.combine(hash, algebraic.hashCode);
    hash = _SystemHash.combine(hash, repoName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GuessRef on AutoDisposeProviderRef<GuessResult> {
  /// The parameter `fen` of this provider.
  String get fen;

  /// The parameter `algebraic` of this provider.
  String get algebraic;

  /// The parameter `repoName` of this provider.
  String get repoName;
}

class _GuessProviderElement extends AutoDisposeProviderElement<GuessResult>
    with GuessRef {
  _GuessProviderElement(super.provider);

  @override
  String get fen => (origin as GuessProvider).fen;
  @override
  String get algebraic => (origin as GuessProvider).algebraic;
  @override
  String get repoName => (origin as GuessProvider).repoName;
}

String _$addOpeningTillHereHash() =>
    r'68013279dc554211faf669e0fc999c92f726d5a3';

/// See also [addOpeningTillHere].
@ProviderFor(addOpeningTillHere)
const addOpeningTillHereProvider = AddOpeningTillHereFamily();

/// See also [addOpeningTillHere].
class AddOpeningTillHereFamily extends Family<void> {
  /// See also [addOpeningTillHere].
  const AddOpeningTillHereFamily();

  /// See also [addOpeningTillHere].
  AddOpeningTillHereProvider call({
    required Game game,
    required String comment,
    required bool forWhite,
  }) {
    return AddOpeningTillHereProvider(
      game: game,
      comment: comment,
      forWhite: forWhite,
    );
  }

  @override
  AddOpeningTillHereProvider getProviderOverride(
    covariant AddOpeningTillHereProvider provider,
  ) {
    return call(
      game: provider.game,
      comment: provider.comment,
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
  String? get name => r'addOpeningTillHereProvider';
}

/// See also [addOpeningTillHere].
class AddOpeningTillHereProvider extends AutoDisposeProvider<void> {
  /// See also [addOpeningTillHere].
  AddOpeningTillHereProvider({
    required Game game,
    required String comment,
    required bool forWhite,
  }) : this._internal(
          (ref) => addOpeningTillHere(
            ref as AddOpeningTillHereRef,
            game: game,
            comment: comment,
            forWhite: forWhite,
          ),
          from: addOpeningTillHereProvider,
          name: r'addOpeningTillHereProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addOpeningTillHereHash,
          dependencies: AddOpeningTillHereFamily._dependencies,
          allTransitiveDependencies:
              AddOpeningTillHereFamily._allTransitiveDependencies,
          game: game,
          comment: comment,
          forWhite: forWhite,
        );

  AddOpeningTillHereProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.game,
    required this.comment,
    required this.forWhite,
  }) : super.internal();

  final Game game;
  final String comment;
  final bool forWhite;

  @override
  Override overrideWith(
    void Function(AddOpeningTillHereRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddOpeningTillHereProvider._internal(
        (ref) => create(ref as AddOpeningTillHereRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        game: game,
        comment: comment,
        forWhite: forWhite,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _AddOpeningTillHereProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddOpeningTillHereProvider &&
        other.game == game &&
        other.comment == comment &&
        other.forWhite == forWhite;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, game.hashCode);
    hash = _SystemHash.combine(hash, comment.hashCode);
    hash = _SystemHash.combine(hash, forWhite.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddOpeningTillHereRef on AutoDisposeProviderRef<void> {
  /// The parameter `game` of this provider.
  Game get game;

  /// The parameter `comment` of this provider.
  String get comment;

  /// The parameter `forWhite` of this provider.
  bool get forWhite;
}

class _AddOpeningTillHereProviderElement
    extends AutoDisposeProviderElement<void> with AddOpeningTillHereRef {
  _AddOpeningTillHereProviderElement(super.provider);

  @override
  Game get game => (origin as AddOpeningTillHereProvider).game;
  @override
  String get comment => (origin as AddOpeningTillHereProvider).comment;
  @override
  bool get forWhite => (origin as AddOpeningTillHereProvider).forWhite;
}

String _$duePositionsHash() => r'01a0e566898a1b32343a1f73b8624fbece2af69c';

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

String _$savedMovesHash() => r'900ed29c8d4a8fba4d73956a8c9676e3d3ae6284';

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
    required String repoName,
  }) {
    return SavedMovesProvider(
      fen: fen,
      repoName: repoName,
    );
  }

  @override
  SavedMovesProvider getProviderOverride(
    covariant SavedMovesProvider provider,
  ) {
    return call(
      fen: provider.fen,
      repoName: provider.repoName,
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
    required String repoName,
  }) : this._internal(
          (ref) => savedMoves(
            ref as SavedMovesRef,
            fen: fen,
            repoName: repoName,
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
          repoName: repoName,
        );

  SavedMovesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fen,
    required this.repoName,
  }) : super.internal();

  final String fen;
  final String repoName;

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
        repoName: repoName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<PositionMove>> createElement() {
    return _SavedMovesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavedMovesProvider &&
        other.fen == fen &&
        other.repoName == repoName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fen.hashCode);
    hash = _SystemHash.combine(hash, repoName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SavedMovesRef on AutoDisposeProviderRef<List<PositionMove>> {
  /// The parameter `fen` of this provider.
  String get fen;

  /// The parameter `repoName` of this provider.
  String get repoName;
}

class _SavedMovesProviderElement
    extends AutoDisposeProviderElement<List<PositionMove>> with SavedMovesRef {
  _SavedMovesProviderElement(super.provider);

  @override
  String get fen => (origin as SavedMovesProvider).fen;
  @override
  String get repoName => (origin as SavedMovesProvider).repoName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
