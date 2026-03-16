return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		keys = {
			{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
			{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
			{ "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek folded lines" },
		},
		opts = {
			-- Use treesitter first, indent as fallback
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			-- Don't auto-close folds when leaving insert mode
			close_fold_kinds_for_ft = {},
			open_fold_hl_timeout = 0,
			-- Show number of folded lines
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d lines "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "Comment" })
				return newVirtText
			end,
		},
	},
}
