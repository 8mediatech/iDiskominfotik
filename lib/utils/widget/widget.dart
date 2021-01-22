import 'dart:async';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/foundation.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/main.dart';
import 'package:url_launcher/url_launcher.dart';




Widget buildProgressIndicator() {
  bool isLoading = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Opacity(
        opacity: isLoading ? 1.0 : 00,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget text(
    String text, {
      var fontSize = textSizeLargeMedium,
      textColor = appTextColorSecondary,
      var fontFamily,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5,
      bool textAllCaps = false,
      var isLongText = false,
      bool lineThrough = false,
    }) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
      lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration2(
    {double radius = 2,
      Color color = Colors.transparent,
      Color bgColor,
      var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? appStore.scaffoldBackground,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: false);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
}

// ignore: non_constant_identifier_names
Widget label_build(var text) {
  return Padding(
    padding: EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text,
            style: TextStyle(
                fontSize: 18, color: db6_black, fontFamily: fontBold)),
        Text(lbl_semua,
            style: TextStyle(fontSize: 14, color: db6_textColorSecondary)),
      ],
    ),
  );
}

Widget commonCacheImageWidget(String url, double height,
    {double width, BoxFit fit}) {
  if (isMobile) {
    return CachedNetworkImage(
      placeholder: placeholderWidgetFn(),
      imageUrl: '$url',
      height: height,
      width: width,
      fit: fit,
    );
  } else {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

Widget toolBarTitle(var title, {textColor = t12_text_color_primary}) {
  return text(title,
      fontSize: textSizeLarge, fontFamily: fontBold, textColor: textColor);
}

Function(BuildContext, String) placeholderWidgetFn() =>
        (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/dashboard/opvideocall2.png', fit: BoxFit.cover);
Widget mSale(BuildContext context) {
  return Container(
    alignment: Alignment.bottomLeft,
    margin: EdgeInsets.only(left: spacing_middle, bottom: spacing_standard_new),
    child: Container(
      padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_control_half,
          spacing_standard_new, spacing_control_half),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[t13_colorPrimary, t13_color_gradient1],
        ),
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
      ),
      child: text(lbl_cari, textColor: db6_white, fontSize: 12.0),
    ),
  );
}

Divider view() {
  return Divider(color: t8_view_color, height: 0.5);
}

Text profile(var label) {
  return Text(label,
      style:
      TextStyle(color: db7_dark_yellow, fontSize: 18, fontFamily: 'Medium'),
      textAlign: TextAlign.center);
}

// ignore: must_be_immutable
class T3AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  T3AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T3AppButtonState();
  }
}

class T3AppButtonState extends State<T3AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.onPressed,
        textColor: db6_white,
        elevation: 4,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[t3_colorPrimary, t3_colorPrimaryDark]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  State<StatefulWidget> createState() {
    return null;
  }
}

// ignore: must_be_immutable
class T4Button extends StatefulWidget {
  static String tag = '/T4Button';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 50.0;

  T4Button(
      {@required this.textContent,
        @required this.onPressed,
        this.isStroked = false,
        this.height = 45.0});

  @override
  T4ButtonState createState() => T4ButtonState();
}

class T4ButtonState extends State<T4Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: text(widget.textContent,
            textColor: widget.isStroked ? t4_colorPrimary : db6_white,
            isCentered: true,
            fontFamily: fontMedium,
            textAllCaps: true),
        decoration: widget.isStroked
            ? boxDecoration2(
            bgColor: Colors.transparent, color: t4_colorPrimary)
            : boxDecoration2(bgColor: t4_colorPrimary, radius: 4),
      ),
    );
  }
}

BoxDecoration boxDecoration({double radius = 80.0, Color backGroundColor = opPrimaryColor, double blurRadius = 8.0, double spreadRadius = 8.0, shadowColor = Colors.black12}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ],
    color: backGroundColor,
  );
}
// ignore: non_constant_identifier_names
Widget VerifyCards({final Size size, String title, String subtitle, String image, Color color}) {
  return Container(
    decoration: boxDecoration(backGroundColor: color, radius: 7, spreadRadius: 2, blurRadius: 4),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: boldTextStyle(size: 16,fontFamily: fontIntro, color: Colors.white),
                ),
                SizedBox(
                    height: 5
                ),
                Text(
                  subtitle,
                  style: primaryTextStyle(size: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
        ],
      ),
    ),
  );
}
Widget oPDotIndicator({bool isActive}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    height: isActive ? 10.0 : 8.0,
    width: isActive ? 10.0 : 8.0,
    decoration: BoxDecoration(
      color: isActive ? opPrimaryColor : Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
}
// ignore: non_constant_identifier_names
Widget SliderButton({Color color, String title = '', VoidCallback onPressed}) {
  return RaisedButton(
      padding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: BorderSide(color: Colors.transparent),
      ),
      color: color,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        onPressed();
      });
}
BoxDecoration boxDecorations({double radius = 8, Color color = Colors.transparent, Color bgColor = Colors.white, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow ? [BoxShadow(color: dbShadowColor, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

// ignore: must_be_immutable
class SDButton extends StatefulWidget {
  static String tag = '/T4Button';
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 40.0;

  SDButton({@required this.textContent, @required this.onPressed, this.isStroked = false, this.height = 45.0});

  @override
  SDButtonState createState() => SDButtonState();
}
class SDButtonState extends State<SDButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          style: boldTextStyle(size: 16, color: Colors.white, letterSpacing: 2),
        ),
        decoration: widget.isStroked ? boxDecorations(bgColor: Colors.transparent, color: db6_colorPrimary) : boxDecorations(bgColor: db6_colorPrimary, radius: 6),
      ),
    );
  }
}


//slider
class Db4CarouselSlider extends StatefulWidget {
  Db4CarouselSlider(
      {@required this.items,
        this.height,
        this.aspectRatio: 16 / 9,
        this.viewportFraction: 0.8,
        this.initialPage: 0,
        int realPage: 10000,
        this.enableInfiniteScroll: true,
        this.reverse: false,
        this.autoPlay: false,
        this.autoPlayInterval: const Duration(seconds: 4),
        this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
        this.autoPlayCurve: Curves.fastOutSlowIn,
        this.pauseAutoPlayOnTouch,
        this.enlargeCenterPage = false,
        this.onPageChanged,
        this.scrollPhysics,
        this.scrollDirection: Axis.horizontal})
      : this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
        this.itemCount = items.length,
        this.itemBuilder = null,
        this.pageController = PageController(
          viewportFraction: viewportFraction,
          initialPage: enableInfiniteScroll ? realPage + initialPage : initialPage,
        );

  /// The on demand item builder constructor
  Db4CarouselSlider.builder(
      {@required this.itemCount,
        @required this.itemBuilder,
        this.height,
        this.aspectRatio: 16 / 9,
        this.viewportFraction: 0.8,
        this.initialPage: 0,
        int realPage: 10000,
        this.enableInfiniteScroll: true,
        this.reverse: false,
        this.autoPlay: false,
        this.autoPlayInterval: const Duration(seconds: 4),
        this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
        this.autoPlayCurve: Curves.fastOutSlowIn,
        this.pauseAutoPlayOnTouch,
        this.enlargeCenterPage = false,
        this.onPageChanged,
        this.scrollPhysics,
        this.scrollDirection: Axis.horizontal})
      : this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
        this.items = null,
        this.pageController = PageController(
          viewportFraction: viewportFraction,
          initialPage: enableInfiniteScroll ? realPage + initialPage : initialPage,
        );

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget> items;

  /// The widget item builder that will be used to build item on demand
  final IndexedWidgetBuilder itemBuilder;

  /// The widgets count that should be shown at carousel
  final int itemCount;

  /// Set carousel height and overrides any existing [aspectRatio].
  final double height;

  /// Aspect ratio is used if no height have been declared.
  ///
  /// Defaults to 16:9 aspect ratio.
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final num viewportFraction;

  /// The initial page to show when first creating the [Db4CarouselSlider].
  ///
  /// Defaults to 0.
  final num initialPage;

  /// The actual index of the [PageView].
  ///
  /// This value can be ignored unless you know the carousel will be scrolled
  /// backwards more then 10000 pages.
  /// Defaults to 10000 to simulate infinite backwards scrolling.
  final num realPage;

  ///Determines if carousel should loop infinitely or be limited to item length.
  ///
  ///Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Reverse the order of items if set to true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve autoPlayCurve;

  /// Sets a timer on touch detected that pause the auto play with
  /// the given [Duration].
  ///
  /// Touch Detection is only active if [autoPlay] is true.
  final Duration pauseAutoPlayOnTouch;

  /// Determines if current page should be larger then the side images,
  /// creating a feeling of depth in the carousel.
  ///
  /// Defaults to false.
  final bool enlargeCenterPage;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Called whenever the page in the center of the viewport changes.
  final Function(int index) onPageChanged;

  /// How the carousel should respond to user input.
  ///
  /// For example, determines how the items continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics scrollPhysics;

  /// [pageController] is created using the properties passed to the constructor
  /// and can be used to control the [PageView] it is passed to.
  final PageController pageController;

  /// Animates the controlled [Db4CarouselSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> nextPage({Duration duration, Curve curve}) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  /// Animates the controlled [Db4CarouselSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> previousPage({Duration duration, Curve curve}) {
    return pageController.previousPage(duration: duration, curve: curve);
  }

  /// Changes which page is displayed in the controlled [Db4CarouselSlider].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  void jumpToPage(int page) {
    final index = _getRealIndex(pageController.page.toInt(), realPage - initialPage, itemCount);
    return pageController.jumpToPage(pageController.page.toInt() + page - index);
  }

  /// Animates the controlled [Db4CarouselSlider] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> animateToPage(int page, {Duration duration, Curve curve}) {
    final index = _getRealIndex(pageController.page.toInt(), realPage - initialPage, itemCount);
    return pageController.animateToPage(pageController.page.toInt() + page - index, duration: duration, curve: curve);
  }

  @override
  _Db4CarouselSliderState createState() => _Db4CarouselSliderState();
}

class _Db4CarouselSliderState extends State<Db4CarouselSlider> with TickerProviderStateMixin {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = getTimer();
  }

  Timer getTimer() {
    return widget.autoPlay
        ? Timer.periodic(widget.autoPlayInterval, (_) {
      widget.pageController.nextPage(duration: widget.autoPlayAnimationDuration, curve: widget.autoPlayCurve);
    })
        : null;
  }

  void pauseOnTouch() {
    timer.cancel();
    timer = Timer(widget.pauseAutoPlayOnTouch, () {
      timer = getTimer();
    });
  }

  Widget getWrapper(Widget child) {
    if (widget.height != null) {
      final Widget wrapper = Container(height: widget.height, child: child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    } else {
      final Widget wrapper = AspectRatio(aspectRatio: widget.aspectRatio, child: child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    }
  }

  Widget addGestureDetection(Widget child) => GestureDetector(onPanDown: (_) => pauseOnTouch(), child: child);

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return getWrapper(PageView.builder(
      physics: widget.scrollPhysics,
      scrollDirection: widget.scrollDirection,
      controller: widget.pageController,
      reverse: widget.reverse,
      itemCount: widget.enableInfiniteScroll ? null : widget.itemCount,
      onPageChanged: (int index) {
        int currentPage = _getRealIndex(index + widget.initialPage, widget.realPage, widget.itemCount);
        if (widget.onPageChanged != null) {
          widget.onPageChanged(currentPage);
        }
      },
      itemBuilder: (BuildContext context, int i) {
        final int index = _getRealIndex(i + widget.initialPage, widget.realPage, widget.itemCount);

        return AnimatedBuilder(
          animation: widget.pageController,
          child: (widget.items != null) ? widget.items[index] : widget.itemBuilder(context, index),
          builder: (BuildContext context, child) {
            // on the first render, the pageController.page is null,
            // this is a dirty hack
            if (widget.pageController.position.minScrollExtent == null || widget.pageController.position.maxScrollExtent == null) {
              Future.delayed(Duration(microseconds: 1), () {
                if (this.mounted) {
                  setState(() {});
                }
              });
              return Container();
            }
            double value = widget.pageController.page - i;
            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);

            final double height = widget.height ?? MediaQuery.of(context).size.width * (1 / widget.aspectRatio);
            final double distortionValue = widget.enlargeCenterPage ? Curves.easeOut.transform(value) : 1.0;

            if (widget.scrollDirection == Axis.horizontal) {
              return Center(child: SizedBox(height: distortionValue * height, child: child));
            } else {
              return Center(child: SizedBox(width: distortionValue * MediaQuery.of(context).size.width, child: child));
            }
          },
        );
      },
    ));
  }
}

/// Converts an index of a set size to the corresponding index of a collection of another size
/// as if they were circular.
///
/// Takes a [position] from collection Foo, a [base] from where Foo's index originated
/// and the [length] of a second collection Baa, for which the correlating index is sought.
///
/// For example; We have a Carousel of 10000(simulating infinity) but only 6 images.
/// We need to repeat the images to give the illusion of a never ending stream.
/// By calling _getRealIndex with position and base we get an offset.
/// This offset modulo our length, 6, will return a number between 0 and 5, which represent the image
/// to be placed in the given position.
int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _remainder(offset, length);
}

/// Returns the remainder of the modulo operation [input] % [source], and adjust it for
/// negative values.
int _remainder(int input, int source) {
  if (source == 0) return 0;
  final int result = input % source;
  return result < 0 ? source + result : result;
}


