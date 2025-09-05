class Room {
  final String question;
  final String answer;
  final String hint;

  Room({required this.question, required this.answer, required this.hint});
}

final rooms = [
  Room(
    question: "¿Cuál es la capital de España?",
    answer: "Madrid",
    hint: "Es la ciudad donde está el Palacio Real",
  ),
  Room(question: "¿Cuánto es 5 + 7?", answer: "12", hint: "Es mayor que 10"),
  Room(
    question: "¿Cuál es el planeta más cercano al Sol?",
    answer: "Mercurio",
    hint: "Su nombre empieza con M",
  ),
  Room(
    question: "¿Qué idioma se habla en Brasil?",
    answer: "Portugués",
    hint: "No es español",
  ),
  Room(question: "¿Cuánto es 9 × 3?", answer: "27", hint: "Es mayor que 20"),
];
