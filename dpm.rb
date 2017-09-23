#https://www.sourceclear.com/blog/Distribute-Your-Java-App-Via-Brew/

class Dpm < Formula
  desc "The Defold Package Manager"
  homepage "https://github.com/adamwestman/DPM"
  url "https://github.com/adamwestman/DPM/archive/0.0.3.zip"
  sha256 "410882f6807a70f68052734e9ff5dffcee03eb87eb2d3769c3b2df71e13caa38"


  head do
    url "https://github.com/adamwestman/DPM.git"
  end


  def install
    inreplace "bin/brew/dpm", "##PREFIX##", "#{prefix}"
    prefix.install "bin/dpm.o"
    bin.install "bin/brew/dpm"
  end

  test do
    output = File.open( "game.project","w" )
    output << "[project]\n"
    output << "title=test\n"
    output.close

    system bin/"dpm", "init"
    assert File.exist? "dpm.package"
  end
end
