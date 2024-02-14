import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/board_constants.dart';

String? selectedBackground;

class SelectBoardBackground extends StatefulWidget {
  const SelectBoardBackground({super.key});

  @override
  State<SelectBoardBackground> createState() => _SelectBoardBackgroundState();
}

class _SelectBoardBackgroundState extends State<SelectBoardBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Board background"),
        centerTitle: false,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 20),
          itemCount: backgrounds.length,
          itemBuilder: (BuildContext cxt, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedBackground = backgrounds[index];
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(int.parse(backgrounds[index])),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    (backgrounds[index] == selectedBackground)
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 50,
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ));
          }),
    );
  }
}
