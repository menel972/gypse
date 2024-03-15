/// Enum representing the keys for different rewards.
enum RewardKey {
  q12S('5Q12S', 5),
  q20S('5Q20S', 5),
  q30S('5Q30S', 5),
  qDiff('1QDiff', 1),
  serie3('Serie3', 1),
  serie10('Serie10', 1),
  serie20('Serie20', 1),
  qAll('100', 1),
  platine('Platine', 1),
  book('Book100', 1),
  random20('20QR', 20),
  random100('100QR', 100),
  easy3('3QE', 3),
  easy20('20QE', 20),
  easy50('50QE', 50),
  med3('3QM', 3),
  med20('20QM', 20),
  med50('50QM', 50),
  hard3('3QH', 3),
  hard20('20QH', 20),
  hard50('50QH', 50);

  final String id;
  final int condition;
  const RewardKey(this.id, this.condition);
}
