import 'package:flutter/material.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/service/alarm/notification_helper.dart';

class WalkAlarmSelector extends StatefulWidget {
  const WalkAlarmSelector({super.key});

  @override
  State<WalkAlarmSelector> createState() => _WalkAlarmSelectorState();
}

class _WalkAlarmSelectorState extends State<WalkAlarmSelector> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedTime != null)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time,size: 22, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      '예약된 시간: ${selectedTime!.hour}시 ${selectedTime!.minute}분',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  tooltip: '알림 삭제',
                  onPressed: () async {
                    await NotificationHelper.cancel(id: 1);
                    setState(() => selectedTime = null);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('알림이 삭제되었어요 🗑️')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),


        Center(
          child: SizedBox(
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentGreenColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time != null) {
                  setState(() => selectedTime = time);

                  await NotificationHelper.schedule(
                    '🐶 산책할 시간이예요!',
                    '지금 딱 산책하기 좋은 시간이예요~',
                    time,
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${time.hour}시 ${time.minute}분에 알림이 예약되었어요! 🐾',
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text('시간 선택하기'),
            ),
          ),
        ),
      ],
    );
  }
}
