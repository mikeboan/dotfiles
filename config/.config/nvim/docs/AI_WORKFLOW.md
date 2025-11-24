# AI Code Assistance Workflow Guide

**Last Updated**: November 8, 2025

---

## Overview

AI-powered code assistance directly in Neovim using codecompanion.nvim with Claude (Anthropic). Provides conversational chat, inline edits with diff preview, and deep integration with git, testing, and refactoring workflows.

---

## Implementation

### Plugin
- **codecompanion.nvim**: Modular AI code assistance with chat and inline editing

### AI Provider
- **Anthropic Claude**: Claude Sonnet 4 (latest model)
- **API Key Required**: Store in `~/.config/anthropic/api_key` or env var

### Configuration File
- **Location**: `lua/mike-custom/config/ai.lua`

### Dependencies
- plenary.nvim (async operations)
- nvim-treesitter (code understanding)
- telescope.nvim (file selection)
- dressing.nvim (better UI)

---

## Setup: API Key Configuration

### Method 1: Config File (Recommended)

```bash
# Create config directory
mkdir -p ~/.config/anthropic

# Add your API key
echo "sk-ant-your-key-here" > ~/.config/anthropic/api_key

# Secure the file
chmod 600 ~/.config/anthropic/api_key
```

### Method 2: Environment Variable

```bash
# Add to ~/.zshrc or ~/.bashrc
export ANTHROPIC_API_KEY="sk-ant-your-key-here"

# Reload shell
source ~/.zshrc
```

### Verify Setup

```vim
:checkhealth codecompanion
```

---

## Keybinding Reference

### Core Operations

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>aa` | Normal/Visual | Toggle chat | Open/close AI chat window |
| `<leader>ac` | Normal/Visual | New chat | Start fresh AI conversation |
| `<leader>ai` | Normal/Visual | Inline actions | Quick AI actions menu |
| `<leader>at` | Normal/Visual | Actions menu | Full AI actions menu |

### Context Management

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>ab` | Normal | Add buffer | Add current file to chat context |
| `<leader>ad` | Normal | Add diagnostics | Add LSP diagnostics to chat |

### Git Workflow Integration

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>agg` | Normal | Commit message | Generate from staged changes |
| `<leader>agp` | Normal | PR description | Generate from branch diff |

### Testing Workflow Integration

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>att` | Normal/Visual | Generate tests | Create tests for selected code |
| `<leader>ate` | Normal | Explain failure | Explain why test failed |

### Code Review & Documentation

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>arc` | Normal/Visual | Code review | Get review suggestions |
| `<leader>ard` | Normal/Visual | Generate docs | Create documentation |
| `<leader>are` | Normal/Visual | Explain code | Explain in plain language |

### Refactoring Integration

| Keybind | Mode | Operation | Description |
|---------|------|-----------|-------------|
| `<leader>ars` | Normal/Visual | Suggest refactoring | Get refactoring ideas |

---

## Step-by-Step Workflows

### 1. Starting a Conversation

**Scenario**: You want to discuss code architecture or ask questions.

**Steps**:

1. **Open AI chat**:
   ```
   Press: <leader>aa
   ```

2. **Chat window opens** (vertical split, 45% width)

3. **Type your question**:
   ```
   How should I structure a user authentication system in TypeScript?
   ```

4. **Send message**:
   ```
   Press: <CR> (normal mode)
   or: <C-s> (insert mode)
   ```

5. **Claude responds** with detailed explanation

6. **Continue conversation**:
   - Type follow-up questions
   - Add files to context with `<leader>ab`
   - Keep chat open while coding

7. **Close chat**:
   ```
   Press: q (in chat window)
   or: <leader>aa (toggle)
   ```

**Example Conversation**:
```
You: How should I structure a user authentication system in TypeScript?

Claude: I'd recommend a layered architecture:

1. **Auth Service Layer**:
   - Handles JWT token generation/validation
   - Password hashing with bcrypt
   - Session management

2. **Auth Controller Layer**:
   - Express route handlers
   - Input validation
   - Error handling

3. **Auth Middleware**:
   - Protects routes
   - Extracts user from token

Would you like me to show code examples for any of these?

You: Yes, show me the auth middleware
```

---

### 2. Adding Files to Context

**Scenario**: You want AI to analyze specific files.

**Steps**:

1. **Open the file** you want to discuss

2. **Add to chat context**:
   ```
   Press: <leader>ab
   ```

3. **Confirmation appears**: "Added buffer to chat"

4. **In chat**, ask about the file:
   ```
   Can you review this authentication service for security issues?
   ```

5. **AI analyzes the file** and provides feedback

**Adding Multiple Files**:

1. Open first file → `<leader>ab`
2. Switch to second file → `<leader>ab`
3. Switch to third file → `<leader>ab`
4. Ask question about all files

**Example**:
```
# Add auth.service.ts
:e src/auth/auth.service.ts
<leader>ab

# Add auth.controller.ts
:e src/auth/auth.controller.ts
<leader>ab

# Ask in chat
How can I improve error handling across these authentication files?
```

---

### 3. Inline Code Actions (Quick Edits)

**Scenario**: You want AI to modify code with diff preview.

**Steps**:

1. **Visual select code** to modify:
   ```
   Press: V (visual line mode)
   Select lines: j/k
   ```

2. **Open actions menu**:
   ```
   Press: <leader>ai
   ```

3. **Select action** from menu:
   - Explain code
   - Refactor code
   - Add comments
   - Fix bugs
   - Generate tests
   - Optimize performance
   - Add error handling

4. **Diff view opens** showing changes:
   ```
   - Old code (left)
   + New code (right)
   ```

5. **Navigate changes**:
   ```
   ]c    Next change (hunk)
   [c    Previous change
   ```

6. **Accept or reject**:
   ```
   <leader>ha    Accept hunk
   <leader>hr    Reject hunk
   or accept all changes
   ```

**Example**:
```typescript
// Before: Selected this code
function getUser(id) {
  const user = users.find(u => u.id === id);
  return user;
}

// Action: "Add error handling"
// After: AI suggests
function getUser(id: string): User {
  const user = users.find(u => u.id === id);
  if (!user) {
    throw new Error(`User with id ${id} not found`);
  }
  return user;
}
```

---

### 4. Generate Git Commit Message

**Scenario**: You've staged changes and need a commit message.

**Steps**:

1. **Stage changes** with gitsigns:
   ```
   <leader>hs    Stage hunk
   or in Neogit: <leader>gg → stage files
   ```

2. **Generate commit message**:
   ```
   Press: <leader>agg
   ```

3. **AI analyzes** `git diff --staged`

4. **Chat opens** with generated message:
   ```
   feat(auth): add JWT token validation middleware

   - Implement token validation in auth middleware
   - Add error handling for expired/invalid tokens
   - Extract user claims from JWT payload
   - Add unit tests for middleware

   Improves security by validating all protected routes.
   ```

5. **Copy message**:
   ```
   Visual select → y (yank)
   ```

6. **Use in Neogit**:
   ```
   <leader>gg    Open Neogit
   c c           Start commit
   Paste message
   :wq           Complete commit
   ```

---

### 5. Generate Pull Request Description

**Scenario**: You've finished a feature and need a PR description.

**Steps**:

1. **Ensure you're on feature branch**:
   ```bash
   git branch --show-current
   # feature/user-auth
   ```

2. **Generate PR description**:
   ```
   Press: <leader>agp
   ```

3. **AI analyzes**:
   - Branch diff vs main
   - Commit history
   - Changed files

4. **Chat opens** with PR description:
   ```markdown
   ## Summary
   - Implement user authentication system with JWT
   - Add login/logout endpoints
   - Add auth middleware for protected routes

   ## Changes
   - **Backend**: JWT authentication service
   - **Middleware**: Token validation middleware
   - **Controllers**: Login/logout endpoints
   - **Tests**: Auth service and middleware tests

   ## Test Plan
   - [ ] Unit tests pass (100% coverage on auth code)
   - [ ] Manual testing: Login flow works
   - [ ] Manual testing: Protected routes require auth
   - [ ] Manual testing: Invalid tokens rejected

   ## Security Considerations
   - Passwords hashed with bcrypt
   - JWT tokens expire after 1 hour
   - Refresh tokens stored securely
   ```

5. **Copy description** and use in PR:
   ```
   <leader>gpc    Create PR (Octo.nvim)
   Paste description
   Submit PR
   ```

---

### 6. Generate Tests for Function

**Scenario**: You wrote a function and need tests.

**Steps**:

1. **Position cursor** in function:
   ```typescript
   function validateEmail(email: string): boolean {
     const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     return regex.test(email);
   }
   ```

2. **Or visual select** the entire function

3. **Generate tests**:
   ```
   Press: <leader>att
   ```

4. **AI generates tests** in appropriate framework:
   ```typescript
   describe('validateEmail', () => {
     it('should return true for valid email', () => {
       expect(validateEmail('user@example.com')).toBe(true);
     });

     it('should return false for email without @', () => {
       expect(validateEmail('userexample.com')).toBe(false);
     });

     it('should return false for email without domain', () => {
       expect(validateEmail('user@')).toBe(false);
     });

     it('should return false for email with spaces', () => {
       expect(validateEmail('user @example.com')).toBe(false);
     });

     it('should return false for empty string', () => {
       expect(validateEmail('')).toBe(false);
     });
   });
   ```

5. **Copy tests** to test file

6. **Run tests**:
   ```
   <leader>T    Run file tests
   ```

---

### 7. Explain Test Failure

**Scenario**: Test is failing and you don't know why.

**Steps**:

1. **Run test**:
   ```
   <leader>t    Run nearest test
   ```

2. **Test fails** - diagnostics appear in buffer

3. **Explain failure**:
   ```
   Press: <leader>ate
   ```

4. **AI reads diagnostics** and explains:
   ```
   The test is failing because:

   1. **Root Cause**: The `getUser` function returns `undefined`
      when user is not found, but the test expects it to throw an error.

   2. **Expected vs Actual**:
      - Expected: Error thrown
      - Actual: `undefined` returned

   3. **Fix Options**:

   Option A: Update function to throw error
   ```typescript
   function getUser(id: string): User {
     const user = users.find(u => u.id === id);
     if (!user) {
       throw new Error(`User ${id} not found`);
     }
     return user;
   }
   ```

   Option B: Update test to expect undefined
   ```typescript
   it('should return undefined for non-existent user', () => {
     expect(getUser('999')).toBeUndefined();
   });
   ```

   I recommend Option A for better error handling.
   ```

5. **Apply fix** based on suggestion

6. **Re-run test**:
   ```
   <leader>t
   ```

---

### 8. Code Review Suggestions

**Scenario**: You want AI to review your code.

**Steps**:

1. **Visual select code block**:
   ```typescript
   async function processOrder(orderId: string) {
     const order = await getOrder(orderId);
     const user = await getUser(order.userId);
     await chargeCard(user.cardId, order.total);
     await sendEmail(user.email, 'Order confirmed');
     return order;
   }
   ```

2. **Request review**:
   ```
   Press: <leader>arc
   ```

3. **AI provides suggestions**:
   ```
   Code Review Findings:

   1. **Missing Error Handling** (HIGH)
      - What if getOrder fails? Add try-catch
      - What if chargeCard fails? Handle payment failure
      - Suggestion: Wrap in try-catch, rollback on failure

   2. **Race Condition Risk** (MEDIUM)
      - getOrder and getUser can run in parallel
      - Suggestion: Use Promise.all for performance

   3. **Missing Transaction** (HIGH)
      - chargeCard + sendEmail should be atomic
      - If email fails, card already charged
      - Suggestion: Use database transaction

   4. **Type Safety** (LOW)
      - Return type not specified
      - Suggestion: Add `: Promise<Order>`

   Improved version:
   ```typescript
   async function processOrder(orderId: string): Promise<Order> {
     try {
       // Parallel fetch
       const [order, user] = await Promise.all([
         getOrder(orderId),
         getUser(order.userId)
       ]);

       // Transaction for payment + notification
       await db.transaction(async (tx) => {
         await chargeCard(user.cardId, order.total, tx);
         await sendEmail(user.email, 'Order confirmed', tx);
       });

       return order;
     } catch (error) {
       logger.error('Order processing failed', { orderId, error });
       throw new Error(`Failed to process order ${orderId}`);
     }
   }
   ```
   ```

4. **Apply improvements** from review

---

### 9. Generate Documentation

**Scenario**: You need to document a complex function.

**Steps**:

1. **Position cursor** in function or select it

2. **Generate docs**:
   ```
   Press: <leader>ard
   ```

3. **AI generates JSDoc/docstring**:
   ```typescript
   /**
    * Validates and processes a user registration request.
    *
    * Performs the following validations:
    * - Email format and uniqueness
    * - Password strength (min 8 chars, 1 uppercase, 1 number)
    * - Username availability
    *
    * On success, creates user account and sends verification email.
    *
    * @param {RegistrationRequest} request - User registration data
    * @param {string} request.email - User's email address
    * @param {string} request.password - Plain text password (will be hashed)
    * @param {string} request.username - Desired username
    *
    * @returns {Promise<User>} Created user object (without password)
    *
    * @throws {ValidationError} If validation fails
    * @throws {DuplicateUserError} If email or username already exists
    * @throws {EmailError} If verification email fails to send
    *
    * @example
    * const user = await registerUser({
    *   email: 'user@example.com',
    *   password: 'SecureP@ss1',
    *   username: 'johndoe'
    * });
    * console.log('User created:', user.id);
    */
   async function registerUser(request: RegistrationRequest): Promise<User> {
     // Implementation...
   }
   ```

4. **Insert documentation** above function

---

### 10. Explain Complex Code

**Scenario**: You're reading unfamiliar code and need explanation.

**Steps**:

1. **Visual select code** (10-50 lines):
   ```typescript
   const memoize = <T extends (...args: any[]) => any>(fn: T) => {
     const cache = new Map();
     return ((...args: Parameters<T>): ReturnType<T> => {
       const key = JSON.stringify(args);
       if (cache.has(key)) return cache.get(key);
       const result = fn(...args);
       cache.set(key, result);
       return result;
     }) as T;
   };
   ```

2. **Request explanation**:
   ```
   Press: <leader>are
   ```

3. **AI explains** in plain language:
   ```
   This is a **memoization** higher-order function that caches function results.

   What it does:
   1. Takes any function as input
   2. Returns a wrapped version that caches results
   3. On subsequent calls with same args, returns cached result (no re-computation)

   How it works:
   1. **Cache creation**: Creates a Map to store results
   2. **Key generation**: Converts function arguments to JSON string as cache key
   3. **Cache lookup**: Checks if result exists for these arguments
   4. **Cache hit**: Returns cached result immediately
   5. **Cache miss**: Calls original function, stores result, returns it

   Use case:
   - Expensive computations (factorial, fibonacci)
   - API calls with same parameters
   - Complex calculations that repeat

   Example:
   ```typescript
   const expensiveCalc = (n: number) => {
     // Complex computation
     return n * 2;
   };

   const memoized = memoize(expensiveCalc);
   memoized(5); // Computes: 10
   memoized(5); // Cached: 10 (instant)
   ```

   Gotchas:
   - Memory usage grows with unique argument combinations
   - JSON.stringify may not work for all argument types (functions, symbols)
   ```

4. **Use explanation** to understand code

---

### 11. Suggest Refactoring Improvements

**Scenario**: You have working code but want to improve it.

**Steps**:

1. **Select code** to refactor:
   ```typescript
   function processData(data) {
     let result = [];
     for (let i = 0; i < data.length; i++) {
       if (data[i].active) {
         if (data[i].score > 50) {
           result.push({
             id: data[i].id,
             name: data[i].name,
             score: data[i].score
           });
         }
       }
     }
     return result;
   }
   ```

2. **Request refactoring suggestions**:
   ```
   Press: <leader>ars
   ```

3. **AI suggests improvements**:
   ```
   Refactoring Suggestions:

   1. **Replace imperative loop with functional approach** (RECOMMENDED)
      - More readable
      - Less error-prone
      - More idiomatic JavaScript

   2. **Add type safety** (TypeScript)
      - Define input/output types
      - Catch bugs at compile time

   3. **Extract magic number** (50)
      - Make threshold configurable
      - Improve maintainability

   4. **Extract transformation logic**
      - Separate filtering from mapping
      - Single Responsibility Principle

   Refactored version:
   ```typescript
   interface DataItem {
     id: string;
     name: string;
     score: number;
     active: boolean;
   }

   interface ProcessedItem {
     id: string;
     name: string;
     score: number;
   }

   const SCORE_THRESHOLD = 50;

   function processData(
     data: DataItem[],
     threshold: number = SCORE_THRESHOLD
   ): ProcessedItem[] {
     return data
       .filter(item => item.active && item.score > threshold)
       .map(({ id, name, score }) => ({ id, name, score }));
   }
   ```

   Benefits:
   - 70% fewer lines
   - Type-safe
   - Configurable threshold
   - Declarative (what, not how)
   - Easier to test
   ```

4. **Apply refactorings** incrementally

5. **Run tests** to verify:
   ```
   <leader>T
   ```

---

## Chat Window Features

### Navigation
- `j/k` - Scroll messages
- `<C-d>/<C-u>` - Page up/down
- `gg/G` - Top/bottom

### Sending Messages
- `<CR>` (normal mode) - Send message
- `<C-s>` (insert mode) - Send message
- `<C-c>` - Stop generation

### Managing Chat
- `q` - Close chat window
- `<leader>aa` - Toggle chat
- `<C-r>` - Reload chat

### Code Blocks in Chat
- AI responses with code have syntax highlighting
- Copy code blocks with visual select + yank
- Run code snippets with `:!command` or paste to file

---

## Advanced Workflows

### Multi-File Refactoring Discussion

1. **Add multiple related files**:
   ```
   :e src/user.service.ts    → <leader>ab
   :e src/user.controller.ts → <leader>ab
   :e src/user.model.ts      → <leader>ab
   ```

2. **Ask architectural question**:
   ```
   How should I refactor these files to separate authentication
   from user management?
   ```

3. **AI suggests**:
   - New file structure
   - What to move where
   - Interface changes
   - Migration steps

4. **Implement incrementally** with tests

---

### Debug Session with AI

1. **Add file with bug**: `<leader>ab`
2. **Add diagnostics**: `<leader>ad`
3. **In chat**:
   ```
   I'm getting TypeError at line 42. What's wrong?
   ```
4. **AI analyzes** code + diagnostics
5. **Suggests fix** with explanation
6. **Apply fix** and verify

---

### Architecture Planning Session

1. **Start new chat**: `<leader>ac`
2. **Discuss requirements**:
   ```
   I need to build a real-time notification system.
   Users should get notifications in browser and mobile.
   What architecture do you recommend?
   ```
3. **AI proposes**: WebSocket server, Redis pub/sub, etc.
4. **Ask follow-ups**: "How do I handle reconnections?"
5. **Get code examples**: "Show me the WebSocket server setup"
6. **Implement** based on discussion

---

## Tips & Best Practices

1. **Add context early** - Use `<leader>ab` to add relevant files
2. **Be specific** - "Add error handling for network failures" vs "improve this"
3. **Review diffs carefully** - AI can make mistakes, verify changes
4. **Iterate** - Start with small changes, refine in conversation
5. **Use custom shortcuts** - Git commit, test generation shortcuts save time
6. **Keep chat open** - Leave chat window open while coding
7. **Learn from AI** - Read explanations to understand patterns
8. **Combine tools** - Use with LSP, refactoring.nvim, neotest

---

## Troubleshooting

### "API key not found"

**Cause**: API key not configured

**Solution**:
```bash
echo "sk-ant-your-key" > ~/.config/anthropic/api_key
chmod 600 ~/.config/anthropic/api_key
```

Or set env var:
```bash
export ANTHROPIC_API_KEY="sk-ant-your-key"
```

### Chat window not opening

**Cause**: Plugin not loaded

**Solution**:
```vim
:Lazy
# Check if codecompanion.nvim is loaded
# If not, press 'L' to load it
```

### Diff view not showing

**Cause**: mini_diff not working

**Solution**:
```vim
:checkhealth codecompanion
# Check for missing dependencies
```

### Slow responses

**Cause**: Large files in context

**Solution**:
- Use visual selection instead of full file
- Remove unnecessary buffers from context
- Start new chat: `<leader>ac`

### AI giving generic responses

**Cause**: Missing context

**Solution**:
- Add relevant files: `<leader>ab`
- Add diagnostics: `<leader>ad`
- Be more specific in prompt

---

## Quick Reference Card

```
AI CODE ASSISTANCE (<leader>a prefix)

Core:
  <leader>aa    Toggle AI chat
  <leader>ac    New AI chat
  <leader>ai    Inline AI actions
  <leader>at    AI actions menu

Context:
  <leader>ab    Add buffer to chat
  <leader>ad    Add diagnostics to chat

Git Workflow:
  <leader>agg   Generate commit message
  <leader>agp   Generate PR description

Testing:
  <leader>att   Generate tests
  <leader>ate   Explain test failure

Code Review:
  <leader>arc   Code review suggestions
  <leader>ard   Generate documentation
  <leader>are   Explain code

Refactoring:
  <leader>ars   Suggest refactoring

In Chat Window:
  <CR>          Send message (normal)
  <C-s>         Send message (insert)
  <C-c>         Stop generation
  q             Close chat
  <C-r>         Reload chat

In Diff View:
  ]c / [c       Next/previous change
  <leader>ha    Accept hunk
  <leader>hr    Reject hunk
```

---

## Comparison with Claude Code CLI

| Feature | Claude Code CLI | codecompanion.nvim | Notes |
|---------|----------------|-------------------|-------|
| Chat interface | ✅ | ✅ | Both conversational |
| File context | ✅ | ✅ | Add with `<leader>ab` |
| Inline edits | ✅ | ✅ | Diff preview in nvim |
| Diff view | ✅ | ✅ | Same accept/reject workflow |
| Multi-file context | ✅ | ✅ | Add multiple buffers |
| Custom prompts | ⚠️ | ✅ | Configured in ai.lua |
| Workflow integration | ❌ | ✅ | Git, testing, refactoring |
| Keyboard-driven | ⚠️ | ✅ | Full vim keybindings |
| Works offline | ❌ | ❌ | Both require API |

**Overall**: codecompanion.nvim provides Claude Code functionality with deeper Neovim integration and workflow shortcuts.

---

## Related Workflows

- **Git**: Use `<leader>agg` before committing (GIT_WORKFLOW.md)
- **Testing**: Use `<leader>att` to generate tests (TESTING_WORKFLOW.md)
- **Refactoring**: Combine AI suggestions with refactoring.nvim (REFACTORING_WORKFLOW.md)
- **Code Review**: Use `<leader>arc` before creating PR (GITHUB_PR_WORKFLOW.md)

---

## Further Reading

- codecompanion.nvim: https://github.com/olimorris/codecompanion.nvim
- Anthropic API: https://console.anthropic.com
- Config: `lua/mike-custom/config/ai.lua`

---

**Next**: Try `<leader>ai` on selected code to explore AI actions!
