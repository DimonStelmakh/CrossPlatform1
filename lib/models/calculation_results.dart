class Task1Input {
  final double h;
  final double c;
  final double s;
  final double n;
  final double o;
  final double w;
  final double a;

  Task1Input({
    required this.h,
    required this.c,
    required this.s,
    required this.n,
    required this.o,
    required this.w,
    required this.a,
  });
}

class DryMass {
  final double h;
  final double c;
  final double s;
  final double n;
  final double o;
  final double a;

  DryMass({
    required this.h,
    required this.c,
    required this.s,
    required this.n,
    required this.o,
    required this.a,
  });
}

class CombustibleMass {
  final double h;
  final double c;
  final double s;
  final double n;
  final double o;

  CombustibleMass({
    required this.h,
    required this.c,
    required this.s,
    required this.n,
    required this.o,
  });
}

class HeatingValue {
  final double working;
  final double dry;
  final double combustible;

  HeatingValue({
    required this.working,
    required this.dry,
    required this.combustible,
  });
}

class Task1Result {
  final DryMass dryMass;
  final CombustibleMass combustibleMass;
  final HeatingValue heatingValue;

  Task1Result({
    required this.dryMass,
    required this.combustibleMass,
    required this.heatingValue,
  });
}

class Task2Input {
  final double c;
  final double h;
  final double o;
  final double s;
  final double ad;
  final double wr;
  final double v;
  final double qiDaf;

  Task2Input({
    required this.c,
    required this.h,
    required this.o,
    required this.s,
    required this.ad,
    required this.wr,
    required this.v,
    required this.qiDaf,
  });
}

class WorkingMass {
  final double c;
  final double h;
  final double o;
  final double s;
  final double a;
  final double v;

  WorkingMass({
    required this.c,
    required this.h,
    required this.o,
    required this.s,
    required this.a,
    required this.v,
  });
}

class Task2Result {
  final WorkingMass workingMass;
  final double qiR;

  Task2Result({
    required this.workingMass,
    required this.qiR,
  });
}

// Calculation functions
Task1Result calculateTask1(Task1Input input) {
  final dryCoefficient = 100 / (100 - input.w);
  final combustibleCoefficient = 100 / (100 - input.w - input.a);

  final dryMass = DryMass(
    c: input.c * dryCoefficient,
    h: input.h * dryCoefficient,
    s: input.s * dryCoefficient,
    n: input.n * dryCoefficient,
    o: input.o * dryCoefficient,
    a: input.a * dryCoefficient,
  );

  final combustibleMass = CombustibleMass(
    c: input.c * combustibleCoefficient,
    h: input.h * combustibleCoefficient,
    s: input.s * combustibleCoefficient,
    n: input.n * combustibleCoefficient,
    o: input.o * combustibleCoefficient,
  );

  final lhv = 339 * input.c + 1030 * input.h - 108.8 * (input.o - input.s) - 25 * input.w;
  final lhvDry = ((lhv / 1000 + 0.025 * input.w) * (100 / (100 - input.w))) * 1000;
  final lhvCombustible = ((lhv / 1000 + 0.025 * input.w) * (100 / (100 - input.w - input.a))) * 1000;

  final heatingValue = HeatingValue(
    working: lhv,
    dry: lhvDry,
    combustible: lhvCombustible,
  );

  return Task1Result(
    dryMass: dryMass,
    combustibleMass: combustibleMass,
    heatingValue: heatingValue,
  );
}

Task2Result calculateTask2(Task2Input input) {
  final workingCoefficient = (100 - input.wr - input.ad) / 100;
  final workingCoefficientForAV = (100 - input.wr) / 100;

  final workingMass = WorkingMass(
    c: input.c * workingCoefficient,
    h: input.h * workingCoefficient,
    o: input.o * workingCoefficient,
    s: input.s * workingCoefficient,
    a: input.ad * workingCoefficientForAV,
    v: input.v * workingCoefficientForAV,
  );

  final qiR = input.qiDaf * ((100 - input.wr - input.ad) / 100) - 0.025 * input.wr;

  return Task2Result(
    workingMass: workingMass,
    qiR: qiR,
  );
}