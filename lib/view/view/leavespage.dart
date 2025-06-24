import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF4F6F8),
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
                            ),
                          ),
                          SizedBox(height: 3.h),

                          _buildLabel("Employee Name"),
                          _buildReadonlyField(
                            "Employee Name - auto-filled",
                            Icons.person,
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Employee ID"),
                          _buildReadonlyField(
                            "Employee ID - auto-filled",
                            Icons.badge,
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
                              _buildDropdown(
                                vm.leaveTypes,
                                "Leave Type",
                                vm.leaveType,
                                (val) => vm.updateLeaveType(val!),
                                Icons.work_outline,
                                validator:
                                    (val) =>
                                        val == null ? "Select a type" : null,
                              ),
                              _buildDropdown(
                                vm.dayTypes,
                                "Day Type",
                                vm.dayType,
                                (val) => vm.updateDayType(val!),
                                Icons.timelapse,
                                validator:
                                    (val) =>
                                        val == null ? "Select a type" : null,
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Reason"),
                          TextFormField(
                            // controller: vm.reasonController,
                            // maxLines: 4,
                            // validator:
                            //     (val) =>
                            //         val == null || val.trim().isEmpty
                            //             ? "Please enter a reason"
                            //             : null,
                            decoration: InputDecoration(
                              hintText: "Text area",
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(2.h),
                            ),
                          ),
                          SizedBox(height: 2.h),

                          _buildLabel("Attachment"),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.attachment),
                              hintText: "Attachment (Optional)",
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(2.h),
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
    return Text(text, style: TextStyle(fontSize: 17.sp));
  }

  Widget _buildReadonlyField(String value, IconData icon) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(2.h),
      ),
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
      width: 42.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 1.h),
          InkWell(
            onTap: () => vm.pickDate(context, isFrom),
            child: InputDecorator(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: Text(
                  date != null
                      ? "${date.day}/${date.month}/${date.year}"
                      : "$label Date",
                  style: TextStyle(
                    color: date != null ? Colors.black : Colors.grey,
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
          Text(label, style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 1.h),
          DropdownButtonFormField<String>(
            value: value,
            items:
                items
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              hintText: " $label",
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
