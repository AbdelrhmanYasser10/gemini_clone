import 'package:chat_iq/index.dart';


class BuildTimeLinetile extends StatelessWidget {
  const BuildTimeLinetile({
    super.key,
    required this.text,
    required this.isSelected,
  });
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.manual,
      lineXY: 1,
      isFirst: text == 'Email',
      isLast: text == 'Pass',
      indicatorStyle: IndicatorStyle(
          width: 35.w,
          height: 35.h,
          color: isSelected ? Constants.mainColor : Colors.grey[400]!,
          indicatorXY: 0.5,
          iconStyle: isSelected
              ? IconStyle(
                  iconData: Icons.done_outlined, color: Colors.grey[400]!)
              : IconStyle(
                  iconData: Icons.done_outlined,
                  color: Colors.transparent,
                )),
      afterLineStyle: LineStyle(
        thickness: 2,
        color: isSelected ? Constants.mainColor : Colors.grey[400]!,
      ),
      beforeLineStyle: LineStyle(
        thickness: 2,
        color: isSelected ? Constants.mainColor : Colors.grey[400]!,
      ),
      startChild: Container(
        alignment: Alignment.center,
        width: 60,
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Constants.mainColor : Colors.grey[400]!,
              fontSize: 12),
        ),
      ),
    );
  }
}
