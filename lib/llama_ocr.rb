require 'net/http'
require 'json'
require 'base64'

module LlamaOCR
  class Error < StandardError; end

  class OCR
    TOGETHER_API_URL = 'https://api.together.xyz/v1/chat/completions'.freeze

    def self.ocr(file_path:, api_key: ENV['TOGETHER_API_KEY'], model: 'Llama-3.2-90B-Vision')
      new(file_path: file_path, api_key: api_key, model: model).perform
    end

    def initialize(file_path:, api_key:, model:)
      @file_path = file_path
      @api_key = api_key
      @model = model
      @vision_llm = model == 'free' ? 'meta-llama/Llama-Vision-Free' : "meta-llama/#{model}-Instruct-Turbo"
    end

    def perform
      response = make_api_request
      JSON.parse(response.body)['choices'][0]['message']['content']
    end

    private

    def make_api_request
      uri = URI(TOGETHER_API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{@api_key}"

      request.body = JSON.dump({
        model: @vision_llm,
        messages: [
          {
            role: 'user',
            content: [
              { type: 'text', text: system_prompt },
              { type: 'image_url', image_url: { url: final_image_url } }
            ]
          }
        ]
      })

      http.request(request)
    end

    def system_prompt
      <<~PROMPT
        Convert the provided image into Markdown format. Ensure that all content from the page is included, such as headers, footers, subtexts, images (with alt text if possible), tables, and any other elements.

        Requirements:

        - Output Only Markdown: Return solely the Markdown content without any additional explanations or comments.
        - No Delimiters: Do not use code fences or delimiters like ```markdown.
        - Complete Content: Do not omit any part of the page, including headers, footers, and subtext.
      PROMPT
    end

    def final_image_url
      remote_file? ? @file_path : "data:image/jpeg;base64,#{encode_image}"
    end

    def remote_file?
      @file_path.start_with?('http://', 'https://')
    end

    def encode_image
      Base64.strict_encode64(File.read(@file_path))
    end
  end
end