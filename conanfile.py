from conan import ConanFile
from conan.tools.cmake import CMake, CMakeToolchain, CMakeDeps

class TestConan(ConanFile):
    name = "cpp-base-container"
    version = "1.0"
    license = "MIT"
    author = "Colin Ciesla <colinciesla@gmail.com>"
    url = "https://github.com/colinciesla/cpp-base-container.git"

    settings = "os", "compiler", "build_type", "arch"

    requires = ["fmt/10.2.1", "spdlog/1.12.0", "catch2/3.5.2"]

    tool_requires = ["cmake/3.28.0", "ninja/1.11.1"]

    def layout(self):
        self.folders.build = "build"  # Ensure Conan outputs files inside 'build/'

    def config_options(self):
        if self.settings.os == "Windows":
            self.options["spdlog"].shared = True  # Example option for Windows

    def configure(self):
        self.settings.compiler.cppstd = "20"

    def generate(self):
        CMakeToolchain(self).generate()
        CMakeDeps(self).generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()
