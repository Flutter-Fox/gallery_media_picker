import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:photo_manager/photo_manager.dart';

class DecodeImage extends ImageProvider<DecodeImage> {
  final AssetPathEntity entity;
  final double scale;
  final int thumbSize;
  final int index;

  const DecodeImage(
    this.entity, {
    this.scale = 1.0,
    this.thumbSize = 120,
    this.index = 0,
  });

  @override
  ImageStreamCompleter load(DecodeImage key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
    );
  }

  Future<ui.Codec> _loadAsync(DecodeImage key, DecoderCallback decode) async {
    assert(key == this);

    final coverEntity = (await key.entity.getAssetListRange(start: index, end: index + 1))[0];

    final bytes = await coverEntity.thumbnailDataWithSize(ThumbnailSize(thumbSize, thumbSize), format: ThumbnailFormat.png);

    return decode(bytes!);
  }

  @override
  Future<DecodeImage> obtainKey(ImageConfiguration configuration) async {
    return this;
  }
}
