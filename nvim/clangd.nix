{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".clang-format".text = ''
    BasedOnStyle: LLVM
    IndentWidth: 4
    TabWidth: 4
  '';

  home.file.".config/clangd/config.yaml".text =
    let
      gcc = pkgs.gcc.cc;
      gccVersion = pkgs.gcc.cc.version;
    in
    ''
      CompileFlags:
        Add:
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}"
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}/x86_64-unknown-linux-gnu"
          - "-isystem"
          - "${gcc}/include/c++/${gccVersion}/backward"
          - "-isystem"
          - "${gcc}/lib/gcc/x86_64-unknown-linux-gnu/${gccVersion}/include"
          - "-isystem"
          - "${gcc}/include"
          - "-isystem"
          - "${gcc}/lib/gcc/x86_64-unknown-linux-gnu/${gccVersion}/include-fixed"
          - "-isystem"
          - "${pkgs.glibc.dev}/include"
    '';
}
