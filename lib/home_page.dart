import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

   final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _altura=TextEditingController();
  final _peso=TextEditingController();
   String txt1="";
   double? _imc;

  void _calculoImc () {
    final double? altura = double.tryParse(_altura.value.text);
    final double? peso = double.tryParse(_peso.value.text);
    
 if(altura == null || altura<=0 || peso==null || peso<=0 ){
  
   setState(() {    
   txt1="Error,Por favor insira seus dados";
     }
    );  
    return; 
  }
  setState(() {    
  _imc=peso / (altura*altura);
  if(_imc! <18.5){
   txt1="Você esta abaixo do peso ideal";
  }else if(_imc! <25.00){
   txt1="Você esta saudavel  ";
  }else if(_imc! <30.00){
   txt1="Você esta acima do peso ideal";
  }
     
  });
 }

var mask1 = MaskTextInputFormatter(mask: '#.##');
var mask2 = MaskTextInputFormatter(mask: '##.##');

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
               labelText: "Altura",
               prefixIcon: Icon(Icons.person),
               suffixText: 'ALT.',
               hintText: '0.00',
             ),
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
             controller: _altura,
              inputFormatters: [mask1],
            ),
            TextField(
             style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
               border: OutlineInputBorder(),
               labelText: "Peso",
               prefixIcon: Icon(Icons.person),
               suffixText: 'KG.',
               hintText: '00.00',
               ),
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
             controller: _peso,
              inputFormatters: [mask2],
            ),             
             Text(_imc==null?'Informe seus dados':_imc!.toStringAsFixed(2),
             style: const TextStyle(fontSize: 25),) ,
             Text(txt1,style: const TextStyle(fontSize: 15),),
             ElevatedButton(
              onPressed: _calculoImc, 
              child: const Text("Calcular")), 
              ],       
            ),
           ),
          ),
        ),
      ),
     
    );
  }
}
