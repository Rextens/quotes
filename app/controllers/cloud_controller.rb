class CloudController < ApplicationController

  def logo
    quotesCloudInstance = Quote.order("quoteindex DESC").limit(5)

    words = []

    quotesCloudInstance.each do |item|
      words.push [item['title'], item['quoteindex'] + 50 ]
    end

    cloudResult = MagicCloud::Cloud.new(words, rotate: :free, scale: :log)

    #byebug
    img = cloudResult.draw(960, 600)
    img.write('test.png')

    LetterOpener.configure do |config|
      config.location = Rails.root.join('tmp', 'my_mails')

      config.message_template = :light
    end

    #    p "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"

    #send_file img, type: 'image/png', disposition: 'inline'
    img
  end

  def cloud

    # logo

    #@order = Order.new(name: "abc", email: "jskudrys@gmail.com", address: "jskudrys@gmail.com", phone: "533078977", message: "assd")
    #@order.save


    #OrderMailer.with(order: @order).new_order_email.deliver_later

    #quotesCloudInstance = MagicCloud::Cloud.new()
  end
end
