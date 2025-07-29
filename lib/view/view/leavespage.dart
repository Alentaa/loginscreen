import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/viewmodel/leavesPage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveFormViewModel(),
      child: const _LeavesFormBody(),
    );
  }
}

class _LeavesFormBody extends StatelessWidget {
  const _LeavesFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LeaveFormViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(), // hide keyboard
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            "Apply for Leave",
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),

                          _buildLabel("Employee Name"),
                          _buildReadonlyField(
                            "Employee Name - auto-filled",
                            Icons.person_outline,
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Employee ID"),
                          _buildReadonlyField(
                            "Employee ID - auto-filled",
                            Icons.badge_outlined,
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Date Range"),
                          SizedBox(height: 1.h),
                          Wrap(
                            spacing: 3.w,
                            runSpacing: 2.h,
                            children: [
                              _buildDateField(context, "From", true, vm),
                              _buildDateField(context, "To", false, vm),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Leave Details"),
                          SizedBox(height: 1.h),
                          Wrap(
                            spacing: 3.w,
                            runSpacing: 3.h,
                            children: [
                              Container(
                                width: 400,
                                child: _buildDropdown(
                                  vm.leaveTypes,
                                  "Choose Type",
                                  vm.leaveType,
                                  (val) => vm.updateLeaveType(val!),
                                  Icons.work_outline,
                                  validator:
                                      (val) =>
                                          val == null ? "Select a type" : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Reason"),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Text area",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(7.h),
                            ),
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Attachment"),
                          InkWell(
                            onTap: () => vm.pickAttachment(),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 2.h,
                                horizontal: 3.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.attachment, color: Colors.grey),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Text(
                                      vm.attachmentFileName ??
                                          "Choose file (optional)",
                                      style: TextStyle(
                                        color:
                                            vm.attachmentFileName != null
                                                ? Colors.black87
                                                : Colors.grey,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 3.h),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: Size.fromHeight(6.h),
                            ),
                            onPressed: () {
                              if (vm.validateForm()) {
                                final leave = vm.createLeaveModel();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Leave Submitted'),
                                  ),
                                );
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/home',
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17.sp,
        color: const Color.fromARGB(255, 92, 90, 90),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildReadonlyField(String value, IconData icon) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(2.h),
      ),
      style: TextStyle(color: const Color.fromARGB(255, 105, 104, 104)),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    String label,
    bool isFrom,
    LeaveFormViewModel vm,
  ) {
    final date = isFrom ? vm.fromDate : vm.toDate;
    return SizedBox(
      width: 43.w,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () => vm.pickDate(context, isFrom),
            child: InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.w),
                child: Text(
                  date != null
                      ? "${date.day}/${date.month}/${date.year}"
                      : "$label Date",
                  style: TextStyle(
                    color: date != null ? Colors.grey[800] : Colors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String label,
    String? value,
    Function(String?) onChanged,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: 42.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.sp, color: const Color.fromARGB(255, 162, 161, 161)),
          ),
          SizedBox(height: 1.h),
          DropdownButtonFormField<String>(
            value: value,
            items:
                items
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey),
              hintText: " $label",
              hintStyle: TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
            ),
            style: TextStyle(color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
