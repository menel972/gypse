part of '../multi_screen.dart';

class MultiListView extends StatelessWidget {
  const MultiListView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            maxHeight: 60,
            minHeight: 60,
            child: GypseButton.orange(
              context,
              label: 'Nouvelle partie',
              onPressed: () {},
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            maxHeight: Dimensions.xs(context).height,
            minHeight: Dimensions.xs(context).height,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'À toi de jouer',
                style: GypseFont.m(bold: true),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
          itemCount: 3,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'En attente de',
                style: GypseFont.m(bold: true),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
          itemCount: 3,
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'Terminées',
                style: GypseFont.m(bold: true),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
          itemCount: 13,
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  const _SliverAppBarDelegate({
    required this.child,
    this.maxHeight = 50,
    this.minHeight = 50,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}
