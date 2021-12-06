import 'package:audioplayers/audioplayers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lang/providers/verbprovider.dart';
import 'package:lang/ui/widgets/answer.dart';
import 'package:lang/utils/setup.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioCache player = AudioCache();
  @override
  void initState() {
    super.initState();
    backend<VerbProvider>().setVerbs().then((value) => value);
  }

  List<Widget> items() {
    List<Widget> lst = [];
    backend<VerbProvider>().verbs.forEach((verb) {
      lst.add(Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade300)],
              border: Border.all(width: 1, color: Colors.grey)),
          child: Draggable<String>(
            data: verb.en,
            child: AnswerChild(color: Colors.white, data: verb.en),
            feedback: AnswerChild(color: Colors.grey.shade200, data: verb.en),
          )));
    });
    lst.shuffle();
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VerbProvider>(builder: (context, verb, child) {
      return verb.isbusy
          ? const Scaffold(
              body: Center(
              child: CircularProgressIndicator(),
            ))
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber.shade400,
                title: Text(
                  "Your Score : ${verb.score ?? 0}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                centerTitle: true,
              ),
              body: Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    DragTarget<String>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          color: Colors.grey,
                          strokeWidth: 2,
                          dashPattern: const [8],
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: verb.color,
                              child: Center(
                                  child: Text(
                                verb.verbs[0].ru,
                                textScaleFactor: 2,
                              )),
                            ),
                          ),
                        );
                      },
                      onAccept: (data) {
                        if (data == verb.verbs[0].en) {
                          verb.verbs[0].points =
                              int.parse("${verb.verbs[0].points}") + 1;
                          verb.update(verb.verbs[0]);
                          player.play("audio/correct.mp3");
                          verb.isRight = true;
                          ChangeNotifier();
                        } else {
                          verb.color = Colors.red;
                          player.play("audio/wrong.mp3");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Wrap(
                          runSpacing: 10,
                          spacing: 15,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: items(),
                        ))
                  ],
                ),
              )),
            );
    });
  }
}
