class Vaeql < Formula
  desc "PHP Extension that provides accelerated parsing for VaeDB queries"
  homepage ""
  url "https://github.com/actionverb/vaeql/archive/1.0.0.tar.gz"
  version "1.0.0"
  sha256 "7a0c561b96b4a06c69f7398c8111e868e677a57c8e700875891f4a95e936b198"

  depends_on 'actionverb/tap/avlibantlr3c-3.2'
  depends_on 'homebrew/php/php70'
  depends_on 'homebrew/php/php70-opcache'

  def config
    begin
      <<-EOS.undent
      [vaeql]
      extension="#{prefix}/vaeql.so"
      EOS
    rescue Exception
      nil
    end
  end

  def config_file
    "/usr/local/etc/php/7.0/conf.d/ext-vaeql.ini"
  end

  def install
    system "make"
    prefix.install "vaeql.so"
    IO.write("ext-vaeql.ini", config, mode: 'a')
    system "cp", "ext-vaeql.ini", config_file
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test vaeql`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
