typedef struct {
    int idxMasuk;
    int idxKeluar;
}Tele;

typedef struct{
    Tele buffer;
    int Neff;
}arrayTele;



void cekTeleportasi(Payer* nama, arrayTele daftarTele){
    if(!buffTele(nama)){
        for(int i=0;i<daftaTele.Neff;i++){
            if(nama.posisi==daftarTele.buffer[i]).idxMasuk){
                (nama*).posisi=daftarTele.buffer[i].idxKeluar;
            }
        }
    }
}