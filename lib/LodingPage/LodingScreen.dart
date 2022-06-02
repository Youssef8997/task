import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  final bool isNormal;

  var scrollController = ScrollController();

   LoadingPage({required this.isNormal});
  @override
  Widget build(BuildContext context) {
    var Size= MediaQuery.of(context).size;
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
          child: ConditionalBuilder(
            builder:(context)=> ListView.separated(
              controller: scrollController,
                itemBuilder: (context,i)=>Loading(),
                separatorBuilder: (context,_)=>const SizedBox(height: 10,),
                itemCount: 30),
            fallback: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage("https://i.pinimg.com/564x/5b/ac/75/5bac7554c5c6ce538a7dcf00b7de88c4.jpg",),radius: 90),
                  SizedBox(
                    height: Size.height-30,
                    width:Size.width,
                    child: ListView.separated(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,i)=>sacoundLoading(),
                        separatorBuilder: (context,_)=>const SizedBox(height: 10,),
                        itemCount: 1),
                  ),
                ],
              ),
            ),
            condition: isNormal,
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
  Widget sacoundLoading() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            enabled: true,baseColor:Colors.grey[600]!,
            highlightColor:  Colors.grey[400]!,
            child: Container(height: 30, width: 200,color: Colors.grey[600],),
          ),
          const SizedBox(height: 20,),
          Shimmer.fromColors(
            enabled: true,
            baseColor:Colors.grey[600]!,
            highlightColor:  Colors.grey[400]!,
            child: Container(
              height: 300,
              width: 300,
              color: Colors.grey[600]!,
            ),
          ),
          const  SizedBox(height: 15,),
          Shimmer.fromColors(
            enabled: true,baseColor:Colors.grey[600]!,
            highlightColor:  Colors.grey[400]!,
            child: Container(height: 30, width: 300,color: Colors.grey[600],),
           ),
          const  SizedBox(height: 15,),

        ],
      ),
    );
  }

}
