# Gym-database-project

Jag valde mina entiteter som speglar et verkligt gym system, members, classes, bookings, trainers, membership plans, subscriptions. Varje entitet representerar begrepp till verksamheten.

Databsen är tänkt att varje tabell har ett eget tydligt ansvar och ingen data lagras i onödan där den inte ska vara, eller på flera ställen. Den är normaliserad på så sätt att information om klasser lagras endast i tabellen classes och bokningar i booknings som sedan är kopplade med foreign key.

Constrains som skyddar min data: 
- Primary key: varje rad med id ska vara unik
- Foreign key: för att koppla ihop tabeller
- CHECK: till exempel förhindra negativa belopp
- NOT NULL: för att säkerställa att viktigt data finns

Med dessa regler skapar vi förutsättningen att inte felaktig data kan sparas i databasen.

Om jag hade fortsätt jobba på detta projekt hade jag kunnat lägga till fler kontroller så att en klass inte kan bli fullbokad.
