import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/models/room.dart';
import 'package:projeto_hospede_se/pages/rooms/room_manager.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/styles/style.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final title = TextEditingController();
  final description = TextEditingController();
  final number = TextEditingController();
  final quantity = TextEditingController();
  //final status = TextEditingController();
  bool status = true;
  final price = TextEditingController();
  final guestCount = TextEditingController();
  final bedCount = TextEditingController();
  final bathCount = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void signUpRoom() async {
    try {
      final hotelId = context.read<HotelManager>().getHotel().id;
      await context.read<RoomManager>().signUpRoom(Room(hotelId: hotelId, number: int.parse(number.text), quantity: int.parse(quantity.text), title: title.text, description: description.text, status: status, price: double.parse(price.text), guestCount: int.parse(guestCount.text), bedCount: int.parse(bedCount.text), bathCount: int.parse(bathCount.text)));
      // CARREGAR NOVAMENTE A LISTA DE QUARTOS
      Navigator.pop(context);
      
    } on SignUpRoomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  int c_step = 0;

  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Cadastro de Quarto'),
          centerTitle: true,
          backgroundColor: Colors.green.shade800,
          elevation: 5,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.green),
          ),
          child: Form(
            key: formKey,
            child: Stepper(
              type: StepperType.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              steps: getSteps(),
              currentStep: c_step,
              onStepContinue: () {
                final isLastStep = c_step == getSteps().length - 1;
                if (!isLastStep) {
                  setState(() => c_step++);
                } else {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                  signUpRoom();
                }
              },
              onStepCancel: () {
                final isFirstStep = c_step == 0;
                if (!isFirstStep) {
                  setState(() => c_step--);
                }
              },
              controlsBuilder: (BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                final isLastStep = c_step == getSteps().length - 1;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (c_step != 0)
                      ElevatedButton(
                        onPressed: onStepCancel,
                        child: const Text('Voltar'),
                        style: elevatedButton,
                      ),
                    ElevatedButton(
                      onPressed: onStepContinue,
                      child: Text(isLastStep ? 'Confirmar' : 'Próximo'),
                      style: elevatedButton,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

  List<Step> getSteps() => [
    Step(
      state: c_step > 0 ? StepState.complete : StepState.disabled,
      isActive: c_step >= 0,
      title: const Text('Sobre o Quarto'),
      content: Container(
        child: Column(
          children: [
            TextFormField(
              controller: title,
              validator: (title) => Validators.validateText(title!),
              decoration: inputDecorationSignUp('Título', const Icon(Icons.create)
              ),
            ),
            TextFormField(
              controller: description,
              validator: (description) => Validators.validateText(description!),
              decoration: inputDecorationSignUp('Descrição', const Icon(Icons.title)),
            ),
            TextFormField(
              controller: number,
              validator: (number) => Validators.validateText(number!),
              decoration: inputDecorationSignUp('Número', const Icon(Icons.short_text)),
            ),
          ]
          ),
        ),
      ),
    Step(
      state: c_step > 1 ? StepState.complete : StepState.disabled,
      isActive: c_step >= 1,
      title: const Text('Informações Quarto'),
      content: Container(
        child: Column(
          children: [
            TextFormField(
              controller: quantity,
              validator: (quantity) => Validators.validateNumber(quantity!),
              decoration: inputDecorationSignUp('Quantidade', const Icon(Icons.add)),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: price,
              validator: (price) => Validators.validateNumber(price!),
              decoration: inputDecorationSignUp('Preço', const Icon(Icons.attach_money)),
              keyboardType: TextInputType.number,
            ),
          ]
          ),
        ),
      ),
    Step(
      state: c_step > 2 ? StepState.complete : StepState.disabled,
      isActive: c_step >= 2,
      title: const Text('Serviços'),
      content: Container(
        child: Column(
          children: [
            TextFormField(
              controller: guestCount,
              validator: (guestCount) => Validators.validateNumber(guestCount!),
              decoration: inputDecorationSignUp('Capacidade', const Icon(Icons.add)),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: bedCount,
              validator: (bedCount) => Validators.validateNumber(bedCount!),
              decoration: inputDecorationSignUp('Camas', const Icon(Icons.add)),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: bathCount,
              validator: (bathCount) => Validators.validateNumber(bathCount!),
              decoration: inputDecorationSignUp('Banheiros', const Icon(Icons.add)),
              keyboardType: TextInputType.number,
            ),
          ]
        ),
      ),
    )
  ];
}
