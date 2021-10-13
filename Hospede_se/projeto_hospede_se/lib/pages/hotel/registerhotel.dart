import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class RegisterHotel extends StatefulWidget {
  const RegisterHotel({Key? key}) : super(key: key);

  @override
  _RegisterHotel createState() => _RegisterHotel();
}

class _RegisterHotel extends State<RegisterHotel> {
  double value = 5;
  int c_step = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('Cadastro do Hotel'),
          centerTitle: true,
          backgroundColor: Colors.green.shade800,
          elevation: 5,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.green),
          ),
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
                // SEND TO FIREBASE
              }
            },
            onStepCancel: () {
              final isFirstStep = c_step == 0;
              if (!isFirstStep) {
                setState(() => c_step--);
              }
            },
            controlsBuilder: (BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: onStepCancel,
                      child: const Text('Voltar'),
                      style: elevatedButton,
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: onStepContinue,
                      child: const Text('Próximo'),
                      style: elevatedButton,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
  List<Step> getSteps() => [
        Step(
          state: c_step > 0 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 0,
          title: const Text('Informações Gerais'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome do Hotel',
                    icon: const Icon(
                      Icons.business,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: const Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Fone',
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: c_step > 1 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 1,
          title: const Text('Classificação'),
          content: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.green,
                    ),
                    Text(value.round().toString())
                  ],
                ),
                Slider(
                  value: value,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: Colors.green,
                  //label: value.round().toString(),
                  onChanged: (value) => setState(() => this.value = value),
                )
              ],
            ),
          ),
        ),
        Step(
          state: c_step > 2 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 2,
          title: Row(
            children: const [
              Text('Endereço'),
            ],
          ),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Endereco',
                    icon: const Icon(
                      Icons.edit_location,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Número',
                    icon: const Icon(
                      Icons.markunread_mailbox,
                      color: Colors.green,
                    ),
                    enabledBorder: inputBorderGreen,
                    focusedBorder: inputFocusedBorderGreen,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: null,
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  label: const Text('Sua Localização'),
                ),
              ],
            ),
          ),
        ),
      ];
}
