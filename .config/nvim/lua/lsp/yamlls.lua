-- yaml-language-server settings
--

local config = require("yaml-companion").setup({
  lspconfig = {
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        format = { enable = true, singleQuote = true },
        validate = true,
        hover = true,
        completion = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = {
            "helm/*.yaml",
            "kube/*.yaml",
          },
          ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
          ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["https://raw.githubusercontent.com/ansible/schemas/main/f/ansible.json"] = "roles/*/tasks/*.{yml,yaml}",
          ["https://raw.githubusercontent.com/ansible/schemas/main/f/ansible.json#/$defs/playbook"] = "playbooks/*.{yml,yaml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "**/docker-compose*.yml",
          ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["https://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
          ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
          ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["https://json.schemastore.org/helmfile"] = "helmfile.{yml,yaml}",
          ["https://json.schemastore.org/gitlab-ci"] = "/*lab-ci.{yml,yaml}",
        },
        schemaDownload = { enable = true },
      },
    },
    filetypes = {
      "yaml",
      "yaml.ansible"
    },
  },
})

return {
  config = function(_)
    return config
  end,
}
