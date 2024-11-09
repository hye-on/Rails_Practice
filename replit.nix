{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.ruby_3_3       # Ruby 3.3 버전 설정
    pkgs.nodejs
    pkgs.yarn
    pkgs.rubyPackages.railties # Railties 패키지
    pkgs.libyaml        # YAML 지원을 위한 libyaml 추가
    pkgs.sqlite         # SQLite 데이터베이스
  ];
}
