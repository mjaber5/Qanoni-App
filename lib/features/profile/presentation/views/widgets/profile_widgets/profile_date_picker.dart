import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ProfileDatePicker extends StatefulWidget {
  final TextEditingController controller;

  const ProfileDatePicker({super.key, required this.controller});

  @override
  State<ProfileDatePicker> createState() => _ProfileDatePickerState();
}

class _ProfileDatePickerState extends State<ProfileDatePicker> {
  String _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(args.value);
      });
    }
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  void _onOk() {
    widget.controller.text = _selectedDate;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      initialSelectedDate: DateTime.now(),
      showActionButtons: true,
      onCancel: _onCancel,
      onSubmit: (Object? value) {
        _onOk();
      },
      backgroundColor: isLight ? QColors.dark : QColors.light,
      selectionColor: QColors.secondary.withOpacity(0.8),
      startRangeSelectionColor: QColors.secondary,
      endRangeSelectionColor: QColors.secondary,
      rangeTextStyle: const TextStyle(color: QColors.white),
      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        backgroundColor: QColors.secondary,
        textStyle: isLight
            ? QTextTheme.darkTextTheme.bodyMedium
            : QTextTheme.lightTextTheme.bodyMedium,
      ),
      monthViewSettings: DateRangePickerMonthViewSettings(
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          backgroundColor: QColors.secondary.withOpacity(0.2),
          textStyle: isLight
              ? QTextTheme.darkTextTheme.bodyMedium
              : QTextTheme.lightTextTheme.bodyMedium,
        ),
      ),
      todayHighlightColor: QColors.success,
      selectionTextStyle: const TextStyle(color: QColors.white),
      rangeSelectionColor: QColors.darkGrey,
      confirmText: QTexts.profileDatePickerOK,
      cancelText: QTexts.profileDatePickerCancel,
    );
  }
}
