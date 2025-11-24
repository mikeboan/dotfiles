# Testing & Coverage Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

This guide covers modern test-driven development in Neovim using `neotest` for inline test results and `nvim-coverage` for visualization, providing an IntelliJ-like testing experience with better performance.

---

## Implementation

### Primary Plugins

**neotest** - Modern test runner
- **Repository**: https://github.com/nvim-neotest/neotest
- **Features**: Inline results, test tree, watch mode, DAP integration

**nvim-coverage** - Coverage visualization
- **Repository**: https://github.com/andythigpen/nvim-coverage
- **Features**: Sign column indicators, coverage summary

### Test Adapters (by framework)

| Framework | Adapter | Your Usage |
|-----------|---------|------------|
| Jest | neotest-jest | React, Angular (old), Node.js |
| Vitest | neotest-vitest | Modern TypeScript projects |
| Pytest | neotest-python | Python, Django |
| RSpec | neotest-rspec | Ruby, Rails |

### Configuration File
- **Location**: `lua/mike-custom/config/testing.lua`

### Dependencies
- nvim-treesitter (test discovery)
- nvim-dap (for debugging tests)
- plenary.nvim (utilities)

---

## Keybinding Reference

All test operations use the `<leader>t` prefix.

### Core Operations (Synced with IntelliJ)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>t` | Run nearest test | Test at cursor or in current scope |
| `<leader>T` | Run file tests | All tests in current file |
| `<leader>a` | Run all tests | Entire test suite |
| `<leader>l` | Rerun last test | Last executed test |
| `<leader>tv` | Visit failed test | Jump to next failed test |

### Neotest UI Features (Nvim-only)

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>ts` | Toggle test summary | Open/close test tree panel |
| `<leader>to` | Show test output | View test output in floating window |
| `<leader>tO` | Toggle output panel | Persistent output panel |
| `<leader>td` | Debug test | Run test with debugger |
| `<leader>tx` | Stop test | Kill running tests |
| `<leader>tw` | Toggle watch mode | Re-run on file save |

### Coverage Operations

| Keybind | Operation | Description |
|---------|-----------|-------------|
| `<leader>tc` | Show coverage | Load and display coverage |
| `<leader>tC` | Toggle coverage | Show/hide coverage indicators |
| `<leader>tcc` | Clear coverage | Remove coverage display |

---

## Step-by-Step Workflows

### 1. Running Your First Test

**Scenario**: You have a test file open and want to run a specific test.

**Steps**:

1. **Position cursor** inside a test function
   ```javascript
   describe('UserService', () => {
     it('should validate email', () => {  // <-- Cursor here
       expect(validateEmail('test@example.com')).toBe(true);
     });
   });
   ```

2. **Run the test**
   ```
   Press: <leader>t
   ```

3. **Watch the magic** ✨
   - Test runs in background
   - Sign appears in gutter: ✓ (pass) or ✗ (fail)
   - Status shown in virtual text
   - Output available if needed

4. **Check result**
   - Green ✓ = Test passed
   - Red ✗ = Test failed (press `<leader>to` for output)

---

### 2. Test-Driven Development (TDD) Workflow

**The Red-Green-Refactor Cycle**:

**Steps**:

1. **Write failing test**
   ```typescript
   it('should calculate user age', () => {
     const user = { birthDate: '1990-01-01' };
     expect(calculateAge(user)).toBe(35);  // Function doesn't exist yet
   });
   ```

2. **Run test** → `<leader>t`
   - See red ✗ in gutter
   - Error: "calculateAge is not defined"

3. **Implement minimum code**
   ```typescript
   function calculateAge(user: User): number {
     const today = new Date();
     const birthDate = new Date(user.birthDate);
     return today.getFullYear() - birthDate.getFullYear();
   }
   ```

4. **Run test again** → `<leader>t`
   - See green ✓ in gutter
   - Test passes!

5. **Refactor if needed**
   - Extract logic: `<leader>Re` (refactoring)
   - Run tests: `<leader>t` (verify still green)

6. **Repeat** for next feature

---

### 3. Using the Test Summary Panel

**When to use**: You want an overview of all tests in your project.

**Steps**:

1. **Open test summary**
   ```
   Press: <leader>ts
   ```

2. **Navigate the tree**
   ```
   j/k      Move down/up
   <Enter>  Expand/collapse or jump to test
   o        Run test under cursor
   O        Run all tests in file
   d        Debug test under cursor
   x        Stop running tests
   ```

3. **Interpret icons**
   ```
   📁 gray  - Not run
   ✓ green - Passed
   ✗ red   - Failed
   ● blue  - Running
   ○ white - Skipped
   ```

4. **Close panel**
   ```
   Press: <leader>ts again
   or: q (in panel)
   ```

**Example Tree**:
```
beamjobs-frontend/
  ├─ src/
  │  ├─ services/
  │  │  ├─ user.service.spec.ts
  │  │  │  ├─ UserService
  │  │  │  │  ├─ ✓ should create instance
  │  │  │  │  ├─ ✗ should validate email
  │  │  │  │  └─ ○ should hash password (skipped)
```

---

### 4. Debugging a Failing Test

**Scenario**: Test fails, you need to debug it.

**Steps**:

1. **Position cursor** on failing test

2. **Start debugger**
   ```
   Press: <leader>td
   ```

3. **Debugger starts**
   - Breakpoint at test start
   - DAP UI opens (F7)
   - Variables panel shows state

4. **Debug controls**
   ```
   F5  - Continue
   F2  - Step over
   F1  - Step into
   F3  - Step out
   F7  - Toggle DAP UI
   ```

5. **Inspect variables**
   - Hover over variables
   - Check watches panel
   - Evaluate expressions

6. **Find the bug**, fix it, rerun → `<leader>t`

---

### 5. Watch Mode (Continuous Testing)

**When to use**: You want tests to automatically rerun when you save files.

**Steps**:

1. **Enable watch mode**
   ```
   Press: <leader>tw
   ```

2. **Work normally**
   - Edit your code
   - Save file (`:w` or `<leader>w`)
   - Tests run automatically
   - Results update in gutter

3. **See live feedback**
   - ✓/✗ updates as you code
   - No need to manually run tests
   - Faster feedback loop

4. **Disable watch mode**
   ```
   Press: <leader>tw again
   ```

**Perfect for**: TDD, refactoring sessions, bug fixing.

---

### 6. Test Coverage Visualization

**Scenario**: You want to see which lines are covered by tests.

**Steps**:

1. **Generate coverage** (one-time setup per project)

   **JavaScript/TypeScript (Jest/Vitest)**:
   ```bash
   # In package.json, ensure coverage is enabled
   npm test -- --coverage
   ```

   **Python (Pytest)**:
   ```bash
   coverage run -m pytest
   coverage json -o coverage.json
   ```

   **Ruby (RSpec + SimpleCov)**:
   ```bash
   # SimpleCov auto-generates coverage
   bundle exec rspec
   ```

2. **Load coverage in Neovim**
   ```
   Press: <leader>tc
   ```

3. **See coverage indicators**
   - Green ▎ = Line covered by tests
   - Red ▎ = Line NOT covered
   - Yellow ▎ = Partially covered (branches)

4. **Navigate to uncovered code**
   - Look for red ▎ indicators
   - Write tests for those lines

5. **Toggle coverage display**
   ```
   Press: <leader>tC  (hide/show)
   ```

**Example View**:
```typescript
▎ function calculateTotal(items: Item[]) {
▎   if (items.length === 0) {
▎     return 0;
▎   }
▎   return items.reduce((sum, item) => {
▎     return sum + (item.price * item.quantity);
▎   }, 0);
  }  // <-- Red bar = uncovered line

  function applyDiscount(total: number) {  // <-- Red = function not tested
    return total * 0.9;
  }
```

---

### 7. Running Tests in Specific Contexts

**Run tests in different scopes**:

| Scope | Keybind | Use Case |
|-------|---------|----------|
| Single test | `<leader>t` | Testing one assertion |
| Test block | `<leader>t` (in describe) | Testing a feature |
| File | `<leader>T` | Testing a module |
| Directory | `<leader>a` | Full test suite |

**Steps**:

**For single test**: Cursor inside `it()` or `test()` → `<leader>t`

**For describe block**: Cursor inside `describe()` → `<leader>t`

**For file**: Anywhere in file → `<leader>T`

**For all tests**: Anywhere → `<leader>a`

---

## Framework-Specific Guides

### Jest (React, Angular, Node.js)

**Test file patterns**:
- `*.spec.ts`, `*.spec.tsx`
- `*.test.ts`, `*.test.tsx`
- `__tests__/*.ts`

**Run single test**:
```typescript
describe('Component', () => {
  it('renders correctly', () => {  // Cursor here, press <leader>t
    render(<MyComponent />);
    expect(screen.getByText('Hello')).toBeInTheDocument();
  });
});
```

**Coverage command**:
```bash
npm test -- --coverage --watchAll=false
```

---

### Pytest (Python, Django)

**Test file patterns**:
- `test_*.py`
- `*_test.py`

**Run single test**:
```python
class TestUserService:
    def test_validate_email(self):  # Cursor here, press <leader>t
        assert validate_email('test@example.com') == True
```

**Django-specific**:
```python
from django.test import TestCase

class UserModelTest(TestCase):
    def test_create_user(self):  # Neotest handles Django test runner
        user = User.objects.create(email='test@test.com')
        assert user.email == 'test@test.com'
```

**Coverage command**:
```bash
coverage run -m pytest
coverage json -o coverage.json
```

---

### RSpec (Ruby, Rails)

**Test file patterns**:
- `spec/**/*_spec.rb`

**Run single test**:
```ruby
RSpec.describe UserService do
  it 'validates email' do  # Cursor here, press <leader>t
    expect(UserService.validate_email('test@test.com')).to be true
  end
end
```

**Coverage** (with SimpleCov in `spec/spec_helper.rb`):
```ruby
require 'simplecov'
SimpleCov.start 'rails'
```

---

## Advanced Features

### Parametrized Tests

**Pytest**:
```python
@pytest.mark.parametrize("input,expected", [
    ("test@test.com", True),
    ("invalid", False),
])
def test_email_validation(input, expected):  # <leader>t runs all parameters
    assert validate_email(input) == expected
```

**Jest**:
```typescript
test.each([
  ['test@test.com', true],
  ['invalid', false],
])('validates %s as %s', (input, expected) => {  // <leader>t runs all cases
  expect(validateEmail(input)).toBe(expected);
});
```

---

### Test Filtering

**Run tests matching pattern** (via summary panel):
1. Open summary: `<leader>ts`
2. Navigate to file/describe block
3. Press `o` to run just that subset

**Or use neotest API**:
```lua
:lua require('neotest').run.run({suite = false, extra_args = {"--grep", "user"}})
```

---

### Integration with DAP

**Debugging is fully integrated**:

1. Set breakpoint in source code: `<leader>b`
2. Run test with debugger: `<leader>td`
3. Debugger stops at breakpoint
4. Step through code: `F2`, `F1`, `F3`
5. Inspect state in DAP UI

**Works with**:
- ✅ Jest/Vitest (vscode-js-debug)
- ✅ Pytest (debugpy)
- ✅ RSpec (ruby-debug)

---

## Common Workflows

### Workflow 1: Fix Failing CI Tests

1. **Pull latest** → Run all tests: `<leader>a`
2. **Check failures** → Open summary: `<leader>ts`
3. **Navigate to failed test** → Press `<Enter>`
4. **Debug if needed** → `<leader>td`
5. **Fix code**
6. **Rerun** → `<leader>l`
7. **Verify all pass** → `<leader>a`

### Workflow 2: Add Tests to Untested Code

1. **Show coverage** → `<leader>tc`
2. **Find red bars** (uncovered lines)
3. **Write test** for uncovered code
4. **Run test** → `<leader>t`
5. **Refresh coverage** → `<leader>tc`
6. **Repeat** until green

### Workflow 3: Refactor with Confidence

1. **Ensure tests pass** → `<leader>a`
2. **Enable watch mode** → `<leader>tw`
3. **Refactor code** → Use `<leader>R*` operations
4. **Save file** → Tests run automatically
5. **Check results** → Green ✓ = safe refactor
6. **Disable watch** → `<leader>tw`

---

## Troubleshooting

### Tests Not Discovered

**Symptoms**: No tests shown in summary panel.

**Solutions**:
1. Check test file naming matches patterns
2. Verify test framework adapter is installed
3. Run `:checkhealth neotest`
4. Check test file has correct syntax

### Coverage Not Showing

**Symptoms**: `<leader>tc` doesn't show coverage.

**Solutions**:
1. Ensure coverage file exists:
   - Jest: `coverage/coverage-final.json`
   - Pytest: `coverage.json`
   - RSpec: `coverage/.resultset.json`
2. Run tests with coverage enabled first
3. Check `:lua print(vim.inspect(require('coverage').config))`

### Watch Mode Not Working

**Symptoms**: Tests don't rerun on save.

**Solutions**:
1. Disable watch: `<leader>tw`, re-enable
2. Check test framework supports watch
3. Verify no syntax errors in test file

### Debug Session Won't Start

**Symptoms**: `<leader>td` does nothing.

**Solutions**:
1. Check DAP is configured: `:checkhealth dap`
2. Verify debugger for language is installed (Mason)
3. Check `:DapShowLog` for errors
4. Try regular test run first: `<leader>t`

---

## Comparison with IntelliJ

| Feature | IntelliJ | Neotest | Notes |
|---------|----------|---------|-------|
| Run single test | ✅ | ✅ | Same experience |
| Inline results | ✅ | ✅ | Neotest faster |
| Test tree | ✅ | ✅ | Similar UX |
| Coverage visualization | ✅ | ✅ | Similar |
| Debug tests | ✅ | ✅ | Same keybinds |
| Watch mode | ✅ | ✅ | Neotest more responsive |
| Test history | ✅ | ❌ | Not available |
| Test templates | ✅ | ❌ | Use snippets instead |
| Coverage trends | ✅ | ❌ | External tools |

**Overall**: 90% feature parity. Daily TDD workflow is identical or better.

---

## Performance Tips

1. **Use watch mode** for active development (`<leader>tw`)
2. **Run file tests** instead of all tests during iteration (`<leader>T`)
3. **Keep test summary closed** when not needed (saves resources)
4. **Clear old coverage** before loading new (`<leader>tcc` then `<leader>tc`)

---

## Tips & Best Practices

1. **Learn the signs**: ✓/✗/●/○ = pass/fail/running/skipped
2. **Use summary panel**: Great overview of test health
3. **Enable coverage early**: Guides where to write tests
4. **Debug failing tests**: `<leader>td` is faster than print statements
5. **Watch mode for TDD**: Instant feedback on code changes
6. **Close summary after use**: Keep screen real estate
7. **Run full suite before commits**: `<leader>a`

---

## Quick Reference Card

```
TEST OPERATIONS (<leader>t prefix)

Run Tests:
  <leader>t   Run nearest test (at cursor)
  <leader>T   Run file tests (all in file)
  <leader>a   Run all tests (entire suite)
  <leader>l   Rerun last test

Test UI:
  <leader>ts  Toggle test summary panel
  <leader>to  Show test output (floating)
  <leader>tO  Toggle output panel (persistent)

Advanced:
  <leader>td  Debug test (with DAP)
  <leader>tx  Stop running tests
  <leader>tw  Toggle watch mode (auto-rerun)
  <leader>tv  Visit next failed test

Coverage:
  <leader>tc  Show coverage
  <leader>tC  Toggle coverage display
  <leader>tcc Clear coverage

Signs:
  ✓ green - Test passed
  ✗ red   - Test failed
  ● blue  - Test running
  ○ white - Test skipped
```

---

## Related Workflows

- **Debugging**: See F-key debugging in testing.lua
- **Refactoring**: Run `<leader>t` after `<leader>R*` operations
- **Git**: Check test status before commit (`<leader>gg`)
- **Coverage**: Compare with CI coverage reports

---

## Further Reading

- Neotest docs: `:help neotest`
- Coverage docs: `:help nvim-coverage`
- GitHub: https://github.com/nvim-neotest/neotest
- Config file: `lua/mike-custom/config/testing.lua`
- Video: "TDD in Neovim with Neotest" (search YouTube)

---

**Next**: Try TDD workflow on a new feature in beamjobs!
