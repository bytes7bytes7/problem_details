import 'dart:io';

part 'problem_details_defaults.dart';

const _statusKey = 'status';
const _typeKey = 'type';
const _titleKey = 'title';
const _detailKey = 'detail';
const _instanceKey = 'instance';

/// Machine-readable details of errors for a HTTP response.
///
/// For more info see https://www.rfc-editor.org/rfc/rfc7807
class ProblemDetails {
  /// The HTTP status code generated by the origin server for
  /// this occurrence of the problem.
  final int status;

  /// A URI reference that identifies the problem type.
  /// This specification encourages that, when dereferenced, it provide
  /// human-readable documentation for the problem type.
  final String? type;

  /// A short, human-readable summary of the problem type.
  final String? title;

  /// A human-readable explanation specific to this occurrence
  /// of the problem.
  final String? detail;

  /// A URI reference that identifies the specific occurrence
  /// of the problem.
  final String? instance;

  /// Additional information about problem.
  final Map<String, Object?> extensions;

  factory ProblemDetails({
    int? status,
    String? type,
    String? title,
    String? detail,
    String? instance,
    Map<String, Object?>? extensions,
  }) {
    status ??= HttpStatus.internalServerError;

    final defaults = _problemDetailsDefaults[status];

    if (defaults != null) {
      type ??= defaults.link;
      title ??= defaults.title;
    }

    type ??= 'about:blank';

    return ProblemDetails.raw(
      status: status,
      type: type,
      title: title,
      detail: detail,
      instance: instance,
      extensions: extensions,
    );
  }

  const ProblemDetails.raw({
    required this.status,
    this.type,
    this.title,
    this.detail,
    this.instance,
    Map<String, Object?>? extensions,
  }) : extensions = extensions ?? const {};

  factory ProblemDetails.fromJson(Map<String, Object?> json) {
    final status = json.remove(_statusKey) as int;
    final type = json.remove(_typeKey) as String?;
    final title = json.remove(_titleKey) as String?;
    final detail = json.remove(_detailKey) as String?;
    final instance = json.remove(_instanceKey) as String?;

    return ProblemDetails.raw(
      status: status,
      type: type,
      title: title,
      detail: detail,
      instance: instance,
      extensions: json,
    );
  }

  Map<String, Object?> toJson() {
    final result = <String, Object?>{
      _statusKey: status,
    };

    if (type != null) {
      result[_typeKey] = type;
    }

    if (title != null) {
      result[_titleKey] = title;
    }

    if (detail != null) {
      result[_detailKey] = detail;
    }

    if (instance != null) {
      result[_instanceKey] = instance;
    }

    result.addAll(extensions);

    return result;
  }

  ProblemDetails addOrUpdateExtension(String key, Object? value) {
    return ProblemDetails.raw(
      status: status,
      type: type,
      title: title,
      detail: detail,
      instance: instance,
      extensions: Map.from(extensions)..[key] = value,
    );
  }

  ProblemDetails addOrUpdateExtensions(Map<String, Object?> data) {
    return ProblemDetails.raw(
      status: status,
      type: type,
      title: title,
      detail: detail,
      instance: instance,
      extensions: Map.from(extensions)..addAll(data),
    );
  }

  ProblemDetails removeExtension(String key) {
    return ProblemDetails.raw(
      status: status,
      type: type,
      title: title,
      detail: detail,
      instance: instance,
      extensions: Map.from(extensions)..remove(key),
    );
  }
}