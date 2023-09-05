class TextInputValidator {
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama Lengkap tidak boleh kosong';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (value.length < 6) {
      return 'Password harus terdiri dari minimal 6 karakter';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final phoneRegex = RegExp(r'^[0-9]{10,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Nomor telepon harus terdiri dari 10 hingga 12 digit angka';
    }

    return null;
  }
}
