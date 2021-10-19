import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class SignUpHostPage extends StatefulWidget {
  const SignUpHostPage({Key? key}) : super(key: key);

  @override
  _SignUpHostPage createState() => _SignUpHostPage();
}

//FORM PARA VALIDAR OS CAMPOS
//CONTROLLER PRA O FIELD
//CRIA UM OBJETO USER E UM OBJETO HOTEL
class _SignUpHostPage extends State<SignUpHostPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwd = TextEditingController();
  final cpasswd = TextEditingController();
  final nameHotel = TextEditingController();
  final phone = TextEditingController();

  double value = 5; // RATING HOTEL
  int c_step = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
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
          title: const Text('Usuário'),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  validator: (name) => Validators.validateName(name!),
                  decoration: inputDecorationSignUp('Nome Completo', const Icon(Icons.person)),
                ),
                TextFormField(
                  controller: email,
                  validator: (email) => Validators.validateEmail(email!),
                  decoration: inputDecorationSignUp('Email', const Icon(Icons.email)),
                ),
                TextFormField(
                  controller: passwd,
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                  decoration: inputDecorationSignUp('Senha', const Icon(Icons.password)),
                ),
                TextFormField(
                  controller: cpasswd,
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                  decoration: inputDecorationSignUp('Senha', const Icon(Icons.password_sharp)),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: c_step > 1 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 1,
          title: const Text('Informações Hotel'),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: nameHotel,
                  validator: (name) => Validators.validateText(name!),
                  decoration: inputDecorationSignUp('Nome Hotel', const Icon(Icons.business)),
                ),
                TextFormField(
                  controller: phone,
                  validator: (phone) => Validators.validateText(phone!),
                  decoration: inputDecorationSignUp('Fone', const Icon(Icons.call)),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: c_step > 2 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 2,
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
          state: c_step > 3 ? StepState.complete : StepState.disabled,
          isActive: c_step >= 3,
          title: Row(
            children: const [
              Text('Endereço'),
            ],
          ),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (address) => Validators.validateText(address!),
                  decoration: inputDecorationSignUp('Endereço', const Icon(Icons.password)),
                ),
                TextFormField(
                  validator: (number) => Validators.validateText(number!),
                  decoration: inputDecorationSignUp('Número', const Icon(Icons.markunread_mailbox)),
                ),
                TextFormField(
                  validator: (city) => Validators.validateText(city!),
                  decoration: inputDecorationSignUp('Cidade', const Icon(Icons.add_location_alt)),
                ),
                TextFormField(
                  validator: (state) => Validators.validateText(state!),
                  decoration: inputDecorationSignUp('Estado', const Icon(Icons.add_location_alt)),
                ),
                TextFormField(
                  validator: (country) => Validators.validateText(country!),
                  decoration: inputDecorationSignUp('Estado', const Icon(Icons.add_location_alt)),
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
