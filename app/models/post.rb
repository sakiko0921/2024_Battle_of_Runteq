class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :text_image, PostUploader

  validates :book, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }

  def analyze_image(uploaded_image_path)
    # APIキーの設定
    api_key = ENV["GOOGLE_VISION_API_KEY"]
    # APIのエンドポイント設定
    uri = URI.parse("https://vision.googleapis.com/v1/images:annotate?key=#{api_key}")
    # 画像をBase64にエンコード !ここでエラー発生中!
    base64_image = Base64.strict_encode64(File.open(uploaded_image_path, "rb").read)

    # デバッグステートメント
    puts "uploaded_image_path: #{uploaded_image_path}"
    puts "base64_image: #{base64_image}"

    body = {
      requests: [{
        image: {
          content: base64_image
        },
        features: [{
          type: "DOCUMENT_TEXT_DETECTION",
          maxResults: 10
        }]
      }]
    }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, initheader = { "Content-Type" => "application/json" })
    request.body = body

    response = http.request(request)

    if response.code == "200"
      json_data = JSON.parse(response.body)
      text_content = json_data["responses"][0]["fullTextAnnotation"]["text"]
    else
      "読み込みに失敗しました"
    end
    p text_content
  end
end
