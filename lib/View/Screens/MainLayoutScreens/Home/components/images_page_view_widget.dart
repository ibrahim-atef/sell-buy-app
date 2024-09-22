 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'custom_cached_network_image.dart';




class ImagePageViewWidget extends StatefulWidget {
  final List<String> imageUrls;

  ImagePageViewWidget({Key? key, required this.imageUrls}) : super(key: key);

  @override
  _ImagePageViewWidgetState createState() => _ImagePageViewWidgetState();
}

class _ImagePageViewWidgetState extends State<ImagePageViewWidget> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.animateToPage(
        _currentPageIndex - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPageIndex < widget.imageUrls.length - 1) {
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Container(
            height: 200, // Adjust the height as needed
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            iconTheme: IconThemeData(color: Colors.white),
                          ),
                          body: Container(
                            child: PhotoView(
                              imageProvider: NetworkImage(widget.imageUrls[index]),
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 2,
                              initialScale: PhotoViewComputedScale.contained,
                            ),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        widget.imageUrls.isNotEmpty&& widget.imageUrls.length!=1
            ? SizedBox(height: 8)
            : SizedBox.shrink(), // Spacer
        widget.imageUrls.isNotEmpty && widget.imageUrls.length!=1
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: List.generate(
                    widget.imageUrls.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: CirculeImageAvatar(
                        imageUrl: widget.imageUrls[index],
                        width: Get.width * .15,
                        callback: () {
                          setState(() {
                            _pageController.jumpToPage(index);
                          });
                        },
                        isSelected: _currentPageIndex == index,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(), // Placeholder if no images
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
