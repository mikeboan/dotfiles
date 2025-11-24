# Rails Development Workflow Guide

**Last Updated**: November 8, 2025

## Overview

Rails-specific development using vim-rails for navigation, ruby_lsp for language features, and neotest-rspec for testing.

## Implementation

### Plugins
- **vim-rails**: Rails framework integration
- **vim-bundler**: Bundler support
- **vim-rake**: Rake task integration
- **ruby_lsp**: Language Server
- **neotest-rspec**: RSpec test runner

### Configuration
- **Location**: `lua/mike-custom/config/lang/ruby.lua`

## Rails-Specific Keybindings

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>ra` | Alternate file | Switch test ↔ implementation |
| `<leader>rr` | Related file | Related Rails file |
| `<leader>rm` | Model | Open/create model |
| `<leader>rc` | Controller | Open/create controller |
| `<leader>rv` | View | Open/create view |
| `<leader>rd` | Migration | Open migration |
| `<leader>rs` | Schema | Open schema.rb |

## Step-by-Step Workflows

### 1. Navigate Rails Project

**Jump from controller to view**:
```ruby
# users_controller.rb
def show
  @user = User.find(params[:id])
  # Cursor here, press: <leader>rv
end
# Opens: app/views/users/show.html.erb
```

**Jump to model**:
```
Press: <leader>rm
Type: User
Opens: app/models/user.rb
```

### 2. Test-Driven Development with RSpec

**Alternate between test and implementation**:
```ruby
# spec/models/user_spec.rb
describe User do
  it 'validates email' do  # <-- Press <leader>ra
    # Jumps to: app/models/user.rb
  end
end
```

**Run tests**:
```
<leader>t   # Run current spec
<leader>T   # Run file specs
<leader>a   # Run all specs
```

### 3. Rails Console in tmux

```bash
# In tmux pane
bundle exec rails console

# Or rails c in project root
rails c

# Test models
User.first
User.where(active: true)
```

### 4. Working with Migrations

**Create migration**:
```bash
# In terminal
rails generate migration AddEmailToUsers email:string
```

**Navigate to migration**:
```
Press: <leader>rd
Select migration from list
```

**Edit and run**:
```ruby
class AddEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
  end
end
```

```bash
# In terminal
rails db:migrate
```

### 5. Rails Commands

**vim-rails provides**:
- `:Emodel User` - Open model
- `:Econtroller Users` - Open controller
- `:Eview users/show` - Open view
- `:Emigration add_email_to_users` - Open migration
- `:Eschema` - Open schema
- `:A` - Alternate file (test ↔ impl)
- `:R` - Related file

## Common Workflows

### Creating a New Resource

1. **Generate** (terminal):
   ```bash
   rails g scaffold User name:string email:string
   ```

2. **Review migration**: `<leader>rd`

3. **Run migration**:
   ```bash
   rails db:migrate
   ```

4. **Review model**: `<leader>rm` → User

5. **Add validations**:
   ```ruby
   class User < ApplicationRecord
     validates :email, presence: true, uniqueness: true
   end
   ```

6. **Write tests**: `<leader>ra` → switch to spec

7. **Run tests**: `<leader>t`

### Debugging Rails Apps

**Use byebug/debug in code**:
```ruby
def show
  byebug  # Or: debugger
  @user = User.find(params[:id])
end
```

**Or use nvim-dap** (if configured):
```
Set breakpoint: <leader>b
Run with debugger: <leader>td
```

## Rails-Specific Tips

1. **Use gf** on partial names to jump to partial
2. **Use gf** on routes to jump to controller action
3. **:A** is faster than `<leader>ra` for alternate file
4. **Schema as reference**: `<leader>rs` to check DB structure

## Quick Reference

```
Rails Navigation (<leader>r prefix):
  <leader>ra    Alternate file (test ↔ impl)
  <leader>rr    Related file
  <leader>rm    Open model
  <leader>rc    Open controller
  <leader>rv    Open view
  <leader>rd    Open migration
  <leader>rs    Open schema

vim-rails Commands:
  :A            Alternate file
  :R            Related file
  :Emodel       Open model
  :Econtroller  Open controller
  :Eview        Open view
  :Eschema      Open schema

Testing:
  <leader>t     Run spec at cursor
  <leader>T     Run file specs
  <leader>a     Run all specs
```

## Further Reading

- vim-rails: https://github.com/tpope/vim-rails
- Rails guides: https://guides.rubyonrails.org
- Config: `lua/mike-custom/config/lang/ruby.lua`
