# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class New < Formula
  desc "2018.10.21.release"
  homepage "https://github.com/cn100800/new/releases/latest"
  url "https://github.com/cn100800/new/releases/download/2018.10.21.release/2018.10.21.release.tar.gz"
  sha256 "f179a41c60f366a4d08fd83b18b76066109768d38f991e2ddd7a0114cfd15d1a"
  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    #system "./configure", "--disable-debug",
                          #{}"--disable-dependency-tracking",
                          #{}"--disable-silent-rules",
                          #{}"--prefix=#{prefix}"
    bin.install "new"
    # system "cmake", ".", *std_cmake_args
    #system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test new`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
