library matrix;

class Matrix<T> {
  List<List<T>> _data;

  Matrix(int rows, int columns) {
    this._data = new List<List<T>>();

    this.rows = rows;
    this.columns = columns;
  }

  Matrix.fromArray(List<List<T>> list) {
    this._data = list;

    this.rows = this._data.length;

    int columns = 0;
    for(int i = 0; i < this.rows; i++) {
      if(this._data[i].length > columns) {
        columns = this._data[i].length;
      }
    }

    this.columns = columns;
  }

  int   get columns => (this._data[0] == null ? 0 : this._data[0].length);
  void  set columns(int columns) {
    if(columns == null) {
      throw new ArgumentError.notNull('columns');
    }

    if(columns < 0) {
      throw new RangeError.value(columns, 'columns', 'Column count must be positive');
    }

    for(int i = 0; i < this.rows; i++) {
      this._data[i].length = columns;
    }
  }

  int   get rows => this._data.length;
  void  set rows(int rows) {
    if(rows == null) {
      throw new ArgumentError.notNull('rows');
    }

    if(rows < 0) {
      throw new RangeError.value(rows, 'rows', 'Row count must be positive');
    }

    if(rows >= this._data.length) {
      // need to set i before growing the list
      int i = this._data.length;

      this._data.length = rows;
      for(i; i < rows; i++) {
        this._data[i] = new List<T>()..length = this.columns;
      }
    }
  }

  T get(int row, int column) {
    try {
      this._throwRowOutOfBoundsError(row);
      this._throwColumnOutOfBoundsError(column);
    } catch(e) {
      throw e;
    }

    return this._data[row][column];
  }

  void set(int row, int column, T value) {
    try {
      this._throwRowOutOfBoundsError(row);
      this._throwColumnOutOfBoundsError(column);
    } catch(e) {
      throw e;
    }

    this._data[row][column] = value;
  }

  void forEach(Function f, [Function afterRow]) {
    int i, j;

    for(i = 0; i < this.rows; i++) {
      for(j = 0; j < this.columns; j++) {
        f(this.get(i, j), i, j);
      }

      if(afterRow != null) {
        afterRow(i);
      }
    }
  }

  void _throwRowOutOfBoundsError(int row, [String name = 'row']) {
    if(row == null) {
      throw new ArgumentError.notNull(name);
    }

    if(row < 0 || row >= this.rows) {
      throw new RangeError.range(row, 0, this.rows, name);
    }
  }

  void _throwColumnOutOfBoundsError(int column, [String name = 'column']) {
    if(column == null) {
      throw new ArgumentError.notNull(name);
    }

    if(column < 0 || column >= this.columns) {
      throw new RangeError.range(column, 0, this.columns, name);
    }
  }
}