part of 'problem_details.dart';

class _DefaultsValue {
  const _DefaultsValue({
    required this.link,
    required this.title,
  });

  final String link;
  final String title;
}

/// Predefined info for Problem Details.
const _problemDetailsDefaults = <int, _DefaultsValue>{
  400: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.1',
    title: 'Bad Request',
  ),
  401: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7235#section-3.1',
    title: 'Unauthorized',
  ),
  403: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.3',
    title: 'Forbidden',
  ),
  404: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.4',
    title: 'Not Found',
  ),
  405: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.5',
    title: 'Method Not Allowed',
  ),
  406: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.6',
    title: 'Not Acceptable',
  ),
  407: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7235#section-3.2',
    title: 'Proxy Authentication Required',
  ),
  408: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.7',
    title: 'Request Timeout',
  ),
  409: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.8',
    title: 'Conflict',
  ),
  410: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.9',
    title: 'Gone',
  ),
  411: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.10',
    title: 'Length Required',
  ),
  413: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.11',
    title: 'Payload Too Large',
  ),
  414: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.12',
    title: 'URI Too Long',
  ),
  415: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.13',
    title: 'Unsupported Media Type',
  ),
  417: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.14',
    title: 'Expectation Failed',
  ),
  422: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc4918#section-11.2',
    title: 'Unprocessable Entity',
  ),
  426: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.5.15',
    title: 'Upgrade Required',
  ),
  500: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.1',
    title: 'Internal Server Error',
  ),
  501: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.2',
    title: 'Not Implemented',
  ),
  502: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.3',
    title: 'Bad Gateway',
  ),
  503: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.4',
    title: 'Service Unavailable',
  ),
  504: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.5',
    title: 'Gateway Timeout',
  ),
  505: _DefaultsValue(
    link: 'https://www.rfc-editor.org/rfc/rfc7231#section-6.6.6',
    title: 'HTTP Version Not Supported',
  ),
};
