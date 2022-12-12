class Either<L, R> {
  final L? _left;
  final R? _right;

  Either(this._left, this._right);

  bool isRight() => _right != null;
  R asRight() => _right!;

  bool isLeft() => _left != null;
  L asLeft() => _left!;
}

class Right<L, R> extends Either<L, R> {
  Right(R data) : super(null, data);
}

class Left<L, R> extends Either<L, R> {
  Left(L error) : super(error, null);
}
