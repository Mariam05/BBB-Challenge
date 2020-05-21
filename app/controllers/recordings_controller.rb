require 'nokogiri'

class RecordingsController < ApplicationController

  @server_url = "https://bbb.mariam.blindside-dev.com/bigbluebutton/api/"

  def index
    @server_url = "https://bbb.mariam.blindside-dev.com/bigbluebutton/api/"
    apicall_name = "getRecordings"
    get_request = @server_url + apicall_name + "?" + "checksum=#{compute_checksum("", apicall_name)}"
    rec_response = HTTParty.get(get_request, timeout: 3000) # 5 min timeout
    # puts "1GET RECORDING RESPONSE: " + rec_response.to_s
    recordings_parser = Nokogiri::XML(rec_response.body).xpath("//recording")

    for record in recordings_parser do
      meet_id = record.xpath("./recordID").text()
      unless Recording.exists?(:meetingID => meet_id)
        Recording.new({:meetingID => meet_id}).save
      end
    end

    @recordings = Recording.all 
  end

  def show
  end

  def new
    @recording = Recording.new
    
  end

  def create
    puts "~ IN RECORDINGS/CREATE" 
    meeting_id = "demo-meeting" + rand(1000).to_s 
    @recording = Recording.new({:meetingID => meeting_id})
    moderator_pw = "mpw"
    server_url = "https://bbb.mariam.blindside-dev.com/bigbluebutton/api/"

    # First: Create the Meeting
    apicall = "name=Demo+Meeting&meetingID=#{meeting_id}&moderatorPW=#{moderator_pw}&record=true"
    apicall_name = "create"
    urlparams = apicall +"&checksum=#{compute_checksum(apicall, apicall_name)}"
    create_request = server_url + apicall_name + "?" + urlparams
    response = HTTParty.get(create_request, timeout: 3000) # 5 min timeout
    puts "RESPONSE: " + response.to_s

    # Next: Join the Meeting
    apicall_name = "join"
    apicall = "fullName=#{$participant_name}&meetingID=#{meeting_id}&password=#{moderator_pw}"
    urlparams = apicall +"&checksum=#{compute_checksum(apicall, apicall_name)}"
    join_request = server_url + apicall_name +"?" + urlparams
    redirect_to join_request
  end

  def destroy
    # Delete from database
    @recording = Recording.find(params[:id])
    @recording.destroy

    # Delete from server
    server_url = "https://bbb.mariam.blindside-dev.com/bigbluebutton/api/"
    parameters = "recordID=#{params[:meetingID]}"
    apicall_name = "deleteRecordings"
    urlparams = parameters + "&checksum=#{compute_checksum(parameters, apicall_name)}"
    create_request = server_url + apicall_name + "?" + urlparams
    response = HTTParty.get(create_request, timeout: 3000) # 5 min timeout

    redirect_to recordings_path
  end

  private 
  def compute_checksum(apicall, apicallname)
    shared_secret = "EE7QiaPSgjYODK4u4gA1Vw4VVMF2iO7w5w5d3RDW0"
    string_to_sh1 = apicallname + apicall + shared_secret
    Digest::SHA1.hexdigest string_to_sh1 #return the sha1 code
  end

end
