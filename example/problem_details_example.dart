// ignore_for_file: avoid_print

import 'package:problem_details/problem_details.dart';

void main() {
  predefinedWithNoParams();
  predefined();
  noPredefined();
  raw();
  extensions();
  toJson();
  fromJson();
}

void predefinedWithNoParams() {
  /// If you do not specify `status`, then it sets to 500 by default.
  final problemDetails = ProblemDetails();

  /// prints: 500
  print(problemDetails.status);
}

void predefined() {
  /// ProblemDetails has some predefined `type`s and `title`s for
  /// some status codes.
  /// For example, for 403 there is predefined `type` and `title`.
  /// Thus, ProblemDetails fulfills `type` and `title` with defaults.
  final problemDetails = ProblemDetails(status: 403);

  // prints: https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3
  print(problemDetails.type);

  // prints: Forbidden
  print(problemDetails.title);
}

void noPredefined() {
  /// If ProblemDetails does not have predefined `type` and `title` for
  /// specified status, then `type` is set to 'about:blank'
  final problemDetails = ProblemDetails(status: 1);

  // prints: about:blank
  print(problemDetails.type);
}

void raw() {
  /// If you want to set all fields manually without autocomplete
  /// with defaults, use `ProblemDetails.raw` constructor.
  final problemDetails = ProblemDetails.raw(status: 403);

  // prints: null
  print(problemDetails.type);

  // prints: null
  print(problemDetails.title);
}

void extensions() {
  /// If you want to add custom fields to ProblemDetails, use `extensions`.
  var problemDetails = ProblemDetails(
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

  // prints:
  //  {
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    }
  //  }
  print(problemDetails.extensions);

  /// You can modify single pair of `extensions` with `addOrUpdateExtension`.
  problemDetails = problemDetails.addOrUpdateExtension('KEY', 'VALUE');

  // prints:
  //  {
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    },
  //    'KEY': 'VALUE'
  //  }
  print(problemDetails.extensions);

  /// You can modify multiple pairs of `extensions` with
  /// `addOrUpdateExtensions`.
  problemDetails = problemDetails.addOrUpdateExtensions(
    {
      'a': 1,
      'b': 2,
    },
  );

  // prints:
  //  {
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    },
  //    'KEY': 'VALUE',
  //    'a': 1,
  //    'b': 2
  //  }
  print(problemDetails.extensions);

  /// You can remove some pair of `extensions` with `removeExtension`.
  problemDetails = problemDetails.removeExtension('KEY');

  // prints:
  //  {
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    },
  //    'a': 1,
  //    'b': 2
  //  }
  print(problemDetails.extensions);
}

void toJson() {
  final problemDetails = ProblemDetails(
    status: 403,
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

  /// `toJson` converts `ProblemDetails` to a Map.
  /// Standard fields (`status`, `type`, `title`, `details`, `instance`)
  /// are not included in a Map if a field is null.
  /// Content of `extensions` field is put on the top level of a Map.
  final jsonData = problemDetails.toJson();

  // prints:
  //  {
  //    status: 403,
  //    type: https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3,
  //    title: Forbidden,
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    }
  //  }
  print(jsonData);
}

void fromJson() {
  var problemDetails = ProblemDetails(
    status: 403,
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

  final jsonData = problemDetails.toJson();

  /// `ProblemDetails.fromJson` constructor parse Map to ProblemDetails.
  problemDetails = ProblemDetails.fromJson(jsonData);

  // prints:
  //  ProblemDetails {
  //    status: 403,
  //    type: https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3,
  //    title: Forbidden,
  //    key1: value,
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    }
  //  }
  print(problemDetails);
}
