{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
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

              local get_root_dir = function()
                return jdtls.setup.find_root({ "packageInfo" }) or jdtls.setup.find_root({ "mvnw", "gradlew", ".git" })
              end

              jdtls.start_or_attach({
                capabilities = vim.tbl_deep_extend(
                  "force",
                  {},
                  vim.lsp.protocol.make_client_capabilities(),
                  require("cmp_nvim_lsp").default_capabilities()
                ),
                cmd = {
                  "${lib.getExe pkgs.jdt-language-server}",
                  "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar",
                  "-configuration",
                  vim.fn.stdpath("cache") .. "/jdtls/config",
                  "-data",
                  vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(get_root_dir(), ":p:h:t"),
                },
                on_attach = function(_, bufnr)
                  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end,
                root_dir = get_root_dir(),
                settings = {
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
                    eclipse = { downloadsources = true },
                    inlayHints = { parameterNames = { enabled = "all" } },
                    signatureHelp = { enabled = true },
                    sources = {
                      organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                      },
                    },
                  },
                },
              })
            end
          '';
        desc = "jdtls start autocmd";
        event = ["FileType"];
        pattern = ["java"];
      }
    ];

    extraPackages = with pkgs; [
      jdt-language-server
      lombok
      jdk8
      jdk11
      jdk17
      jdk21
    ];

    extraPlugins."jdtls" = {
      package = pkgs.vimPlugins.nvim-jdtls;
    };
  };
}
