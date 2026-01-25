import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/widgets/psalm_text.dart';

class PsalmView extends StatefulWidget {
  const PsalmView({super.key});

  @override
  State<PsalmView> createState() => _PsalmViewState();
}

class _PsalmViewState extends State<PsalmView> {
  late final PageController _pageController;
  bool _programmatic = false;
  bool _isUserSwiping = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: PsalmPageSlot.current.slotIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleSwipe(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      _isUserSwiping = true;
      return;
    }

    if (notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        _isUserSwiping) {
      _isUserSwiping = false;

      final page = _pageController.page;
      if (page == null) return;

      final idx = page.round();
      if (idx == PsalmPageSlot.current.slotIndex) return;

      final forward = idx == PsalmPageSlot.next.slotIndex;
      _programmatic = true;

      final reading = context.read<ReadingProvider>();
      reading.commitCandidate(forward: forward, notify: false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _pageController.jumpToPage(PsalmPageSlot.current.slotIndex);
        reading.notify();
        _programmatic = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ReadingProvider>(
        builder: (context, reading, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                     if (!_programmatic) _handleSwipe(notification);
                     return false;
                  },
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildPage(
                        PsalmPageSlot.previous,
                        reading.prevPsalmText,
                        psalmNumberKey: reading.prevPsalmNumber,
                      ),
                      _buildPage(
                        PsalmPageSlot.current,
                        reading.currentPsalmText,
                        psalmNumberKey: reading.psalmNumber,
                      ),
                      _buildPage(
                        PsalmPageSlot.next,
                        reading.nextPsalmText,
                        psalmNumberKey: reading.nextPsalmNumber,
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: SizedBox(
                  width: 60,
                  child: Center(child: _buildNavigationIcon(forward: false)),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: SizedBox(
                  width: 60,
                  child: Center(child: _buildNavigationIcon()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _navigateButton({required bool forward}) async {
    if (_programmatic) return;
    _programmatic = true;

    await _pageController.animateToPage(
      forward ? PsalmPageSlot.next.slotIndex : PsalmPageSlot.previous.slotIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    if (!mounted) return;

    context.read<ReadingProvider>().commitCandidate(forward: forward);
    _pageController.jumpToPage(PsalmPageSlot.current.slotIndex);
    _programmatic = false;
  }

  Widget _buildNavigationIcon({bool forward = true}) {
    final Icon icon = forward
        ? Icon(Icons.chevron_right_rounded)
        : Icon(Icons.chevron_left_rounded);

    return IconButton(
      onPressed: () => unawaited(_navigateButton(forward: forward)),
      icon: icon,
    );
  }

  Widget _buildPage(
    PsalmPageSlot slot,
    Future<String> psalmFuture, {
    required int psalmNumberKey,
  }) {
    //eventualno makni Padding iz build i stavi tu
    return KeyedSubtree(
      key: ValueKey(psalmNumberKey),
      child: SingleChildScrollView(
        child: PsalmText(key: ValueKey(psalmNumberKey), text: psalmFuture),
      ),
    );
  }
}
