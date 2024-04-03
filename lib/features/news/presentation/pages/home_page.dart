import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';

import 'package:news_app/features/news/presentation/controller/home_controller.dart';

import 'package:news_app/features/news/presentation/widgets/loading_news.dart';
import 'package:news_app/features/news/presentation/widgets/news_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController(Get.find(), Get.find());

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  Future<void> onRefresh() async {
    controller.topHeadlines();
    controller.headlinesCategory(controller.selected.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: Column(
          children: [
            const SizedBox(height: 5),
            topHeadlines(),
            const SizedBox(height: 10),
            categoryHeadlines(),
          ],
        ),
      ),
    );
  }

  Widget categoryHeadlines() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.category.map((e) {
                  return Obx(() => GestureDetector(
                        onTap: () {
                          controller.selected.value = e;
                          controller.headlinesCategory(e);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: controller.selected.value == e ? Colors.indigo : Colors.transparent,
                            border: Border.all(
                              color: controller.selected.value == e ? Colors.indigo : Colors.grey,
                              width: 1.2,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                          ),
                          margin: const EdgeInsets.only(right: 8),
                          child: Text(
                            e.capitalizeFirst!,
                            style: TextStyle(
                              color: controller.selected.value == e ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final state = controller.baseCategory.value.state;
                final message = controller.baseCategory.value.message;
                final result = controller.baseCategory.value.data;

                if (state == StatusState.initial) {
                  return const SizedBox();
                } else if (state == StatusState.loading) {
                  return ListView.builder(
                    itemCount: 4,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                        child: const LoadingNews(),
                      );
                    },
                  );
                } else if (state == StatusState.failed) {
                  return Center(child: Text(message));
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: result!.length,
                    itemBuilder: (context, index) {
                      final news = result[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => Get.toNamed('/web-page', arguments: news.url),
                          child: NewsItem(news: news),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget topHeadlines() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berita Utama',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final newsResponse = controller.baseTopHeadlines.value;
              final state = controller.baseTopHeadlines.value.state;
              final message = controller.baseTopHeadlines.value.message;

              if (state == StatusState.loading) {
                return const LoadingNews();
              } else if (state == StatusState.failed) {
                return Center(child: Text(message));
              } else if (state == StatusState.loaded) {
                return PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: newsResponse.data!.length,
                  itemBuilder: (context, index) {
                    final news = newsResponse.data![index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Get.toNamed('/web-page', arguments: news.url),
                      child: NewsItem(news: news),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }
}
