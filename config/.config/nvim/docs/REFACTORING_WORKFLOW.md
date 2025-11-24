# Refactoring Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

This guide covers advanced code refactoring capabilities in Neovim using `refactoring.nvim`, providing IntelliJ-like refactoring operations with language awareness for TypeScript, Python, and Ruby.

---

## Implementation

### Plugin
- **Name**: refactoring.nvim
- **Author**: ThePrimeagen
- **Repository**: https://github.com/ThePrimeagen/refactoring.nvim

### Configuration File
- **Location**: `lua/mike-custom/config/refactoring.lua`

### Dependencies
- nvim-treesitter (for language parsing)
- plenary.nvim (utility functions)

### Supported Languages
- ✅ TypeScript/JavaScript
- ✅ Python
- ✅ Ruby
- ✅ Go
- ✅ C/C++
- ✅ Lua

---

## Keybinding Reference

All refactoring operations use the `<leader>R` prefix (capital R).

| Keybind | Mode | Operation | Languages |
|---------|------|-----------|-----------|
| `<leader>Re` | Visual | Extract function | All |
| `<leader>Rf` | Visual | Extract to new file | All |
| `<leader>Rv` | Visual | Extract variable | All |
| `<leader>Rc` | Visual | Extract constant | All |
| `<leader>Ri` | Normal/Visual | Inline variable | All |
| `<leader>RI` | Normal | Inline function | All |
| `<leader>Rb` | Normal | Extract block | All |
| `<leader>Rbf` | Normal | Extract block to file | All |
| `<leader>Rq` | Normal/Visual | Refactoring menu | All |

**Sync with IntelliJ**: Changed from `<leader>Rm` to `<leader>Re` for consistency.

---

## Step-by-Step Workflows

### 1. Extract Function/Method

**When to use**: You have complex logic that should be its own function.

**Steps**:

1. **Select the code** to extract (Visual mode)
   ```
   1. Position cursor at start of code block
   2. Press 'V' for line-wise visual mode (or 'v' for character-wise)
   3. Move cursor to select all code to extract
   ```

2. **Trigger extract function**
   ```
   Press: <leader>Re
   ```

3. **Enter function name**
   ```
   Type the new function name in the prompt
   Press: <Enter>
   ```

4. **Result**:
   - Selected code replaced with function call
   - New function created above current function
   - Function parameters auto-detected from variable usage

**Example - TypeScript**:

**Before**:
```typescript
function processUser(user: User) {
  // [Select these 3 lines]
  const fullName = `${user.firstName} ${user.lastName}`;
  const email = user.email.toLowerCase();
  console.log(`Processing ${fullName} (${email})`);
  // [End selection]

  saveToDatabase(user);
}
```

**After pressing `<leader>Re` and typing "logUserInfo"**:
```typescript
function logUserInfo(user: User) {
  const fullName = `${user.firstName} ${user.lastName}`;
  const email = user.email.toLowerCase();
  console.log(`Processing ${fullName} (${email})`);
}

function processUser(user: User) {
  logUserInfo(user);
  saveToDatabase(user);
}
```

---

### 2. Extract Variable

**When to use**: Complex expression that should be named for clarity.

**Steps**:

1. **Select the expression** (Visual mode)
   ```
   1. Position cursor at start of expression
   2. Press 'v' for character-wise visual mode
   3. Select the entire expression
   ```

2. **Trigger extract variable**
   ```
   Press: <leader>Rv
   ```

3. **Enter variable name**
   ```
   Type the variable name
   Press: <Enter>
   ```

**Example - Python**:

**Before**:
```python
def calculate_total(items):
    # Select: items[0].price * items[0].quantity
    return items[0].price * items[0].quantity + tax
```

**After pressing `<leader>Rv` and typing "first_item_total"**:
```python
def calculate_total(items):
    first_item_total = items[0].price * items[0].quantity
    return first_item_total + tax
```

---

### 3. Extract Constant

**When to use**: Magic numbers or strings that should be named constants.

**Steps**:

1. **Select the literal value** (Visual mode)

2. **Trigger refactoring menu**
   ```
   Press: <leader>Rc
   ```

3. **Choose "Extract Constant"** from the menu

4. **Enter constant name** (typically UPPER_CASE)

**Example - Ruby**:

**Before**:
```ruby
def max_retries
  return 3  # Select '3'
end
```

**After**:
```ruby
MAX_RETRY_COUNT = 3

def max_retries
  return MAX_RETRY_COUNT
end
```

---

### 4. Inline Variable

**When to use**: Variable is only used once and makes code more complex.

**Steps**:

1. **Position cursor** on variable name

2. **Trigger inline variable**
   ```
   Press: <leader>Ri
   ```

3. **Confirm** the inlining

**Example - TypeScript**:

**Before**:
```typescript
const userName = user.name;  // Cursor here
return `Hello ${userName}`;
```

**After pressing `<leader>Ri`**:
```typescript
return `Hello ${user.name}`;
```

---

### 5. Extract to New File

**When to use**: Function belongs in a separate module.

**Steps**:

1. **Select the entire function** (Visual mode)

2. **Trigger extract to file**
   ```
   Press: <leader>Rf
   ```

3. **Enter new file path**
   ```
   Type: relative/path/to/newfile.ts
   Press: <Enter>
   ```

4. **Result**:
   - Function moved to new file
   - Import statement added to current file
   - Export statement added to new file

**Example - TypeScript**:

**Before** (`src/user.ts`):
```typescript
export function processUser(user: User) {
  // ... implementation
}

// [Select this entire function]
function validateUserEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}
```

**After pressing `<leader>Rf` and typing "utils/validation.ts"**:

**New file** (`src/utils/validation.ts`):
```typescript
export function validateUserEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}
```

**Original file** (`src/user.ts`):
```typescript
import { validateUserEmail } from './utils/validation';

export function processUser(user: User) {
  // ... implementation
}
```

---

### 6. Refactoring Menu (Quick Access)

**When to use**: Not sure which refactoring you need.

**Steps**:

1. **Select code** (Visual mode) or position cursor

2. **Open refactoring menu**
   ```
   Press: <leader>Rq
   ```

3. **Choose operation** from Telescope picker
   ```
   Use arrow keys or type to filter
   Press: <Enter> to select
   ```

4. **Follow prompts** for chosen refactoring

---

## Advanced Usage

### Extract Block (Code Organization)

**When to use**: Multiple statements that form a logical unit.

**Steps**:

1. **Position cursor** inside the block

2. **Trigger extract block**
   ```
   Press: <leader>Rb
   ```

3. **Treesitter finds the block** automatically

4. **Enter function name**

**Use Case**: Extracting initialization logic, validation steps, or cleanup code.

---

### Inline Function

**When to use**: Function is trivial wrapper, only called once.

**Steps**:

1. **Position cursor** on function name or call site

2. **Trigger inline function**
   ```
   Press: <leader>RI
   ```

3. **Confirm** the inlining

---

## Language-Specific Notes

### TypeScript/JavaScript

**Works great for**:
- Arrow functions
- React component extraction
- Async/await refactoring
- Class method extraction

**Limitations**:
- JSX extraction is basic (use React-specific tools if needed)

### Python

**Works great for**:
- Function extraction from classes
- Django view refactoring
- List comprehension simplification

**Limitations**:
- Decorator handling is basic

### Ruby/Rails

**Works great for**:
- Method extraction
- Rails controller action refactoring
- Block extraction

**Limitations**:
- Some Rails magic may need manual adjustment

---

## Common Workflows

### Refactoring Legacy Code

1. **Identify complex function**
2. **Extract logical blocks** → `<leader>Rb`
3. **Extract repeated logic** → `<leader>Re`
4. **Inline trivial variables** → `<leader>Ri`
5. **Move utilities to separate file** → `<leader>Rf`

### Test-Driven Refactoring

1. **Ensure tests pass**
2. **Extract code** using refactoring operations
3. **Run tests** → `<leader>t`
4. **Verify behavior unchanged**
5. **Repeat**

### Component Organization (React/Angular)

1. **Extract helper functions** → `<leader>Re`
2. **Move to utils file** → `<leader>Rf`
3. **Extract complex JSX** to sub-components (manual)
4. **Clean up imports**

---

## Troubleshooting

### "Refactoring failed" Error

**Cause**: Treesitter couldn't parse the selection correctly.

**Solutions**:
1. Check syntax is valid (run LSP diagnostics)
2. Select complete statements (not partial)
3. Try selecting a bit more or less
4. Check language is supported

### Incorrect Variable Detection

**Cause**: Treesitter scope analysis limitation.

**Solutions**:
1. Manually adjust the generated code
2. Use `<leader>Rq` menu to try different refactoring
3. Report edge case to plugin author

### Import/Export Not Added

**Cause**: File path or module system not detected.

**Solutions**:
1. Manually add import statement
2. Check project has proper module configuration
3. Use LSP code action to add import

---

## Comparison with IntelliJ

| Feature | IntelliJ | refactoring.nvim | Notes |
|---------|----------|------------------|-------|
| Extract Method | ✅ | ✅ | Same keybind now |
| Extract Variable | ✅ | ✅ | Same keybind |
| Inline Variable | ✅ | ✅ | Same keybind |
| Inline Method | ✅ | ✅ | Different keybind |
| Extract to File | ✅ | ✅ | Nvim advantage |
| Change Signature | ✅ | ❌ | Use LSP |
| Safe Delete | ✅ | ❌ | Manual check |
| Rename | ✅ | ✅ | Use LSP `<leader>rn` |

**Overall**: 85% feature parity. Core refactorings work identically.

---

## Tips & Best Practices

1. **Select Precisely**: Include full statements for best results

2. **Use Visual Line Mode**: `V` for full line selection when extracting blocks

3. **Check Scope**: Extracted function appears in correct scope (module, class, etc.)

4. **Test Immediately**: Run `<leader>t` after refactoring

5. **Combine with LSP**: Use `<leader>rn` (rename) and `<leader>ca` (code actions) alongside

6. **Practice**: Start with simple extractions, build to complex refactorings

7. **Undo Safety**: `u` undoes the entire refactoring if needed

---

## Quick Reference Card

```
REFACTORING OPERATIONS (<leader>R prefix)

Extract:
  <leader>Re  Extract function (visual)
  <leader>Rv  Extract variable (visual)
  <leader>Rc  Extract constant (visual)
  <leader>Rf  Extract to file (visual)
  <leader>Rb  Extract block (normal)

Inline:
  <leader>Ri  Inline variable (normal/visual)
  <leader>RI  Inline function (normal)

Menu:
  <leader>Rq  Refactoring menu (all options)
```

---

## Related Workflows

- **Testing**: Run `<leader>t` after refactoring to verify
- **LSP Rename**: Use `<leader>rn` for simple renames
- **Git**: Check diff with `<leader>gg` (lazygit)
- **Code Actions**: `<leader>ca` for LSP-provided refactorings

---

## Further Reading

- Plugin docs: `:help refactoring`
- GitHub: https://github.com/ThePrimeagen/refactoring.nvim
- Video tutorial: ThePrimeagen's YouTube channel
- Config file: `lua/mike-custom/config/refactoring.lua`

---

**Next**: Try refactoring some code in your beamjobs projects!
