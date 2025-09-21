/// SimpleRepTracker
/// Counts reps for a workout using a very basic placeholder logic.
/// Replace this later with AI/pose detection if desired.

class SimpleRepTracker {
  int _repCount = 0;
  bool _isDownPosition = false;

  /// Call this function each time user moves (or each frame in camera later)
  /// For now, pass `true` if user goes down, `false` if up
  void updatePosition(bool isDown) {
    if (!_isDownPosition && isDown) {
      _isDownPosition = true; // started down
    }

    if (_isDownPosition && !isDown) {
      _repCount++;           // completed one rep
      _isDownPosition = false;
    }
  }

  /// Returns current rep count
  int get repCount => _repCount;

  /// Resets the counter
  void reset() {
    _repCount = 0;
    _isDownPosition = false;
  }
}
