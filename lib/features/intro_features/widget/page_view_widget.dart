import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/media_query.dart';
import '../../../const/responsive.dart';

class PageViewItems extends StatelessWidget {
  const PageViewItems({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
          SizedBox(height: 10.sp),
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 10.sp : 18.sp,
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: isDesktop ? 8.sp : 14.sp,
              fontFamily: 'normal',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
