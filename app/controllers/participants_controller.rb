class ParticipantsController < ApplicationController
  def new
    @page_title = "Join a Demo Meeting"
    @participant = Participant.new
  end

  def join
  end
end
