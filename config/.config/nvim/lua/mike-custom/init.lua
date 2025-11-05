-- Import globals before everything else!
require("mike-custom.g")

-- Configs
require("mike-custom.opt")
require("mike-custom.keybinds")
require("mike-custom.autocmd")

-- Load plugin manager (Lazy)
require("mike-custom.plugins")

-- Load plugin configurations
require("mike-custom.config.completion")
require("mike-custom.config.editor")
require("mike-custom.config.file-management")
require("mike-custom.config.git")
require("mike-custom.config.language-support")
require("mike-custom.config.navigation")
require("mike-custom.config.terminal")
require("mike-custom.config.testing")
require("mike-custom.config.ui")
require("mike-custom.config.workflow")
require("mike-custom.config.writing")

-- Load language-specific configurations
require("mike-custom.config.lang.python")
require("mike-custom.config.lang.javascript")
