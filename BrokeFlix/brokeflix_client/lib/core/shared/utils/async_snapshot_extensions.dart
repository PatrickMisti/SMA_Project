

import 'package:flutter/cupertino.dart';

extension AsyncSnapshotExtensions on AsyncSnapshot {


  Widget loadSnapshot<T>({
    required Widget Function() onLoading,
    required Widget Function(Object? error) onError,
    Widget Function()? onEmpty,
    required Widget Function(T? data) onData,
  }) {
    if (connectionState == ConnectionState.waiting) {
      return onLoading();
    } else if (hasError) {
      return onError(error);
    } else if (!hasData || (data is Iterable && (data as Iterable).isEmpty)) {
      if (onEmpty == null) {
        return onData(null);
      }
      return onEmpty();
    } else {
      return onData(data);
    }
  }
}