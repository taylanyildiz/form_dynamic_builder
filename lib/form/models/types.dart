import '/core/models/models.dart';

/// Holder:
///
/// location index
/// dyanmic field
typedef FormDynamicFieldLocation = ({int index, int dragIndex, int dropIndex, FormDynamicField field});

extension CopyableFormDynamicFieldLocation on FormDynamicFieldLocation {
  /// Copy dynamic field location
  FormDynamicFieldLocation copyWith({int? index, int? dragIndex, int? dropIndex, FormDynamicField? field}) => (
        index: index ?? this.index,
        field: field ?? this.field,
        dragIndex: dragIndex ?? this.dragIndex,
        dropIndex: dropIndex ?? this.dropIndex,
      );
}
