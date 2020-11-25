class FrequencyToNote {
  static final double TWELVETH_ROOT = 1.0594630943593;
  static final int A4_INDEX = 57;
  static double DEFAULT_A4 = 440.00;

  Node root;

  FrequencyToNote() {}

  void main(List<String> args) {
    FrequencyToNote frequencyToNote = FrequencyToNote();
    frequencyToNote.calibrate(DEFAULT_A4);
    print(frequencyToNote.nodes);
  }

  void calibrate(double a4) {
    nodes[A4_INDEX - 1].to = a4;

    for (int i = A4_INDEX; i < nodes.length; i++) {
      Node node = nodes[i];
      node.from = nodes[i - 1].to;
      node.to = node.from * TWELVETH_ROOT;
    }

    for (int i = A4_INDEX - 1; i >= 0; i--) {
      Node node = nodes[i];
      node.to = nodes[i + 1].from;
      node.from = node.to / TWELVETH_ROOT;
    }

    root = construct(nodes);
  }

  Node construct(List<Node> nodes) {
    List<Node> list = nodes;
    while (list.length > 1) {
      list = [];
      for (int i = 0; i < nodes.length;) {
        if (i + 1 < nodes.length) {
          Node node = new Node("-", nodes[i].from, nodes[i + 1].to);
          node.left = nodes[i];
          node.right = nodes[i + 1];
          i++;
          list.add(node);
        } else {
          list.add(nodes[i]);
        }
        i++;
      }
      nodes = list;
    }

    return list[0];
  }

  Node findInterval(double val) {
    return find(val, root);
  }

  Node find(double val, Node node) {
    if (node == null) return null;

    if (val >= node.from && val <= node.to) {
      Node leftN = find(val, node.left);
      Node rightN = find(val, node.right);

      if (leftN == null && rightN == null)
        return node;
      else if (leftN == null)
        return rightN;
      else
        return leftN;
    } else {
      return null;
    }
  }

  var nodes = [
    "C0",
    "C#0",
    "D0",
    "D#0",
    "E0",
    "F0",
    "F#0",
    "G0",
    "G#0",
    "A0",
    "A#0",
    "B0",
    "C1",
    "C#1",
    "D1",
    "D#1",
    "E1",
    "F1",
    "F#1",
    "G1",
    "G#1",
    "A1",
    "A#1",
    "B1",
    "C2",
    "C#2",
    "D2",
    "D#2",
    "E2",
    "F2",
    "F#2",
    "G2",
    "G#2",
    "A2",
    "A#2",
    "B2",
    "C3",
    "C#3",
    "D3",
    "D#3",
    "E3",
    "F3",
    "F#3",
    "G3",
    "G#3",
    "A3",
    "A#3",
    "B3",
    "C4",
    "C#4",
    "D4",
    "D#4",
    "E4",
    "F4",
    "F#4",
    "G4",
    "G#4",
    "A4",
    "A#4",
    "B4",
    "C5",
    "C#5",
    "D5",
    "D#5",
    "E5",
    "F5",
    "F#5",
    "G5",
    "G#5",
    "A5",
    "A#5",
    "B5",
    "C6",
    "C#6",
    "D6",
    "D#6",
    "E6",
    "F6",
    "F#6",
    "G6",
    "G#6",
    "A6",
    "A#6",
    "B6",
    "C7",
    "C#7",
    "D7",
    "D#7",
    "E7",
    "F7",
    "F#7",
    "G7",
    "G#7",
    "A7",
    "A#7",
    "B7",
    "C8",
    "C#8",
    "D8",
    "D#8",
    "E8",
    "F8",
    "F#8",
    "G8",
    "G#8",
    "A8",
    "A#8",
    "B8"
  ].map((String s) => Node(s, 0, 0)).toList();
}

class Node implements Comparable<Node> {
  String note;
  double from, to;
  Node left, right;

  Node(String note, double from, double to) {
    this.note = note;
    this.from = from;
    this.to = to;
  }

  @override
  int compareTo(Node other) {
    return this.from.compareTo(other.from);
  }

  @override
  String toString() {
    return "$note $from - $to";
  }
}
