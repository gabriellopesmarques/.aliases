help_dbcli() {
  cat << 'EOF'
=== MySQL (mycli) ===
  \l            list databases
  \u <db>       use database
  \dt           list tables
  DESCRIBE <t>  describe table

=== PostgreSQL (pgcli / psql) ===
  \l            list databases
  \c <db>       connect to database
  \dt           list tables
  \d <t>        describe table
EOF
}
