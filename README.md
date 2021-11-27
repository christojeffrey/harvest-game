# LesgoLogkom

Gede Prasidha Bhawarnawa 13520004\
Jeremy S.O.N. Simbolon 13520042\
Muhammad Risqi Firdaus 13520043\
Christopher Jeffrey 13520055

[link spek tubes](https://docs.google.com/document/d/15iaOJ1DnSfNMVwf6HU0i5PdTpW8opQNcFwil6gcQzq4/edit)

> reminder, rule dan nama dari fakta diawali huruf kecil, variabel di fakta diawali huruf besar. emang gitu ketentuan di prolog.

## urutan rule yang dapat diakses

`help.` bisa digunakan kapanpun. help yang diberikan tergantung playerState saat ini

1. **rule yang harus diakses pertama kali**

   - `startGame.`\
     menampilkan menu. udah itu aja.

2. **rule yang dapat diakses setelah startGame**

   - `start.`\
     menentukan class (fisherman, farmer, dkk). assert semua variabel juga.
   - ` map.`

3. **rule yang dapat diakses setelah start**\
    _rule disini memiliki akses terhadap globalFact yang sudah di set oleh startGame_

   - `status.`
   - urusan map
     `map.`
     `w.`
     `a.`
     `s.`
     `d.`
   - `inventory.`
     (masih gk ngerti bedanya apa sama item, tpi pokoknya ada inventory)

4. **rule yang dapat diakses berdasarkan lokasi saat ini(LIHAT SPEK BUAT LEBIH JELASNYA)**\
   _rule disini memiliki akses terhadap globalFact dan yang sudah di set oleh startGame, juga globalRule_ **dan juga rule yang dibuat untuk dirinya sendiri**
   - `quest.`
   - `market.`
   - `house.`
   - `ranch.`
   - `fish.`
   - urusan farm
     `dig.`
     `plant.`
     `harvest.`

---

`goalState.`\
goal tercapai ketika player mempunyai uang dengan jumlah minimal tertentu. jadi,
dilakukan pengecekan terhadap uang player ketika dia mendapatkan uang. Harusnya ini cuman terjadi di market.\
`failState.`\
fail tercapai kalau hari sudah menembus 1 tahun(ntah ngitungnya gimana). di implemen di dalam house.\

---

## Item

kita kunci dulu biar gk beda2 semua. jangan bikin sendiri2, nti beda2.
ada **barang**. barang kita bikin gapunya level aja ya, ini pilihan barangnya.

**FARM**

- seed corn
- seed carrot
- seed wheat
- corn
- carrot
- wheat

**FISH**

- tuna (common)
- salmon (rare)
- catfish (legend)

**RANCH**

- wool
- egg
- milk
- chicken
- cow
- sheep

kedua ada **equipment**. ini condong ke tool. sementara bikin dua dulu,

- fishing rod, fishing rod sebagai tool buat mancing.
- shovel, shovel sebagai tool buat farming.

kalo bingung bedanya inventory sama item, item itu beneran nyimpennya, kek variabelnya. inventory itu commandnya.

---

waktu membuat rule (misalnya quest), kan dapat membuat rule sendiri, nah itu silakan dibikin didalem file itu sendiri(misanya ruleQuest.pl), atau membuat file baru (factQuest.pl). kalau menurutmu bakal dipake sama rule2 lainnya, silakan taruh di globalFact(tambahi dibawah trus comment sebgai pembatas dulu ya, misal `% fakta quest`). ini berlaku juga buat globalRule.\
pemilihan ini hampir murni biar rapi aja(tapi ya kalo rapi endingnya ngecode nya jadi lebih gampang).
