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
      clang = pkgs.clang.cc;
      clangVersion = pkgs.clang.cc.version;
    in
    ''
      CompileFlags:
        Add:
          - "-isystem"
          - "${clang}/include/c++/${clangVersion}"
          - "-isystem"
          - "${clang}/include/c++/${clangVersion}/x86_64-unknown-linux-gnu"
          - "-isystem"
          - "${clang}/include/c++/${clangVersion}/backward"
          - "-isystem"
          - "${clang}/lib/gcc/x86_64-unknown-linux-gnu/${clangVersion}/include"
          - "-isystem"
          - "${clang}/include"
          - "-isystem"
          - "${clang}/lib/gcc/x86_64-unknown-linux-gnu/${clangVersion}/include-fixed"
          - "-isystem"
          - "${pkgs.glibc.dev}/include"
    '';
}
