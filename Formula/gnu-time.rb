class GnuTime < Formula
  desc "GNU implementation of time utility"
  homepage "https://www.gnu.org/software/time/"
  url "https://ftp.gnu.org/gnu/time/time-1.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/time/time-1.8.tar.gz"
  sha256 "8a2f540155961a35ba9b84aec5e77e3ae36c74cecb4484db455960601b7a2e1b"

  bottle do
    cellar :any_skip_relocation
    sha256 "b3763d0f3f85e55ce1e9dabaafba0bb4e5af5706b0184dddb96e5c888310c494" => :high_sierra
    sha256 "96e4ff64f2754423ef0e333457097c025ce77f2f8103ff1d6eb4c7e40e3e0281" => :sierra
    sha256 "37ee681d846bb5d11a31c7d53ee877ea3d30b0946775491c7952ea59a50f3293" => :el_capitan
    sha256 "cb6b07d4dc525577cf1ca422b81a10f26f1ef480afa382333bb4c2430a2cda08" => :x86_64_linux
  end

  option "with-default-names", "Do not prepend 'g' to the binary"

  def install
    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--info=#{info}",
    ]

    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make", "install"

    bin.install_symlink "time" => "gtime" if build.with?("default-names") && !OS.mac?
  end

  test do
    if OS.mac?
      system bin/"gtime", "ruby", "--version"
    else
      system bin/"gtime", bin/"gtime", "--version"
    end
  end
end
