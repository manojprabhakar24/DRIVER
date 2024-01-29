import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leadingWidth: 150,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_removebg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications_none)),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.question_mark_rounded)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, top: 15),
              child: Text(
                "Hi Manoj,",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(color: Colors.orange, width: 6),
                  top: BorderSide(color: Colors.orange),
                  right: BorderSide(color: Colors.orange),
                  left: BorderSide(color: Colors.orange),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(63, 10, 10, 5),
                        child: Text(
                          "From,",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 30, 5),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Icon(Icons.circle_outlined,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Load from...',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: CustomPaint(
                          size: Size(30, 20),
                          painter: DottedLinePainter(),
                        ),
                      ),
                      SizedBox(width: 9),
                      Text("To,"),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.swap_horiz, color: Colors.grey),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 30, 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orangeAccent,
                          ),
                          child: Icon(Icons.location_on_outlined,
                              color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Unload to...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 30, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(5.0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(double.maxFinite, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.shade400),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Center(
                child: Image.asset('assets/offerimage.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Center(
                child: Image.asset('assets/sale1.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Center(
                child: Image.asset('assets/delivery.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double startY = 0;
    double startX = size.width / 2;

    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + 4), paint);
      startY += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

