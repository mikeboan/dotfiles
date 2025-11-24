# Database Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

Database querying and management using vim-dadbod + vim-dadbod-ui with SQL LSP autocomplete, providing a terminal-based alternative to DataGrip.

---

## Implementation

### Plugins
- **vim-dadbod**: Query execution engine
- **vim-dadbod-ui**: Database browser UI
- **vim-dadbod-completion**: Autocomplete for SQL
- **sqlls**: SQL Language Server (autocomplete, diagnostics)

### Configuration Files
- **Location**: `lua/mike-custom/config/lang/web.lua`
- **LSP**: `lua/mike-custom/config/language-support.lua`
- **Connections**: `~/.config/nvim/db_ui/connections.json`

---

## Keybinding Reference

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>db` | Open DBUI | Launch database browser |
| `<leader>dt` | Toggle DBUI | Show/hide browser |
| `<leader>df` | Find buffer | Find database query buffer |
| `<leader>dr` | Rename buffer | Rename query buffer |
| `<leader>dq` | Last query info | Show last query execution details |
| `<leader>de` | Execute SQL | Run selected SQL (visual mode) |

---

## Setup: First Time Configuration

### 1. Add Database Connection

**Steps**:

1. **Open DBUI**
   ```
   Press: <leader>db
   ```

2. **Press `A`** to add connection

3. **Enter connection string**
   ```
   For PostgreSQL:
   postgresql://username:password@localhost:5432/database_name

   For MySQL:
   mysql://username:password@localhost:3306/database_name
   ```

4. **Name the connection** (e.g., "beamjobs_dev")

5. **Connection saved** to `~/.config/nvim/db_ui/connections.json`

**Example connections.json**:
```json
{
  "beamjobs_dev": "postgresql://mike:password@localhost:5432/beamjobs_dev",
  "beamjobs_test": "postgresql://mike:password@localhost:5432/beamjobs_test"
}
```

---

## Step-by-Step Workflows

### 1. Browse Database Schema

**Steps**:

1. **Open DBUI** → `<leader>db`

2. **Navigate tree**
   ```
   j/k       Move down/up
   <Enter>   Expand/collapse
   o         Open in new buffer
   ```

3. **Tree structure**:
   ```
   📁 beamjobs_dev
      ├─ 📁 Tables
      │  ├─ users
      │  ├─ jobs
      │  └─ applications
      ├─ 📁 Views
      └─ 📁 Stored Procedures
   ```

4. **View table structure**
   - Navigate to table name
   - Press `<Enter>`
   - Schema shown in buffer

**Example output**:
```sql
-- Table: users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

### 2. Writing and Executing Queries

**Method 1: Quick Query**

1. **In DBUI**, press `S` on connection

2. **Query buffer opens**

3. **Write SQL**
   ```sql
   SELECT * FROM users
   WHERE created_at > '2025-01-01'
   LIMIT 10;
   ```

4. **Execute query**
   ```
   Visual mode: Select query
   Press: <leader>de
   or: <C-x> (in DBUI query buffer)
   ```

5. **Results appear** in split window

**Method 2: Saved Query**

1. **Create .sql file**
   ```bash
   nvim queries/users.sql
   ```

2. **Add connection comment** at top
   ```sql
   -- db: beamjobs_dev

   SELECT id, email, created_at
   FROM users
   ORDER BY created_at DESC
   LIMIT 100;
   ```

3. **Execute** → Select query, `<leader>de`

4. **Save for reuse**

---

### 3. Using SQL Autocomplete

**With sqlls LSP**:

1. **Open .sql file**

2. **Start typing**
   ```sql
   SELECT u.
   ```

3. **Autocomplete triggers** (Ctrl-Space if not automatic)
   - Table names
   - Column names
   - SQL keywords
   - Functions

4. **Navigate completions**
   ```
   <C-n>     Next item
   <C-p>     Previous item
   <Enter>   Accept
   ```

**Example**:
```sql
SELECT
  u.id,
  u.email,
  u.created_at,  -- <-- columns autocomplete
  j.title
FROM users u
JOIN jobs j ON j.user_id = u.id  -- <-- table names autocomplete
WHERE u.email LIKE '%@example.com'  -- <-- keywords autocomplete
```

---

### 4. Formatting SQL Queries

**Steps**:

1. **Write messy SQL**
   ```sql
   select id,email,created_at from users where status='active' and role='admin' order by created_at desc;
   ```

2. **Format**
   ```
   Normal mode: <leader>cf
   or: <leader>f
   ```

3. **Formatted output**
   ```sql
   SELECT
     id,
     email,
     created_at
   FROM
     users
   WHERE
     status = 'active'
     AND role = 'admin'
   ORDER BY
     created_at DESC;
   ```

---

### 5. Working with Query Results

**Navigating results**:
```
j/k         Move down/up rows
<Enter>     Expand row details
q           Close results
```

**Copy results**:
1. Visual select rows
2. Yank: `y`
3. Paste in document

**Export to CSV** (manual):
```sql
COPY (
  SELECT * FROM users WHERE status = 'active'
) TO '/tmp/active_users.csv' CSV HEADER;
```

---

### 6. Common Database Tasks

**Count rows**:
```sql
SELECT COUNT(*) FROM users;
```

**Find table by name**:
1. In DBUI tree
2. Type `/` to search
3. Type table name
4. Press `n` for next match

**View recent data**:
```sql
SELECT * FROM users
ORDER BY created_at DESC
LIMIT 20;
```

**Check constraints**:
```sql
SELECT
  conname AS constraint_name,
  contype AS constraint_type
FROM pg_constraint
WHERE conrelid = 'users'::regclass;
```

---

## Advanced Workflows

### Multi-Database Queries

**Compare data across environments**:

1. **Connection 1**: beamjobs_dev
   ```sql
   SELECT COUNT(*) FROM users;  -- Returns 1000
   ```

2. **Connection 2**: beamjobs_prod
   ```sql
   SELECT COUNT(*) FROM users;  -- Returns 50000
   ```

3. **Compare results** manually

### Transaction Management

```sql
BEGIN;

UPDATE users
SET status = 'inactive'
WHERE last_login < NOW() - INTERVAL '1 year';

-- Review changes
SELECT * FROM users WHERE status = 'inactive' LIMIT 10;

-- If good:
COMMIT;

-- If bad:
-- ROLLBACK;
```

### Using Variables (PostgreSQL)

```sql
\set user_id 123

SELECT *
FROM users
WHERE id = :user_id;
```

---

## Comparison with DataGrip

| Feature | DataGrip | vim-dadbod | Notes |
|---------|----------|------------|-------|
| Query execution | ✅ | ✅ | Same functionality |
| Autocomplete | ✅ | ✅ | sqlls provides |
| Schema browser | ✅ | ✅ | DBUI tree view |
| Results view | ✅ | ✅ | Text-based |
| SQL formatting | ✅ | ✅ | sql_formatter |
| Multiple connections | ✅ | ✅ | Switch in DBUI |
| ER diagrams | ✅ | ❌ | Use external tool |
| Data editor grid | ✅ | ❌ | Text-only |
| CSV export | ✅ | ⚠️ | Manual COPY command |
| Query history | ✅ | ⚠️ | Saved files |
| Execution plan | ✅ | ⚠️ | Manual EXPLAIN |

**Overall**: 70% feature parity. Daily queries work great. Use DBeaver/TablePlus for ER diagrams.

---

## Tips & Best Practices

1. **Save common queries** as .sql files
2. **Use connection comment** (`-- db: name`) in files
3. **Format before committing** queries to git
4. **LIMIT results** in development (avoid huge result sets)
5. **Use transactions** for data modifications
6. **Test in dev first** before running in prod
7. **Keep DBUI closed** when not needed (save screen space)

---

## Troubleshooting

### Connection failed

**Solutions**:
- Check database is running: `psql -U username -d database`
- Verify connection string format
- Check password/permissions

### Autocomplete not working

**Solutions**:
- Ensure sqlls installed: `:Mason`
- Check filetype: `:set ft=sql`
- Restart LSP: `:LspRestart`

### Can't find table

**Solutions**:
- Refresh DBUI: Press `R` in tree
- Check you're connected to right database
- Verify table exists: `\dt` in psql

---

## Quick Reference Card

```
DATABASE OPERATIONS (<leader>d prefix)

DBUI:
  <leader>db    Open database UI
  <leader>dt    Toggle database UI
  <leader>df    Find database buffer
  <leader>dr    Rename buffer
  <leader>dq    Last query info

Execute:
  <leader>de    Execute selected SQL (visual)

In DBUI Tree:
  j/k           Navigate
  <Enter>       Expand/collapse
  S             New query for connection
  A             Add connection
  D             Delete connection
  R             Refresh
  q             Close DBUI

Results:
  j/k           Navigate rows
  <Enter>       Expand row
  q             Close results
```

---

## Related Workflows

- **Django**: Query Django models data
- **Rails**: ActiveRecord console alternative
- **Testing**: Verify test data setup
- **Debugging**: Check application state

---

## Further Reading

- Dadbod docs: `:help dadbod`
- DBUI docs: `:help dadbod-ui`
- sqlls: https://github.com/joe-re/sql-language-server
- Config: `lua/mike-custom/config/lang/web.lua`

---

**Alternative Tools**:
- DBeaver (free): ER diagrams
- TablePlus: Nice GUI for Mac
- psql/mysql: Command-line clients
