import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translatorapp/cats_facts_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 // List list = [for(int i=0; i < 10; i++) i]; //массив с помощью цикла от 0 до 10
 List<CatsFactsModel> list = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cats',
          style: TextStyle(fontSize: 25),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                     decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25)
                     ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          list[index].fact.toString(),
                          style: const TextStyle(
                            fontSize: 25),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: getCatsFacts(), 
                  child: const Icon(Icons.add,
                 ),
                ),
                ElevatedButton(
                  onPressed: (){
                    list.removeLast();
                    setState(() {});
                  },
                  child: const Icon(Icons.remove,
                 ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  getCatsFacts() async {
    final dio = Dio();
    // ignore: unused_local_variable
    final response = await dio.get('https://catfact.ninja/fact');
    final result = CatsFactsModel.fromJson(response.data);
    list.add(result);
    setState(() {});
  }
}