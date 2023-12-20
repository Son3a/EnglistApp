import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(2, 4), blurRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text(
          label,
          style: AppStyle.h4.copyWith(
              color: AppColor.textColor,
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
