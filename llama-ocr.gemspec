Gem::Specification.new do |spec|
    spec.name          = "llama-ocr"
    spec.version       = "0.0.6"
    spec.authors       = ["Hassan El Mghari"]
    spec.email         = ["hassan@example.com"]
  
    spec.summary       = "Image to markdown (OCR) with Llama 3.2 Vision."
    spec.description   = "An Ruby gem to run OCR for free with Llama 3.2 Vision."
    spec.homepage      = "https://github.com/Nutlope/llama-ocr"
    spec.license       = "MIT"
    spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")
  
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/Nutlope/llama-ocr"
  
    spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]
  
    spec.add_development_dependency "bundler", "~> 2.0"
    spec.add_development_dependency "rake", "~> 13.0"
    spec.add_development_dependency "rspec", "~> 3.0"
  end