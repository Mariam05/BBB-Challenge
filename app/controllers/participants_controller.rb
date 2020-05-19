require('bigbluebutton_api')
require('digest')
require('httparty')

class ParticipantsController < ApplicationController

  def new
    @page_title = "Join a Demo Meeting"
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(params.require(:participant).permit(:name))
    $participant_name = @participant[:name]
    puts "~ PARTICIPANT " + $participant_name
    if @participant.save

      puts("~ SAVED PARTICIPANT, CREATING MEETING")
      redirect_to '/recordings/create' #recordings_path
    else
      redirect_to('new')
    end
  end

  private 
  def compute_checksum(apicall, apicallname)
    shared_secret = "EE7QiaPSgjYODK4u4gA1Vw4VVMF2iO7w5w5d3RDW0"
    string_to_sh1 = apicallname + apicall + shared_secret
    Digest::SHA1.hexdigest string_to_sh1 #return the sha1 code
  end

end
