import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/hq720_live.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility:true,
            thickness: 10,
           trackVisibility: true,
            child: ListView.separated(
              controller: scrollController,
                itemBuilder: (context,i)=>Loading(),
                separatorBuilder: (context,_)=>const SizedBox(height: 10,),
                itemCount: 30),
          ),
        ),
      ),
    );
  }

  Widget Loading() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Shimmer.fromColors(
                enabled: true,
                baseColor:Colors.grey[600]!,
                highlightColor:  Colors.grey[400]!,
                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.grey[600]!,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                enabled: true,baseColor:Colors.grey[600]!,
                highlightColor:  Colors.grey[400]!,
                child: Container(height: 30, width: 150,color: Colors.grey[600],),
               ),
             const  SizedBox(height: 15,),
              Shimmer.fromColors(
                enabled: true,baseColor:Colors.grey[600]!,
                highlightColor:  Colors.grey[400]!,
                child: Container(height: 30, width: 100,color: Colors.grey[600],),
               ),
              const  SizedBox(height: 15,),
              Shimmer.fromColors(
                enabled: true,baseColor:Colors.grey[600]!,
                highlightColor:  Colors.grey[400]!,
                child: Container(height: 30, width: 70,color: Colors.grey[600],),
               ),


            ],
          )
        ],
      ),
    );
  }
}
