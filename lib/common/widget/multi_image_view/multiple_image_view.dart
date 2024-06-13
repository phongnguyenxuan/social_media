import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'smart_image.dart';

class MultipleImageView extends StatelessWidget {
  final List<String>? imageUrls;
  final ImageType type;
  final List<XFile>? files;
  const MultipleImageView({
    super.key,
    this.imageUrls,
    required this.type,
    this.files,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _contentRender(),
    );
  }

  List<Widget> _contentRender() {
    switch ((type == ImageType.network) ? imageUrls!.length : files!.length) {
      case 1:
        return _singleImageView();

      case 2:
        return _twoImageView();

      case 3:
        return _threeImageView();

      case 4:
        return _foureImageView();

      default:
        return _multipleImageView();
    }
  }

  List<Widget> _singleImageView() {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SmartImage(
          type: type,
          imageUrl: imageUrls?.first,
          file: files?.first.path,
          fit: BoxFit.fill,
        ),
      ),
    ];
  }

  List<Widget> _twoImageView() {
    return [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: SmartImage(
            type: type,
            imageUrl: imageUrls?.first,
            file: files?.first.path,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: SmartImage(
            type: type,
            imageUrl: imageUrls?.last,
            file: files?.last.path,
            fit: BoxFit.cover,
          ),
        ),
      )
    ];
  }

  List<Widget> _threeImageView() {
    return [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: SmartImage(
            type: type,
            imageUrl: imageUrls?[0],
            file: files?[0].path,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[1],
                  file: files?[1].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[2],
                  file: files?[2].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _foureImageView() {
    return [
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: SmartImage(
            type: type,
            imageUrl: imageUrls?[0],
            file: files?[0].path,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[1],
                  file: files?[1].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[2],
                  file: files?[2].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[3],
                  file: files?[3].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _multipleImageView() {
    return [
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: SmartImage(
            type: type,
            imageUrl: imageUrls?[0],
            file: files?[0].path,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[1],
                  file: files?[1].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                child: SmartImage(
                  type: type,
                  imageUrl: imageUrls?[2],
                  file: files?[2].path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                    child: SmartImage(
                      type: type,
                      imageUrl: imageUrls?[3],
                      file: files?[3].path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        (type == ImageType.network)
                            ? '+${imageUrls!.length - 4}'
                            : '+${files!.length - 4}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "Nulito",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
