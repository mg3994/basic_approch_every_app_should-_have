enum UrlSchema { http, https, ftp, ws, wss, sftp, ssh }

extension BaseUrlSchemaX on UrlSchema {
  String toUrlSchema() {
    switch (this) {
      case UrlSchema.http:
        return 'http';
      case UrlSchema.https:
        return 'https';
      case UrlSchema.ftp:
        return 'ftp';
      case UrlSchema.ws:
        return 'ws';
      case UrlSchema.wss:
        return 'wss';
      case UrlSchema.sftp:
        return 'sftp';
      case UrlSchema.ssh:
        return 'ssh';
    }
  }
}
