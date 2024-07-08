import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/shape.dart';
import 'package:residence/features/comment_features/logic/comment_bloc.dart';
import 'package:residence/features/comment_features/widget/empty_commment_widget.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/route/names.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../widget/text_form_field_multi_line.dart';

class ShowCommentScreen extends StatefulWidget {
  const ShowCommentScreen({super.key});

  @override
  State<ShowCommentScreen> createState() => _ShowCommentScreenState();
}

class _ShowCommentScreenState extends State<ShowCommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final _key = GlobalKey<FormState>();
  Map<String, dynamic>? arguments;

  @override
  void initState() {
    super.initState();
    // Here you can safely call the method you want to run only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      BlocProvider.of<CommentBloc>(context).add(CallShowCommentEvent(
          id: arguments!['residence_detail_id'].toString()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //!add comment
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Form(
                      key: _key,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          width: getAllWidth(context),
                          height: getWidth(context, 0.7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.sp),
                                topLeft: Radius.circular(20.sp)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: ListView(
                              children: [
                                Container(
                                  width: getAllWidth(context),
                                  margin: EdgeInsets.only(top: 20.sp),
                                  child: Text(
                                    'ثبت دیدگاه',
                                    style: TextStyle(
                                        fontSize: 16.sp, fontFamily: 'bold'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                TextFormFieldMultiLine(
                                    minLine: 5,
                                    maxLine: 8,
                                    labelText: 'دیدگاه',
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.multiline,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    controller: _commentController,
                                    icon: const Icon(Icons.edit_outlined)),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize:
                                            Size(getAllWidth(context), 45),
                                        backgroundColor: primaryColor),
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        BlocProvider.of<CommentBloc>(context)
                                            .add(CallAddCommentEvent(
                                                id: arguments![
                                                    'residence_detail_id'],
                                                comment: _commentController.text
                                                    .trim()));
                                        _commentController.clear();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'ثبت دیدگاه',
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              label: Row(
                children: [
                  Text(
                    'ثبت نظر',
                    style: TextStyle(fontFamily: 'medium', fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  const Icon(Icons.add_comment_outlined),
                ],
              )),
          //!app bar
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                //! residence DetailScreen
                Navigator.pushReplacementNamed(
                    context, ScreenNames.residenceDetailScreen, arguments: {
                  'residence_detail_id':
                      arguments!['residence_detail_id'].toString()
                });
              },
            ),
            title: Text(
              'نظرات کاربران',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'bold',
                  fontSize: 14.sp),
            ),
            centerTitle: true,
          ),
          //! body comment
          body: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadingState) {
                return const Center(
                    child: SpinKitFadingCube(
                  color: primaryColor,
                  size: 40.0,
                ));
              }
              if (state is CommentCompletedState) {
                return state.comments!.isEmpty
                    ? const EmptyCommentWidget()
                    : ListView.builder(
                        itemCount: state.comments!.length,
                        itemBuilder: (context, index) {
                          final helper = state.comments![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Card(
                              shape: getShapeFunc(5),
                              color: Colors.grey.shade100,
                              child: Container(
                                padding: EdgeInsets.all(5.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.sp,
                                    ),
                                    Text(
                                      helper.fullname ?? 'کار',
                                      style: TextStyle(
                                          fontFamily: 'bold', fontSize: 12.sp),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Text(
                                      helper.comment!,
                                      style: TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 10.sp),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Text(
                                      helper.timeSinceCreated!,
                                      style: TextStyle(
                                          fontFamily: 'bold',
                                          fontSize: 10.sp,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
              if (state is CommentErrorState) {
                return ErrorScreenWidget(
                    errorMsg: state.error.toString(), function: () {});
              }

              return const SizedBox.shrink();
            },
          )),
    );
  }
}
