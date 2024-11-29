import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:user_repository/user_reposetory.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/styles.dart';

class ProfileUserInformationCard extends StatefulWidget {
  const ProfileUserInformationCard({super.key});

  @override
  State<ProfileUserInformationCard> createState() =>
      _ProfileUserInformationCardState();
}

class _ProfileUserInformationCardState
    extends State<ProfileUserInformationCard> {
  late final FirebaseUserRepo _userRepo;
  String? _userName;
  String? _idNumber;
  String? _userIduse;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _userRepo = FirebaseUserRepo();
    _loadUserInformation();
  }

  Future<void> _loadUserInformation() async {
    try {
      final currentUser = _userRepo.firebaseAuth.currentUser;
      if (currentUser != null) {
        final userDoc =
            await _userRepo.usersCollection.doc(currentUser.uid).get();

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.data()?['userName'] ?? 'Unknown';
            _idNumber = userDoc.data()?['idNumber'] ?? 'UnKnown';
            _userIduse = userDoc.data()?['userIduse'] ?? 'UnKnown';
            _isLoading = false;
          });
        } else {
          setState(() {
            _userName = 'Unknown User';
            _idNumber = 'UnKnown User';
            _userIduse = 'UnKnown User';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _userName = 'No User Logged In';
          _idNumber = 'No User Logged In';
          _userIduse = 'No User Logged In';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text('Error loading user information'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(QImages.profileImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName ?? 'No name available',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle16,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${QTexts.idnumber} : $_idNumber',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle16,
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(
                          'ID : $_userIduse',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle16,
                        ),
                        const Gap(10),
                        InkWell(
                            onTap: () {
                              _copyToClipboard('$_userIduse', context);
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 20,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ID copied to clipboard')),
    );
  }
}
