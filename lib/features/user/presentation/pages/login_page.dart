import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  static Country _selectedFilterDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("20");
  // String? _countryCode = _selectedFilterDialogCountry.phoneCode;
  @override
  void dispose() {
    _phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          children: [
            const Text(
              "Verify your phone number",
              style: TextStyle(
                  color: tabColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              "WhatsApp Clone will send you SMS message (carrier charges may apply) to verify your phone number. Enter the country code and phone number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ListTile(
              onTap: () {
                _openFilteredCountryPickerDialog();
              },
              title: SelectCountryWidget(
                country: _selectedFilterDialogCountry,
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: tabColor))),
                  width: 60,
                  child: Text(
                    _selectedFilterDialogCountry.phoneCode!,
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: tabColor))),
                    child: TextField(
                      controller: _phoneController,
                      style: TextStyle(color: whiteColor),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                )
              ],
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpPage(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                color: messageColor,
                padding: const EdgeInsets.all(5),
                height: 40,
                width: 120,
                child: const Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.greenAccent,
            ),
            child: CountryPickerDialog(
              titlePadding: const EdgeInsets.all(8.0),
              searchCursorColor: tabColor,
              searchInputDecoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: whiteColor),
              ),
              isSearchable: true,
              title: const Text(
                "Select your phone code",
                style: TextStyle(color: whiteColor),
              ),
              onValuePicked: (Country country) {
                setState(() {
                  _selectedFilterDialogCountry = country;
                });
              },
              itemBuilder: _buildDialogItem,
            )));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: tabColor, width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(
            " +${country.phoneCode}",
            style: const TextStyle(color: whiteColor),
          ),
          Expanded(
              child: Text(
            " ${country.name}",
            style: const TextStyle(color: whiteColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}

class SelectCountryWidget extends StatelessWidget {
  final Country country;

  const SelectCountryWidget({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const UnderlineTabIndicator(borderSide: BorderSide(color: tabColor)),
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 10,
          ),
          Text(
            country.phoneCode!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            country.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          )),
          const Icon(
            Icons.arrow_drop_down_outlined,
            size: 40,
          )
        ],
      ),
    );
  }
}
