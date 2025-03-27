{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  java_debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug";
  java_test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test";
in {
  config.vim = {
    autocmds = [
      {
        callback =
          mkLuaInline
          # lua
          ''
            function()
              local jdtls = require("jdtls")

              local root_dir = jdtls.setup.find_root({ "mvnw", "gradlew", ".git" })

              local cmd = {
                "${lib.getExe pkgs.jdt-language-server}",
                "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar",
                "-configuration",
                vim.fn.stdpath("cache") .. "/jdtls/config",
                "-data",
                vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
              }

              local on_attach = function(_, bufnr)
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                local overrides = {
                  -- https://github.com/microsoft/vscode-java-debug/blob/main/src/launchCommand.ts#L27
                  shortenCommandLine = "argfile",
                }

                vim.keymap.set("n", "<leader>jtc", function()
                  jdtls.test_class({
                    config_overrides = overrides,
                  })
                end, { buffer = bufnr, desc = "[T]est [C]lass" })

                vim.keymap.set("n", "<leader>jtm", function()
                  jdtls.test_nearest_method({
                    config_overrides = overrides,
                  })
                end, { buffer = bufnr, desc = "[T]est nearest [M]ethod" })
              end

              local get_init_options = function()
                local bundles = vim.split(vim.fn.glob("${java_debug}/server/com.microsoft.java.debug.plugin-*.jar"), "\n")

                vim.list_extend(bundles, vim.split(vim.fn.glob("${java_test}/server/*.jar"), "\n"))

                -- https://github.com/mfussenegger/nvim-jdtls/issues/746

                local ignored_bundles = { "com.microsoft.java.test.runner-jar-with-dependencies.jar", "jacocoagent.jar" }

                local function should_ignore_bundle(bundle)
                  for _, ignored in ipairs(ignored_bundles) do
                    if string.find(bundle, ignored, 1, true) then
                      return true
                    end
                  end
                end

                bundles = vim.tbl_filter(function(bundle)
                  return bundle ~= "" and not should_ignore_bundle(bundle)
                end, bundles)

                return {
                  bundles = bundles,
                  extendedClientCapabilities = vim.tbl_extend(
                    "force",
                    {},
                    jdtls.extendedClientCapabilities,
                    { resolveAdditionalTextEditsSupport = true }
                  ),
                }
              end

              local settings = {
                java = {
                  completion = { enabled = true },
                  configuration = {
                    runtimes = {
                      {
                        name = "JavaSE-1.8",
                        path = "${pkgs.jdk8}",
                      },
                      {
                        name = "JavaSE-11",
                        path = "${pkgs.jdk11}",
                      },
                      {
                        name = "JavaSE-17",
                        path = "${pkgs.jdk17}",
                        default = true,
                      },
                      {
                        name = "JavaSE-21",
                        path = "${pkgs.jdk21}",
                      },
                    },
                  },
                  contentProvider = { preferred = "fernflower" },
                  eclipse = { downloadSources = true },
                  inlayHints = { parameterNames = { enabled = "all" } },
                  signatureHelp = { enabled = true },
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                },
              }

              jdtls.start_or_attach({
                capabilities = capabilities,
                cmd = cmd,
                on_attach = on_attach,
                init_options = get_init_options(),
                root_dir = root_dir,
                settings = settings,
              })
            end
          '';
        desc = "jdtls start autocmd";
        event = ["FileType"];
        pattern = ["java"];
      }
    ];

    extraPlugins."jdtls" = {
      package = pkgs.vimPlugins.nvim-jdtls;
    };
  };
}
