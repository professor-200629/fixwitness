import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

FwException notFound(String message) =>
    FwException(code: FwErrorCode.notFound, message: message);

FwException forbidden(String message) =>
    FwException(code: FwErrorCode.forbidden, message: message);

FwException invalid(String message) =>
    FwException(code: FwErrorCode.validation, message: message);

FwException badTransition(String message) =>
    FwException(code: FwErrorCode.invalidTransition, message: message);

/// True when [error] is Postgres rejecting a duplicate key. Used to make
/// operation-id inserts idempotent when two retries race each other.
bool isUniqueViolation(Object error) =>
    error is DatabaseQueryException &&
    error.code == PgErrorCode.uniqueViolation;
