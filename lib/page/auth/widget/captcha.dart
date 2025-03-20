import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/captcha_auth_entity.dart';
import 'package:konesp/http/http.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:steel_crypt/steel_crypt.dart';

class Captcha extends StatefulWidget {
  final Function(String v)? onSuccess; //拖放完成后验证成功回调
  final Function(String v)? onFail; //拖放完成后验证失败回调

  Captcha({this.onSuccess, this.onFail});

  @override
  State<Captcha> createState() => _CaptchaState();
}

class _CaptchaState extends State<Captcha> with TickerProviderStateMixin {
  String baseImageBase64 = '';
  String slideImageBase64 = '';
  String captchaToken = '';
  String secretKey = ''; //加密key

  Size baseSize = Size.zero; //底部基类图片
  Size slideSize = Size.zero; //滑块图片

  var sliderColor = Colors.white; //滑块的背景色
  var sliderIcon = Icons.arrow_forward; //滑块的图标
  var movedXBorderColor = Colors.white; //滑块拖动时，左边已滑的区域边框颜色
  double sliderStartX = 0; //滑块未拖前的X坐标
  double sliderXMoved = 0;
  bool sliderMoveFinish = false; //滑块拖动结束
  bool checkResultAfterDrag = false; //拖动后的校验结果

  int _checkMilliseconds = 0; //滑动时间
  bool _showTimeLine = false; //是否显示动画部件
  bool _checkSuccess = false; //校验是否成功
  late AnimationController controller;

  //高度动画
  late Animation<double> offsetAnimation;

  //底部部件key
  GlobalKey _containerKey = GlobalKey();

  //背景图key
  GlobalKey _baseImageKey = GlobalKey();

  //滑块
  GlobalKey _slideImageKey = GlobalKey();
  double _bottomSliderSize = 60;

  checkSuccess(String content) async {
    setState(() {
      checkResultAfterDrag = true;
      _checkSuccess = true;
      _showTimeLine = true;
    });
    await controller.forward();
    updateSliderColorIcon();
    Future.delayed(Duration(milliseconds: 500)).then((v) async {
      await controller.reverse();
      setState(() {
        _showTimeLine = false;
      });
      Get.back();
      widget.onSuccess?.call(content);
    });
  }

  void checkFail() async {
    setState(() {
      _showTimeLine = true;
      _checkSuccess = false;
      checkResultAfterDrag = false;
    });
    await controller.forward();
    updateSliderColorIcon();
    Future.delayed(Duration(milliseconds: 500)).then((v) async {
      await controller.reverse();
      setState(() {
        _showTimeLine = false;
      });
      loadCaptcha();
    });
  }

  //重设滑动颜色与图标
  void updateSliderColorIcon() {
    var _sliderColor; //滑块的背景色
    var _sliderIcon; //滑块的图标
    var _movedXBorderColor; //滑块拖动时，左边已滑的区域边框颜色

    //滑块的背景色
    if (sliderMoveFinish) {
      //拖动结束
      _sliderColor = checkResultAfterDrag ? Colors.green : Colors.red;
      _sliderIcon = checkResultAfterDrag ? Icons.check : Icons.close;
      _movedXBorderColor = checkResultAfterDrag ? Colors.green : Colors.red;
    } else {
      //拖动未开始或正在拖动中
      _sliderColor = sliderXMoved > 0 ? Color(0xff447ab2) : Colors.white;
      _sliderIcon = Icons.arrow_forward;
      _movedXBorderColor = Color(0xff447ab2);
    }

    sliderColor = _sliderColor;
    sliderIcon = _sliderIcon;
    movedXBorderColor = _movedXBorderColor;
    setState(() {});
  }

  //加载验证码
  void loadCaptcha() async {
    setState(() {
      _showTimeLine = false;
      sliderMoveFinish = false;
      checkResultAfterDrag = false;
      sliderColor = Colors.white; //滑块的背景色
      sliderIcon = Icons.arrow_forward; //滑块的图标
      movedXBorderColor = Colors.white; //滑块拖动时，左边已滑的区域边框颜色
    });
    final result = await Http().captchaQuery<CaptchaAuthEntity>(
      Api.getCaptcha,
      params: {'captchaType': 'blockPuzzle'},
    );
    if (result.success) {
      CaptchaAuthEntity _entity = result.data!;
      sliderXMoved = 0;
      sliderStartX = 0;
      captchaToken = '';
      checkResultAfterDrag = false;
      baseImageBase64 = _entity.originalImageBase64!.replaceAll('\n', '');
      secretKey = _entity.secretKey!;
      slideImageBase64 = _entity.jigsawImageBase64!.replaceAll('\n', '');
      captchaToken = _entity.token!;
      var baseR = await getImageWH(image: Image.memory(Base64Decoder().convert(baseImageBase64)));
      baseSize = baseR.size;
      var silderR = await getImageWH(image: Image.memory(Base64Decoder().convert(slideImageBase64)));
      slideSize = silderR.size;
      setState(() {});
    } else {
      widget.onFail?.call(result.msg);
    }
  }

  //校验验证码
  checkCaptcha(sliderXMoved, captchaToken, {BuildContext? myContext}) async {
    setState(() {
      sliderMoveFinish = true;
    });
    var pointMap = {'x': sliderXMoved, 'y': 5};
    var pointStr = json.encode(pointMap);
    var cryptedStr = pointStr;
    if (!ObjectUtil.isEmpty(secretKey)) {
      cryptedStr = aesEncode(key: secretKey, content: pointStr);
    }
    final result = await Http().captchaQuery<Map>(
      Api.checkCaptcha,
      params: {
        'captchaType': 'blockPuzzle',
        'pointJson': cryptedStr,
        'token': captchaToken,
      },
    );
    if (result.success) {
      bool isChecked = result.data!['result'];
      if (isChecked) {
        var captchaVerification = '$captchaToken---$pointStr';
        if (!ObjectUtil.isEmpty(secretKey)) {
          captchaVerification = aesEncode(key: secretKey, content: captchaVerification);
        }
        checkSuccess(captchaVerification);
      } else {
        checkFail();
      }
    } else {
      checkFail();
    }
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
    loadCaptcha();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initAnimation() {
    controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    offsetAnimation = Tween<double>(begin: 0.5, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(Captcha oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double _dialogWidth = 0.8 * 1.sw;
    if (_dialogWidth < 330) {
      _dialogWidth = 1.sw;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          key: _containerKey,
          width: _dialogWidth,
          height: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _topContainer(),
              _middleContainer(),
              _bottomContainer(),
            ],
          ),
        ),
      ),
    );
  }

  ///顶部，提示+关闭
  _topContainer() {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colours.bg)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '请完成安全验证',
            style: TextStyle(
              fontSize: 16,
              color: Colours.text_333,
            ),
          ),
          IconButton(
            icon: Icon(Icons.highlight_off),
            iconSize: 25,
            color: Colours.text_333,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _middleContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: <Widget>[
          ///底图 310*155
          ///底图 310*155
          baseImageBase64.length > 0
              ? Image.memory(
                  Base64Decoder().convert(baseImageBase64),
                  fit: BoxFit.fitWidth,
                  key: _baseImageKey,
                  gaplessPlayback: true,
                )
              : Container(
                  width: double.infinity,
                  height: 155,
                  child: CenterLoading(),
                ),

          ///滑块图
          slideImageBase64.length > 0
              ? Container(
                  margin: EdgeInsets.fromLTRB(sliderXMoved, 0, 0, 0),
                  child: Image.memory(
                    Base64Decoder().convert(slideImageBase64),
                    fit: BoxFit.fitHeight,
                    key: _slideImageKey,
                    gaplessPlayback: true,
                  ),
                )
              : Container(),

          //刷新按钮
          baseImageBase64.length > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(icon: Icon(Icons.refresh), iconSize: 30, color: Colors.black54, onPressed: () => loadCaptcha()),
                )
              : SizedBox(),
          Positioned(
              bottom: 0,
              left: -10,
              right: -10,
              child: Offstage(
                offstage: !_showTimeLine,
                child: FractionalTranslation(
                  translation: Offset(0, offsetAnimation.value),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    color: _checkSuccess ? Color(0x7F66BB6A) : Color.fromRGBO(200, 100, 100, 0.4),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _checkSuccess ? '${(_checkMilliseconds / (60.0 * 12)).toStringAsFixed(2)}s验证成功' : '验证失败',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Offstage(
                offstage: !_showTimeLine,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 20,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }

  ///底部，滑动区域
  _bottomContainer() {
    return baseSize.width > 0
        ? Container(
            height: 70,
            width: baseSize.width,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: <Widget>[
                Container(
                  height: _bottomSliderSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xffe5e5e5),
                    ),
                    color: Color(0xfff8f9fb),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '向右拖动滑块填充拼图',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  width: sliderXMoved,
                  height: _bottomSliderSize - 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: sliderXMoved > 0 ? 1 : 0,
                      color: movedXBorderColor,
                    ),
                    color: Color(0xfff3fef1),
                  ),
                ),
                GestureDetector(
                  onPanStart: (startDetails) {
                    ///开始
                    _checkMilliseconds = DateTime.now().millisecondsSinceEpoch;
                    sliderStartX = startDetails.localPosition.dx;
                  },
                  onPanUpdate: (updateDetails) {
                    ///更新
                    double _w1 = _baseImageKey.currentContext!.size!.width - _slideImageKey.currentContext!.size!.width;
                    double offset = updateDetails.localPosition.dx - sliderStartX;
                    if (offset < 0) {
                      offset = 0;
                    }
                    if (offset > _w1) {
                      offset = _w1;
                    }
                    setState(() {
                      sliderXMoved = offset;
                    });
                    //滑动过程，改变滑块左边框颜色
                    updateSliderColorIcon();
                  },
                  onPanEnd: (endDetails) async {
                    await checkCaptcha(sliderXMoved, captchaToken);
                    int _nowTime = DateTime.now().millisecondsSinceEpoch;
                    _checkMilliseconds = _nowTime - _checkMilliseconds;
                  },
                  child: Container(
                    width: _bottomSliderSize,
                    height: _bottomSliderSize,
                    margin: EdgeInsets.only(left: sliderXMoved > 0 ? sliderXMoved : 1),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Color(0xffe5e5e5),
                        ),
                        right: BorderSide(
                          width: 1,
                          color: Color(0xffe5e5e5),
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffe5e5e5),
                        ),
                      ),
                      color: sliderColor,
                    ),
                    child: IconButton(
                      icon: Icon(sliderIcon),
                      iconSize: 30,
                      color: Colors.black54,
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ))
        : SizedBox();
  }

  String aesEncode({required String key, required String content}) {
    var aesCrypt = AesCrypt(key: base64UrlEncode(key.codeUnits), padding: PaddingAES.pkcs7);
    return aesCrypt.ecb.encrypt(inp: content);
  }

  Future<Rect> getImageWH({Image? image, String? url, String? localUrl, String? package}) {
    if (ObjectUtil.isEmpty(image) && ObjectUtil.isEmpty(url) && ObjectUtil.isEmpty(localUrl)) {
      return Future.value(Rect.zero);
    }
    Completer<Rect> completer = Completer<Rect>();
    Image img = image ?? ((url != null && url.isNotEmpty) ? Image.network(url) : Image.asset(localUrl!, package: package));
    img.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener(
          (ImageInfo info, bool _) {
        completer.complete(Rect.fromLTWH(0, 0, info.image.width.toDouble(), info.image.height.toDouble()));
      },
      onError: (Object exception, StackTrace? stackTrace) {
        completer.completeError(exception, stackTrace);
      },
    ));
    return completer.future;
  }
}
