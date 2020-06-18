* Encoding: windows-1252.

recode CB7 (1 = 1) (9 = 8) (else = 2) into schoolAttendance.
variable labels schoolAttendance "School attendance".
value labels schoolAttendance 1 "Attending" 2 "Not attending" 8 "Missing".

* variable labels schoolAttendance "Fréquentation scolaire".
* value labels schoolAttendance 1 "Participer" 2 "Ne participe pas" 8 "Manquant".
