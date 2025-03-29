{
  mkActionBinding = binding: action: desc: ''
    vim.keymap.set("n", "${binding}", "${action}", { noremap = true, silent = true, desc = "${desc}" })
  '';
  mkFnBinding = binding: fn: desc: ''
    vim.keymap.set("n", "${binding}", ${fn}, { noremap = true, silent = true, desc = "${desc}" })
  '';
  # expects bufnr is defined in the scope of the lua code
  mkActionBindingToBuffer = binding: action: desc: ''
    vim.keymap.set("n", "${binding}", "${action}", { buffer = bufnr, noremap = true, silent = true, desc = "${desc}" })
  '';
  # expects bufnr is defined in the scope of the lua code
  mkFnBindingToBuffer = binding: fn: desc: ''
    vim.keymap.set("n", "${binding}", ${fn}, { buffer = bufnr, noremap = true, silent = true, desc = "${desc}" })
  '';
}
