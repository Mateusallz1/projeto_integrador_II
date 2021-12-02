String bookingType(int code) {
  switch (code) {
    case 0:
      return 'booking';
    case 1:
      return 'hosted';
    case 2:
      return 'inactive';
    default:
      return 'booking';
  }
}
