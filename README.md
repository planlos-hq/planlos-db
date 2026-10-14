# planlos-db

PostgreSQL-Datenbank und Schemamigrationen des Stundenplan-Assistenzsystems
PlanLos. Das Backend liegt in
[planlos-server](https://github.com/planlos-hq/planlos-server).

## Starten mit Docker Compose

```bash
cp .env.example .env   # Passwort setzen
docker compose up -d --build   # Postgres auf 127.0.0.1:8003
```

| Variable            | Bedeutung                                   |
| ------------------- | ------------------------------------------- |
| `POSTGRES_PASSWORD` | Datenbankpasswort (Pflicht)                 |
| `DB_PORT`           | Port auf dem Host (Standard `8003`)         |
| `PLANLOS_NETWORK`   | Netzwerk für planlos-server (Standard `planlos-network`) |

Datenbank und Benutzer heißen `planlos`. Eine neue Datenbank wird mit dem
neuesten `schema.sql` angelegt, die Daten liegen im Volume `db-data`.

Compose legt das Netzwerk `planlos-network` an. planlos-server tritt ihm bei und
erreicht die Datenbank dort unter dem Namen `planlos-db`.

## Migrationen

Unter `migrations/<version>/` liegen je ein vollständiges `schema.sql` und ein
`up.sql` für die Migration von der Vorversion. planlos-server bettet die
Migrationen ein und migriert beim Start selbst.

Neue Version anlegen:

1. `migrations/<n+1>/up.sql` (beginnt mit `insert into schema_version_history`)
   und das vollständige `schema.sql` schreiben.
2. `COPY` im [`Dockerfile`](Dockerfile) auf die neue Version setzen.
3. `./format_sql.sh` ausführen (pgFormatter; mit Nix: `direnv allow` bzw.
   `nix develop`).
4. In planlos-server das Submodul aktualisieren
   (`git submodule update --remote db`) und committen.

**Keine Passwörter, echten Namen, Benutzernamen (auch keine
`authorized_user`-Einträge), Hostnamen oder Serverkonfigurationen committen.**
