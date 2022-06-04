import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_windows/webview_windows.dart';
import 'dart:async';
class LoadingPage extends StatefulWidget {
  final bool isNormal;

   LoadingPage({required this.isNormal});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  //Controllers
  final _controller = WebviewController();
  var scrollController = ScrollController();
  final _textController = TextEditingController();
//bool to end loading screen
  bool endLoading= false;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    try {
      //init web view and load url if the app is normal user or not
      await _controller.initialize();
      _controller.url.listen((url) {
        widget.isNormal? _textController.text = "https://www.facebook.com/":_textController.text = "https://twitter.com/i/flow/login?input_flow_data=%7B%22requested_variant%22%3A%22eyJsYW5nIjoiYXIifQ%3D%3D%22%7D";
      });

      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Code: ${e.code}'),
                  Text('Message: ${e.message}'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
      });
    }
  }
  Widget myWeb() {
    if (!_controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Webview(
                          _controller,
                          permissionRequested: _onPermissionRequested,
                        ),
                        StreamBuilder<LoadingState>(
                            stream: _controller.loadingState,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == LoadingState.loading) {
                                return LinearProgressIndicator();
                              } else {
                                return SizedBox();
                              }
                            }),
                      ],
                    ))),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var Size= MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ConditionalBuilder(
          fallback: (context)=> Container(
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
              condition: widget.isNormal,
            ),
          ),
          builder: (context)=>myWeb(),
          condition: endLoading,
        ),
      ),
    );
  }


  Widget Loading() {
    _controller.loadUrl("https://www.youtube.com/watch?v=sqyn-73GPJw");
    Future.delayed(const Duration(seconds: 4),(){
      setState(() {
        endLoading=true;
      });
    });
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
    _controller.loadUrl("https://www.facebook.com/");
        Future.delayed(const Duration(seconds: 4),(){
      setState(() {
       endLoading=true;
      });
    });
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
  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}
