# Relational Model

1. Mother (RAMQ-id, mname, email, phone-number, date-of-brith, address, profession, blood-type)
2. Father (father-id, fname, email, phone-number, date-of-brith, address, profession, blood-type, RAMQ-id)
3. Couple (couple-id, RAMQ-id, father-id) RAMQ-id Reference Mother, father-id Reference Father
4. Institution (institution-id, name, phone-number, email, address, website)
5. Community-Clinic (institution-id) institution-id Reference Institution
6. Birth-Center (institution-id) institution-id Reference Institution
7. Midwife (practitioner-id, name, phone-number, email, institution-id) institution-id Reference Institution
8. Technician (tech-id, name, phone-number)
9. Pregnancy (couple-id, pregnancy-number, interested, expected-due-date, estimated-due-date, ultrasound-due-date, final-due-date, home-birth, primary-practitioner-id, backup-practitioner-id, institution-id) primary-practitioner-id Reference Midwife, backup-practitioner-id Reference Midwife, institution-id Reference Institution
10. Baby (baby-id, name, birth-date, birth-time, blood-type, gender, pregnancy-number, couple-id) (couple-id, pregnancy-numer) Reference Pregnancy
11. Medical-Tests (test-id, type, labwork-date, prescribed-date, taken-date, result, practitioner-id, pregnancy-number, couple-id, baby-id, tech-id) practitioner-id Reference Midwife, (couple-id, pregnancy-number) Reference Pregnancy, baby-id Reference Baby, tech-id Reference Technician
12. Information-Session (session-id, date, time, language, practitioner-id) practitioner-id Reference Midwife
13. Appointment (appointment-id, date, time, pregancy-number, couple-id, practitioner-id, institution-id) practitioner-id Reference Midwife, (couple-id, pregnancy-number) Reference Pregnancy, institution-id Reference Institution
14. Notes (note-id, time, date, content, appointment-id) appointment-id Reference Appointment
15. Information-Session-Registration (session-id, couple-id, attended)