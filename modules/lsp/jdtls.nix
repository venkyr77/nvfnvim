{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.strings) hasSuffix;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (import ../../helpers) mkFnBindingToBuffer;

  vscode-java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug";
  vscode-java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test";

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
    ])
  );

  settings = {
    java = {
      completion.enabled = true;
      configuration.runtimes = [
        {
          name = "JavaSE-1.8";
          path = "${pkgs.jdk8}";
        }
        {
          name = "JavaSE-11";
          path = "${pkgs.jdk11}";
        }
        {
          name = "JavaSE-17";
          path = "${pkgs.jdk17}";
          default = true;
        }
        {
          name = "JavaSE-21";
          path = "${pkgs.jdk21}";
        }
      ];
      contentProvider.preferred = "fernflower";
      eclipse.downloadSources = true;
      inlayHints.parameterNames.enabled = "all";
      signatureHelp.enabled = true;
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
    };
  };
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

                -- https://github.com/microsoft/vscode-java-debug/blob/main/src/launchCommand.ts#L27
                local overrides = { shortenCommandLine = "argfile" }

                ${mkFnBindingToBuffer "<leader>ltc" "function() jdtls.test_class({ config_overrides = overrides }) end" "[t]est [c]lass"}
                ${mkFnBindingToBuffer "<leader>ltm" "function() jdtls.test_nearest_method({ config_overrides = overrides }) end" "[t]est [c]lass"}
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

              jdtls.start_or_attach({
                capabilities = capabilities,
                cmd = cmd,
                on_attach = on_attach,
                init_options = init_options,
                root_dir = root_dir,
                settings = ${toLuaObject settings},
              })
            end
          '';
        desc = "jdtls start autocmd";
        event = ["FileType"];
        pattern = ["java"];
      }
    ];

    extraPlugins."jdtls".package = pkgs.vimPlugins.nvim-jdtls;
  };
}
