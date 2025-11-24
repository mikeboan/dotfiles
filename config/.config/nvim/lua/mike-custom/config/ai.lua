-- AI code assistance with Claude integration
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- For file selection in context
			"stevearc/dressing.nvim", -- Better UI for selections
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			-- Core AI operations
			{
				"<leader>aa",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				desc = "[A]I: Toggle ch[a]t",
			},
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat<cr>",
				mode = { "n", "v" },
				desc = "[A]I: New [c]hat",
			},
			{
				"<leader>ai",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "[A]I: [I]nline actions",
			},
			{
				"<leader>at",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "[A]I: Actions menu",
			},

			-- Context management
			{
				"<leader>ab",
				function()
					require("codecompanion").add_to_chat({ type = "buffer" })
				end,
				desc = "[A]I: Add [b]uffer to chat",
			},
			{
				"<leader>ad",
				function()
					require("codecompanion").add_to_chat({ type = "diagnostics" })
				end,
				desc = "[A]I: Add [d]iagnostics to chat",
			},

			-- Workflow-specific shortcuts (git)
			{
				"<leader>agg",
				function()
					require("codecompanion").prompt("Commit Message")
				end,
				desc = "[A]I: [G]it commit messa[g]e",
			},
			{
				"<leader>agp",
				function()
					require("codecompanion").prompt("PR Description")
				end,
				desc = "[A]I: [G]it [P]R description",
			},

			-- Workflow-specific shortcuts (testing)
			{
				"<leader>att",
				function()
					require("codecompanion").prompt("Generate Tests")
				end,
				mode = { "n", "v" },
				desc = "[A]I: Generate [t]es[t]s",
			},
			{
				"<leader>ate",
				function()
					require("codecompanion").prompt("Explain Test Failure")
				end,
				desc = "[A]I: Explain [t]est [e]rror",
			},

			-- Code review and documentation
			{
				"<leader>arc",
				function()
					require("codecompanion").prompt("Code Review")
				end,
				mode = { "n", "v" },
				desc = "[A]I: Code [r]eview suggestions",
			},
			{
				"<leader>ard",
				function()
					require("codecompanion").prompt("Generate Docs")
				end,
				mode = { "n", "v" },
				desc = "[A]I: Generate [d]ocs",
			},
			{
				"<leader>are",
				function()
					require("codecompanion").prompt("Explain Code")
				end,
				mode = { "n", "v" },
				desc = "[A]I: [E]xplain code",
			},

			-- Refactoring shortcuts
			{
				"<leader>ars",
				function()
					require("codecompanion").prompt("Suggest Refactoring")
				end,
				mode = { "n", "v" },
				desc = "[A]I: [R]efactor [s]uggest",
			},
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "cmd:cat ~/.config/anthropic/api_key 2>/dev/null || echo $ANTHROPIC_API_KEY",
							},
							schema = {
								model = {
									default = "claude-sonnet-4-20250514",
									-- Alternatives: claude-opus-4-20250514, claude-haiku-4-20250413
								},
							},
						})
					end,
				},
				strategies = {
					chat = {
						adapter = "anthropic",
						roles = {
							llm = "Claude",
							user = "You",
						},
						keymaps = {
							send = {
								modes = {
									n = "<CR>",
									i = "<C-s>",
								},
							},
							close = {
								modes = {
									n = "q",
								},
							},
							stop = {
								modes = {
									n = "<C-c>",
								},
							},
						},
					},
					inline = {
						adapter = "anthropic",
					},
				},
				display = {
					diff = {
						enabled = true,
						provider = "mini_diff", -- Shows diffs like git hunks
					},
					chat = {
						window = {
							layout = "vertical", -- or "float" for floating window
							width = 0.45,
							height = 0.85,
							relative = "editor",
							border = "rounded",
						},
						show_settings = true, -- Show model/settings in chat
						show_token_count = true,
					},
				},
				opts = {
					log_level = "ERROR", -- DEBUG, ERROR, INFO, TRACE
					send_code = true, -- Send code context with prompts
					use_default_actions = true, -- Use built-in actions
				},
				-- Custom prompts for your workflows
				prompts = {
					-- Git workflow prompts
					["Commit Message"] = {
						strategy = "chat",
						description = "Generate conventional commit message from staged changes",
						prompts = {
							{
								role = "system",
								content = [[You generate concise, conventional commit messages.
Format: <type>(<scope>): <description>

Types: feat, fix, docs, style, refactor, test, chore
Keep description under 72 characters.
Add body if changes are complex (what and why, not how).]],
							},
							{
								role = "user",
								content = function()
									local diff = vim.fn.system("git diff --staged")
									if vim.v.shell_error ~= 0 or diff == "" then
										return "No staged changes. Please stage changes first with `git add`."
									end
									return "Generate a commit message for these staged changes:\n\n```diff\n"
										.. diff
										.. "\n```"
								end,
							},
						},
					},
					["PR Description"] = {
						strategy = "chat",
						description = "Generate pull request description from branch diff",
						prompts = {
							{
								role = "system",
								content = [[Generate a clear PR description with:
## Summary
- Brief overview of changes (2-3 bullets)

## Changes
- Detailed list of modifications

## Test Plan
- How to test these changes

## Checklist
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or documented)]],
							},
							{
								role = "user",
								content = function()
									local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
									local main_branch = "main" -- or detect: origin/HEAD
									local diff = vim.fn.system("git diff " .. main_branch .. "...HEAD")
									local log =
										vim.fn.system("git log " .. main_branch .. "..HEAD --oneline")

									return string.format(
										"Generate PR description for branch `%s`:\n\nCommits:\n%s\n\nDiff:\n```diff\n%s\n```",
										branch,
										log,
										diff
									)
								end,
							},
						},
					},

					-- Testing workflow prompts
					["Generate Tests"] = {
						strategy = "chat",
						description = "Generate tests for selected code or current function",
						prompts = {
							{
								role = "system",
								content = [[You generate comprehensive tests following these principles:
- Use the testing framework detected from the project
- Cover happy path, edge cases, and error cases
- Use descriptive test names that explain intent
- Follow AAA pattern: Arrange, Act, Assert
- Include setup/teardown if needed
- Add comments explaining complex test scenarios]],
							},
							{
								role = "user",
								content = function(context)
									local bufnr = vim.api.nvim_get_current_buf()
									local filetype = vim.bo[bufnr].filetype
									local code = context.selection or context.buffer

									return string.format(
										"Generate tests for this %s code:\n\n```%s\n%s\n```\n\nDetect the appropriate test framework and follow its conventions.",
										filetype,
										filetype,
										code
									)
								end,
							},
						},
					},
					["Explain Test Failure"] = {
						strategy = "chat",
						description = "Explain why tests are failing using diagnostics",
						prompts = {
							{
								role = "system",
								content = [[Analyze test failures and:
1. Explain why the test is failing
2. Identify the root cause
3. Suggest fixes
4. Note any potential side effects of the fix]],
							},
							{
								role = "user",
								content = function()
									local diagnostics = vim.diagnostic.get(0)
									local diag_text = ""
									for _, diag in ipairs(diagnostics) do
										diag_text = diag_text
											.. string.format("[%s] Line %d: %s\n", diag.source, diag.lnum + 1, diag.message)
									end

									if diag_text == "" then
										return "No diagnostics found. Run tests first."
									end

									return "Explain these test failures:\n\n" .. diag_text
								end,
							},
						},
					},

					-- Code review and documentation prompts
					["Code Review"] = {
						strategy = "chat",
						description = "Provide code review suggestions",
						prompts = {
							{
								role = "system",
								content = [[Provide constructive code review focusing on:
1. Bugs and logic errors
2. Performance issues
3. Security vulnerabilities
4. Code style and best practices
5. Readability improvements
6. Test coverage gaps

Be specific and provide examples for suggestions.]],
							},
							{
								role = "user",
								content = function(context)
									return "Review this code:\n\n```\n" .. (context.selection or context.buffer) .. "\n```"
								end,
							},
						},
					},
					["Generate Docs"] = {
						strategy = "inline",
						description = "Generate documentation for code",
						prompts = {
							{
								role = "system",
								content = [[Generate clear, concise documentation:
- For functions: describe params, return value, side effects
- For classes: describe purpose, key methods, usage examples
- Use JSDoc, docstrings, or appropriate format for the language
- Include examples for complex functions]],
							},
							{
								role = "user",
								content = function(context)
									return "Generate documentation for:\n\n```\n"
										.. (context.selection or context.buffer)
										.. "\n```"
								end,
							},
						},
					},
					["Explain Code"] = {
						strategy = "chat",
						description = "Explain what code does in plain language",
						prompts = {
							{
								role = "system",
								content = [[Explain code clearly:
1. What it does (high-level purpose)
2. How it works (step-by-step logic)
3. Why certain approaches were used
4. Any gotchas or important details

Use plain language, avoid jargon when possible.]],
							},
							{
								role = "user",
								content = function(context)
									return "Explain this code:\n\n```\n"
										.. (context.selection or context.buffer)
										.. "\n```"
								end,
							},
						},
					},

					-- Refactoring prompts
					["Suggest Refactoring"] = {
						strategy = "chat",
						description = "Suggest refactoring improvements",
						prompts = {
							{
								role = "system",
								content = [[Suggest refactoring improvements:
1. Identify code smells (duplication, complexity, etc.)
2. Propose specific refactorings (extract method, rename, etc.)
3. Explain the benefits of each suggestion
4. Prioritize suggestions by impact
5. Provide before/after examples]],
							},
							{
								role = "user",
								content = function(context)
									return "Suggest refactorings for:\n\n```\n"
										.. (context.selection or context.buffer)
										.. "\n```"
								end,
							},
						},
					},
				},
			})
		end,
	},
}
