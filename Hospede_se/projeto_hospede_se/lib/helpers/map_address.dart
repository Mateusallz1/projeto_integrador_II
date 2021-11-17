Map mapAddress(Map address) {
  address = {
    'description': address['description'].toString().replaceAll(' State of ', ' '),
    'flongname': address['flongname'].toString().replaceAll('State of ', ''),
    'fshortname': address['fshortname'].toString().replaceAll('State of', ''),
    'llongname': address['llongname'].toString().replaceAll('State of', ''),
    'lshortname': address['lshortname'].toString().replaceAll('State of', ''),
  };
  return address;
}
