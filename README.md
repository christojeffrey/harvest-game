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
     menampilkan menu. Set globalvariabel dasar(level - 1, dst)

2. **rule yang dapat diakses setelah startGame**

   - `start.`\
     menentukan class (fisherman, farmer, dkk)
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

inventory yang tersedia. kita kunci dulu biar gk beda2 semua

**FARM**

- corn
- carrot
- wheat

**FISH**

- tuna
- salmon
- catfish

**RANCH**

- wool
- egg
- milk

---

yg belom dicover

- urusan inventory dengan item.

---

waktu membuat rule (misalnya quest), kan dapat membuat rule sendiri, nah itu silakan dibikin didalem file itu sendiri(misanya ruleQuest.pl), atau membuat file baru (factQuest.pl). kalau menurutmu bakal dipake sama rule2 lainnya, silakan taruh di globalFact(tambahi dibawah trus comment sebgai pembatas dulu ya, misal `% fakta quest`). ini berlaku juga buat globalRule.\
pemilihan ini hampir murni biar rapi aja(tapi ya kalo rapi endingnya ngecode nya jadi lebih gampang).
