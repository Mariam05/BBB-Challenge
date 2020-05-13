require('bigbluebutton_api')
require('digest')
require('httparty')

class ParticipantsController < ApplicationController

  def new
    @page_title = "Join a Demo Meeting"
    @participant = Participant.new
  end

  # def join
  # end

  def create
    @participant = Participant.new(params.require(:participant).permit(:name))
 
    # @participant.name = params.require(:participant).permit(:name)
    # puts "PARTICIPANT NAME: " + @participant.name.to_s
    if @participant.save
      meeting_id = "demo-meeting" + rand(1000).to_s
      moderator_pw = "mpw"
      server_url = "https://bbb.mariam.blindside-dev.com/bigbluebutton/api/"
  
      # First: Create the Meeting
      apicall = "name=Demo+Meeting&meetingID=#{meeting_id}&moderatorPW=#{moderator_pw}"
      apicall_name = "create"
      urlparams = apicall +"&checksum=#{compute_checksum(apicall, apicall_name)}"
      create_request = server_url + apicall_name +"?" + urlparams
      response = HTTParty.get(create_request)
      puts "RESPONSE: " + response.to_s
     # https://bbb.mariam.blindside-dev.com/bigbluebutton/api/join?fullName=User+4701709&meetingID=random-1581843&password=mp&redirect=true&checksum=156fea90214360544bc083c559507436bf0a611c
      # Next: Join the Meeting
      apicall_name = "join"
      apicall = "fullName=#{@participant[:name]}&meetingID=#{meeting_id}&password=#{moderator_pw}"
      urlparams = apicall +"&checksum=#{compute_checksum(apicall, apicall_name)}"
      join_request = server_url + apicall_name +"?" + urlparams
      redirect_to join_request
    else
      render 'new'
    end
  end

  def join
    begin
      @api = BigBlueButton::BigBlueButtonApi.new('https://bbb.mariam.blindside-dev.com/bigbluebutton/api/',
        'EE7QiaPSgjYODK4u4gA1Vw4VVMF2iO7w5w5d3RDW0', 1.0.to_s, true)
        meeting_name = "Test Meeting"
        meeting_id = "test-meeting"
        moderator_name = @participant.to_s
        puts "Moderator name: " + moderator_name
        unless @api.is_meeting_running?(meeting_id)
          puts "---------------------------------------------------"
          options = { 
            :welcome => 'Welcome to my meeting',
            :maxParticipants => 25 }
          @api.create_meeting(meeting_name, meeting_id, options)
          puts "The meeting has been created. Please open a web browser and enter the meeting using either of the URLs below."
      
          puts
          puts "---------------------------------------------------"
          url = @api.join_meeting_url(meeting_id, moderator_name, options[:moderatorPW])
          puts "1) Moderator URL = #{url}"
      
          puts
          puts "---------------------------------------------------"
          puts "Waiting 30 seconds for you to enter via browser"
          sleep(30)
        end
      end
  end

  private 
  def compute_checksum(apicall, apicallname)
    shared_secret = "EE7QiaPSgjYODK4u4gA1Vw4VVMF2iO7w5w5d3RDW0"
    string_to_sh1 = apicallname + apicall + shared_secret
    Digest::SHA1.hexdigest string_to_sh1 #return the sha1 code
  end

end
