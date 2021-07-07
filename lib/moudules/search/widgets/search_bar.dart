import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.onPressed,
      required this.onClose,
      this.back,
      this.hintText = "请输入搜索内容",
      this.fontSize = 16,
      this.textColor = Colors.black,
      this.hintColor = Colors.black26})
      : super(key: key);
  final Function(String) onPressed;
  final Function() onClose;
  final Function()? back;
  final String? hintText;
  final double? fontSize;
  final Color? textColor;
  final Color? hintColor;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  late Function() _back;

  @override
  void initState() {
    super.initState();

    _back = widget.back ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(240, 240, 240, 1)),
              child: TextField(
                  controller: _controller,
                  focusNode: FocusNode(),
                  style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Color.fromRGBO(50, 50, 50, 1),
                      textBaseline: TextBaseline.alphabetic),
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (value.length > 0) {
                      widget.onPressed(value);
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 0) {
                      widget.onClose();
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.red,
                      contentPadding: EdgeInsets.fromLTRB(0, -5, 0, 0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      icon: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, bottom: 3, left: 15),
                        child: Image.asset(
                          "assets/images/search_find.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          fontSize: widget.fontSize, color: widget.hintColor),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _controller.text = "";
                          widget.onClose();
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/images/search_close_delete.png",
                          ),
                        ),
                      ))),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: _back,
            child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: Text(
                "取消",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
