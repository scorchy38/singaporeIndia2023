class CellModel {
  final int x;
  final int y;
  bool isMine = false;
  bool isRevealed = true;
  bool isFinal = false;
  int value = 0;
  bool isFlagged = false;
  CellModel(this.x, this.y);
}
