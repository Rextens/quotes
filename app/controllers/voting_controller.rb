class VotingController < ApplicationController
  def vote

  end

  def chooseQuote

  end

  #before_action  :bakeCookie, if: -> { :voteForQuote }

  def bakeCookie

  end

  def voteForQuote

    if !(cookies().key?("expireDate"))
      cookies["expireDate"] = {
        value: 0,
        expires_in: 1.hour
      }

      cookies["countVotes"] = {
        value: 0
      }
    elsif cookies().key?("countVotes")
      cookies["countVotes"] = {
        value: cookies["countVotes"].to_i + 1
      }
    end

    if (cookies().key?("countVotes"))
      if(cookies["countVotes"].to_i < 6 && cookies["countVotes"].to_i > -1)

        chosenQuote = (Quote.find_by title: params[:data][:chosen])
        otherQuote = (Quote.find_by title: params[:data][:other])

        if otherQuote[:quoteindex] > chosenQuote[:quoteindex]
          Quote.where(title: chosenQuote[:title]).update(quoteindex: otherQuote[:quoteindex])
          Quote.where(title: otherQuote[:title]).update(quoteindex: chosenQuote[:quoteindex])
        end

        puts cookies["countVotes"]
      end
    else
      cookies["countVotes"] = 0
    end

    redirect_to '/vote'

  end

  def create

  end
end
