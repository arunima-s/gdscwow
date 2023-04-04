// import 'package:flutter/material.dart';

// class LoginSCreen extends StatelessWidget {
//   const LoginSCreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(tLoginTitle,style: Theme.of(context).textTheme.displayLarge),
//               Text(tLoginSubTitle, style: Theme.of(context).textTheme.bodyLarge),


//               Form(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 20.0),
//                   child: Column(,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.person_outline_outlined), 
//                         labelText: temail,
//                         hintText: temail,
//                         border: OutlineInputBorder()
//                       ),
//                     ),
//                      SizedBox(height: foreheight,) 
//                       TextFormField(
//                       decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.person_outline_outlined), 
//                         labelText: tpassword,
//                         hintText: tpassword, 
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           onPressed: null,
//                           icon: Icon(Icons.remove.red.eye.sharp),
//                         ),  
//                       ),
//                     ),
//                     const SizedBox(height: tformheight-2),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton,
//                       onPressed:(){},
                    
//                     ),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton,
//                        onPressed:() {},
//                        child: Text(tlogin.toUpperCase()),
//                      )
//                     ),
//                   ], 
//                 ),
//               )
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
