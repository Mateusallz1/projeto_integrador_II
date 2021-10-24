import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:projeto_hospede_se/models/user.dart';
import 'package:projeto_hospede_se/models/hotel.dart';
import 'package:projeto_hospede_se/models/hotel_manager.dart';
import 'package:projeto_hospede_se/helpers/validators.dart';
import 'package:projeto_hospede_se/services/auth_service.dart';
import 'package:projeto_hospede_se/widgets/auth_check.dart';
import 'package:projeto_hospede_se/pages/components/snackbar_alert.dart';
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
  String? city;
  String? state;
  String? country;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void save() async {
    try {
      await context.read<AuthService>().signUp(UserApp(host: true, name: name.text, email: email.text, password: passwd.text, confirmPassword: cpasswd.text));
      String? userId = context.read<AuthService>().getUser().id;
      await context.read<HotelManager>().signUpHotel(Hotel(userId: userId, name: nameHotel.text, phone: phone.text, address: address.text, number: number.text, city: city, state: state, country: country, rating: value.toInt()));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthCheck()),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarAlert(e.message));
    }
  }

  double value = 5; // RATING HOTEL
  int cstep = 0;

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
              currentStep: cstep,
              onStepContinue: () {
                final isLastStep = cstep == getSteps().length - 1;
                if (!isLastStep) {
                  setState(() => cstep++);
                } else {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    save();
                  }
                }
              },
              onStepCancel: () {
                final isFirstStep = cstep == 0;
                if (!isFirstStep) {
                  setState(() => cstep--);
                }
              },
              controlsBuilder: (BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                final isLastStep = cstep == getSteps().length - 1;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (cstep != 0)
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
          state: cstep > 0 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 0,
          title: const Text('Usuário'),
          content: Column(
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
                keyboardType: TextInputType.emailAddress,
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
                validator: (cpasswd) => Validators.comparePassword(passwd.text, cpasswd!),
                decoration: inputDecorationSignUp('Confirmar Senha', const Icon(Icons.password_sharp)),
              ),
            ],
          ),
        ),
        Step(
          state: cstep > 1 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 1,
          title: const Text('Informações Hotel'),
          content: Column(
            children: [
              TextFormField(
                controller: nameHotel,
                validator: (name) => Validators.validateName(name!),
                decoration: inputDecorationSignUp('Nome Hotel', const Icon(Icons.business)),
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                controller: phone,
                validator: (phone) => Validators.validatePhone(phone!),
                decoration: inputDecorationSignUp('Fone', const Icon(Icons.call)),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        Step(
          state: cstep > 2 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 2,
          title: const Text('Classificação'),
          content: Column(
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
        Step(
          state: cstep > 3 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 3,
          title: Row(
            children: const [
              Text('Endereço'),
            ],
          ),
          content: Column(
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
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CSCPicker(
                  countrySearchPlaceholder: "País",
                  stateSearchPlaceholder: "Estado",
                  citySearchPlaceholder: "Cidade",
                  //
                  countryDropdownLabel: "País",
                  stateDropdownLabel: "Estado",
                  cityDropdownLabel: "Cidade",
                  //
                  dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white70,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  dropdownDialogRadius: 10,

                  onCountryChanged: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      state = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
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
      ];
}
