class Classes {
  final String name;
  final List objects;
  String id;

  Classes({
    this.id = '',
    required this.name,
    required this.objects,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'objects': objects,
      };
}
