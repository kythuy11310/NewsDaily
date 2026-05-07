import 'package:flutter/material.dart';
import 'app_styles.dart';
// Nhúng file ProfileView vào (bạn có thể dùng package:baitap1/profile/profile_view.dart nếu dùng cách import tuyệt đối)
import '../../profile/profile_view.dart'; 

class VnExpressHeader extends StatelessWidget {
  final Widget? appLogo;
  final VoidCallback? onSearchTapped;

  const VnExpressHeader({Key? key, this.appLogo, this.onSearchTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: AppStyles.headerBox,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: AppStyles.textGrey, size: 28),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: appLogo ?? const Text('APP LOGO', style: TextStyle(fontSize: 22, color: AppStyles.textGrey)),
                    ),
                    const SizedBox(height: 2),
                    const Text('PTK', style: AppStyles.sloganText),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildTextLink(''),
                  const SizedBox(width: 8),
                  _buildInternationalLink(),
                  const SizedBox(width: 4),
                  
                  // Kính lúp tìm kiếm
                  IconButton(
                    icon: const Icon(Icons.search, color: AppStyles.textGrey),
                    onPressed: onSearchTapped, 
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  
                  // NÚT CÁ NHÂN (Đã thêm sự kiện chuyển trang)
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: AppStyles.textGrey),
                    onPressed: () {
                      // Chuyển sang màn hình ProfileView khi được bấm
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          decoration: AppStyles.navBarBox,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: AppStyles.circleGreyBg,
                  child: const Icon(Icons.home, color: AppStyles.bgWhite, size: 16),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildNavItem('VnE-GO'),
                      _buildNavItem('Thời sự'),
                      _buildNavItem('Thế giới'),
                      _buildNavItem('Kinh doanh'),
                      _buildNavItem('Khoa học công nghệ'),
                      _buildNavItem('Góc nhìn'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextLink(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
      child: Text(text, style: AppStyles.topLinkText),
    );
  }

  Widget _buildInternationalLink() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: AppStyles.redBorderIcon,
            child: const Text('E', style: AppStyles.eIconText),
          ),
          const SizedBox(width: 6),
          const Text('International', style: AppStyles.topLinkText),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
        child: Text(title, style: AppStyles.navItemText),
      ),
    );
  }
}