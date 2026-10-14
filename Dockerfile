FROM docker.io/library/postgres:18

ENV POSTGRES_DB=planlos \
    POSTGRES_USER=planlos

# Latest full schema for a fresh database; existing databases are migrated by planlos-server
COPY migrations/006/schema.sql /docker-entrypoint-initdb.d/01_schema.sql
