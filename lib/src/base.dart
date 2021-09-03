import 'package:flutter/material.dart';
import 'package:proste_drop_menu/src/menu.dart';
import './header.dart';
import './constroller.dart';
import './observer.dart';

class ProsteDropMenu extends StatefulWidget {
  ProsteDropMenu({
    this.maskColor = Colors.black12,
    this.controller,
    this.backgroundColor = Colors.white,
    this.padding,
    required this.headers,
    required this.menus,
  })  : assert(headers.length > 0, 'headers length must be greater than 0'),
        assert(menus.length > 0, 'menus length must be greater than 0'),
        assert(menus.length == headers.length,
            'the length of menus and headers must be equal');

  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color maskColor;
  final ProsteDropMenuController? controller;
  final List<ProsteDropMenuHeaderItem> headers;
  final List<ProsteDropMenuItem> menus;
  @override
  _ProsteDropMenuState createState() => _ProsteDropMenuState();
}

class _ProsteDropMenuState extends State<ProsteDropMenu> with RouteAware {
  ProsteDropMenuController? _localController;
  ProsteDropMenuController get _controller =>
      widget.controller ?? _localController!;
  OverlayEntry? _overlay;
  GlobalKey _key = GlobalKey();

  void reBuild() {
    if (!mounted) return;
    setState(() {});
  }

  void _toggleEvent() {
    if (_controller.isShow) {
      _show(_controller.selectItem);
    } else {
      _hide();
    }
    reBuild();
  }

  void _show(int key) {
    _build(key);
    Overlay.of(context)?.insert(_overlay!);
  }

  void _hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }

  void _build(int key) {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double topSpace = renderBox.size.height + offset.dy;
    Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
    _overlay = OverlayEntry(
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return Container(
          width: width,
          height: height,
          child: Column(
            children: <Widget>[
              Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (PointerDownEvent event) {
                  if (!rect.contains(event.localPosition)) {
                    _controller.hideMenu();
                  }
                },
                child: SizedBox(
                  height: topSpace,
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: height - topSpace),
                width: MediaQuery.of(context).size.width,
                child: Material(
                  child: widget.menus[key].builder!(context),
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _controller.hideMenu,
                  child: Container(
                    color: widget.maskColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didPop() {
    super.didPop();
    _hide();
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null)
      _localController = ProsteDropMenuController();
    _controller.addListener(_toggleEvent);
  }

  @override
  void didChangeDependencies() {
    prosteDropMenuObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _hide();
    prosteDropMenuObserver.unsubscribe(this);
    _controller.removeListener(_toggleEvent);
    _localController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      color: widget.backgroundColor,
      width: double.infinity,
      child: Container(
        child: Row(
          children: widget.headers.asMap().keys.map((k) {
            final h = widget.headers[k];
            bool isSelect = k == _controller.selectItem && _controller.isShow;
            final icon = Icon(
              h.icon ??
                  (isSelect
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
              color: isSelect ? h.selectColor : h.color,
            );
            ProsteDropMenuItem item = widget.menus[k];

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  assert(item.builder != null || item.tigger != null,
                      'item.builder and item.toggle cannot all be null');
                  if (item.tigger != null) {
                    _controller.hideMenu();
                    item.tigger!.call(context);
                  } else {
                    _controller.toggleMenu(k);
                  }
                },
                child: Container(
                  padding: h.padding,
                  decoration: k != widget.headers.length - 1
                      ? BoxDecoration(
                          border: Border(right: h.border!),
                        )
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          h.label,
                          maxLines: 1,
                          style: isSelect ? h.selectText : h.style,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      icon,
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
