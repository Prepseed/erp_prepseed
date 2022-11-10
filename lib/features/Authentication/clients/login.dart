
import 'package:flutter/material.dart';

import '../../../common/constant/color_palate.dart';
import '../../../common/widgets/exceptionHandler_widgets.dart';
import '../../../networking/response.dart';
import 'login_bloc.dart';
import 'login_model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovieList(),
        child: StreamBuilder<dynamic>(
          stream: _bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data!.message);
                  break;
                case Status.COMPLETED:
                  return ClientList(clientList: snapshot.data!.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => _bloc.fetchMovieList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ClientList extends StatefulWidget {
  final List<Clients>? clientList;

  const ClientList({Key? key, this.clientList}) : super(key: key);

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  String? selectedid;
  bool selected = false;
  bool isVisited = false;
  double iconHeight = 300;
  double dropSec = 250;

  @override
  Widget build(BuildContext context) {
    // final _myJson = Map.fromIterable(widget.clientList!, key: (e) => e.id, value: (e) => e.name);
    return Column(
/*      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,*/
      children: [
        Container(
          alignment: Alignment.center,
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: iconHeight,
          child: Stack(
            children: [
              AnimatedPositioned(
                  width: selected ? 150.0 : MediaQuery.of(context).size.width,
                  height: selected ? 50.0 : 200.0,
                  top: selected ? 50.0 : 20.0,
                  duration: const Duration(seconds: 2),
                  child: Image.asset('assets/images/logo.png'))
            ],
          ),
        ),
        // SizedBox(height: 45,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: dropSec,
                  child: Stack(
                    children: [AnimatedPositioned(
                      width: MediaQuery.of(context).size.width - 50,
                      height: selected ? 50.0 : 70.0,
                      top: selected ? 20.0 : 0.0,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: InkWell(
                        onTap: () {
                          /*setState((){
                            if(!isVisited){
                              print('object');
                              isVisited = true;
                              selected = !selected;
                              iconHeight =  iconHeight == 300 ? 100 : 300;
                            }
                          });*/
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                boxShadow:  [
                                  BoxShadow(
                                      color: Constants.shadowColor,
                                      blurRadius: 5.0,
                                      offset: Offset(5, 6)
                                  )],
                                color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                menuMaxHeight: 500,
                                hint: const Text("Select"),
                                value: selectedid,
                                onTap: (){
                                  setState((){
                                    if(!isVisited){
                                      isVisited = true;
                                      selected = !selected;
                                      iconHeight =  iconHeight == 300 ? 100 : 300;
                                      dropSec = dropSec == 250 ? 100 : 250;
                                    }
                                  });
                                },
                                onChanged: ( newValue) async {
                                  setState((){
                                    isVisited = false;
                                    selected = !selected;
                                    iconHeight =  iconHeight == 300 ? 100 : 300;
                                    dropSec = dropSec == 250 ? 100 : 250;
                                  });
                                  setState(() {
                                    selectedid = newValue!;
                                  });
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                isExpanded: true,
                                items: widget.clientList!.map((Clients client) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.bottomCenter,
                                      enabled: true,
                                      value: client.sId,
                                      child: Row(
                                        children: [
                                          /*CachedNetworkImage(
                                            imageUrl: client.logo ?? "",
                                            errorWidget: (context,url,error) => Icon(Icons.error),
                                            placeholder: (context, url) => const CircleAvatar(
                                              backgroundColor: Colors.amber,
                                            ),
                                            imageBuilder: (context, image) => CircleAvatar(
                                              backgroundImage: image,
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ),*/
                                          SizedBox(width: 10,),
                                          Expanded(child: Text(client.name!,)),
                                        ],
                                      )
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )],
                  ),
                ),
              ),
            ),
          ),
        ),


        // SizedBox(height: 70,),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Constants.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              onPressed: (){
                /*setState((){
                  isVisited = false;
                  selected = !selected;
                  iconHeight =  iconHeight == 300 ? 100 : 300;
                  dropSec = dropSec == 250 ? 100 : 250;
                });*/
/*                if (_prepSeed_login.currentState!.validate()) {
                  _myJson.forEach((element) async {
                    if(element['_id'] == selectedid){
                      print('matched id:'+ element['_id'].toString());

                      institutename = element['name']!;
                      institutelogo = element['logo']!;

                      final pref = await SharedPreferences.getInstance();
                      pref.setString('InstituteName', institutename!);
                      pref.setString('InstituteLogo', institutelogo!);
                    }else{
                      // print('nm');
                    }
                  });
                  (institutename != null)?
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => signIn_signUp(clientname: institutename!,clientlogo: institutelogo!,)))
                      : ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(const SnackBar(
                    content: Text("Select your Institute / Collage name"),
                  ));
                }else{
                  print('oops..');
                  return null;
                }*/
              }, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text('Next', style: GoogleFonts.poppins(fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Constants.backgroundColorlight),),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward,
                    color: Constants.backgroundColorlight),
              )
            ],
          )),
        )
      ],
    );
  }
}
