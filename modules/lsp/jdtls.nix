{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.strings) hasSuffix;
  inherit (lib.nvim.lua) toLuaObject;

  vscode-java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug";
  vscode-java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test";
  vscode-java-decompiler = pkgs.fetchFromGitHub {
    owner = "dgileadi";
    repo = "vscode-java-decompiler";
    rev = "master";
    sha256 = "sha256-VoCxa5zwkLP1eIpZTHaVpbnHbwDTpJztrpQ9Ll3KY/o=";
  };

  getJars = plugin:
    map
    (jar: "${plugin}/${jar}")
    (builtins.attrNames (builtins.readDir "${plugin}/server"));

  bundles = toLuaObject (
    builtins.filter
    # https://github.com/mfussenegger/nvim-jdtls/issues/746
    (jar: !(hasSuffix "com.microsoft.java.test.runner-jar-with-dependencies.jar" jar || hasSuffix "jacocoagent.jar" jar))
    (builtins.concatLists [
      (getJars vscode-java-debug)
      (getJars vscode-java-test)
      (getJars vscode-java-decompiler)
    ])
  );
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

              local init_options = {
                bundles = ${bundles},
                extendedClientCapabilities = vim.tbl_extend(
                  "force",
                  {},
                  jdtls.extendedClientCapabilities,
                  { resolveAdditionalTextEditsSupport = true }
                ),
              }

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
                init_options = init_options,
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
