# Django Development Workflow Guide

**Last Updated**: November 8, 2025

## Overview

Django-specific development in Neovim using django-plus.vim, Pyright LSP with Django support, and Ruff formatting.

## Implementation

### Plugins
- **django-plus.vim**: Template support
- **Pyright**: LSP with Django detection
- **Ruff**: Fast linting/formatting
- **neotest-pytest**: Django test runner

### Configuration
- **Location**: `lua/mike-custom/config/lang/python.lua`
- **LSP**: Auto-detects manage.py for Django mode

## Django-Specific Features

### Template Syntax Highlighting

**.html files in templates/** automatically get `htmldjango` filetype:

```django
{% load static %}
<div class="container">
  {% for user in users %}
    <p>{{ user.email }}</p>
  {% endfor %}
</div>
```

**Syntax highlighting** for:
- Template tags: `{% %}``
- Variables: `{{ }}`
- Filters: `{{ value|filter }}`
- Comments: `{# #}`

### LSP Features for Django

**Model autocomplete**:
```python
from django.db import models

class User(models.Model):
    email = models.EmailField()  # <-- autocomplete for fields
    created_at = models.DateTimeField(auto_now_add=True)
```

**Settings autocomplete**:
```python
from django.conf import settings

DEBUG = settings.  # <-- autocomplete for settings
```

### Testing Django Apps

**Run Django tests**:
```python
# tests.py
from django.test import TestCase

class UserModelTest(TestCase):
    def test_create_user(self):  # <-- <leader>t to run
        user = User.objects.create(email='test@test.com')
        self.assertEqual(user.email, 'test@test.com')
```

**Run with neotest**: `<leader>t` (uses Django test runner automatically)

## Common Workflows

### 1. Navigate Django Project

**Find model**:
```
<leader>ff → type "models/user"
```

**Find view**:
```
<leader>ff → type "views/auth"
```

**Find template**:
```
<leader>ff → type "templates/user_list"
```

### 2. Django Shell in tmux

```bash
# In tmux pane
python manage.py shell_plus  # or shell

# Import models
from myapp.models import User
User.objects.all()
```

### 3. Database Queries

**Use DBUI** for raw SQL:
```
<leader>db → Connect to Django database
```

**Or Django ORM in shell**:
```python
User.objects.filter(is_active=True).count()
```

## Django Management Commands

**Run via terminal/tmux**:
```bash
python manage.py migrate
python manage.py makemigrations
python manage.py createsuperuser
python manage.py runserver
```

**Or create tmuxinator window** with dev server running.

## Quick Reference

```
Django-Specific:
  Template files    Auto-detected as htmldjango
  Model fields      LSP autocomplete
  Settings          LSP autocomplete
  Tests             <leader>t with Django test runner

Terminal Commands:
  manage.py         Run in tmux pane
  shell_plus        Django shell with auto-imports
  Database          <leader>db for raw SQL
```

## Further Reading

- Django docs: https://docs.djangoproject.com
- django-plus: https://github.com/tweekmonster/django-plus.vim
- Config: `lua/mike-custom/config/lang/python.lua`
