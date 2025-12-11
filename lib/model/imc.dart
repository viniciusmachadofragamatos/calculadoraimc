class Imc {
  int? _peso;
  double? _altura;

  Imc(this._peso, this._altura);
  //getter
  int? get obterPeso => _peso;
  double? get obterAltura => _altura;

  //setter
  set salvarAltura(double? altura){
    _altura = altura;
  }
  set salvarPeso(int? peso){
    _peso = peso;
  }

  //calcular
  double? calcular(){
    if(_peso == null || _altura == null) {
      return null;
    }
    return _peso! / (_altura! * _altura!);
  }

  //classificação
  String? classificar(){
    final imc  = calcular();

    if(imc! < 16){return "Magreza grave";}
    if(imc < 17){return "Magreza moderada";}
    if(imc < 18.5){return "Magreza leve";}
    if(imc < 25){return "Saudável";}
    if(imc < 30){return "Sobrepeso";}
    if(imc < 35){return "Obesidade Grau 1";}
    if(imc < 40){return "Obesidade Grau 2";}
    if(imc >= 40){return "Obesidade Grau 3";}
    return null;
  }
}