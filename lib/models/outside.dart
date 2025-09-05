class Outside {
  final String question;
  final String answer;
  final String hint;

  Outside({required this.question, required this.answer, required this.hint});
}

final outsides = [
  Outside(
    question: "¿Cuál es la capital de España?",
    answer: "Madrid",
    hint: "Es la ciudad donde está el Palacio Real",
  ),
  Outside(question: "¿Cuánto es 5 + 7?", answer: "12", hint: "Es mayor que 10"),
  Outside(
    question: "¿Cuál es el planeta más cercano al Sol?",
    answer: "Mercurio",
    hint: "Su nombre empieza con M",
  ),
  Outside(
    question: "¿Qué idioma se habla en Brasil?",
    answer: "Portugués",
    hint: "No es español",
  ),
  Outside(question: "¿Cuánto es 9 × 3?", answer: "27", hint: "Es mayor que 20"),
];
