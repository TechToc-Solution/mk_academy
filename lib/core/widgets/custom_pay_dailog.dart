// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/widgets/custom_qr_code_scanner.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/check_code.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

import '../shared/cubits/pay/pay_cubit.dart';
import '../shared/cubits/pay/pay_state.dart';
import '../utils/functions.dart';

class PaymentCodeDialog extends StatefulWidget {
  final int? courseId;
  bool public = false;
  PaymentCodeDialog({super.key, required this.courseId, required this.public});

  @override
  State<PaymentCodeDialog> createState() => _PaymentCodeDialogState();
}

class _PaymentCodeDialogState extends State<PaymentCodeDialog> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 4,
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius))),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: BlocConsumer<PayCubit, PayState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'enter_promo_code'.tr(context),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.qr_code,
                        color: AppColors.primaryColors,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => QRScannerPage(
                            onScanned: (scannedCode) {
                              setState(() {
                                _codeController.text = scannedCode;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    hintText: 'promo_code'.tr(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (state is PayLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'cancel'.tr(context),
                          style: TextStyle(
                            color: AppColors.primaryColors,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColors,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_codeController.text.isNotEmpty) {
                            if (widget.public) {
                              Navigator.of(context).push(
                                goRoute(
                                    x: CheckCodePage(
                                  code: _codeController.text,
                                )),
                              );
                            } else {
                              context.read<PayCubit>().payCourse(
                                    _codeController.text,
                                  );
                            }
                          }
                        },
                        child: Text(widget.public
                            ? 'code_check'.tr(context)
                            : 'apply'.tr(context)),
                      ),
                    ],
                  ),
              ],
            );
          },
          listener: (BuildContext context, PayState state) {
            if (state is PaySuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<ProfileCubit>().getProfile();
              messages(context, 'payment_success'.tr(context), Colors.green);
            }
            if (state is PayError) {
              Navigator.pop(context);
              Navigator.pop(context);
              messages(context, state.message, Colors.red);
            }
          },
        ),
      ),
    );
  }
}
