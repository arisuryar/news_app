import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/features/news/presentation/controller/search_controller.dart';
import 'package:news_app/features/news/presentation/widgets/loading_news.dart';
import 'package:news_app/features/news/presentation/widgets/news_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final SearchControllerPage controller = SearchControllerPage(Get.find());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            const SizedBox(height: 15),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.indigo),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.searchC,
                      decoration: const InputDecoration(
                        hintText: 'Cari Berita',
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                      onPressed: () {
                        controller.headlinesSearch();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              final newsResponse = controller.baseSearch.value;
              final state = controller.baseSearch.value.state;
              final message = controller.baseSearch.value.message;

              if (state == StatusState.loading) {
                return const Column(
                  children: [
                    SizedBox(height: 10),
                    LoadingNews(),
                    SizedBox(height: 10),
                    LoadingNews(),
                    SizedBox(height: 10),
                    LoadingNews(),
                  ],
                );
              } else if (state == StatusState.failed) {
                return Container(
                  height: Get.height / 1.6,
                  alignment: Alignment.center,
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                );
              } else if (state == StatusState.loaded) {
                return ListView.builder(
                  itemCount: newsResponse.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final news = newsResponse.data![index];
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
              } else {
                return Container(
                  height: Get.height / 1.6,
                  alignment: Alignment.center,
                  child: Text(
                    'Cari Berita Sekarang',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
