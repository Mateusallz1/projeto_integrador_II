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

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void save() async {
    try {
      await context.read<AuthService>().signUp(UserApp(
          host: true,
          name: name.text,
          email: email.text,
          password: passwd.text,
          confirmPassword: cpasswd.text));

      String? userId = context.read<AuthService>().getUser().id;

      await context.read<HotelManager>().signUpHotel(Hotel(
          userId: userId,
          name: nameHotel.text,
          phone: phone.text,
          address: address.text,
          number: number.text,
          city: city,
          state: state,
          country: country,
          rating: value.toInt()));

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
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: Colors.green.shade800, background: Colors.white),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back,
                            color: Colors.green.shade800),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Criar Conta",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
                Stepper(
                  type: StepperType.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  steps: getSteps(),
                  currentStep: cstep,
                  onStepContinue: () {
                    final isLastStep = cstep == getSteps().length - 1;
                    if (formKeys[cstep].currentState!.validate()) {
                      if (!isLastStep) {
                        setState(() => cstep++);
                      } else {
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
                  controlsBuilder: (BuildContext context,
                      {VoidCallback? onStepContinue,
                      VoidCallback? onStepCancel}) {
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
              ],
            ),
          ),
        ),
      );
  List<Step> getSteps() => [
        Step(
          state: cstep > 0 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 0,
          title: const Text('Usuário'),
          content: Form(
            key: formKeys[0],
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  validator: (name) => Validators.validateName(name!),
                  decoration: inputDecorationSignUp(
                      'Nome Completo', const Icon(Icons.person)),
                ),
                TextFormField(
                  controller: email,
                  validator: (email) => Validators.validateEmail(email!),
                  decoration:
                      inputDecorationSignUp('Email', const Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: passwd,
                  obscureText: true,
                  validator: (passwd) => Validators.validatePassword(passwd!),
                  decoration: inputDecorationSignUp(
                      'Senha', const Icon(Icons.password)),
                ),
                TextFormField(
                  controller: cpasswd,
                  obscureText: true,
                  validator: (cpasswd) =>
                      Validators.comparePassword(passwd.text, cpasswd!),
                  decoration: inputDecorationSignUp(
                      'Confirmar Senha', const Icon(Icons.password_sharp)),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: cstep > 1 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 1,
          title: const Text('Informações do Hotel'),
          content: Form(
            key: formKeys[1],
            child: Column(
              children: [
                TextFormField(
                  controller: nameHotel,
                  validator: (name) => Validators.validateName(name!),
                  decoration: inputDecorationSignUp(
                      'Nome Hotel', const Icon(Icons.business)),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  controller: phone,
                  validator: (phone) => Validators.validatePhone(phone!),
                  decoration:
                      inputDecorationSignUp('Fone', const Icon(Icons.call)),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: cstep > 2 ? StepState.complete : StepState.disabled,
          isActive: cstep >= 2,
          title: const Text('Classificação'),
          content: Form(
            key: formKeys[2],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Text(value.round().toString()),
                        ],
                      ),
                    )
                  ],
                ),
                Slider(
                  value: value,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: Colors.green,
                  onChanged: (value) => setState(() => this.value = value),
                ),
              ],
            ),
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
          content: Form(
            key: formKeys[3],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: address,
                  validator: (address) => Validators.validateText(address!),
                  decoration: inputDecorationSignUp(
                      'Endereço', const Icon(Icons.password)),
                ),
                TextFormField(
                  controller: number,
                  validator: (number) => Validators.validateText(number!),
                  decoration: inputDecorationSignUp(
                      'Número', const Icon(Icons.markunread_mailbox)),
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
        ),
      ];
}
