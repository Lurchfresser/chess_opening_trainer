// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$randomTrainingSessionManagerHash() =>
    r'f0537090450dc15e4746989f2788efbf6401a884';

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

abstract class _$RandomTrainingSessionManager
    extends BuildlessAutoDisposeNotifier<bishop.Game> {
  late final bool forWhite;
  late final int numberOfPositions;

  bishop.Game build(
    bool forWhite,
    int numberOfPositions,
  );
}

/// See also [RandomTrainingSessionManager].
@ProviderFor(RandomTrainingSessionManager)
const randomTrainingSessionManagerProvider =
    RandomTrainingSessionManagerFamily();

/// See also [RandomTrainingSessionManager].
class RandomTrainingSessionManagerFamily extends Family<bishop.Game> {
  /// See also [RandomTrainingSessionManager].
  const RandomTrainingSessionManagerFamily();

  /// See also [RandomTrainingSessionManager].
  RandomTrainingSessionManagerProvider call(
    bool forWhite,
    int numberOfPositions,
  ) {
    return RandomTrainingSessionManagerProvider(
      forWhite,
      numberOfPositions,
    );
  }

  @override
  RandomTrainingSessionManagerProvider getProviderOverride(
    covariant RandomTrainingSessionManagerProvider provider,
  ) {
    return call(
      provider.forWhite,
      provider.numberOfPositions,
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
  String? get name => r'randomTrainingSessionManagerProvider';
}

/// See also [RandomTrainingSessionManager].
class RandomTrainingSessionManagerProvider
    extends AutoDisposeNotifierProviderImpl<RandomTrainingSessionManager,
        bishop.Game> {
  /// See also [RandomTrainingSessionManager].
  RandomTrainingSessionManagerProvider(
    bool forWhite,
    int numberOfPositions,
  ) : this._internal(
          () => RandomTrainingSessionManager()
            ..forWhite = forWhite
            ..numberOfPositions = numberOfPositions,
          from: randomTrainingSessionManagerProvider,
          name: r'randomTrainingSessionManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$randomTrainingSessionManagerHash,
          dependencies: RandomTrainingSessionManagerFamily._dependencies,
          allTransitiveDependencies:
              RandomTrainingSessionManagerFamily._allTransitiveDependencies,
          forWhite: forWhite,
          numberOfPositions: numberOfPositions,
        );

  RandomTrainingSessionManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forWhite,
    required this.numberOfPositions,
  }) : super.internal();

  final bool forWhite;
  final int numberOfPositions;

  @override
  bishop.Game runNotifierBuild(
    covariant RandomTrainingSessionManager notifier,
  ) {
    return notifier.build(
      forWhite,
      numberOfPositions,
    );
  }

  @override
  Override overrideWith(RandomTrainingSessionManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RandomTrainingSessionManagerProvider._internal(
        () => create()
          ..forWhite = forWhite
          ..numberOfPositions = numberOfPositions,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forWhite: forWhite,
        numberOfPositions: numberOfPositions,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RandomTrainingSessionManager, bishop.Game>
      createElement() {
    return _RandomTrainingSessionManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RandomTrainingSessionManagerProvider &&
        other.forWhite == forWhite &&
        other.numberOfPositions == numberOfPositions;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forWhite.hashCode);
    hash = _SystemHash.combine(hash, numberOfPositions.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RandomTrainingSessionManagerRef
    on AutoDisposeNotifierProviderRef<bishop.Game> {
  /// The parameter `forWhite` of this provider.
  bool get forWhite;

  /// The parameter `numberOfPositions` of this provider.
  int get numberOfPositions;
}

class _RandomTrainingSessionManagerProviderElement
    extends AutoDisposeNotifierProviderElement<RandomTrainingSessionManager,
        bishop.Game> with RandomTrainingSessionManagerRef {
  _RandomTrainingSessionManagerProviderElement(super.provider);

  @override
  bool get forWhite =>
      (origin as RandomTrainingSessionManagerProvider).forWhite;
  @override
  int get numberOfPositions =>
      (origin as RandomTrainingSessionManagerProvider).numberOfPositions;
}

String _$recursiveTrainingSessionManagerHash() =>
    r'babd0520da556c6cefa1fa119f4070429db5c6a4';

abstract class _$RecursiveTrainingSessionManager
    extends BuildlessAutoDisposeNotifier<bishop.Game> {
  late final bool forWhite;

  bishop.Game build(
    bool forWhite,
  );
}

/// See also [RecursiveTrainingSessionManager].
@ProviderFor(RecursiveTrainingSessionManager)
const recursiveTrainingSessionManagerProvider =
    RecursiveTrainingSessionManagerFamily();

/// See also [RecursiveTrainingSessionManager].
class RecursiveTrainingSessionManagerFamily extends Family<bishop.Game> {
  /// See also [RecursiveTrainingSessionManager].
  const RecursiveTrainingSessionManagerFamily();

  /// See also [RecursiveTrainingSessionManager].
  RecursiveTrainingSessionManagerProvider call(
    bool forWhite,
  ) {
    return RecursiveTrainingSessionManagerProvider(
      forWhite,
    );
  }

  @override
  RecursiveTrainingSessionManagerProvider getProviderOverride(
    covariant RecursiveTrainingSessionManagerProvider provider,
  ) {
    return call(
      provider.forWhite,
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
  String? get name => r'recursiveTrainingSessionManagerProvider';
}

/// See also [RecursiveTrainingSessionManager].
class RecursiveTrainingSessionManagerProvider
    extends AutoDisposeNotifierProviderImpl<RecursiveTrainingSessionManager,
        bishop.Game> {
  /// See also [RecursiveTrainingSessionManager].
  RecursiveTrainingSessionManagerProvider(
    bool forWhite,
  ) : this._internal(
          () => RecursiveTrainingSessionManager()..forWhite = forWhite,
          from: recursiveTrainingSessionManagerProvider,
          name: r'recursiveTrainingSessionManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recursiveTrainingSessionManagerHash,
          dependencies: RecursiveTrainingSessionManagerFamily._dependencies,
          allTransitiveDependencies:
              RecursiveTrainingSessionManagerFamily._allTransitiveDependencies,
          forWhite: forWhite,
        );

  RecursiveTrainingSessionManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forWhite,
  }) : super.internal();

  final bool forWhite;

  @override
  bishop.Game runNotifierBuild(
    covariant RecursiveTrainingSessionManager notifier,
  ) {
    return notifier.build(
      forWhite,
    );
  }

  @override
  Override overrideWith(RecursiveTrainingSessionManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecursiveTrainingSessionManagerProvider._internal(
        () => create()..forWhite = forWhite,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forWhite: forWhite,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RecursiveTrainingSessionManager,
      bishop.Game> createElement() {
    return _RecursiveTrainingSessionManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecursiveTrainingSessionManagerProvider &&
        other.forWhite == forWhite;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forWhite.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecursiveTrainingSessionManagerRef
    on AutoDisposeNotifierProviderRef<bishop.Game> {
  /// The parameter `forWhite` of this provider.
  bool get forWhite;
}

class _RecursiveTrainingSessionManagerProviderElement
    extends AutoDisposeNotifierProviderElement<RecursiveTrainingSessionManager,
        bishop.Game> with RecursiveTrainingSessionManagerRef {
  _RecursiveTrainingSessionManagerProviderElement(super.provider);

  @override
  bool get forWhite =>
      (origin as RecursiveTrainingSessionManagerProvider).forWhite;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
