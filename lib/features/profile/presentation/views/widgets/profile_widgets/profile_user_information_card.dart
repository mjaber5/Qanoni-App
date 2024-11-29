import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gap/gap.dart';
import 'package:qanoni/features/profile/presentation/view_model/my_cache_manager.dart';
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

  static const String _cacheKey = "userProfileInfo";

  @override
  void initState() {
    super.initState();
    _userRepo = FirebaseUserRepo();
    _loadUserInformation();
  }

  Future<void> _loadUserInformation() async {
    try {
      // Use the custom CacheManager
      final cacheManager = MyCacheManager();
      final cachedFile = await cacheManager.getFileFromCache(_cacheKey);

      if (cachedFile != null) {
        // Load from cache
        final cachedData = await cachedFile.file.readAsString();
        final userData = Map<String, dynamic>.from(json.decode(cachedData));
        _updateStateWithUserData(userData);
      } else {
        // Load from Firebase
        final currentUser = _userRepo.firebaseAuth.currentUser;
        if (currentUser != null) {
          final userDoc =
              await _userRepo.usersCollection.doc(currentUser.uid).get();

          if (userDoc.exists) {
            final userData = userDoc.data()!;
            await _cacheUserData(userData, cacheManager);
            _updateStateWithUserData(userData);
          } else {
            _setErrorState();
          }
        } else {
          _setNoUserState();
        }
      }
    } catch (error) {
      _setErrorState();
    }
  }

  Future<void> _cacheUserData(
      Map<String, dynamic> userData, CacheManager cacheManager) async {
    final jsonData = json.encode(userData);
    await cacheManager.putFile(
      _cacheKey,
      Uint8List.fromList(jsonData.codeUnits),
    );
  }

  void _updateStateWithUserData(Map<String, dynamic> userData) {
    setState(() {
      _userName = userData['userName'] ?? 'Unknown';
      _idNumber = userData['idNumber'] ?? 'Unknown';
      _userIduse = userData['userIduse'] ?? 'Unknown';
      _isLoading = false;
    });
  }

  void _setErrorState() {
    setState(() {
      _hasError = true;
      _isLoading = false;
    });
  }

  void _setNoUserState() {
    setState(() {
      _userName = 'No User Logged In';
      _idNumber = 'No User Logged In';
      _userIduse = 'No User Logged In';
      _isLoading = false;
    });
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
