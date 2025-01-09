import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/custom_profile_app_bar.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/profile_text_feild_editing_information.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/profile_user_information_card.dart';
import '../../../../../../core/utils/constants/colors.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarProfilState(),
        const ProfileUserInformationCard(),
        DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "My Property"),
                  Tab(text: "My Information"),
                  Tab(text: "My Contracts"),
                ],
                labelColor: QColors.secondary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: QColors.secondary,
                indicatorWeight: 4.0,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  children: [
                    // محتوى "My Property"
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          _propertyCard(
                            context,
                            title: "Modern Apartment",
                            address: "123 Main Street, City Center",
                            status: "Available",
                            icon: FontAwesomeIcons.building,
                          ),
                          const SizedBox(height: 16),
                          _propertyCard(
                            context,
                            title: "Luxury Villa",
                            address: "456 Beach Road, Seaside",
                            status: "Rented",
                            icon: FontAwesomeIcons.home,
                          ),
                          const SizedBox(height: 16),
                          _propertyCard(
                            context,
                            title: "Cozy Cottage",
                            address: "789 Mountain Path, Countryside",
                            status: "For Sale",
                            icon: FontAwesomeIcons.tree,
                          ),
                        ],
                      ),
                    ),
                    // محتوى "My Information"
                    const ProfileUserInformationEditingField(),
                    // محتوى "My Contracts"
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          _contractCard(
                            context,
                            contractName: "Lease Contract",
                            date: "12 Jan 2023",
                            status: "Active",
                          ),
                          const SizedBox(height: 16),
                          _contractCard(
                            context,
                            contractName: "Purchase Agreement",
                            date: "25 Dec 2022",
                            status: "Completed",
                          ),
                          const SizedBox(height: 16),
                          _contractCard(
                            context,
                            contractName: "Employment Contract",
                            date: "01 Mar 2023",
                            status: "Pending",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _propertyCard(BuildContext context, {
    required String title,
    required String address,
    required String status,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: QColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 40,
                color: QColors.secondary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: QColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      fontSize: 14,
                      color: status == "Available"
                          ? Colors.green
                          : status == "Rented"
                              ? Colors.orange
                              : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contractCard(BuildContext context, {
    required String contractName,
    required String date,
    required String status,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: QColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                FontAwesomeIcons.fileContract,
                size: 30,
                color: QColors.secondary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contractName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: QColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Date: $date",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      fontSize: 14,
                      color: status == "Active"
                          ? Colors.green
                          : status == "Completed"
                              ? Colors.blue
                              : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: QColors.secondary,
              ),
              onPressed: () {
                // Navigation or action for viewing contract details
              },
            ),
          ],
        ),
      ),
    );
  }
}
