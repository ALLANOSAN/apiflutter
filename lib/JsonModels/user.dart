
//In here first we create the users json model
// To parse this JSON data, do
//

class Usuarios{
    final int? usrId;
    final String usrNome;
    final String usrSenha;

    Usuarios({
        this.usrId,
        required this.usrNome,
        required this.usrSenha,
    });

    factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
        usrId: json["usrId"],
        usrNome: json["usrNome"],
        usrSenha: json["usrSenha"],
    );

    Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrNome": usrNome,
        "usrSenha": usrSenha,
    };
}