class Libro {
  late String id;
  late String titolo;
  late String autori;
  late String descrizione;
  late String editore;
  late String immagineCopertina;

  Libro(this.id, this.titolo, this.autori, this.descrizione, this.editore, this.immagineCopertina);

  Libro.fromMap(Map<String, dynamic> mappa) {
    this.id = mappa['id'];
    this.titolo = mappa['volumeInfo']['title'];
    this.autori = (mappa['volumeInfo']['authors'] == "") ? '' : mappa['volumeInfo']['authors'].toString();
    this.descrizione = (mappa['volumeInfo']['description'] == "") ? '' : mappa['volumeInfo']['description'].toString();
    this.editore = (mappa['volumeInfo']['publisher'] == "") ? '' : mappa['volumeInfo']['publisher'].toString();
    try{
      this.immagineCopertina = (mappa['volumeInfo']['imageLinks']['smallThumbnail'] == "") ? '' : mappa['volumeInfo']['imageLinks']['smallThumbnail'].toString();
    }
    catch(errore){
      print(errore.toString());
      this.immagineCopertina = '';
    }
  }
}