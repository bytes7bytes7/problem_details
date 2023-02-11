[English](https://github.com/bytes7bytes7/problem_details/blob/master/README.md)
| [Русский](https://github.com/bytes7bytes7/problem_details/blob/master/resources/l10n/ru_RU/README.md)

# Problem Details

Implementation of ProblemDetails object (for more info see https://www.rfc-editor.org/rfc/rfc7807)

## How to use

### ProblemDetails constructor

You can use unnamed factory constructor `ProblemDetails` to create `ProblemDetails`:

```dart
void main() {
  final problemDetails = ProblemDetails();
}
```

`status` is `500` by default.

`ProblemDetails` constructor fulfills fields: `type` and `title` based on `status`. But, it only
works for a limited set of `status` values. The full set of `status` values you can see
[here](https://github.com/bytes7bytes7/problem_details/blob/master/lib/src/problem_details_defaults.dart)
.

For example:

```dart
void main() {
  final problemDetails = ProblemDetails(status: 403);

  // prints: https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3
  print(problemDetails.type);

  // prints: Forbidden
  print(problemDetails.title);
}
```

If `ProblemDetails` does not have default values of `type`, `title` for a certain `status`,
then `type` is set to `about:blank`.

```dart
void main() {
  final problemDetails = ProblemDetails(status: 1);

  // prints: about:blank
  print(problemDetails.type);
}
```

### ProblemDetails.raw constructor

Use `ProblemDetails.raw` if you want to set all values manually:

```dart
void main() {
  final problemDetails = ProblemDetails.raw(status: 403);

  // prints: null
  print(problemDetails.type);

  // prints: null
  print(problemDetails.title);
}
```

### Additional fields

If you want to add new fields to `ProblemDetails`, use `extensions`:

```dart
void extensions() {
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
}
```

You can change/add a field by using `addOrUpdateExtension` method:

```dart
void main() {
  var problemDetails = ProblemDetails(
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

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
}
```

You can change/add multiple fields by using `addOrUpdateExtensions` method:

```dart
void main() {
  var problemDetails = ProblemDetails(
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

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
  //    'a': 1,
  //    'b': 2
  //  }
  print(problemDetails.extensions);
}
```

You can remove a field by using `removeExtension` method:

```dart
void main() {
  var problemDetails = ProblemDetails(
    extensions: {
      'key1': 'value',
      'key2': null,
      'key3': {
        'key4': [1, 2, 3],
      },
    },
  );

  problemDetails = problemDetails.removeExtension('key1');

  // prints:
  //  {
  //    key2: null,
  //    key3: {
  //      key4: [1, 2, 3]
  //    }
  //  }
  print(problemDetails.extensions);
}
```

### toJson

`toJson` method converts `ProblemDetails` into `Map`.

> **_NOTE:_** Standard fields (`status`, `type`,
> `title`, `details`, `instance`) are not included in a Map, if a field is null.

> **_IMPORTANT:_** Content of `extensions` is put on the top level of a Map.

```dart
void main() {
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
```

### fromJson

`fromJson` constructor parses `Map` into `ProblemDetails`.

> **_IMPORTANT:_** Non-standard fields of `ProblemDetails`
> (i. e. all fields except `status`, `type`,
> `title`, `details`, `instance`) convert in `extensions`.

```dart
void main() {
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
```
