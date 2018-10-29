# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class News < Formula
  desc "2018.10.29.release"
  homepage "https://github.com/cn100800/new/releases/latest"
  url "https://github.com/cn100800/news/releases/download/2018.10.29.release/2018.10.29.release.tar.gz"
  sha256 "58fa57e7e9f82aa7452da64cda8bc34ff1e7a61c4127ee3dd3799b57cae6388f"
  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # system "./configure", "--disable-debug",
                          # "--disable-dependency-tracking",
                          # "--disable-silent-rules",
                          # "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args

    bin.install "news"
    # system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test news`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
