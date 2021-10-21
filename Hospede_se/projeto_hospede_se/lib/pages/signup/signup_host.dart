import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/styles/style.dart';

class SignUpHostPage extends StatefulWidget {
  const SignUpHostPage({Key? key}) : super(key: key);

  @override
  _SignUpHostPage createState() => _SignUpHostPage();
}

class _SignUpHostPage extends State<SignUpHostPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final passwd = TextEditingController();
  final cpasswd = TextEditingController();

  final nameHotel = TextEditingController();
  final phone = TextEditingController();

  final address = TextEditingController();
  final number = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void save() async {
    try {
      await context.read<AuthService>().signUp(UserApp(host: true, name: name.text, email: email.text, password: passwd.text, confirmPassword: cpasswd.text));
      String? userId = context.read<AuthService>().getUser().id;
      await context.read<HotelManager>().signUpHotel(Hotel(userId: userId, name: nameHotel.text, phone: phone.text, address: address.text, number: number.text, city: city.text, state: state.text, country: country.text, rating: value.toInt()));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthCheck()),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  double value = 5; // RATING HOTEL
  int c_step = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
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
                    if (!Validators.comparePassword(passwd.text, cpasswd.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senhas não coincidem'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    save();
                  }
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
                  decoration: inputDecorationSignUp('Confirmar Senha', const Icon(Icons.password_sharp)),
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
                  validator: (name) => Validators.validateName(name!),
                  decoration: inputDecorationSignUp('Nome Hotel', const Icon(Icons.business)),
                ),
                TextFormField(
                  controller: phone,
                  validator: (phone) => Validators.validatePhone(phone!),
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
                  controller: address,
                  validator: (address) => Validators.validateText(address!),
                  decoration: inputDecorationSignUp('Endereço', const Icon(Icons.password)),
                ),
                TextFormField(
                  controller: number,
                  validator: (number) => Validators.validateText(number!),
                  decoration: inputDecorationSignUp('Número', const Icon(Icons.markunread_mailbox)),
                ),
                TextFormField(
                  controller: city,
                  validator: (city) => Validators.validateText(city!),
                  decoration: inputDecorationSignUp('Cidade', const Icon(Icons.add_location_alt)),
                ),
                TextFormField(
                  controller: state,
                  validator: (state) => Validators.validateText(state!),
                  decoration: inputDecorationSignUp('Estado', const Icon(Icons.add_location_alt)),
                ),
                TextFormField(
                  controller: country,
                  validator: (country) => Validators.validateText(country!),
                  decoration: inputDecorationSignUp('País', const Icon(Icons.add_location_alt)),
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