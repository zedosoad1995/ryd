node v20.10.0 was used.

To install run:

```bash
npm i
```

To start the DB, run the script `/dockers/start_db.bat`

You need to init the DB with:

```bash
npx prisma migrate dev
npx prisma generate
```

To start dev run:

```bash
npm run dev
```
