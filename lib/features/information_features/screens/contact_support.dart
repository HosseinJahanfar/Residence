import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/responsive.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!appbar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgScaffold,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //!back Info
            Navigator.pop(context);
          },
        ),
        title: Text(
          'تماس با پشتیبانی',
          style: TextStyle(
              fontFamily: 'bold', fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      //!body contact support
      body: Padding(
        padding: EdgeInsets.all(12.5.sp),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: getWidth(context, 0.8),
                  ),
                  Text(
                    'به کمک اقامتگاه نیاز دارید؟',
                    style: TextStyle(fontFamily: 'medium', fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'تیم پشتیبانی اقامتگاه از 7 صبح تا 2 بامداد آماده پاسخگویی به شماست',
                    style: TextStyle(fontFamily: 'normal', fontSize: 12.sp,),textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  //!phone
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary2Color,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: getBorderRadiusFunc(8.sp)),
                          fixedSize: Size(getAllWidth(context),
                              Responsive.isTablet(context) ? 65 : 45)),
                      onPressed: () {
                        final Uri telLaunchUri=Uri(
                          scheme: 'tel',
                          path: '09016022853',
                        );
                        launchUrl(telLaunchUri);
                      },
                      child: const Text(
                        'تماس با پشتیبانی',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                            color: Colors.white),
                      )),
                  SizedBox(
                    height: 10.sp,
                  ),
                  //! email
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: getBorderRadiusFunc(8.sp),
                              side: const BorderSide(width: 2)),
                          fixedSize: Size(getAllWidth(context),
                              Responsive.isTablet(context) ? 65 : 45)),
                      onPressed: () {
                        String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'smith@example.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Example Subject & Symbols are allowed!',
                          }),
                        );

                        launchUrl(emailLaunchUri);
                      },
                      child: const Text(
                        'ارسال ایمیل',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                            color: primary2Color),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
