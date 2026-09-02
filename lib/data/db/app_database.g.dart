// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Gender, String> gender =
      GeneratedColumn<String>(
        'gender',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Gender>($ProfilesTable.$convertergender);
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
    'birth_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ActivityLevel, String> activity =
      GeneratedColumn<String>(
        'activity',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ActivityLevel>($ProfilesTable.$converteractivity);
  @override
  late final GeneratedColumnWithTypeConverter<DeficitLevel, String> deficit =
      GeneratedColumn<String>(
        'deficit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DeficitLevel>($ProfilesTable.$converterdeficit);
  static const VerificationMeta _proteinRatioMeta = const VerificationMeta(
    'proteinRatio',
  );
  @override
  late final GeneratedColumn<double> proteinRatio = GeneratedColumn<double>(
    'protein_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.25),
  );
  static const VerificationMeta _fatRatioMeta = const VerificationMeta(
    'fatRatio',
  );
  @override
  late final GeneratedColumn<double> fatRatio = GeneratedColumn<double>(
    'fat_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.30),
  );
  static const VerificationMeta _carbRatioMeta = const VerificationMeta(
    'carbRatio',
  );
  @override
  late final GeneratedColumn<double> carbRatio = GeneratedColumn<double>(
    'carb_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.45),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gender,
    birthYear,
    heightCm,
    weightKg,
    activity,
    deficit,
    proteinRatio,
    fatRatio,
    carbRatio,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_birthYearMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('protein_ratio')) {
      context.handle(
        _proteinRatioMeta,
        proteinRatio.isAcceptableOrUnknown(
          data['protein_ratio']!,
          _proteinRatioMeta,
        ),
      );
    }
    if (data.containsKey('fat_ratio')) {
      context.handle(
        _fatRatioMeta,
        fatRatio.isAcceptableOrUnknown(data['fat_ratio']!, _fatRatioMeta),
      );
    }
    if (data.containsKey('carb_ratio')) {
      context.handle(
        _carbRatioMeta,
        carbRatio.isAcceptableOrUnknown(data['carb_ratio']!, _carbRatioMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gender: $ProfilesTable.$convertergender.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}gender'],
        )!,
      ),
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_year'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      activity: $ProfilesTable.$converteractivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}activity'],
        )!,
      ),
      deficit: $ProfilesTable.$converterdeficit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}deficit'],
        )!,
      ),
      proteinRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_ratio'],
      )!,
      fatRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_ratio'],
      )!,
      carbRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb_ratio'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, String, String> $convertergender =
      const EnumNameConverter<Gender>(Gender.values);
  static JsonTypeConverter2<ActivityLevel, String, String> $converteractivity =
      const EnumNameConverter<ActivityLevel>(ActivityLevel.values);
  static JsonTypeConverter2<DeficitLevel, String, String> $converterdeficit =
      const EnumNameConverter<DeficitLevel>(DeficitLevel.values);
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final Gender gender;
  final int birthYear;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activity;
  final DeficitLevel deficit;
  final double proteinRatio;
  final double fatRatio;
  final double carbRatio;
  final DateTime updatedAt;
  const Profile({
    required this.id,
    required this.gender,
    required this.birthYear,
    required this.heightCm,
    required this.weightKg,
    required this.activity,
    required this.deficit,
    required this.proteinRatio,
    required this.fatRatio,
    required this.carbRatio,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['gender'] = Variable<String>(
        $ProfilesTable.$convertergender.toSql(gender),
      );
    }
    map['birth_year'] = Variable<int>(birthYear);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    {
      map['activity'] = Variable<String>(
        $ProfilesTable.$converteractivity.toSql(activity),
      );
    }
    {
      map['deficit'] = Variable<String>(
        $ProfilesTable.$converterdeficit.toSql(deficit),
      );
    }
    map['protein_ratio'] = Variable<double>(proteinRatio);
    map['fat_ratio'] = Variable<double>(fatRatio);
    map['carb_ratio'] = Variable<double>(carbRatio);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      gender: Value(gender),
      birthYear: Value(birthYear),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      activity: Value(activity),
      deficit: Value(deficit),
      proteinRatio: Value(proteinRatio),
      fatRatio: Value(fatRatio),
      carbRatio: Value(carbRatio),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      gender: $ProfilesTable.$convertergender.fromJson(
        serializer.fromJson<String>(json['gender']),
      ),
      birthYear: serializer.fromJson<int>(json['birthYear']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      activity: $ProfilesTable.$converteractivity.fromJson(
        serializer.fromJson<String>(json['activity']),
      ),
      deficit: $ProfilesTable.$converterdeficit.fromJson(
        serializer.fromJson<String>(json['deficit']),
      ),
      proteinRatio: serializer.fromJson<double>(json['proteinRatio']),
      fatRatio: serializer.fromJson<double>(json['fatRatio']),
      carbRatio: serializer.fromJson<double>(json['carbRatio']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gender': serializer.toJson<String>(
        $ProfilesTable.$convertergender.toJson(gender),
      ),
      'birthYear': serializer.toJson<int>(birthYear),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'activity': serializer.toJson<String>(
        $ProfilesTable.$converteractivity.toJson(activity),
      ),
      'deficit': serializer.toJson<String>(
        $ProfilesTable.$converterdeficit.toJson(deficit),
      ),
      'proteinRatio': serializer.toJson<double>(proteinRatio),
      'fatRatio': serializer.toJson<double>(fatRatio),
      'carbRatio': serializer.toJson<double>(carbRatio),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith({
    int? id,
    Gender? gender,
    int? birthYear,
    double? heightCm,
    double? weightKg,
    ActivityLevel? activity,
    DeficitLevel? deficit,
    double? proteinRatio,
    double? fatRatio,
    double? carbRatio,
    DateTime? updatedAt,
  }) => Profile(
    id: id ?? this.id,
    gender: gender ?? this.gender,
    birthYear: birthYear ?? this.birthYear,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    activity: activity ?? this.activity,
    deficit: deficit ?? this.deficit,
    proteinRatio: proteinRatio ?? this.proteinRatio,
    fatRatio: fatRatio ?? this.fatRatio,
    carbRatio: carbRatio ?? this.carbRatio,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      activity: data.activity.present ? data.activity.value : this.activity,
      deficit: data.deficit.present ? data.deficit.value : this.deficit,
      proteinRatio: data.proteinRatio.present
          ? data.proteinRatio.value
          : this.proteinRatio,
      fatRatio: data.fatRatio.present ? data.fatRatio.value : this.fatRatio,
      carbRatio: data.carbRatio.present ? data.carbRatio.value : this.carbRatio,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('birthYear: $birthYear, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activity: $activity, ')
          ..write('deficit: $deficit, ')
          ..write('proteinRatio: $proteinRatio, ')
          ..write('fatRatio: $fatRatio, ')
          ..write('carbRatio: $carbRatio, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gender,
    birthYear,
    heightCm,
    weightKg,
    activity,
    deficit,
    proteinRatio,
    fatRatio,
    carbRatio,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.birthYear == this.birthYear &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.activity == this.activity &&
          other.deficit == this.deficit &&
          other.proteinRatio == this.proteinRatio &&
          other.fatRatio == this.fatRatio &&
          other.carbRatio == this.carbRatio &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<Gender> gender;
  final Value<int> birthYear;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<ActivityLevel> activity;
  final Value<DeficitLevel> deficit;
  final Value<double> proteinRatio;
  final Value<double> fatRatio;
  final Value<double> carbRatio;
  final Value<DateTime> updatedAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activity = const Value.absent(),
    this.deficit = const Value.absent(),
    this.proteinRatio = const Value.absent(),
    this.fatRatio = const Value.absent(),
    this.carbRatio = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required Gender gender,
    required int birthYear,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activity,
    required DeficitLevel deficit,
    this.proteinRatio = const Value.absent(),
    this.fatRatio = const Value.absent(),
    this.carbRatio = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : gender = Value(gender),
       birthYear = Value(birthYear),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       activity = Value(activity),
       deficit = Value(deficit);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? gender,
    Expression<int>? birthYear,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? activity,
    Expression<String>? deficit,
    Expression<double>? proteinRatio,
    Expression<double>? fatRatio,
    Expression<double>? carbRatio,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (birthYear != null) 'birth_year': birthYear,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (activity != null) 'activity': activity,
      if (deficit != null) 'deficit': deficit,
      if (proteinRatio != null) 'protein_ratio': proteinRatio,
      if (fatRatio != null) 'fat_ratio': fatRatio,
      if (carbRatio != null) 'carb_ratio': carbRatio,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<Gender>? gender,
    Value<int>? birthYear,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<ActivityLevel>? activity,
    Value<DeficitLevel>? deficit,
    Value<double>? proteinRatio,
    Value<double>? fatRatio,
    Value<double>? carbRatio,
    Value<DateTime>? updatedAt,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      birthYear: birthYear ?? this.birthYear,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activity: activity ?? this.activity,
      deficit: deficit ?? this.deficit,
      proteinRatio: proteinRatio ?? this.proteinRatio,
      fatRatio: fatRatio ?? this.fatRatio,
      carbRatio: carbRatio ?? this.carbRatio,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(
        $ProfilesTable.$convertergender.toSql(gender.value),
      );
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(
        $ProfilesTable.$converteractivity.toSql(activity.value),
      );
    }
    if (deficit.present) {
      map['deficit'] = Variable<String>(
        $ProfilesTable.$converterdeficit.toSql(deficit.value),
      );
    }
    if (proteinRatio.present) {
      map['protein_ratio'] = Variable<double>(proteinRatio.value);
    }
    if (fatRatio.present) {
      map['fat_ratio'] = Variable<double>(fatRatio.value);
    }
    if (carbRatio.present) {
      map['carb_ratio'] = Variable<double>(carbRatio.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('birthYear: $birthYear, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activity: $activity, ')
          ..write('deficit: $deficit, ')
          ..write('proteinRatio: $proteinRatio, ')
          ..write('fatRatio: $fatRatio, ')
          ..write('carbRatio: $carbRatio, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcalPer100gMeta = const VerificationMeta(
    'kcalPer100g',
  );
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
    'kcal_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _carbPer100gMeta = const VerificationMeta(
    'carbPer100g',
  );
  @override
  late final GeneratedColumn<double> carbPer100g = GeneratedColumn<double>(
    'carb_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('custom'),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    kcalPer100g,
    proteinPer100g,
    fatPer100g,
    carbPer100g,
    source,
    barcode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(
    Insertable<Food> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
        _kcalPer100gMeta,
        kcalPer100g.isAcceptableOrUnknown(
          data['kcal_per100g']!,
          _kcalPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kcalPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    }
    if (data.containsKey('carb_per100g')) {
      context.handle(
        _carbPer100gMeta,
        carbPer100g.isAcceptableOrUnknown(
          data['carb_per100g']!,
          _carbPer100gMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      kcalPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      carbPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb_per100g'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String name;
  final String? category;
  final double kcalPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbPer100g;
  final String source;
  final String? barcode;
  final DateTime createdAt;
  const Food({
    required this.id,
    required this.name,
    this.category,
    required this.kcalPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
    required this.carbPer100g,
    required this.source,
    this.barcode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['carb_per100g'] = Variable<double>(carbPer100g);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      kcalPer100g: Value(kcalPer100g),
      proteinPer100g: Value(proteinPer100g),
      fatPer100g: Value(fatPer100g),
      carbPer100g: Value(carbPer100g),
      source: Value(source),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      createdAt: Value(createdAt),
    );
  }

  factory Food.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      carbPer100g: serializer.fromJson<double>(json['carbPer100g']),
      source: serializer.fromJson<String>(json['source']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'carbPer100g': serializer.toJson<double>(carbPer100g),
      'source': serializer.toJson<String>(source),
      'barcode': serializer.toJson<String?>(barcode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Food copyWith({
    int? id,
    String? name,
    Value<String?> category = const Value.absent(),
    double? kcalPer100g,
    double? proteinPer100g,
    double? fatPer100g,
    double? carbPer100g,
    String? source,
    Value<String?> barcode = const Value.absent(),
    DateTime? createdAt,
  }) => Food(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    kcalPer100g: kcalPer100g ?? this.kcalPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    carbPer100g: carbPer100g ?? this.carbPer100g,
    source: source ?? this.source,
    barcode: barcode.present ? barcode.value : this.barcode,
    createdAt: createdAt ?? this.createdAt,
  );
  Food copyWithCompanion(FoodsCompanion data) {
    return Food(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      kcalPer100g: data.kcalPer100g.present
          ? data.kcalPer100g.value
          : this.kcalPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      carbPer100g: data.carbPer100g.present
          ? data.carbPer100g.value
          : this.carbPer100g,
      source: data.source.present ? data.source.value : this.source,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbPer100g: $carbPer100g, ')
          ..write('source: $source, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    kcalPer100g,
    proteinPer100g,
    fatPer100g,
    carbPer100g,
    source,
    barcode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.kcalPer100g == this.kcalPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.carbPer100g == this.carbPer100g &&
          other.source == this.source &&
          other.barcode == this.barcode &&
          other.createdAt == this.createdAt);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<double> kcalPer100g;
  final Value<double> proteinPer100g;
  final Value<double> fatPer100g;
  final Value<double> carbPer100g;
  final Value<String> source;
  final Value<String?> barcode;
  final Value<DateTime> createdAt;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.carbPer100g = const Value.absent(),
    this.source = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    required double kcalPer100g,
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.carbPer100g = const Value.absent(),
    this.source = const Value.absent(),
    this.barcode = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       kcalPer100g = Value(kcalPer100g);
  static Insertable<Food> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? kcalPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? carbPer100g,
    Expression<String>? source,
    Expression<String>? barcode,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (carbPer100g != null) 'carb_per100g': carbPer100g,
      if (source != null) 'source': source,
      if (barcode != null) 'barcode': barcode,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? category,
    Value<double>? kcalPer100g,
    Value<double>? proteinPer100g,
    Value<double>? fatPer100g,
    Value<double>? carbPer100g,
    Value<String>? source,
    Value<String?>? barcode,
    Value<DateTime>? createdAt,
  }) {
    return FoodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      carbPer100g: carbPer100g ?? this.carbPer100g,
      source: source ?? this.source,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (carbPer100g.present) {
      map['carb_per100g'] = Variable<double>(carbPer100g.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbPer100g: $carbPer100g, ')
          ..write('source: $source, ')
          ..write('barcode: $barcode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealSlotMeta = const VerificationMeta(
    'mealSlot',
  );
  @override
  late final GeneratedColumn<int> mealSlot = GeneratedColumn<int>(
    'meal_slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
    'food_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES foods (id)',
    ),
  );
  static const VerificationMeta _foodNameMeta = const VerificationMeta(
    'foodName',
  );
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
    'food_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<double> kcal = GeneratedColumn<double>(
    'kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbMeta = const VerificationMeta('carb');
  @override
  late final GeneratedColumn<double> carb = GeneratedColumn<double>(
    'carb',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    mealSlot,
    foodId,
    foodName,
    grams,
    kcal,
    protein,
    fat,
    carb,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_slot')) {
      context.handle(
        _mealSlotMeta,
        mealSlot.isAcceptableOrUnknown(data['meal_slot']!, _mealSlotMeta),
      );
    } else if (isInserting) {
      context.missing(_mealSlotMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    }
    if (data.containsKey('food_name')) {
      context.handle(
        _foodNameMeta,
        foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta),
      );
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('carb')) {
      context.handle(
        _carbMeta,
        carb.isAcceptableOrUnknown(data['carb']!, _carbMeta),
      );
    } else if (isInserting) {
      context.missing(_carbMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mealSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_slot'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_id'],
      ),
      foodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_name'],
      )!,
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal'],
      )!,
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      )!,
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      )!,
      carb: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carb'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }
}

class Entry extends DataClass implements Insertable<Entry> {
  final int id;
  final DateTime date;
  final int mealSlot;
  final int? foodId;
  final String foodName;
  final double grams;
  final double kcal;
  final double protein;
  final double fat;
  final double carb;
  final DateTime createdAt;
  const Entry({
    required this.id,
    required this.date,
    required this.mealSlot,
    this.foodId,
    required this.foodName,
    required this.grams,
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carb,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['meal_slot'] = Variable<int>(mealSlot);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<int>(foodId);
    }
    map['food_name'] = Variable<String>(foodName);
    map['grams'] = Variable<double>(grams);
    map['kcal'] = Variable<double>(kcal);
    map['protein'] = Variable<double>(protein);
    map['fat'] = Variable<double>(fat);
    map['carb'] = Variable<double>(carb);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      date: Value(date),
      mealSlot: Value(mealSlot),
      foodId: foodId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodId),
      foodName: Value(foodName),
      grams: Value(grams),
      kcal: Value(kcal),
      protein: Value(protein),
      fat: Value(fat),
      carb: Value(carb),
      createdAt: Value(createdAt),
    );
  }

  factory Entry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      mealSlot: serializer.fromJson<int>(json['mealSlot']),
      foodId: serializer.fromJson<int?>(json['foodId']),
      foodName: serializer.fromJson<String>(json['foodName']),
      grams: serializer.fromJson<double>(json['grams']),
      kcal: serializer.fromJson<double>(json['kcal']),
      protein: serializer.fromJson<double>(json['protein']),
      fat: serializer.fromJson<double>(json['fat']),
      carb: serializer.fromJson<double>(json['carb']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'mealSlot': serializer.toJson<int>(mealSlot),
      'foodId': serializer.toJson<int?>(foodId),
      'foodName': serializer.toJson<String>(foodName),
      'grams': serializer.toJson<double>(grams),
      'kcal': serializer.toJson<double>(kcal),
      'protein': serializer.toJson<double>(protein),
      'fat': serializer.toJson<double>(fat),
      'carb': serializer.toJson<double>(carb),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Entry copyWith({
    int? id,
    DateTime? date,
    int? mealSlot,
    Value<int?> foodId = const Value.absent(),
    String? foodName,
    double? grams,
    double? kcal,
    double? protein,
    double? fat,
    double? carb,
    DateTime? createdAt,
  }) => Entry(
    id: id ?? this.id,
    date: date ?? this.date,
    mealSlot: mealSlot ?? this.mealSlot,
    foodId: foodId.present ? foodId.value : this.foodId,
    foodName: foodName ?? this.foodName,
    grams: grams ?? this.grams,
    kcal: kcal ?? this.kcal,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    carb: carb ?? this.carb,
    createdAt: createdAt ?? this.createdAt,
  );
  Entry copyWithCompanion(EntriesCompanion data) {
    return Entry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      mealSlot: data.mealSlot.present ? data.mealSlot.value : this.mealSlot,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      grams: data.grams.present ? data.grams.value : this.grams,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      protein: data.protein.present ? data.protein.value : this.protein,
      fat: data.fat.present ? data.fat.value : this.fat,
      carb: data.carb.present ? data.carb.value : this.carb,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('foodId: $foodId, ')
          ..write('foodName: $foodName, ')
          ..write('grams: $grams, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carb: $carb, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    mealSlot,
    foodId,
    foodName,
    grams,
    kcal,
    protein,
    fat,
    carb,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.date == this.date &&
          other.mealSlot == this.mealSlot &&
          other.foodId == this.foodId &&
          other.foodName == this.foodName &&
          other.grams == this.grams &&
          other.kcal == this.kcal &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.carb == this.carb &&
          other.createdAt == this.createdAt);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> mealSlot;
  final Value<int?> foodId;
  final Value<String> foodName;
  final Value<double> grams;
  final Value<double> kcal;
  final Value<double> protein;
  final Value<double> fat;
  final Value<double> carb;
  final Value<DateTime> createdAt;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.foodId = const Value.absent(),
    this.foodName = const Value.absent(),
    this.grams = const Value.absent(),
    this.kcal = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.carb = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int mealSlot,
    this.foodId = const Value.absent(),
    required String foodName,
    required double grams,
    required double kcal,
    required double protein,
    required double fat,
    required double carb,
    this.createdAt = const Value.absent(),
  }) : date = Value(date),
       mealSlot = Value(mealSlot),
       foodName = Value(foodName),
       grams = Value(grams),
       kcal = Value(kcal),
       protein = Value(protein),
       fat = Value(fat),
       carb = Value(carb);
  static Insertable<Entry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? mealSlot,
    Expression<int>? foodId,
    Expression<String>? foodName,
    Expression<double>? grams,
    Expression<double>? kcal,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? carb,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (mealSlot != null) 'meal_slot': mealSlot,
      if (foodId != null) 'food_id': foodId,
      if (foodName != null) 'food_name': foodName,
      if (grams != null) 'grams': grams,
      if (kcal != null) 'kcal': kcal,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (carb != null) 'carb': carb,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? mealSlot,
    Value<int?>? foodId,
    Value<String>? foodName,
    Value<double>? grams,
    Value<double>? kcal,
    Value<double>? protein,
    Value<double>? fat,
    Value<double>? carb,
    Value<DateTime>? createdAt,
  }) {
    return EntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      mealSlot: mealSlot ?? this.mealSlot,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      grams: grams ?? this.grams,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carb: carb ?? this.carb,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mealSlot.present) {
      map['meal_slot'] = Variable<int>(mealSlot.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<double>(kcal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (carb.present) {
      map['carb'] = Variable<double>(carb.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('foodId: $foodId, ')
          ..write('foodName: $foodName, ')
          ..write('grams: $grams, ')
          ..write('kcal: $kcal, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('carb: $carb, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeightLogsTable extends WeightLogs
    with TableInfo<$WeightLogsTable, WeightLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, weightKg, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WeightLogsTable createAlias(String alias) {
    return $WeightLogsTable(attachedDatabase, alias);
  }
}

class WeightLog extends DataClass implements Insertable<WeightLog> {
  final int id;
  final DateTime date;
  final double weightKg;
  final DateTime createdAt;
  const WeightLog({
    required this.id,
    required this.date,
    required this.weightKg,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WeightLogsCompanion toCompanion(bool nullToAbsent) {
    return WeightLogsCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: Value(weightKg),
      createdAt: Value(createdAt),
    );
  }

  factory WeightLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WeightLog copyWith({
    int? id,
    DateTime? date,
    double? weightKg,
    DateTime? createdAt,
  }) => WeightLog(
    id: id ?? this.id,
    date: date ?? this.date,
    weightKg: weightKg ?? this.weightKg,
    createdAt: createdAt ?? this.createdAt,
  );
  WeightLog copyWithCompanion(WeightLogsCompanion data) {
    return WeightLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.createdAt == this.createdAt);
}

class WeightLogsCompanion extends UpdateCompanion<WeightLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> weightKg;
  final Value<DateTime> createdAt;
  const WeightLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WeightLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required double weightKg,
    this.createdAt = const Value.absent(),
  }) : date = Value(date),
       weightKg = Value(weightKg);
  static Insertable<WeightLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? weightKg,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WeightLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<double>? weightKg,
    Value<DateTime>? createdAt,
  }) {
    return WeightLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $WeightLogsTable weightLogs = $WeightLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    foods,
    entries,
    weightLogs,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required Gender gender,
      required int birthYear,
      required double heightCm,
      required double weightKg,
      required ActivityLevel activity,
      required DeficitLevel deficit,
      Value<double> proteinRatio,
      Value<double> fatRatio,
      Value<double> carbRatio,
      Value<DateTime> updatedAt,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<Gender> gender,
      Value<int> birthYear,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<ActivityLevel> activity,
      Value<DeficitLevel> deficit,
      Value<double> proteinRatio,
      Value<double> fatRatio,
      Value<double> carbRatio,
      Value<DateTime> updatedAt,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Gender, Gender, String> get gender =>
      $composableBuilder(
        column: $table.gender,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ActivityLevel, ActivityLevel, String>
  get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DeficitLevel, DeficitLevel, String>
  get deficit => $composableBuilder(
    column: $table.deficit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get proteinRatio => $composableBuilder(
    column: $table.proteinRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatRatio => $composableBuilder(
    column: $table.fatRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbRatio => $composableBuilder(
    column: $table.carbRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deficit => $composableBuilder(
    column: $table.deficit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinRatio => $composableBuilder(
    column: $table.proteinRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatRatio => $composableBuilder(
    column: $table.fatRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbRatio => $composableBuilder(
    column: $table.carbRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Gender, String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ActivityLevel, String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DeficitLevel, String> get deficit =>
      $composableBuilder(column: $table.deficit, builder: (column) => column);

  GeneratedColumn<double> get proteinRatio => $composableBuilder(
    column: $table.proteinRatio,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatRatio =>
      $composableBuilder(column: $table.fatRatio, builder: (column) => column);

  GeneratedColumn<double> get carbRatio =>
      $composableBuilder(column: $table.carbRatio, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Gender> gender = const Value.absent(),
                Value<int> birthYear = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<ActivityLevel> activity = const Value.absent(),
                Value<DeficitLevel> deficit = const Value.absent(),
                Value<double> proteinRatio = const Value.absent(),
                Value<double> fatRatio = const Value.absent(),
                Value<double> carbRatio = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                gender: gender,
                birthYear: birthYear,
                heightCm: heightCm,
                weightKg: weightKg,
                activity: activity,
                deficit: deficit,
                proteinRatio: proteinRatio,
                fatRatio: fatRatio,
                carbRatio: carbRatio,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Gender gender,
                required int birthYear,
                required double heightCm,
                required double weightKg,
                required ActivityLevel activity,
                required DeficitLevel deficit,
                Value<double> proteinRatio = const Value.absent(),
                Value<double> fatRatio = const Value.absent(),
                Value<double> carbRatio = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                gender: gender,
                birthYear: birthYear,
                heightCm: heightCm,
                weightKg: weightKg,
                activity: activity,
                deficit: deficit,
                proteinRatio: proteinRatio,
                fatRatio: fatRatio,
                carbRatio: carbRatio,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;
typedef $$FoodsTableCreateCompanionBuilder =
    FoodsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> category,
      required double kcalPer100g,
      Value<double> proteinPer100g,
      Value<double> fatPer100g,
      Value<double> carbPer100g,
      Value<String> source,
      Value<String?> barcode,
      Value<DateTime> createdAt,
    });
typedef $$FoodsTableUpdateCompanionBuilder =
    FoodsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> category,
      Value<double> kcalPer100g,
      Value<double> proteinPer100g,
      Value<double> fatPer100g,
      Value<double> carbPer100g,
      Value<String> source,
      Value<String?> barcode,
      Value<DateTime> createdAt,
    });

final class $$FoodsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodsTable, Food> {
  $$FoodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntriesTable, List<Entry>> _entriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.entries,
    aliasName: $_aliasNameGenerator(db.foods.id, db.entries.foodId),
  );

  $$EntriesTableProcessedTableManager get entriesRefs {
    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodsTableFilterComposer extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbPer100g => $composableBuilder(
    column: $table.carbPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entriesRefs(
    Expression<bool> Function($$EntriesTableFilterComposer f) f,
  ) {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbPer100g => $composableBuilder(
    column: $table.carbPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbPer100g => $composableBuilder(
    column: $table.carbPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> entriesRefs<T extends Object>(
    Expression<T> Function($$EntriesTableAnnotationComposer a) f,
  ) {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodsTable,
          Food,
          $$FoodsTableFilterComposer,
          $$FoodsTableOrderingComposer,
          $$FoodsTableAnnotationComposer,
          $$FoodsTableCreateCompanionBuilder,
          $$FoodsTableUpdateCompanionBuilder,
          (Food, $$FoodsTableReferences),
          Food,
          PrefetchHooks Function({bool entriesRefs})
        > {
  $$FoodsTableTableManager(_$AppDatabase db, $FoodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double> kcalPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double> carbPer100g = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodsCompanion(
                id: id,
                name: name,
                category: category,
                kcalPer100g: kcalPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbPer100g: carbPer100g,
                source: source,
                barcode: barcode,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> category = const Value.absent(),
                required double kcalPer100g,
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double> carbPer100g = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FoodsCompanion.insert(
                id: id,
                name: name,
                category: category,
                kcalPer100g: kcalPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbPer100g: carbPer100g,
                source: source,
                barcode: barcode,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FoodsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({entriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (entriesRefs) db.entries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entriesRefs)
                    await $_getPrefetchedData<Food, $FoodsTable, Entry>(
                      currentTable: table,
                      referencedTable: $$FoodsTableReferences._entriesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$FoodsTableReferences(db, table, p0).entriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.foodId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FoodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodsTable,
      Food,
      $$FoodsTableFilterComposer,
      $$FoodsTableOrderingComposer,
      $$FoodsTableAnnotationComposer,
      $$FoodsTableCreateCompanionBuilder,
      $$FoodsTableUpdateCompanionBuilder,
      (Food, $$FoodsTableReferences),
      Food,
      PrefetchHooks Function({bool entriesRefs})
    >;
typedef $$EntriesTableCreateCompanionBuilder =
    EntriesCompanion Function({
      Value<int> id,
      required DateTime date,
      required int mealSlot,
      Value<int?> foodId,
      required String foodName,
      required double grams,
      required double kcal,
      required double protein,
      required double fat,
      required double carb,
      Value<DateTime> createdAt,
    });
typedef $$EntriesTableUpdateCompanionBuilder =
    EntriesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> mealSlot,
      Value<int?> foodId,
      Value<String> foodName,
      Value<double> grams,
      Value<double> kcal,
      Value<double> protein,
      Value<double> fat,
      Value<double> carb,
      Value<DateTime> createdAt,
    });

final class $$EntriesTableReferences
    extends BaseReferences<_$AppDatabase, $EntriesTable, Entry> {
  $$EntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods.createAlias(
    $_aliasNameGenerator(db.entries.foodId, db.foods.id),
  );

  $$FoodsTableProcessedTableManager? get foodId {
    final $_column = $_itemColumn<int>('food_id');
    if ($_column == null) return null;
    final manager = $$FoodsTableTableManager(
      $_db,
      $_db.foods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carb => $composableBuilder(
    column: $table.carb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableFilterComposer(
            $db: $db,
            $table: $db.foods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carb => $composableBuilder(
    column: $table.carb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableOrderingComposer(
            $db: $db,
            $table: $db.foods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mealSlot =>
      $composableBuilder(column: $table.mealSlot, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<double> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get carb =>
      $composableBuilder(column: $table.carb, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableAnnotationComposer(
            $db: $db,
            $table: $db.foods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntriesTable,
          Entry,
          $$EntriesTableFilterComposer,
          $$EntriesTableOrderingComposer,
          $$EntriesTableAnnotationComposer,
          $$EntriesTableCreateCompanionBuilder,
          $$EntriesTableUpdateCompanionBuilder,
          (Entry, $$EntriesTableReferences),
          Entry,
          PrefetchHooks Function({bool foodId})
        > {
  $$EntriesTableTableManager(_$AppDatabase db, $EntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mealSlot = const Value.absent(),
                Value<int?> foodId = const Value.absent(),
                Value<String> foodName = const Value.absent(),
                Value<double> grams = const Value.absent(),
                Value<double> kcal = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<double> carb = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EntriesCompanion(
                id: id,
                date: date,
                mealSlot: mealSlot,
                foodId: foodId,
                foodName: foodName,
                grams: grams,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carb: carb,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int mealSlot,
                Value<int?> foodId = const Value.absent(),
                required String foodName,
                required double grams,
                required double kcal,
                required double protein,
                required double fat,
                required double carb,
                Value<DateTime> createdAt = const Value.absent(),
              }) => EntriesCompanion.insert(
                id: id,
                date: date,
                mealSlot: mealSlot,
                foodId: foodId,
                foodName: foodName,
                grams: grams,
                kcal: kcal,
                protein: protein,
                fat: fat,
                carb: carb,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodId,
                                referencedTable: $$EntriesTableReferences
                                    ._foodIdTable(db),
                                referencedColumn: $$EntriesTableReferences
                                    ._foodIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntriesTable,
      Entry,
      $$EntriesTableFilterComposer,
      $$EntriesTableOrderingComposer,
      $$EntriesTableAnnotationComposer,
      $$EntriesTableCreateCompanionBuilder,
      $$EntriesTableUpdateCompanionBuilder,
      (Entry, $$EntriesTableReferences),
      Entry,
      PrefetchHooks Function({bool foodId})
    >;
typedef $$WeightLogsTableCreateCompanionBuilder =
    WeightLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required double weightKg,
      Value<DateTime> createdAt,
    });
typedef $$WeightLogsTableUpdateCompanionBuilder =
    WeightLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<double> weightKg,
      Value<DateTime> createdAt,
    });

class $$WeightLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WeightLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightLogsTable,
          WeightLog,
          $$WeightLogsTableFilterComposer,
          $$WeightLogsTableOrderingComposer,
          $$WeightLogsTableAnnotationComposer,
          $$WeightLogsTableCreateCompanionBuilder,
          $$WeightLogsTableUpdateCompanionBuilder,
          (
            WeightLog,
            BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>,
          ),
          WeightLog,
          PrefetchHooks Function()
        > {
  $$WeightLogsTableTableManager(_$AppDatabase db, $WeightLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WeightLogsCompanion(
                id: id,
                date: date,
                weightKg: weightKg,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required double weightKg,
                Value<DateTime> createdAt = const Value.absent(),
              }) => WeightLogsCompanion.insert(
                id: id,
                date: date,
                weightKg: weightKg,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightLogsTable,
      WeightLog,
      $$WeightLogsTableFilterComposer,
      $$WeightLogsTableOrderingComposer,
      $$WeightLogsTableAnnotationComposer,
      $$WeightLogsTableCreateCompanionBuilder,
      $$WeightLogsTableUpdateCompanionBuilder,
      (WeightLog, BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>),
      WeightLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$FoodsTableTableManager get foods =>
      $$FoodsTableTableManager(_db, _db.foods);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db, _db.weightLogs);
}
