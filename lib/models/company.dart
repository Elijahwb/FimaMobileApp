class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, "Extension Worker"),
      Company(1, "Farmer"),
    ];
  }
}
