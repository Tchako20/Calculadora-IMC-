import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

   final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _height=TextEditingController();
  final _weight=TextEditingController();
   String textMenssage="";
   double? _bmi;

  void _calculateBmi () {
    final double? height = double.tryParse(_height.value.text);
    final double? weight = double.tryParse(_weight.value.text);
    
 if(height == null || height<=0 || weight==null || weight<=0 ){
  
   setState(() {    
   textMenssage="Error,Please Enter Your Details!";
     }
    );  
    return; 
  }
  setState(() {    
  _bmi=weight / (height*height);
  if(_bmi! <18.50){
   textMenssage="You Are Under The Ideal Weight!";
  }else if(_bmi! <25.00){
   textMenssage="You're Healthy!";
  }else if(_bmi! <30.00){
   textMenssage="You're Above The Ideal Weight!";
  }
     
  });
 }

final maskHeight = MaskTextInputFormatter(mask: '#.##');final maskWeight = MaskTextInputFormatter(mask: '##.##');
//MaskText for Height and Weight  

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(  
        title: Text(widget.title),
      ),
      body: Center(     
          child: SizedBox (
             width: 320,
             child:Card(
              color: Colors.white,
              elevation: 10, 
              child:  Padding(
               padding: const EdgeInsets.all(30),
              child:Column(
                mainAxisSize: MainAxisSize.min,
              children:[             
            TextField(              
             style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
               border: OutlineInputBorder(),
               labelText: "Height",
               prefixIcon: Icon(Icons.person),
               suffixText: 'M.',
               hintText: '0.00 M',
             ),
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
             controller: _height,
              inputFormatters: [maskHeight],
            ),//TextField Height
            TextField(
             style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
               border: OutlineInputBorder(),
               labelText: "Weight",
               prefixIcon: Icon(Icons.person),
               suffixText: 'KG',
               hintText: '00.00 KG',
               ),
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
             controller: _weight,
              inputFormatters: [maskWeight],
            ),//TextField Weight
             Text(_bmi==null?'Please Enter Your Details!':_bmi!.toStringAsFixed(2),
             style: const TextStyle(fontSize: 22),) ,
             Text(textMenssage,style: const TextStyle(fontSize: 18),
             ),//Start Text
             ElevatedButton(
              onPressed: _calculateBmi, 
              child: const Text("Calculate",
              style: TextStyle(fontSize: 18),)
               ), //Button calculate
             ],       
            ),
           ),
          ),
         ),
        ),
     
     );
  }
}
