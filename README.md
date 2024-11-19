# Llama OCR

A Ruby gem to run OCR for free with Llama 3.2 Vision.

## Installation

Add this line to your application's Gemfile:

```
ruby
gem 'llama-ocr'
```

And then execute:
```
$ bundle install
```

Or install it yourself as:

```
$ gem install llama-ocr
```

## Usage
```
ruby
require 'llama_ocr'
markdown = LlamaOCR::OCR.ocr(
    file_path: "./trader-joes-receipt.jpg", # path to your image (soon PDF!)
    api_key: ENV['TOGETHER_API_KEY'] # Together AI API key
)
```


## How it works

This gem uses the free Llama 3.2 endpoint from [Together AI](https://dub.sh/together-ai) to parse images and return markdown. Paid endpoints for Llama 3.2 11B and Llama 3.2 90B are also available for faster performance and higher rate limits.

You can control this with the `model` option which is set to `Llama-3.2-90B-Vision` by default but can also accept `free` or `Llama-3.2-11B-Vision`.

## Roadmap

- [x] Add support for local images OCR
- [x] Add support for remote images OCR
- [ ] Add support for single page PDFs
- [ ] Add support for multi-page PDFs OCR (take screenshots of PDF & feed to vision model)
- [ ] Add support for JSON output in addition to markdown

## Credit

This project was inspired by [Zerox](https://github.com/getomni-ai/zerox). Go check them out!