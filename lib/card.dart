import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class CardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final formKey = new GlobalKey<FormState>();
  String _name;
  String _number;
  String _month;
  String _year;
  String _cvv;
  static const platform = const MethodChannel('flutter.experiment');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void validateAndSave(BuildContext context) {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      print(
          'Form is valid. name: $_name number: $_number month: $_month year: $_year cvv:$_cvv');
      getMessageFromNativePlatform(context);
      // new RaisedButton(
      // onPressed: () {
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogo()));
      // },
      // );
    } else {
      print('Form is invalid');
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Form is invalid')));
      Offset(30, 400);
      //showInSnackBar('Form is invalid');
    }
  }
void showInSnackBar(String value) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      //style: textStyle,
    ),
    //backgroundColor: colo,
  ));
}
  Future<void> getMessageFromNativePlatform(BuildContext context) async {
    final result = await platform.invokeMethod('getMessageFromNativePlatform', {
      "name": _name,
      "number": _number,
      "expYear": _year,
      "expMonth": _month,
      "cvv": _cvv
    });
    setState(() {
      print(result);
      showInSnackBar('check');
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: result));
      // Offset(30, 400);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Login'),
        ),
        body: Builder(
          builder: (context) => new Container(
                padding: EdgeInsets.all(25.0),
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Name on Card'),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                           BlacklistingTextInputFormatter(
                              new RegExp('[\\.|\\,]')),
                        ],
                        
                        validator: (value) =>
                            value.isEmpty ? 'Name cant be empty' : null,
                        onSaved: (value) => _name = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText:
                                'Card Number(The 16 digits on front of your card)*'),
                        style:
                            new TextStyle(fontSize: 12.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                        //obscureText: true,
                        validator: (String value) {
                          if(value.length < 16)
                             return 'Name must be 16 charater';
                          else
                             return null;
                         },

                         onSaved: (value) => _number = value,
                      ),
 

                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: TextFormField(
                                    decoration:
                                        new InputDecoration(labelText: 'MM*'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        value.isEmpty ? 'Invalid input' : null,
                                    onSaved: (value) => _month = value,
                                  ))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: TextFormField(
                                    decoration:
                                        new InputDecoration(labelText: 'YY*'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        value.isEmpty ? 'Invalid Input' : null,
                                    onSaved: (value) => _year = value,
                                  ))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration:
                                        new InputDecoration(labelText: 'CVV*'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) =>
                                        value.isEmpty ? 'Invalid Input' : null,
                                    onSaved: (value) => _cvv = value,
                                  ))),
                        ],
                      ),
                      RaisedButton(
                        child: new Text('Login',
                            style: new TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          validateAndSave(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
        ));
  }
}
