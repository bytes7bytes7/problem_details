[English](https://github.com/bytes7bytes7/problem_details/blob/master/README.md)
| [Русский](https://github.com/bytes7bytes7/problem_details/blob/master/resources/l10n/ru_RU/README.md)

# Problem Details

Реализация объекта ProblemDetails (для большей информации
см. https://www.rfc-editor.org/rfc/rfc7807)

- [Как использовать](#как-использовать)
    - [ProblemDetails](#problemdetails)
    - [ProblemDetails.raw](#problemdetailsraw)
    - [Дополнительные поля](#дополнительные-поля)
    - [toJson](#tojson)
    - [fromJson](#fromjson)

## Как использовать

### ProblemDetails

Для создания `ProblemDetails` можно использовать фабричный безымянный конструктор:

```dart
void main() {
  final problemDetails = ProblemDetails();
}
```

По умолчанию `status` равен `500`.

Конструктор `ProblemDetails` на основе `status` заполняет поля: `type`, `title`. Однако, это
работает только для ограниченного набора значений `status`. Список этих значений можно
посмотреть [тут](https://github.com/bytes7bytes7/problem_details/blob/master/lib/src/problem_details_defaults.dart)
.

Например:

```dart
void main() {
  final problemDetails = ProblemDetails(status: 403);

  // выводит: https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3
  print(problemDetails.type);

  // выводит: Forbidden
  print(problemDetails.title);
}
```

Если `ProblemDetails` не имеет значений `type`, `title` для определенного `status`, то `type`
приравнивается к `about:blank`.

```dart
void main() {
  final problemDetails = ProblemDetails(status: 1);

  // выводит: about:blank
  print(problemDetails.type);
}
```

### ProblemDetails.raw

Если вы хотите задать все поля вручную, воспользуйтесь `ProblemDetails.raw`:

```dart
void main() {
  final problemDetails = ProblemDetails.raw(status: 403);

  // выводит: null
  print(problemDetails.type);

  // выводит: null
  print(problemDetails.title);
}
```

### Дополнительные поля

Если вы хотите добавить новые поля к `ProblemDetails`, воспользуйтесь полем `extensions`:

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

  // выводит:
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

Можно изменять/добавлять поле с помощью метода `addOrUpdateExtension`:

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

  // выводит:
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

Можно изменять/добавлять несколько полей с помощью метода `addOrUpdateExtensions`:

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

  // выводит:
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

Можно удалять поля с помощью метода `removeExtension`:

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

  // выводит:
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

Метод `toJson` конвертирует `ProblemDetails` в `Map`.

> **_ПРИМЕЧАНИЕ:_** Стандартные поля (`status`, `type`,
> `title`, `details`, `instance`) не включаются в Map, если они равны null.

> **_ВАЖНО:_** Поля `extensions` выносятся на верхний уровень Map.

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

  // выводит:
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

Конструктор `fromJson` позволяет распарсить `Map` в `ProblemDetails`.

> **_ВАЖНО:_** Поля, неявляющиееся стандартными полями
> `ProblemDetails` (т. е. все поля, кроме: `status`, `type`,
> `title`, `details`, `instance`) переходят в `extensions`.

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

  // выводит:
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