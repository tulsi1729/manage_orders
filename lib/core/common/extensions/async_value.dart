import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/error_text.dart';
import 'package:manage_orders/core/common/loader.dart';

extension WhenAsyncValue<T> on AsyncValue<T> {
  Widget whenWidget(Widget Function(T) data) => when(
        data: data,
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: Loader.new,
      );
}
