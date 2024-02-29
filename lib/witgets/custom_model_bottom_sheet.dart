import 'package:flutter/material.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';
import 'package:kartek_demo/utils/fonts.dart';

class CustomModalButtomSheet {
  buildshowModalBottomSheet(
      {required context,
      required Widget widget,
      Color color = CustomThemeData.whiteColor}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: context.dynamicHeight(0.45),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstant.smallPadding),
            topRight: Radius.circular(AppConstant.smallPadding),
          ),
        ),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(width: AppConstant.defaultPadding),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 6,
                  width: context.dynamicWidth(0.2),
                  decoration: BoxDecoration(
                      color: CustomThemeData.disabledColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: CustomThemeData.backgroudColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.close,
                                    size: 22,
                                  ))),
                        )),
                  ],
                ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
                    child:
                        Padding(padding: customPaddingDefault, child: widget))),
          ],
        ),
      ),
    );
  }
}
