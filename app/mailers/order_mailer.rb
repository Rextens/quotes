class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]

    mail(to: "jskudrys@gmail.com", subject: "You got a new order!")
  end

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

    #p "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"

    #send_file img, type: 'image/png', disposition: 'inline'
    cloudResult
  end
  helper_method :logo

end
