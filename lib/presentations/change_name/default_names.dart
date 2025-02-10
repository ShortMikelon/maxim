final class DefaultNames {
  DefaultNames._();

  static const trainer = 'Тренер';
  static const teacher = 'Учитель';
  static const coach = 'Коуч';
  static const tutor = 'Репетитор';

  static const student = 'Ученик';
  static const client = 'Клиент';

  static const lesson = 'Урок';
  static const training = 'Тренировка';
  static const event = 'Событие';

  static const other = 'Другое';

  static List<String> get adminNames => [trainer, teacher, coach, tutor, other];

  static List<String> get clientNames => [student, client, other];

  static List<String> get eventNames => [lesson, training, event, other];
}
