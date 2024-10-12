import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool showCommentSection = false;
  final TextEditingController _commentController = TextEditingController();
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/body.png',
              fit: BoxFit.cover,
            ),
          ),
          buildTopBar(screenWidth),
          SlideTransition(position: _slideAnimation!, child: _buildCommentSection(screenWidth, screenHeight)),
          buildFavoriteIcon(screenWidth, screenHeight),
          if (!showCommentSection) buildAddCommentButton(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Padding buildTopBar(double screenWidth) {
  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Divider(
            color: Colors.white,
            thickness: 6,
            indent: 16,
            endIndent: 16,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 45,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/back.png'),
              ),
            ),
            title: Text(
              'Mariano Di Vaio',
              style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.white),
            ),
            trailing: Icon(
              Icons.download_outlined,
              size: screenWidth * 0.07,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

  Positioned buildFavoriteIcon(double screenWidth, double screenHeight) {
    return Positioned(
      bottom: screenHeight * 0.15,
      right: screenWidth * 0.05,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLiked = !isLiked;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: screenWidth * 0.12,
            color: isLiked ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }

  Positioned buildAddCommentButton(double screenWidth, double screenHeight) {
    return Positioned(
      bottom: screenHeight * 0.05,
      left: screenWidth * 0.05,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showCommentSection = true;
            _controller?.forward();
          });
        },
        child: Row(
          children: [
            Icon(Icons.comment, color: Colors.white, size: screenWidth * 0.08),
            const SizedBox(width: 10),
            Text("Add a comment...", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentSection(double screenWidth, double screenHeight) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight * 0.45,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Comments", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _controller?.reverse();
                        showCommentSection = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildComment("User1", "This story is amazing!", screenWidth),
                  _buildComment("User2", "Loved the plot twist!", screenWidth),
                ],
              ),
            ),
            _buildCommentInput(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildComment(String username, String comment, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(username[0]),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(comment, style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.036)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: "Add a comment...",
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                setState(() {
                  _commentController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}