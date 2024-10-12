import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1D2732),
      appBar: buildAppBar(screenWidth),
      body: Column(
        children: [
          buildStoryBar(screenWidth, screenHeight),
          Expanded(child: buildPostList(context, screenWidth, screenHeight)),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(screenWidth),
    );
  }

  AppBar buildAppBar(double screenWidth) {
    return AppBar(
      title: Text('SOCIALLY', style: TextStyle(fontSize: screenWidth * 0.05)),
      leading: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Image.asset('assets/notification.png'),
      ),
    );
  }

  Widget buildStoryBar(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35.0),
        child: Container(
          height: screenHeight * 0.15,
          color: const Color(0xFF22303F),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01,
                  vertical: screenHeight * 0.02,
                ),
                child: CircleAvatar(
                  radius: screenWidth * 0.08,
                  backgroundImage: AssetImage('assets/image${index + 1}.png'),
                  backgroundColor: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildPostList(BuildContext context, double screenWidth, double screenHeight) {
    return ListView(
      children: [
        buildPostCard(
          context,
          screenWidth,
          screenHeight,
          'Kylie Jenner .With Zoe Sugg',
          'assets/image1.png',
          'Stopped by @zoesugg today with goosey girl to see @kyliecosmetics & @kylieskin 💕 wow what a dream!!!!!!!! It’s the best experience we have!',
          '2d ago',
        ),
        buildPostWithImageCard(
          context,
          screenWidth,
          screenHeight,
          'Kylie Jenner',
          'assets/image1.png',
          'assets/body.png',
          '2d ago',
        ),
      ],
    );
  }

  Widget buildPostCard(BuildContext context, double screenWidth, double screenHeight, String title, String avatarImage, String postContent, String timeAgo) {
    return Card(
      margin: EdgeInsets.all(screenWidth * 0.03),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(avatarImage)),
              title: Text(title, style: TextStyle(fontSize: screenWidth * 0.036)),
              trailing: Text(timeAgo, style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey)),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
                  children: const [
                    TextSpan(text: 'Stopped by '),
                    TextSpan(text: '@zoesugg', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' today with goosey girl to see '),
                    TextSpan(text: '@kyliecosmetics', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' & '),
                    TextSpan(text: '@kylieskin', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' 💕 wow what a dream!!!!!!!! It’s the best experience we have!'),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.grey, thickness: 2, indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  rowIconText('assets/favorit.png', '1,320', screenWidth),
                  rowIconText('assets/comment.png', '23', screenWidth),
                  SizedBox(width: screenWidth * 0.2),
                  Image.asset('assets/bookmark.png', width: screenWidth * 0.06),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostWithImageCard(BuildContext context, double screenWidth, double screenHeight, String title, String avatarImage, String bodyImage, String timeAgo) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/story');
      },
      child: Card(
        margin: EdgeInsets.all(screenWidth * 0.03),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage(avatarImage)),
                title: Text(title, style: TextStyle(fontSize: screenWidth * 0.036)),
                trailing: Text(timeAgo, style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      bodyImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: screenHeight * 0.25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowIconText(String assetPath, String count, double screenWidth) {
    return Row(
      children: [
        Image.asset(assetPath, width: screenWidth * 0.06),
        SizedBox(width: screenWidth * 0.02),
        Text(count, style: TextStyle(color: Colors.black38, fontSize: screenWidth * 0.03)),
      ],
    );
  }

  ClipRRect buildBottomNavigationBar(double screenWidth) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: screenWidth * 0.07), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined, size: screenWidth * 0.07), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: screenWidth * 0.07), label: ''),
        ],
      ),
    );
  }
}